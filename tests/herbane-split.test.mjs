import test from 'node:test';
import assert from 'node:assert/strict';
import { readFileSync, readdirSync } from 'node:fs';
import { DatabaseSync } from 'node:sqlite';
import { splitHerbane } from '../scripts/split-herbane.mjs';

const read = (path) => readFileSync(new URL(`../${path}`, import.meta.url), 'utf8');
const schema = read('migrations/0001_create_tables.sql');
const migration = read('migrations/0023_split_herbanes_bestiary.sql');

function originalBook() {
  const db = new DatabaseSync(':memory:');
  try {
    db.exec(schema);
    db.exec(read('migrations/0006_library_instruction_research.sql'));
    return db.prepare("SELECT * FROM tomes WHERE call_number = 'AR-V-028'").get();
  } finally {
    db.close();
  }
}

test('source split preserves every section and marks only the two client-specified books', () => {
  const original = originalBook();
  const books = splitHerbane(original);
  assert.equal(books.length, 3);
  assert.equal(books.map(book => book.body).join('\n\n'), original.body.trim());
  assert.deepEqual(books.map(book => book.readable_online), [true, true, false]);
  const readable = JSON.parse(read('content/readable-online.json')).titles;
  for (const book of books) {
    const raw = read(`content/library/${book.call_number}.md`).replace(/\r\n/g, '\n');
    assert.equal(raw.split('\n---\n')[1].trim(), book.body);
    assert.ok(raw.includes(`title: ${book.title}\n`));
    assert.ok(raw.includes(`readable_online: ${book.readable_online}\n`));
    assert.equal(readable.includes(book.title), book.readable_online);
  }
  assert.ok(!readable.includes(original.title));
  assert.equal(splitHerbane(books[0])[0], books[0], 'an already split book stays unchanged');
  assert.throws(() => splitHerbane({ ...original, body: original.body.replace('## Hagravens', '## Changed') }), /sections changed/);
});

test('forward migration preserves existing identity, separates search results and matches source metadata', () => {
  const db = new DatabaseSync(':memory:');
  try {
    const original = originalBook();
    db.exec(schema);
    db.exec(read('migrations/0018_readable_online.sql'));
    // Production uses ID 131 for this book, unlike the historical seed's 152.
    db.prepare('INSERT INTO tomes (id, call_number, title, author, school, body, readable_online) VALUES (?, ?, ?, ?, ?, ?, 1)')
      .run(131, original.call_number, original.title, original.author, original.school, original.body);
    db.exec("INSERT INTO tomes (id,call_number,title,author,school,body) VALUES (287,'AR-V-059','Unrelated book','Other','Instruction & Research','Untouched text');");
    db.exec("INSERT INTO citations (from_tome,cites_call_number) VALUES (287,'AR-V-028');");
    db.exec(read('migrations/0013_search_index.sql'));
    const untouched = db.prepare('SELECT * FROM tomes WHERE id = 287').get();
    const citations = db.prepare('SELECT * FROM citations').all();

    db.exec(migration);

    const actual = db.prepare("SELECT * FROM tomes WHERE author = 'Herbane' ORDER BY call_number").all();
    assert.equal(actual.length, 3);
    assert.equal(actual[0].id, 131);
    assert.equal(db.prepare('SELECT COUNT(*) AS n FROM tomes').get().n, 4);
    assert.deepEqual(db.prepare('SELECT * FROM tomes WHERE id = 287').get(), untouched);
    assert.deepEqual(db.prepare('SELECT * FROM citations').all(), citations);
    for (const [index, expected] of splitHerbane(original).entries()) {
      const book = actual[index];
      assert.equal(book.call_number, expected.call_number);
      assert.equal(book.title, expected.title);
      assert.equal(book.body, expected.body);
      assert.equal(book.readable_online, Number(expected.readable_online));
      assert.equal(book.restricted, 0);
      assert.equal(book.volume, '');
    }
    const search = db.prepare('SELECT t.call_number FROM tomes_fts JOIN tomes t ON t.id = tomes_fts.rowid WHERE tomes_fts MATCH ? ORDER BY t.call_number');
    assert.deepEqual(search.all('Herbane').map(row => row.call_number), ['AR-V-028', 'AR-V-060', 'AR-V-061']);
    for (const [query, accession] of [['Mzulft', 'AR-V-028'], ['Forsworn', 'AR-V-060'], ['Witbane', 'AR-V-061']]) {
      assert.deepEqual(search.all(query).map(row => row.call_number), [accession]);
    }
    db.exec("INSERT INTO tomes_fts(tomes_fts, rank) VALUES('integrity-check', 1)");
  } finally {
    db.close();
  }
});

test('entry-screen catalogue count matches the split source library', () => {
  const count = readdirSync(new URL('../content/library/', import.meta.url)).filter(name => name.endsWith('.md')).length;
  assert.ok(read('src/screens/insert.ts').includes(`CATALOGUING ....... ${count} VOLUMES`));
});
