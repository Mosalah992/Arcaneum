// The source page combines three separate books. Keep these accessions stable:
// AR-V-028 is retained; the two additions follow the existing shelf at 059.
export function splitHerbane(book) {
  if (book.title.replace(/\u2019/g, "'") !== "Herbane's Bestiary: Automatons, Hagravens, Ice Wraiths") {
    return [book];
  }
  const parts = [
    { heading: 'Dwarven Automatons', title: 'Automatons', call_number: 'AR-V-028', readable_online: true },
    { heading: 'Hagravens', title: 'Hagravens', call_number: 'AR-V-060', readable_online: true },
    { heading: 'Ice Wraiths', title: 'Ice Wraiths', call_number: 'AR-V-061', readable_online: false },
  ];
  const body = book.body.replace(/\r\n/g, '\n').trim();
  const headings = [...body.matchAll(/^## (.+)$/gm)];
  if (headings.length !== parts.length || headings[0]?.index !== 0 ||
      parts.some((part, index) => headings[index][1] !== part.heading)) {
    throw new Error('Herbane source sections changed; review before splitting the books');
  }
  return parts.map((part, index) => ({
    ...book,
    call_number: part.call_number,
    title: `Herbane\u2019s Bestiary: ${part.title}`,
    readable_online: part.readable_online,
    body: body.slice(headings[index].index, headings[index + 1]?.index ?? body.length).trim(),
  }));
}
