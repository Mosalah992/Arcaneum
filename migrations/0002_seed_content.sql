-- Migration 0002 — seed content.
--
-- GENERATED FILE. Do not edit by hand: edit the markdown in content/
-- and re-run `node scripts/build-seed.mjs`.
--
-- THESE TOMES ARE DRAFTS AND ARE INTENDED TO BE REPLACED. They are
-- original fan writing set in the Elder Scrolls world, written to give
-- the archive something to hold while the real text is prepared.

DELETE FROM citations;
DELETE FROM tomes;

-- AR-I-018 — Notes Toward the Mending of Bone
INSERT INTO tomes (id, call_number, title, author, school, body, restricted) VALUES
  (1, 'AR-I-018', 'Notes Toward the Mending of Bone', 'Genneth Ophaly, Physician-Adjunct', 'Restoration',
   '*Working notes, Hearthfire 4E 201. Deposited with the Arcanaeum at the request of the Master of Restoration. These are notes, not an instruction; they have not been examined and should not be treated as settled.*

I set these down because I have taught the same correction to eleven students in four years and I am tired of teaching it aloud.

## The error

A student who has learned to close a wound believes they have learned to mend a break. The two feel identical to the caster. Both are a matter of holding the intention of wholeness against the thing that is not whole, and both leave the caster afterward with the same particular emptiness. Nothing in the sensation of the casting distinguishes them.

They are not the same, and the difference is this: skin knows how to be skin. A wound closed by Restoration closes along a seam the flesh had already decided on. The magic does not instruct the body. It removes the obstacles to what the body was going to do anyway, and does it in an afternoon rather than a fortnight.

Bone does not decide. A break sets in whatever position it is held in. A caster who pours Restoration into a badly set break, with great skill and great will, produces reliably a badly set break that is now permanent and can no longer be corrected by any means short of breaking it again.

## The correction

Set first. Cast second. The order is not a preference.

I have written that sentence at the head of every set of notes I have given a student and it has not been enough, so let me be plainer. The impulse to cast immediately is not impatience and it is not vanity. It is compassion. You are looking at somebody in pain, and the means to end that pain is in your hands, and every part of you objects to waiting. That impulse is the thing you have to learn to overrule, and it does not weaken with practice. Mine has not.

## On the limits

I am asked, always by second-year students and always with the same expression, where the boundary lies. Whether a thing sufficiently broken can be made whole by a caster sufficiently strong.

The honest answer is that strength is not the variable. Restoration works upon a body that is still, in some sense, engaged in the business of being itself. Where that engagement has ceased, the school has nothing to grip. What is attempted past that point is not Restoration, and it is not practised here. The students who ask persistently are, in my experience, not asking out of scholarly interest. I note their names. I do not report them, but I note them, and I make a point of being available.

:: Cross-filed against the reagent notes at AR-IV-118. The willow preparations there are of real use in setting, and are routinely overlooked by casters who assume that magic supersedes splints. It does not. — G.O.', 0);

-- AR-II-041 — On the Conduct of Flame Within Enclosed Halls
INSERT INTO tomes (id, call_number, title, author, school, body, restricted) VALUES
  (2, 'AR-II-041', 'On the Conduct of Flame Within Enclosed Halls', 'Merenwen Faryl, Warden of Practice', 'Destruction',
   '*Filed to the standing instructions of the Hall of Countenance, 12th of Second Seed, 4E 194. Supersedes the instruction of 4E 187.*

Every apprentice admitted to flame practice is to read this document in full before their first casting beneath this roof, and to sign the practice roll in the warden''s presence. The signature is not a formality. It is the record by which the College establishes that you were told.

## I. On the nature of the difficulty

Flame is not made dangerous by its heat. A forge is hotter than anything an apprentice will produce in their first three years, and nobody has ever asked the College to seal a forge. Flame is made dangerous by the fact that it feeds.

A spell released in an open field spends itself against nothing and dies within the second. The same spell released in a stone corridor finds tapestry, lamp oil, dry timber in the ceiling joists, and the still air of a hall that has not been opened to the wind since the Collapse. It does not die. It is given a second life that has nothing to do with the caster and cannot be recalled by them.

The apprentice who protests that they released only a small flame has not understood what they are being warned about. Nobody has ever been injured in this Hall by the size of a spell.

## II. Standing instruction

Practice of the destructive school within the Hall of Countenance is permitted only in the lower practice chamber, only between the eighth and the fourteenth hour, and only in the presence of a warden. The chamber is stripped for the purpose. There is nothing in it that will take a flame and nothing in it worth grieving over. This is deliberate and is not to be read as an insult to the students who use it.

No practice above the second rank of the school is to be conducted anywhere within the residential halls, at any hour, under any supervision, for any reason a student may find persuasive.

## III. On the incident

Apprentices ask about the incident and are told that the record is sealed. This is true. It is sealed by order of the Arch-Mage. The warden of practice does not have the authority to unseal it, and would not exercise that authority if she had it.

What can be said is this. The student in question was competent. She had passed her examinations. She was not careless in the way the word is usually meant, and the account that circulates in the halls — that she was showing off — is false, and I would be grateful if those repeating it would stop. The failure was not in her casting. It was in a room that nobody had inspected in forty years.

:: The transcript is held at AR-VII-013. I have argued twice for its release to the practice roll, on the grounds that apprentices who cannot read it will invent something worse. I was overruled twice. — M.F.

The instruction stands. Read it again before you cast.', 0);

-- AR-III-107 — A Register of Bound Things
INSERT INTO tomes (id, call_number, title, author, school, body, restricted) VALUES
  (3, 'AR-III-107', 'A Register of Bound Things', 'Ondrel Vaeric, Under-Steward of the Midden', 'Conjuration',
   '*Accession note, 3rd of Frostfall, 4E 198. This register is maintained under the authority of the Master of Conjuration and is copied to the Arcanaeum quarterly.*

The purpose of this register is bookkeeping and nothing more elevated than that. When a thing is called into the Midden it is written down. When it is dismissed it is written down again, with the hour. The register exists so that the difference between the two columns can be read at a glance, and so that when the difference is not zero, somebody notices before the following morning rather than in the following season.

## On the discipline of the columns

Conjurers are, as a body, poor record-keepers. This is not a slander. It follows from the work. A summoning is an event that resolves itself: the atronach arrives, the exercise is completed, the atronach goes, and there is a strong and entirely natural feeling that the matter is closed and requires no paperwork. Nine hundred and ninety-nine times in a thousand that feeling is correct.

The register is for the thousandth.

I have held this post eleven years. In that time the difference between the columns has been other than zero on six occasions. Four were clerical — a student who dismissed correctly and forgot to sign, which is irritating and harmless. One was a flame atronach that had not been dismissed but had simply expired of its own accord, which is permitted and is noted in the margin as such.

The sixth is not discussed in this register.

## Practice

Each summoning is entered with the name of the caster, the hour, the class of the thing called, and the intended duration. On dismissal, the hour again, and a second signature. Where a summoning is conducted under instruction, the instructor countersigns. Where a summoning is conducted alone — which requires written leave, and which is granted perhaps twice in a year — the caster signs both columns, and the Under-Steward inspects the chamber personally before the lamps are put out.

Students frequently ask why the register records the *name* of the thing, where a name is known, rather than merely its class.

The honest answer is that I inherited the column and did not remove it. The less honest answer, which I have given to apprentices who struck me as likely to be careless, is that a thing which has been named in this book has been noticed, and that being noticed may be a condition it does not enjoy. I do not know whether that is true. I have never had cause to test it and I would prefer not to acquire one.

:: On the matter of names and what answers to them, the standing reference is AR-IX-002, which is not on open shelf. Apply to the Arcanaeum in writing. Expect refusal. — O.V.

The register is open to inspection by any member of the College at any hour. It is not open to correction.', 0);

-- AR-IV-118 — Concerning the Reagents of the Cold Coast
INSERT INTO tomes (id, call_number, title, author, school, body, restricted) VALUES
  (4, 'AR-IV-118', 'Concerning the Reagents of the Cold Coast', 'Bereth Mallory, Herbalist-in-Residence', 'Alchemy',
   '*Herbalist''s memorandum, Last Seed 4E 196. Supersedes the list of 4E 181, which was compiled inland and should never have been applied here.*

The standing complaint of every alchemist posted to this College is that the reagent tables were written for Cyrodiil. This memorandum does not solve that. It records, for the coast between Winterhold and the Pale border, where the inland tables are wrong and by how much, so that a student following them does not spend a season discovering it alone.

## Potency and cold

The rule taught to first-years — that a reagent gathered in cold is weaker — is false, and I would like it struck from the introductory lecture. It confuses two separate effects.

A plant grown in cold produces less material. Where the inland tables assume a handful, this coast will give you a third of a handful, and a student measuring by volume will under-dose and conclude that the reagent is weak. The reagent is not weak. There is simply less of it, and by weight the coastal material is frequently the stronger of the two, because a plant that has grown slowly has concentrated what it made.

Measure by weight. That is the whole of the correction, and it takes four years to teach.

## Specific notes

**Snowberry.** The inland tables list it as a minor restorative. On this coast it is not minor. Berries taken after the first hard frost, and only after, run to roughly twice the listed potency and will ruin a delicate preparation by overwhelming it. Take them before the frost if you want the listed behaviour.

**Frost mirriam.** Unchanged. It is the one honest entry in the inland table, and I mention it only so that students do not assume everything must be adjusted.

**Nirnroot, coastal.** Rare here and worth the walk. The tone carries poorly in cold air, which means the plant is found by patience rather than by hearing, which means students give up. Do not gather after dark. The plant is not easier to hear then and the ice is not easier to read.

**Willow bark, dwarf variety.** Included because it is absent from the inland table and should not be. Prepared as a cold infusion it is a mild analgesic of genuine use in the setting of broken limbs, and the physicians here rely on it rather more than the alchemists supply it. I would welcome a student willing to take the supply on as a standing duty.

## A note on gathering

Two students have been lost to the ice in my tenure. Both in Evening Star, both alone, both experienced. Gather in pairs from the end of First Seed through Rain''s Hand. This is not a rule I have any power to enforce, and I have stopped pretending otherwise. I am asking.

:: Preparations and dosages for the willow infusion are filed with the Restoration notes at AR-I-018 rather than here, which is an error of filing I have not managed to get corrected in nine years. — B.M.', 0);

-- AR-V-233 — The Winterhold Collapse — An Accounting of Records Lost
INSERT INTO tomes (id, call_number, title, author, school, body, restricted) VALUES
  (5, 'AR-V-233', 'The Winterhold Collapse — An Accounting of Records Lost', 'Tolven Aerinsson, Keeper of the Accession Roll', 'History',
   '*Prepared for the Arch-Mage, 19th of Sun''s Dawn, 4E 190. Sixty-eight years after the event.*

I was asked for a number. I am able to give a number. I want to say at the outset that the number is wrong, and that everything following is an explanation of how wrong it is and in which direction.

## The number

Four thousand one hundred and six volumes are recorded in the accession roll as held by this archive on the eve of the Collapse. Two thousand nine hundred and eighty-one volumes were recorded as held in the first complete inventory afterward, which was not begun until 4E 131 and which took two years to finish.

The difference is one thousand one hundred and twenty-five. That is the number I was asked for. That is the number that will be quoted. It is not the number of books that were lost.

## Why it is wrong

It is wrong in three ways, and they do not cancel.

First, the roll was not current. Accession stood three years in arrears at the time of the Collapse; the previous Keeper had been ill and the post was not filled promptly. An unknown quantity of material sat in the receiving room, unentered. The receiving room was on the seaward side. There is no receiving room now.

Second, the inventory of 4E 131 counted what was on the shelves, and a great deal of what was on the shelves in 4E 131 had been put there by people sorting rubble by lamplight, who were not, at that moment, cataloguers. Volumes were shelved by size. Some were shelved according to which pile they had come out of. We have spent sixty years correcting this and we are not finished.

Third — and I would ask the Arch-Mage to weigh this most heavily — a volume that survived intact but whose call number was lost is, for every practical purpose of scholarship, a volume that was lost. We hold it. We cannot find it. A reader who wants it cannot be told that it exists. I have four hundred and some such volumes in the lower stacks under provisional numbers, and I expect to die with most of them still there.

## What I would ask

Not for more staff, though I would take them.

I would ask that the number one thousand one hundred and twenty-five stop being printed as though it were a fact. It is an arithmetic operation performed upon two documents that were not measuring the same thing, sixty-eight years apart, by people who never met.

The city fell into the sea. That is the fact. The archive kept the roll it happened to be keeping, and the roll is a record of our bookkeeping, not of our losses.

:: The provisional-number stacks are worked through at perhaps thirty volumes in a year. Any student wanting a project of genuine use to the College may apply to me directly. In eleven years, nobody has. — T.A.', 0);

-- AR-VI-072 — On the Courtesy of Illusions
INSERT INTO tomes (id, call_number, title, author, school, body, restricted) VALUES
  (6, 'AR-VI-072', 'On the Courtesy of Illusions', 'Silwen Marose, Instructor in Illusion', 'Illusion',
   '*Instruction issued to the second-year cohort, Rain''s Hand 4E 199. Posted to the Arcanaeum at the cohort''s request.*

You have all passed the calm, and you are about to be taught fear. Before I teach it I am going to spend an hour on something that is not technique, and several of you will consider that hour wasted. Read this anyway.

## The problem with this school

Every other school leaves evidence. A flame leaves a mark on the stone. A ward leaves a residue a competent examiner can read for an hour afterward. A summoning is entered in a register by a bored clerk who has no stake in the matter.

Illusion leaves the subject''s memory. The subject''s memory is the one form of evidence that this school is specifically able to alter.

I am not telling you this to alarm you. I am telling you because it explains why the rules governing this school are stricter than the rules governing schools capable of setting a building on fire, and why students consistently find that unjust. Destruction is dangerous in a way that can be measured after the fact. We are dangerous in a way that cannot.

## The three questions

Before any casting upon a person who has not consented, you will ask yourself three questions. You will ask them in this order, and you will not skip the first because you have already decided its answer.

**Would they consent if asked?** Not *should* they. Would they. If the answer is yes, then ask them, and the question of illusion does not arise.

**Will they know afterward?** A calm laid upon a panicking man who is told afterward that he was calmed is a kindness. The same calm, undisclosed, is something else, and the difference is not in the spell.

**Would you do it to somebody who could stop you?** This is the useful one. It is remarkable how often a caster discovers, on being asked it, that the reason they reached for illusion was not that illusion was the right tool.

## On fear

We teach it. I have argued that we should not, and I have lost that argument twice, and having lost it I now teach the thing properly rather than badly, which I recommend to anyone in a similar position.

Fear is taught because a student who meets it without warning in the field will not recognise what is happening to them. The recognition *is* the defence. There is no ward against fear worth the name. There is only the trained habit of noticing that your alarm has arrived without a cause, and treating that as information rather than as alarm.

Practise in the chamber, in pairs, with a third present and sober. Never on the townspeople. I have expelled for this. I will do it again and I will not be sorry.

:: Students inclined to argue the disciplinary standard should read the Keeper''s position at AR-V-233 on what is and is not recoverable. It concerns books. It applies. — S.M.', 0);

-- AR-VII-013 — Transcript — Inquiry into the Hall of Countenance Incident  [RESTRICTED]
INSERT INTO tomes (id, call_number, title, author, school, body, restricted) VALUES
  (7, 'AR-VII-013', 'Transcript — Inquiry into the Hall of Countenance Incident', 'Aldis Ferrow, Clerk to the Inquiry', 'Destruction',
   '*Sealed by order of the Arch-Mage, 4th of Evening Star, 4E 187. Transcribed by Aldis Ferrow, Clerk to the Inquiry. Not for the practice roll.*

The following is the fourth and final sitting. The earlier sittings concern the establishment of times and are omitted here, those times not being in dispute.

---

**MASTER OF DESTRUCTION.** You were casting alone.

**THE APPRENTICE.** I was casting alone. I had leave.

**MASTER.** Leave from whom.

**APPRENTICE.** From Warden Faryl. It is on the practice roll. She wrote it out herself.

**MASTER.** Warden Faryl has confirmed it. I am establishing it for the record and I am not accusing you. What did you cast.

**APPRENTICE.** A flame, second rank. The same one I have cast in that chamber upward of two hundred times.

**MASTER.** And it behaved as expected.

**APPRENTICE.** It behaved exactly as expected. It went out. That is the thing I want the inquiry to understand. It went out, and I stood there perhaps a count of ten, and then the wall went.

**MASTER.** The wall.

**APPRENTICE.** The north wall of the practice chamber. Behind the panelling. I did not touch the north wall. I was not facing it.

---

*[The testimony of the Master of the Works, admitted at the third sitting, is summarised here at the direction of the Arch-Mage.]*

The north wall of the lower practice chamber was found on inspection to enclose a void of approximately eleven feet, filled to a depth of four feet with dry organic material — nesting, principally, together with the accumulated refuse of some decades. The void appears on no plan of the Hall held by this College. The Master of the Works states that it is consistent with a repair made during the reconstruction following the Collapse, in which a damaged section was faced over rather than rebuilt, and that no record of that repair exists because no record of most repairs of that period exists.

The panelling was of unsealed pine.

---

**ARCH-MAGE.** I want the finding stated plainly, Clerk, and I want it in the sealed copy.

**CLERK.** Stated, Arch-Mage.

**ARCH-MAGE.** The apprentice did nothing wrong. She followed the instruction, she had leave, the casting was competent, and it was complete before the fire began. The College put a student in a room it had not inspected in forty years and told her it was safe because we had written the word *safe* upon a door. That is the finding. It is not her failure. It is ours.

**MASTER OF DESTRUCTION.** Then why seal it.

**ARCH-MAGE.** Because I am advised that if the Jarl reads that we cannot account for the interiors of our own walls, we will be asked to account for a great deal else, and I do not believe we would survive the accounting. I am aware of what I am doing. Note that I am aware of it.

---

*Every chamber in the residential halls was opened and inspected in the year following. Four further voids were found and filled. The record of that work is open and may be consulted at the Office of the Works. The reason for the work is not stated in it.*

:: Warden Faryl''s standing instruction was rewritten the following spring and is the version now issued to apprentices at AR-II-041. The third section of it is hers entirely. The Inquiry did not ask her to write it. — Clerk''s note, 4E 194.', 1);

-- AR-VIII-055 — The Weight of Things Made Light
INSERT INTO tomes (id, call_number, title, author, school, body, restricted) VALUES
  (8, 'AR-VIII-055', 'The Weight of Things Made Light', 'Dagrun Stormvei, Instructor in Alteration', 'Alteration',
   '*Lecture notes, deposited Frostfall 4E 193. The Master of Alteration has declined to endorse these. The objection is recorded at the foot.*

Alteration is taught as the school of changing what a thing is. I want to propose, for the length of these notes, that it is better understood as the school of *holding an argument*, and that the difference matters for every practical problem a student of this school will ever meet.

## The argument

When you lighten a burden, the burden does not become light. Nothing about it changes in any way that would survive your leaving the room. What you have done is assert, continuously and at some cost to yourself, a claim about the object which the world does not accept. The world is not persuaded. It is merely, for the moment, outvoted.

This is why Alteration is tiring in a way that Destruction is not. A flame is a thing you spend and are done with. A lightened stone is a thing you are still spending on, in every moment, until you stop — and the moment you stop, the world resumes its previous opinion instantly and without any period of grace.

## Consequences a student should hold onto

**Nothing you alter is safe to leave.** A student who lightens a beam in order to move it, and then walks away, has not moved a beam. They have arranged for a beam to fall later, at an hour they will not choose, onto a person they will not know.

**Duration is not strength.** A student who can hold a heavy alteration for four seconds and a student who can hold a slight one for four hours are not ranked against one another by any measure this school possesses, and I would ask instructors to stop implying otherwise in front of the first-years.

**Water-breathing is the exception that proves the rule, and it kills people.** The alteration holds while you hold it, and not one moment longer. Fatigue is not a warning of the event; fatigue *is* the event. This is the single most reliable cause of death among students of this school, and it is always, without exception, a student who was doing well.

## On the objection

The Master of Alteration holds that the framing above is imprecise, that *argument* imports intention where none is required, and that students taught this way acquire a habit of anthropomorphising the school which must later be corrected at some cost.

I have taught it this way for nine years. I have not had to correct it once, and I have had no drownings. I record the objection because it is proper to record it, and because he may be right and I may merely have been lucky.

:: For the physical limits of a body under cold water in particular, the physician''s notes at AR-I-018 are of more use than anything in this school''s own literature. — D.S.', 0);

-- AR-IX-002 — On the Names Which Answer  [RESTRICTED]
INSERT INTO tomes (id, call_number, title, author, school, body, restricted) VALUES
  (9, 'AR-IX-002', 'On the Names Which Answer', 'Vanril Sedry, sometime Master of Conjuration', 'Daedra',
   '*Withdrawn from open shelf, 4E 161. Retained under the standing instruction of the Arcanaeum that no volume is destroyed. The author''s preface is reproduced as written.*

I have been asked to set down what I know about naming. I find that I would rather not, and that I am going to do it regardless, because the alternative is that it is set down worse by somebody who knows less.

## What a name is not

The apprentice''s understanding of a name is that it is a handle. You learn the name, you speak the name, the thing comes. This understanding produces adequate results with the lesser bound and is therefore never corrected, and that failure to correct it is, I think, the largest single error in the teaching of this school.

A name is not a handle. A handle is a thing you fix to an object for your own convenience, and the object is indifferent to it. What we call the name of a bound thing is closer to an address — and the significant property of an address is that it works in both directions. Correspondence goes out along it. Correspondence can come back along it.

## What follows

Three things follow, and I will state them without ornament.

The first is that the act of naming is not free. It costs nothing at the moment of casting, which is precisely why it is believed to be free. What it does is establish that a particular conjurer, in a particular place, was interested in a particular thing. That establishment persists. It does not decay when the summoning ends, because it was never part of the summoning.

The second is that the lesser bound do not notice. A flame atronach is not, in any sense I am able to defend, a thing that keeps records. Address it as often as you like. This is why the error remains invisible: nearly all the naming that is done is done upon things incapable of caring.

The third is that not everything a conjurer can reach is a lesser bound thing, and the boundary is not marked, and it is not marked because the things on the far side of it have no reason to mark it for us.

## On the practice of the register

The Under-Steward of the Midden keeps a column for names. I instituted that column, and I would like the reason recorded, since I am told my successors regard it as antiquarian.

It is not there to record what we called.

It is there so that if a name should appear in that book which no one entered, somebody will see it.

That has happened once. I was Master of Conjuration at the time. The entry was in my hand and I did not write it, and the College''s position — arrived at after some months of consideration, which I did not contest then and do not contest now — is that I was tired and mistaken.

I would like the column kept regardless.

:: The register is AR-III-107 and the column is still kept. Sedry resigned the mastership in 4E 160 and left the College. The registers of that period were re-copied in 4E 163; the original is not held. — Keeper''s note, undated.', 1);

-- Citations, extracted from the call numbers appearing in each body.
INSERT INTO citations (from_tome, cites_call_number) VALUES (1, 'AR-IV-118');
INSERT INTO citations (from_tome, cites_call_number) VALUES (2, 'AR-VII-013');
INSERT INTO citations (from_tome, cites_call_number) VALUES (3, 'AR-IX-002');
INSERT INTO citations (from_tome, cites_call_number) VALUES (4, 'AR-I-018');
INSERT INTO citations (from_tome, cites_call_number) VALUES (6, 'AR-V-233');
INSERT INTO citations (from_tome, cites_call_number) VALUES (7, 'AR-II-041');
INSERT INTO citations (from_tome, cites_call_number) VALUES (8, 'AR-I-018');
INSERT INTO citations (from_tome, cites_call_number) VALUES (9, 'AR-III-107');
