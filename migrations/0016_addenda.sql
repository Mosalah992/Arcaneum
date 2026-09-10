-- Volumes added after the corpus was written.
--
-- Hand-shaped rather than regenerated: migrations 0002-0012 number every id
-- in one pass, so slotting books into the middle of that sequence would
-- renumber every row after them. These take the next free ids and the
-- catalogue orders by call number, not by id.
--
-- Idempotent on the call number, so a full reseed in either order leaves one
-- row per book.

-- AR-I-011  Rislav The Righteous
DELETE FROM tomes WHERE call_number = 'AR-I-011';
INSERT INTO tomes (id, call_number, title, author, school, body, restricted) VALUES (
  (SELECT IFNULL(MAX(id), 0) + 1 FROM tomes),
  'AR-I-011', 'Rislav The Righteous', 'Anonymous', 'Biographies',
  'Like all true heroes, Rislav Larich had inauspicious beginnings. We are told by chroniclers that the springtide night in the 448th year of the first era on which he was born was unseasonably cold, and that his mother Queen Lynada died very shortly after setting eyes upon her son. If he were much beloved of his father, King Mhorus of Skingrad, who already had plenty of heirs, three sons and four daughters before him, the chroniclers make no mention of it.

His existence was so very undistinguished that we hear virtually nothing of him for the first twenty years of his life. His schooling, we can suppose, was similar to that of any "spare prince" in the Colovian West, with Ayleid tutors to teach him the ways of hunting and battle. Etiquette, religious instruction, and even basic statecraft were seldom a part of the training of a prince of the Highlands, as it was in the more civilized valley of Nibenay.

There is a brief reference to him, together with his family, as part of the rolls of honor during the coronation of the Emperor Gorieus on the 23rd of Sun''s Dawn 1E 461. The ceremony, of course, held during the time of the Alessian Doctrines of Marukh, and so was without entertainment, but the thirteen-year-old Rislav was still witness to some of the greatest figures of legend. The Beast of Anequina, Darloc Brae, represented his kingdom, giving honor to the Empire. The Chieftain of Skyrim Kjoric the White and his son Hoag were in attendance. And despite the Empire''s intolerance of all elves, chimer Indoril Nerevar and dwemer Dumac Dwarfking were evidently there as well, diplomatically representing Resdayn, all in relative peace.

Also mentioned on the rolls was a young mer in service to the Imperial court of High Rock, who was to have a great history with Rislav. Ryain Direnni.

Whether the two young men of about the same age met and conversed is entirely the stuff of historian''s fancy. Ryain is spoken of in praising words as a powerful land-owner, eventually buying the island of Balfiera in the Iliac Bay and gradually conquering all of High Rock and large parts of Hammerfell and Skyrim, but Rislav is not heard of again in history''s books for another seventeen years. We can only offer supposition based on the facts that follow.

Children of kings are, of course, married to the children of other kings to bind alliances. The kingdoms of Skingrad and Kvatch skirmished over common territory throughout the fifth century, until they reached a peace in the year 472. The details of this accord are not recorded, but since we know that Prince Rislav was in the court of Kvatch six years later, as husband to Belene, the daughter of King Justinius, it is fair to make an educated guess that they were married then to make peace.

This brings us to the year 478, when a great plague swept through all of Cyrodiil and seemed particularly concentrated in the independent Colovian West. Among the victims were King Mhorus and the rest of the entire royal family in Skingrad. Rislav''s only surviving elder brother, Dorald, survived, being in the Imperial City as a priest of Marukh. He returned to his homeland to assume the throne.

Of Dorald, we have some history. The King''s second son, he was slightly simple-minded and evidently very pious. All the chroniclers spoke of his sweetness and decency, how he saw a vision in his early years that brought him - with his father''s blessing - from Skingrad to the Imperial City and the priesthood. The priesthood of Marukh, of course, saw no difference between spiritual and political matters. It was the religion of the Alessian Empire, and it taught that to resist the Emperor was to resist the Gods. Given that, it is scarcely a surprise what Dorald did when he became King of the independent kingdom of Skingrad.

His first edict, on his very first day, was to cede the kingdom to the Empire.

The reaction throughout the Colovian Estates was shock and outrage, nowhere more so than in the court of Kvatch. Rislav Larich, we are told, rode forth to his brother''s kingdom, together with his wife and two dozen of his father-in-law''s cavalry. It was surely not an impressive army, no matter how the chroniclers embellish it, but they had little trouble defeating all the guards Dorald sent to stop them. In truth, there was no actual battling, for the soldiers of Skingrad resented their new king''s decision to give up their autonomy.

The brothers faced one another in the castle courtyard where they had grown up.

In typical Colovian fashion, there was no trial, no accusations of treason, no jury, no judge. Only an executioner.

"Thou art no brother of mine," Rislav Larich said, and struck Dorald''s head from his shoulders in one blow. He was crowned King of Skingrad still holding the same bloody axe in his arms.

If King Rislav had no battle experience beforehand, that was shortly to change. Word spread quickly to the Imperial City that Skingrad, once offered, was now being taken back. Gorieus was an accomplished warrior even before taking the throne, and the seventeen years he had as Emperor were scarcely peaceful. Only eight months before Dorald''s assassination and Rislav''s ascendancy, Gorieus and the Alessian army had faced another of his coronation guests, Kjoric the White, on the fields of the frozen north. The High Chieftain of Skyrim lost his life in the Battle of Sungard. While the pact of chieftains was selecting a new leader, Cyrodiil was busily grabbing back the land of southern Skyrim that it had lost.

In short, Emperor Gorieus knew how to deal with rebellious vassals.

The Alessian army poured westward "like a flood of death," to borrow the chronicler''s phrase, in numbers far exceeding what would be required to conquer Skingrad. Gorieus could not have thought actual battle was likely. Rislav, as we said, had little to no experience at warfare, and only a few days'' practice at kingcraft. His kingdom and all of the Colovian West had just been ravaged by plague. The Alessians anticipated that a mere show of arms, and a surrender.

Rislav instead prepared for battle. He quickly inspected his troops and drew up plans.

The chroniclers who had heretofore ignored the life of Rislav now devote verse after verse describing the king''s aspect with fetishistic delight. While it may lack literary merit and taste, we are at least given some details at last. Not surprisingly, the king wore the finest armor of his era, as the Colovian Estates then had the finest leathersmiths - the only type of armor available - in all of Tamriel. The king''s klibanion mail, boiled and waxed for hardness, and studded with inch-long spikes, was a rich chestnut red, and he wore it over his black tunic but under his black cloak. The statue of Rislav the Righteous which now stands in Skingrad is a romanticized version of king, but not inaccurate except in the armor represented. No bard of the Colovian West would have gone to the market so lightly protected. But it does, as we will see, include the most important accouterments of Rislav: his trained hawk and his fast horse.

The winter rains had washed through the roads to the south, sending much of the West Weald spilling into Valenwood. The Emperor took the northern route, and King Rislav with a small patrol of guards met him at a low pass on what is now the Gold Road. The Emperor''s army, it is said, was so large that the Beast of Anequina could hear its march from hundreds of miles away, and despite himself, the chroniclers say, he quaked in fear.

Rislav, it was said, did not quake. With perfect politeness, he told the Emperor that his party was too large to be accommodated in the tiny kingdom of Skingrad.

"Next time," Rislav said. "Write before you come."

The Emperor was, like most Alessian Emperors, not a man of great humor, and he thought Rislav touched by Sheogorath. He ordered his personal guards to arrest the poor madman, but at that moment, the King of Skingrad raised his arm and sent his hawk flying into the sky. It was a signal his army had been waiting for. The Alessian were all within the pass and the range of their arrows.

King Rislav and his guard began riding westward as fast as if they had been "kissed by wild Kynareth," as the chroniclers said. He did not dare to look behind him, but his plan went faultlessly. The far eastern end of the pass was sealed by rolling boulders, giving the Alessian no direction to go but westward. The Skingrad archers rained arrows down upon the Imperial army from far above on the plateaus, remaining safe from reprisal. The furious Emperor Gorieus chased Rislav from the Weald to the Highlands, leaving Skingrad far behind, all the while his army growing steadily smaller and smaller.

In the ancient Highland forest, the Imperial army met the army of Rislav''s father-in-law, the King of Kvatch. The Alessian army likely still outnumbered their opponents, but they were exhausted and their morale had been obliterated by the chase amid a sea of arrows. After an hour''s battle, they retreated north into what is now the Imperial Reserve, and from there, further north and east, to slip back to nurse their wounds and pride in Nibenay.

It was the beginning of the end of the Alessian hegemony. The Kings of the Colovian West joined with Kvatch and Skingrad to resist Imperial incursions. The Clan Direnni under Ryain was inspired to outlaw the religion of the Alessian Reform throughout his lands in High Rock, and began pushing into Imperial territories. The new High Chief of Skyrim, Hoag, now called Hoag Merkiller, though sharing the Emperor''s official xenophobia, also joined the resistance. His heir, King Ysmir Wulfharth of Atmora, helped continue the struggle upon Hoag''s death in battle, and also insured his place in history.

The heroic King of Skingrad, who faced the Emperor''s army virtually alone, and triggered its end, justly deserves his sobriquet of Rislav the Righteous.', 0
);

-- AR-II-009  Fire and Darkness
DELETE FROM tomes WHERE call_number = 'AR-II-009';
INSERT INTO tomes (id, call_number, title, author, school, body, restricted) VALUES (
  (SELECT IFNULL(MAX(id), 0) + 1 FROM tomes),
  'AR-II-009', 'Fire and Darkness', 'Anonymous', 'Faction Books',
  '"Brother, I still call you brother for we share our bonds of blood, tested but unbroken by hatred. Even if I am murdered, which seems inevitable now, know that, brother. You and I are not innocents, so our benedictions of mutual enmity is not tragedy, but horror. This state of silent, shadowed war, of secret poisons and sleeping men strangled in their beds, of the sudden arrow and the artful dagger, has no end that I can see. No possibility for peace. I see the shadows in the room move though the flame of my candle is steady. I know the signs that I …"

This note was found where it had fallen beneath the floorboards of an abandoned house in the Nordic village of Jallenheim in the 358th year of the second era. It was said that a quiet cobbler lived in the house, whispered by some to be a member of the dread Morag Tong, the assassin''s guild outlawed throughout Tamriel thirty-four years previously. The house itself was perfectly in order, as if the cobbler had simply vanished. There was a single drop of blood on the note.

The Dark Brotherhood had paid a call.

This note and others like it are rare. Both the Morag Tong and its hated child, the Dark Brotherhood, are scrupulous about leaving no evidence behind - their members know that to divulge secrets of their orders is a lethal infraction. This obviously makes the job of the historian seeking to trace their histories very difficult.

The Morag Tong, according to most scholars, had been a facet of the culture of Morrowind almost since its beginning. After all, the history of Resdayn, the ancient name of Morrowind, is rife with assassination, blood sacrifice, and religious zealotry, hallmarks of the order. It is commonly said that the Morag Tong then as now murdered for the glory of the Daedra Prince Mephala, but common assumptions are rarely completely accurate. It is my contention that the earliest form of the Tong additionally worshipped an even older and more malevolent deity than Mephala. As terrifying as that Prince of Oblivion is, they had and have reverence for a far greater evil.

Writs of assassination from the first era offer rare glimpses into the Morag Tong''s earliest philosophy. They are as matter of fact as current day writs, but many contain snatches of poetry which have perplexed our scholars for hundreds of years. "Lisping sibilant hisses,'' ''Ether''s sweet sway,'' ''Rancid kiss of passing sin,'' and other strange, almost insane insertions into the writs were codes for the name of the person to be assassinated, his or her location, and the time at which death was to come. They were also direct references to the divine spirit called Sithis.

Evidence of the Morag Tong''s expertise in assassination seems scarcely necessary. The few instances of someone escaping a murder attempt by them are always remarkable and rare, proving that they were and are patient, capable murderers who use their tools well. A fragment of a letter found among the effects of a well-known armorer has been sealed in our vaults for some time. It was likely penned by an unknown Tong assassin ordering weapons for his order, and offers some illumination into what they looked for in their blades, as well the mention of Vounoura, the island where the Tong sent its agents in retirement --

''I congratulate you on your artistry, and the balance and heft of your daggers. The knife blade is whisper thin, elegantly wrought, but inpractical *[sic]*. It must have a bolder edge, for arteries, when cut, have a tendencies to self seal, preventing adequate blood loss. I will be leaving Vounoura in two weeks time to inspect your new tools, hoping they will be more satisfactory.''

The Morag Tong spread quietly throughout Tamriel in the early years of the second era, worshipping Mephala and Sithis with blood, as they had always done.

When the Morag Tong assassinated the Emperor Reman in the year 2920 of the first era, and his successor, Potentate Versidae-Shae *[sic]* in the 324th year of the second era, the assassins so long in the shadows were suddenly thrust into the light. They had become brazen, drunk with murder, literally painting the words ''MORAG TONG'' on the wall in the Potentate''s blood.

The Morag Tong was instantly and unanimously outlawed in all corners of Tamriel, with the exception of its home province of Morrowind. There they continued to operate with the blessings of the Houses, apparently cutting off all contact with their satellite brothers to the west. There they continue their quasi-legal existence, accepting black writs and murdering with impunity.

Most scholars believe that the birth of the Dark Brotherhood, the secular, murder-for- profit order of assassins, was as a result of a religious schism in the Morag Tong. Given the secrecy of both cults, it is difficult to divine the exact nature of it, but certain logical assumptions can be made.

In order to exist, the Morag Tong must have appealed to the highest power in Morrowind, which at that time, the Second Era, could only have been the Tribunal of Almalexia, Sotha Sil, and Vivec. Mephala, whom the Tong worshipped with Sithis, was said to have been the Anticipation of Vivec. Is it not logical to assume that in exchange for toleration of their continued existence, the Tong would have ceased their worship of Mephala in exchange for the worship of Vivec?

The Morag Tong continues, as we know, to worship Sithis. The Dark Brotherhood is not considered a religious order by most, merely a secular organization, offering murder for gold. I have seen, however, proof positive in the form of writs to the Brotherhood that Sithis is still revered above all.

So where, the reader, asks, is the cause for the schism? How could a silent war have begun, when both groups are so close? Both assassin''s guilds, after all, worship Sithis. And yet, a figure emerges from history who should give those with this assumption pause.

The Night Mother.

Who the Night Mother is, where she came from, what her functions are, no one knows. Carlovac Townway in his generally well-researched historical fiction 2920: The Last Year of the First Era tries to make her the leader of the Morag Tong. But she is never historically associated with the Tong, only the Dark Brotherhood.

The Night Mother, my dear friend, is Mephala. The Dark Brotherhood of the west, unfettered by the orders of the Tribunal, continue to worship Mephala. They may not call her by her name, but the daedra of murder, sex, and secrets is their leader still. And they did not, and still do not, to this day, forgive their brethren for casting her aside.

The cobbler who met his end in the second era, who saw no end in the war between the Brotherhood and the Tong, was correct. In the shadows of the Empire, the Brothers of Death remain locked in combat, and they will likely remain that way forever.', 0
);

-- AR-II-010  Great Harbingers
DELETE FROM tomes WHERE call_number = 'AR-II-010';
INSERT INTO tomes (id, call_number, title, author, school, body, restricted) VALUES (
  (SELECT IFNULL(MAX(id), 0) + 1 FROM tomes),
  'AR-II-010', 'Great Harbingers', 'Anonymous', 'Faction Books',
  'This history is recorded by Swyk the Long-Sighted, of the Circle of Jorrvaskr in the 3rd era. While I am not gifted with a sharp gift of words, I have learned the stories of the Companions before me, and set to record them that they might not be lost when I am. Hereafter is the list of notable Harbingers of the Companions, those who lead us through the darkness to glories in Sovngarde.

**Notes on the Harbinger**: the Companions have never had a true leader since Ysgramor -- none have been mighty enough to corral the great hearts that beat within Jorrvaskr. While others like mages and thieves need the blessings of their hierarchy to know how to dress, we Companions are capable of leading our own destinies to glory. The Harbinger advises, resolves disputes, and helps to clarify when questions arise of the nature of honor. In the thousands of years the Companions have held at Jorrvaskr, there have been Harbingers both terrible and brilliant, those known for their arm, those for their hearts, and those for their minds. Here are listed some of the most gloried Harbingers, who inspire song and deed.

**Ysgramor**: the first Harbinger, the first Man, the bringer of Words, and the one who first bound the Companions to honor in that far off land of long ago. Better people have written of him, so I will not attempt to meet their words.

**Jeek of the River**: Captain of the Jorrvaskr during the Return, discoverer of the Skyforge, founder of Whiterun, and keeper of the original oath of the Companions, now lost to time. While other crews sought glory in conquest, his was the first to settle and serve as protector for the less war-gifted in the land as they came behind.

**Mryfwiil the Withdrawn**: Several hundred years after the death of Ysgramor, the Companions as we now know them were soldiers for hire, little better than mercenaries. Our services could be purchased for the fighting of wars, but the commitment to individual honor meant that often Shield-Brothers would be forced to face each other on the field of battle. The bonds of honor which bind the Companions threaten *[sic]* to break, until Mryfwiil, in his wisdom, decreed that we would no longer be party to any war or political conflict of any kind. Because of his steady hand, the Companions today are known as impartial arbiters of honor, in addition to their glories on the field of battle.

**Cirroc the Lofty**: The first Harbinger to not be of ancestral Atmoran blood. This was around the time that the Nords began to think of themselves as such, and there were great disputes about purity and the legacy of Ysgramor. Cirroc first came to Jorrvaskr as a servant, but the Redguard quickly proved his mettle when treated disrespectfully by one of the less honor-bound warriors of the time. Granted the stature of an honorary Companion after saving the life of Harbinger Tulvar the Unmentioned, he became known as the most capable of Shield-Brothers in the hall, with speed and cunning surpassing any of the old Atmoran stock. His time as Harbinger was short-lived, but it is said that his field knowledge of bladework continues to pass to every new Companion through their training.

**Henantier the Outsider**: The first elven Harbinger. Like Cirroc before him, he was initially subject to ridicule when arriving at Jorrvaskr, for this was the time (near the closing of the first era) when elves were not permitted to be full Companions, and few were even allowed to see the inside of the hall. Henantier was humble in the daylight hours, performing any task asked of him. At night, he trained fiercely in the outside yard, allowing himself only minutes of sleep before resuming his servant duties the next day. So he toiled through several Harbingers, never resting, never complaining, and always keeping his mind and body sharp. Given his long life, he came to be trusted by the new Companions as the one who them learn *[sic]* the ways of honor.

When one such pupil had aged into an old man and become Harbinger himself, Henantier was the one at his deathbed. With all Companions assembled, he named Henantier as his successor, saying "even an elf can be born with the heart of a Nord sometimes." There were some number of Companions who laid down their weapons that day, but those who remained knew the truth of honor, and it is their legacy we continue to bear.

**Macke of the Piercing Eyes**: A Harbinger known for her great beauty, but any who underestimated her on account of it would never make the mistake again. Was said to have once stared down half an opposing army, then slaughtered the remainder single-handedly. Her disappearance in her 8th year as Harbinger has never been explained, though many slanderous lies claim to make accountings for it.

**Kyrnil Long-Nose**: After the dark periods in the late second era, when a string of false and dishonorable Harbingers laid claim to Jorrvaskr, it was Kyrnil Long-Nose who gathered the true hearts of the Companions in the wilds and stormed Jorrvaskr itself, killing the usurpers and returning honor through blood, in the old ways. He began the tradition of trusted advisors called the Circle (after our great lord Ysgramor''s council of captains) who would serve as examples to the younger, newer Companions.

By ensuring that the notions of honor can have an unbroken string of tradition, he steadied the course of the Companions and restored our destinies to that of Ysgramor''s, pressing ever onwards to Sovngarde.', 0
);

-- AR-II-011  Ice and Chitin
DELETE FROM tomes WHERE call_number = 'AR-II-011';
INSERT INTO tomes (id, call_number, title, author, school, body, restricted) VALUES (
  (SELECT IFNULL(MAX(id), 0) + 1 FROM tomes),
  'AR-II-011', 'Ice and Chitin', 'Anonymous', 'Faction Books',
  'The tale dates to the year 855 of the Second Era, after General Talos had taken the name Tiber Septim and begun his conquest of Tamriel. One of his commanding officers, Beatia of Ylliolos, had been surprised in an ambush while returning from a meeting with the Emperor. She and her personal guard of five soldiers barely escaped, and were separated from their army. They fled across the desolate, sleet-painted rocky cliffs by foot. The attack had been so sudden, they had not even the time to don armor or get to their horses.

"If we can get to the Gorvigh Ridge," hollered Lieutenant Ascutus, gesturing toward a peak off in the mist, his voice barely discernible over the wind. "We can meet the legion you stationed in Porhnak."

Beatia looked across the craggy landscape, through the windswept hoary trees, and shook her head: "Not that way. We''ll be struck down before we make it halfway to the mountain. You can see their horses'' breath through the trees."

She directed her guard toward a ruined old keep on the frozen isthmus of Nerone, across the bay from Gorvigh Ridge. Jutting out on a promontory of rock, it was like many other abandoned castles in northern Skyrim, remnants of Reman Cyrodiil''s protective shield against the continent of Akavir. As they reached their destination and made a fire, they could hear the army of the warchiefs of Danstrar behind them, making camp on the land southwest, blocking the only escape but the sea. The soldiers assessed the stock of the keep while Beatia looked out to the fog-veiled water through the casements of the ruin.

She threw a stone, watching it skip across the ice trailing puffs of mist before it disappeared with a splash into a crack in the surface.

"No food or weaponry to be found, commander," Lieutenant Ascutus reported. "There''s a pile of armor in storage, but it''s definitely taken on the elements over the years. I don''t know if it''s salvageable at all."

"We won''t last long here," Beatia replied. "The Nords know that we''ll be vulnerable when night falls, and this old rock won''t hold them off. If there''s anything in the keep we can use, find it. We have to make it across the ice floe to the Ridge."

After a few minutes of searching and matching pieces, the guards presented two very grimy, scuffed and cracked suits of chitin armor. Even the least proud of the adventurers and pirates who had looted the castle over the years had thought the shells of chitin beneath their notice. The soldiers did not dare to clean them: the dust looked to be the only adhesive holding them together.

"They won''t offer us much protection, just slow us down," grimaced Ascutus. "If we run across the ice as soon as it gets dark--"

"Anyone who can plan and execute an ambush like the warchiefs of Danstrar will be expecting that. We need to move quickly, now, before they''re any closer." Beatia drew a map of the bay in the dust, and then a semicircular path across the water, an arc stretching from the castle to the Gorvigh Ridge. "The men should go the long way across the bay like so. The ice is thick there a ways from the shoreline, and there are a lot of rocks for cover."

"You''re not staying behind to hold the castle!"

"Of course not," Beatia shook her head and drew a straight line from the castle to the closest shore across the Bay. "I''ll take one of the chitin suits, and try to cross the water here. If you don''t see or hear me when you''ve made it to land, don''t wait -- just get to Porhnak."

Lieutenant Ascutus tried to dissuade his commander, but he knew that she was *[sic]* would never order one of her men to perform the suicidal act of diversion, that all would die before they reached Gorvigh Ridge if the warlords'' army was not distracted. He could find only one way to honor his duty to protect his commanding officer. It was not easy convincing Commander Beatia that he should accompany her, but at last, she relented.

The sun hung low but still cast a diffused glow, illuminating the snow with a ghostly light, when the five men and one woman slipped through the boulders beneath the castle to the water''s frozen edge. Beatia and Ascutus moved carefully and precisely, painfully aware of each dull crunch of chitin against stone. At their commander''s signal, the four unarmored men dashed towards the north across the ice.

When her men had reached the first fragment of cover, a spiral of stone jutting a few yards from the base of the promontory, Beatia turned to listen for the sound of the army above. Nothing but silence. They were still unseen. Ascutus nodded, his eyes through the helm showing no fear. The commander and her lieutenant stepped onto the ice and began to run.

When Beatia had surveyed the bay from the castle ramparts, the crossing closest to shore had seemed like a vast, featureless plane of white. Now that she was down on the ice, it was even more flat and stark: the sheet of mist rose only up their ankles, but it billowed up at their approach like the hand of nature itself was pointing out their presence to their enemies. They were utterly exposed. It came almost as a relief when Beatia heard one of the warchiefs'' scouts whistle a signal to his masters.

They didn''t have to turn around to see if the army was coming. The sound of galloping hoofs and the crash of trees giving way was very clear over the whistling wind.

Beatia wished she could risk a glance to the north to see if her men were hidden from view, but she didn''t dare. She could hear Ascutus running to her right, keeping pace, breathing hard. He was used to wearing heavier armor, but the chitin joints were so brittle and tight from years of disuse, it was all he could do to bend them.

The rocky shore to the Ridge still looked at eternity away when Beatia felt and heard the first volley of arrows. Most struck the ice at their feet with sharp cracking sounds, but a few nearly found home, ricocheting off their backs. She silently offered a prayer of thanks to whatever anonymous shellsmith, now long dead, had crafted the armor. They continued to run, as the first rain of arrows was quickly followed by a second and a third.

"Thank Stendarr," Ascutus gasped. "If there was only leather in the keep, we''d be pierced through and through. Now if only it weren''t... so rigid..."

Beatia felt her own armor joints begin to set, her knees and hips finding more and more resistance with every step. There could be no denying it: they were drawing closer toward the shore, but they were running much more slowly. She heard the first dreadful galloping crunch of the army charging across the floe toward them. The riders were cautious on the slippery ice, not driving their horses at full speed, but Beatia knew that they would be upon the two of them soon.

The old chitin armor could withstand the bite of a few arrows, but not a lance driven with the force of a galloping horse. The only great unknown was time.

The thunder of beating hooves was deafening behind them when Ascutus and Beatia reached the edge of the shore. The giant, jagged stones that strung around the beach blockaded the approach. Beneath their feet, the ice sighed and crackled. They could not stand still, run forward, nor run back. Straining against the tired metal in the armor joints, they took two bounds forward and flew at the boulders.

The first landing on the ice sounded an explosive crack. When they rose for the final jump, it was on a wave of water so cold it felt like fire through the thin armor. Ascutus''s right hand found purchase in a deep fissure. Beatia gripped with both hands, but her boulder was slick with frost. Faces pressed to the stone, they could not turn to face the army behind them.

But they heard the ice splintering, and the soldiers cry out in terror for just an instant. Then there was no sound but the whining of the wind and the purring lap of the water. A moment later, there were footsteps on the cliff above.

The four guardsmen had crossed the bay. There were two to pull Beatia up from the face of the boulder, and another two for Ascutus. They strained and swore at the weight, but finally they had their commander and her lieutenant safely on the edge of Gorvigh Ridge.

"By Mara, that''s heavy for light armor."

"Yes," smiled Beatia wearily, looking back over the empty broken ice floe, the cracks radiating from the parallel paths she and Ascutus had run. "But sometimes that''s good."', 0
);

-- AR-III-039  King
DELETE FROM tomes WHERE call_number = 'AR-III-039';
INSERT INTO tomes (id, call_number, title, author, school, body, restricted) VALUES (
  (SELECT IFNULL(MAX(id), 0) + 1 FROM tomes),
  'AR-III-039', 'King', 'Anonymous', 'Fiction',
  'Gentle reader, you will not understand a word of what follows unless you have read and commited *[sic]* to memory the first three volumes in this series, ''Beggar,'' ''Thief,'' and ''Warrior,'' which leads up to this, the conclusion. I encourage you to seek them out at your favorite bookseller.

We last left Eslaf Erol fleeing for his life, which was a common enough occurance *[sic]* for him. He had stolen a lot of gold, and one particularly large gem, from a rich man in Jallenheim named Suoibud. The thief fled north, spending the gold wildly, as thieves generally do, for all sorts of illicit pleasures, which would no doubt disturb the gentleman or lady reading this, so I will not go into detail.

The one thing he held onto was the gem.

He didn''t keep it because of any particular attachment, but because he did not know anyone rich enough to buy it from him. And so he found himself in the ironic situation of being penniless and having in his possession a gem worth millions.

''Will you give me a room, some bread, and a flagon of beer in exchange for this?'' he asked a tavernkeep in the little village of Kravenswold, which was so far north, it was half situated on the Sea of Ghosts.

The tavernkeep looked at it suspiciously.

''It''s just crystal,'' Eslaf said quickly. ''But isn''t it pretty?''

''Let me see that,'' said a young armor-clad woman at the end of the bar. Without waiting permission, she picked up the gem, studied it, and smiled not very sweetly at Eslaf. ''Would you join me at my table?''

''I''m actually in a bit of a hurry,'' replied Eslaf, holding out his hand for the stone. ''Another time?''

''Out of respect for my friend, the tavernkeep here, my men and I leave our weapons behind when we come in here,'' the woman said casually, not handing the gem back, but picking up a broom that was sitting against the bar. ''I can assure you, however, that I can use this quite effectively as a blunt instrument. Not a weapon, of course, but an instrument to stun, medicinally crush a bone or two, and then - once it is on the inside ...''

''Which table?'' asked Eslaf quickly.

The young woman led him to a large table in the back of the tavern where ten of the biggest Nord brutes Eslaf had ever seen were sitting. They looked at him with polite disinterest, as if he were a strange insect, worth briefly studying before crushing.

''My name is Laicifitra,'' she said, and Eslaf blinked. That was the name Suoibud had uttered before Eslaf had made his escape. ''And these are my lieutenants. I am the commander of a very large independent army of noble knights. The very best in Skyrim. Most recently we were given a job to attack a vineyard in The Aalto to force its owner, a man named Laernu, to sell to our employer, a man named Suoibud. Our payment was to be a gem of surpassing size and quality, quite famous and unmistakable.

''We did as we were asked, and when we went to Suoibud to collect our fee, he told us he was unable to pay, due to a recent burglary. In the end, though, he saw things our way, and paid us an amount of gold almost equal to the worth of the prize jewel … It did not empty out his treasury entirely, but it meant he was unable to buy the land in the Aalto after all. So we were not paid enough, Suoibud has taken a heavy financial blow, and Laernu''s prize crop of Jazbay has been temporarily destroyed for naught,'' Laicifitra took a long, slow drink of her mead before continuing. ''Now, I wonder, could you tell me, how came you in the possession of the gem we were promised?''

Eslaf did not answer at once.

Instead, he took a piece of bread from the plate of the savage bearded barbarian on his left and ate it.

''I''m sorry,'' he said, his mouth full. ''May I? Of course, I couldn''t stop you from taking the gem even if I wanted to, and as a matter of fact, I don''t mind at all. It''s also useless to deny how it came into my possession. I stole it from your employer. I certainly didn''t mean you or your noble knights any harm by it, but I can understand why the word of a thief is not suitable for one such as yourself.''

''No,'' replied Laicifitra, frowning, but her eyes showing amusement. ''Not suitable at all.''

''But before you kill me,'' Eslaf said, grabbing another piece of bread. ''Tell me, how suitable is it for noble knights such as yourself to be paid twice for one job? I have no honor myself, but I would have thought that since Suoibud took a profit loss to pay you, and now you have the gem, your handsome profit is not entirely honorable.''

Laicifitra picked up the broom and looked at Eslaf. Then she laughed, ''What is your name, thief?''

''Eslaf,'' said the thief.

''We will take the gem, as it was promised to us. But you are right. We should not be paid twice for the same job. So,'' said the warrior woman, putting down the broomstick. ''You are our new employer. What would you have your own army do for you?''

Many people could find quite a few good uses for their own army, but Eslaf was not among them. He searched his brain, and finally it was decided that it was a debt to be paid later. For all her brutality, Laicifitra was an *[sic]* simple woman, raised, he learned, by the very army she commanded. Fighting and honor were the only things she knew.

When Eslaf left Kravenswold, he had an army at his beck and call, but not a coin to his name. He knew he would have to steal something soon.

As he wandered the woods, scrounging for food, he was beset with a strange feeling of familiarity. These were the very woods he had been in as a child, also starving, also scrounging. When he came out on the road, he found that he had come back on the kingdom where he had been raised by the dear, stupid, shy maid Drusba.

He was in Erolgard.

It had fallen even deeper into despair since his youth. The shops that had refused him food were boarded up, abandoned. The only people left were hollow, hopeless figures, so ravaged by taxation, despotism, and barbaric raids that they were too weak to flee. Eslaf realized how lucky he was to have gotten out in his youth.

There was, however, a castle and a king. Eslaf immediately made plans to raid the treasury. As usual, he watched the place carefully, taking note of the security and the habits of the guards. This took some time. In the end, he realized there was no security and no guards.

He walked in the front door, and down the empty corridors to the treasury. It was full of precisely nothing, except one man. He was Eslaf''s age, but looked much older.

''There''s nothing to steal,'' he said. ''Would that there was.''

King Ynohp, though prematurely aged, had the same white blond hair and blue eyes like broken glass that Eslaf had. In fact, he resembled Suoibud and Laicifitra as well. And though Eslaf had never met the ruined landlord of the Aalto, Laernu, he looked him too. Not surprisingly, since they were quintuplets.

''So, you have nothing?'' asked Eslaf, gently.

''Nothing except my poor kingdom, curse it,'' the King grumbled. ''Before I came to the throne, it was powerful and rich, but I inherited none of that, only the title. For my entire life, I''ve had responsibility thrust on my shoulders, but never had the means to handle it properly. I look over the desolation which is my birthright, and I hate it. If it were possible to steal a kingdom, I would not lift a finger to stop you.''

It was, it turned out, quite possible to steal a kingdom. Eslaf became known as Ynohp, a deception easily done given their physical similarities. The real Ynohp, taking the name of Ylekilnu, happily left his demesne, becoming eventually a simple worker in the vineyards of The Aalto. For the first time free of responsibility, he fell into his new life with gusto, the years melting off him.

The new Ynohp called in his favor with Laicifitra, using her army to restore peace to the kingdom of Erolgard. Now that it was safe, business and commerce began to return to the land, and Eslaf reduced the tyrannical taxes to encourage it to grow. Upon hearing that, Suoibud, ever nervous about losing his money, elected to return to the land of his birth. When he died years later, out of greed, he had refused to name someone an heir, so the kingdom received its entire fortune.

Eslaf used part of the gold to buy the vineyards of The Aalto, after hearing great things of it from Ynohp.

And so it was that Erolgard was returned to its previous prosperity by the fifth born child of King Ytluaf - Eslaf Erol, beggar, thief, warrior (of sorts), and king.', 0
);

-- AR-III-040  Legend of Krately House
DELETE FROM tomes WHERE call_number = 'AR-III-040';
INSERT INTO tomes (id, call_number, title, author, school, body, restricted) VALUES (
  (SELECT IFNULL(MAX(id), 0) + 1 FROM tomes),
  'AR-III-040', 'Legend of Krately House', 'Anonymous', 'Fiction',
  'DRAMATIS PERSONAE

THEOPHON - Imperial man, 24, thief

NIRIM - Bosmer man, 20, thief

SILANUS *[sic]* KRATELY - Imperial man, 51, merchant

DOMINITIA KRATELY - His wife, 40

AELVA KRATELY - Their daughter, 16

MINISTES KRATELY - Their son, 11

Setting: The famous haunted Krately House in Cheydinhal, first and second floors, requiring a stage with a second story where most of the action takes place.

*The stage is dark.*
*There is a CREAKING noise, footsteps on the stairs, the sound of a man breathing, but still we see nothing.*
*Then, a voice calls from above.*

AELVA (off stage): Hello? Is someone down there?

MINESTES *[sic]* (off stage): Should I wake up Papa?

AELVA (off stage): No... Maybe I was imagining it...

*A light from a lantern can be seen coming from the upstairs, and the slim form of a beautiful young girl, AELVA, descends the staircase at stage right, nervously.*
*From the light of the lantern, we can see that we are looking at the second floor of a dusty old house, with a set of stairs going up and another one going down on stage right. An unlit stone fireplace sits at stage left. A table, a locked chest, and a wardrobe complete the furnishings.*
MINESTES *[sic]* (off stage): Aelva, what are you doing?

AELVA: I''m just making certain... Go back to bed, Minestes *[sic]*.

*As the girl passes the table, we see a Bosmer NIRIM slide gracefully up from behind and around her field of sight, carefully avoiding the pool of light. She doesn''t appear to see him as he creeps closer to her, his footsteps silent on the hard wooden floor.*
*When he is almost on her, there is a sudden CRASH from down below. This causes the Bosmer to leap away, hiding again behind the table.*
*The girl does not seem to notice the sound, and Nirim, peeking out from behind the table, watches her.*
MINESTES *[sic]* (off stage): Found anything?

AELVA: No. Probably just my imagination, but I''m just going to check downstairs.

MINESTES *[sic]* (off stage): Is there a fire? I''m cold...

*Aelva looks towards the long dead fireplace, and so does Nirim.*
AELVA: Of course there is. Can''t you hear it crackling?

MINESTES *[sic]* (off stage): I guess so...

*Aelva suddenly jumps as if she heard something which we do not. She turns her attention down the stairs to the first floor.*
AELVA: Hello?

*Aelva, lantern ahead of her, begins the descent. She does not seem to notice as an Imperial, THEOPHON, carrying a big bag of loot and a lantern of his own, calmly walks up right past her.*
THEOPHON: Excuse me, young lady. Just robbing you.

*Aelva continues her slow, nervous walk downstairs, which we can now see thanks to her light. She looks around the low-ceilinged, thoroughly looted room as the action continues upstairs *[sic]**
*Theophon''s lantern provides the dim light for the second floor.*
THEOPHON: Why are you hiding, Nirim? I told you. They can''t see you, and they can''t hear you.

*Nirim sheepishly steps out from behind the table.*
NIRIM: I can''t believe they''re all ghosts. They seem so alive.

THEOPHON: That''s what spooks them superstitians. But they ain''t going to hurt us. Just reliving the past, the way ghosts do.

NIRIM: The night they was murdered.

THEOPHON: Stop thinking about that or you''ll get yourself all willy spooked. I got all kinds of stuff on the first floor - silver candlesticks, silk, even some gold... What''d you get?

*Nirim holds up his empty bag.*
NIRIM: Sorry, Theophon, I was just about to start...

THEOPHON: Get to work on that chest then. That''s what you''re here for.

NIRIM: Oh yeah. I got the talent, you got the ideas... and the equipment. You refilled that lantern before we came here, right? I can''t work in the dark...

THEOPHON: Don''t worry, Nirim. I promise. No surprises.

*Nirim jumps when a young boy, MINESTES *[sic]*, appears on the stairs. The lad creeps down quietly and goes to the fire. He acts as if he''s stoking a fire, feeding it wood, poking at the embers, though there is no wood, no poker, no fire.*
THEOPHON: We got all the time in the world, friend. No one comes near this house. If they sees our lantern light, they''ll just assume it''s the ghosts.

*Nirim begins picking the lock on a chest of drawers, while Theophon opens a wardrobe and begins going through the contents, which are mostly rotten cloth.*
*Nirim is distracted, looking at the young boy.*
NIRIM: Hey, Theophon, how long ago did they die?

THEOPHON: About five years ago. Why you asking?

NIRIM: Just making conversation.

*As they talk, Aelva, downstairs, finally having searched the small room, acts as if she''s locking the front door.*
THEOPHON: Didn''t I already tell you the story?

NIRIM: No, you just said, hey, I know a place we can burgle where no one''s at home, except for the ghosts. I thought you was joking.

THEOPHON: No joking, partner. Five years ago, the Kratelys lived here. Nice people. You seen the daughter Aelva and the boy Minestes *[sic]*. The parents were Silenus and Dominitia, if I remembers rightly.

*Nirim successfully unlocks the chest and begins rummaging through it. While he does so, Ministes gets up from the ''fire,'' apparently warmed up, and stands at the top of the stairs down.*
MINISTES: Hey!

*The boy''s voice causes Nirim, Theophon, and Aelva to all jump.*
AELVA: Why aren''t you in bed? I''m just going to check the cellar.

MINISTES: I''ll wait for you.

NIRIM: So, what happened?

THEOPHON: Oh, they was rip to piece. Halfway eaten. No one ever knew who or what did it neither. Though there was rumors...

*Aelva opens the door to the cellar, and goes in. The light disappears from the first floor. Ministes patiently waits at the top of the stairs, humming a little song to himself.*
NIRIM: What kind of rumors?

*Theophon, having exhausted the possibilities in the wardrobe, helps Nirim sort through the gold in the chest.*
THEOPHON: Pretty good haul, eh? Oh, the rumors. Well, they says old lady Dominitia was a witch before she married Silenus. Gave it all up for him, to be a good wife and mother. But the witches didn''t take too kindly to it. They found her and sent some kind of creature here, late at night. Something horrible, right out of a nightmare.

MINISTES: Aelva? Aelva, what''s taking you so long?

NIRIM: Ye Gods, are we going to watch them get killed, right in front of us?

MINISTES: Aelva!

SILENUS (off stage): What''s happening down there? Stop playing around, boy, and go to sleep.

MINISTES: Papa!

*Ministes, frightened, runs to the stairs up. Along the way, he bumps into Nirim, who falls down. The boy does not seem to notice but continues on up to the dark third floor sleeping porch, off-stage.*
THEOPHON: Are you all right?

*Nirim jumps to his feet, white-faced.*
NIRIM: Never mind that! He touched me?! How can a ghost touch me?!

THEOPHON: Well... Of course they can. Some anyhow. You heard of ancestor spirits guarding tombs, and that ghost of the king they had in Daggerfall. If they don''t touch you, what good are they ? Why you so surprised? You thought he''d move right through you, I figger.

NIRIM: Yes!

SILENUS, the man of the house, comes down the stairs, cautiously.

DOMINITIA (off stage): Don''t leave us alone, Silenus! We''re coming with you!

SILENUS: Wait, it''s dark. Let me get some light.

*Silenus goes to the cold fireplace, sticks his hand forward, and suddenly in his arm, there''s a lit, burning torch. Nirim scrambles back, horrified.*
NIRIM: I felt that! I felt the heat of the fire!

SILENUS: Come on down. It''s all right.

*Ministes leads his mother DOMINITIA down the stairs where they join Silenus.*
THEOPHON: I don''t know why you so scared, Nirim. I must say I''m disappointed. I didn''t figger you for a supersitionalist *[sic]*.

*Theophon goes for the stairs up.*
NIRIM: Where are you going?

THEOPHON: One more floor to search.

NIRIM: Can''t we just go?

*Nirim watches as the family of three, following Silenus and his torch, walk down towards the first floor.*
SILENUS: Aelva? Say something, Aelva.

THEOPHON: There, you see? If you don''t like ghosts, third floor''s the place to be. All four of em are downstairs now.

*Theophon goes upstairs, off-stage, but Nirim stands at the top of the stairs, looking down at the family. The three look around the first floor as Aelva did, finally turning towards the cellar door.*
NIRIM: All... four?

*Silenus opens the cellar door.*
SILENUS: Aelva? What are you doing down in the cellar, girl?

DOMINITIA: You see her?

NIRIM: All four, Theophon?

SILENUS: I think so... I see someone... Hello?

NIRIM: What if there''s five ghosts, Theophon?!

*Silenus thrusts his torch in through the cellar door, and it is suddenly extinguished. The first floor falls into darkness.*
*Ministes, Dominitia, and Silenus SCREAM, but we cannot see what is happening to them.*
*Nirim is nearly hysterical, screaming along with them. Theophon runs downstairs from the third floor.*
THEOPHON: What is it?!

NIRIM: What if there is five ghosts?! The man, the wife, the girl, the boy... and what killed them?!

THEOPHON: And what killed them?

NIRIM: And what if it''s a ghost that can touch us too?! Just like the others!

*From the darkened first floor, there is a CREAK of a door opening, though we cannot see it. And then, there is a heavy, clawed footfall. One step at a time, coming towards the stairs.*
THEOPHON: Don''t get so upset. If it can touch us, what''d make you think it''d wants to? All the others didn''t even notice we was here.

*Theophon''s lantern dims slightly. He adjusts it carefully.*
NIRIM: Only... only what if it ain''t a ghost, Theophon. What if it''s the same creature, and it''s still alive... and it ain''t ate nothing since five years ago...

*The footsteps begin the slow, heavy stomp up the stairs, though whatever it is, we cannot see it. Nirim notices the light beginning to dim from the lantern despite Theophon frantically trying to fix it.*
NIRIM: You said you refilled the lamp!

*The light goes out entirely, and the stage is filled with darkness.*
NIRIM: You promised me you refilled the lamp!

*More footsteps and a horrible, horrible HOWL. The men SCREAM.*
*The curtain falls.*', 0
);

-- AR-III-041  Night Falls on Sentinel
DELETE FROM tomes WHERE call_number = 'AR-III-041';
INSERT INTO tomes (id, call_number, title, author, school, body, restricted) VALUES (
  (SELECT IFNULL(MAX(id), 0) + 1 FROM tomes),
  'AR-III-041', 'Night Falls on Sentinel', 'Anonymous', 'Fiction',
  'No music played in the Nameless Tavern in Sentinel, and indeed there was very little sound except for discreet, cautious murmurs of conversation, the soft pad of the barmaid''s feet on stone, and the delicate slurping of the regular patrons, tongues lapping at their flagons, eyes focused on nothing at all. If anyone were less otherwise occupied, the sight of the young Redguard woman in a fine black velvet cape might have aroused surprise. Even suspicion. As it were, the strange figure, out of place in an underground cellar so modest it had no sign, blended into the shadows.

"Are you Jomic?"

The stout, middle-aged man with a face older than his years looked up and nodded. He returned to his drink. The young woman took the seat next to him.

"My name is Haballa," she said and pulled out a small bag of gold, placing it next to his mug.

"Sure it be," snarled Jomic, and met her eyes again. "Who d''you want dead?"

She did not turn away, but merely asked, "Is it safe to talk here?"

"No one cares about nobody else''s problems but their own here. You could take off your cuirass and dance bare-breasted on the table, and no one''d even spit," the man smiled. "So who d''you want dead?"

"No one, actually," said Haballa. "The truth is, I only want someone ... removed, for a while. Not harmed, you understand, and that''s why I need a professional. You come highly recommended."

"Who you been talking to?" asked Jomic dully, returning to his drink.

"A friend of a friend of a friend of a friend."

"One of them friends don''t know what he''s talking about," grumbled the man. "I don''t do that any more."

Haballa quietly took out another purse of gold and then another, placing them at the man''s elbow. He looked at her for a moment and then poured the gold out and began counting. As he did, he asked, "Who d''you want removed?"

"Just a moment," smiled Haballa, shaking her head. "Before we talk details, I want to know that you''re a professional, and you won''t harm this person very much. And that you''ll be discreet."

"You want discreet?" the man paused in his counting. "Awright, I''ll tell you about an old job of mine. It''s been - by Arkay, I can hardly believe it - more ''n twenty years, and no one but me''s alive who had anything to do with the job. This is back afore the time of the War of Betony, remember that?"

"I was just a baby."

"''Course you was," Jomic smiled. "Everyone knows that King Lhotun had an older brother Greklith what died, right? And then he''s got his older sister Aubki, what married that King fella in Daggerfall. But the truth''s that he had two elder brothers."

"Really?" Haballa''s eyes glistened with interest.

"No lie," he chuckled. "Weedy, feeble fella called Arthago, the King and Queen''s first born. Anyhow, this prince was heir to the throne, which his parents wasn''t too thrilled about, but then the Queen she squeezed out two more princes who looked a lot more fit. That''s when me and my boys got hired on, to make it look like the first prince got took off by the Underking or some such story."

"I had no idea!" the young woman whispered.

"Of course you didn''t, that''s the point," Jomic shook his head. "Discretion, like you said. We bagged the boy, dropped him off deep in an old ruin, and that was that. No fuss. Just a couple fellas, a bag, and a club."

"That''s what I''m interested in," said Haballa. "Technique. My... friend who needs to be taken away is weak also, like this Prince. What is the club for?"

"It''s a tool. So many things what was better in the past ain''t around no more, just ''cause people today prefer ease of use to what works right. Let me explain: there''re seventy-one prime pain centers in an average fella''s body. Elves and Khajiiti, being so sensitive and all, got three and four more respectively. Argonians and Sloads, almost as many at fifty-two and sixty-seven," Jomic used his short stubby finger to point out each region on Haballa''s body. "Six in your forehead, two in your brow, two on your nose, seven in your throat, ten in your chest, nine in your abdomen, three on each arm, twelve in your groin, four in your favored leg, five in the other."

"That''s sixty-three," replied Haballa.

"No, it''s not," growled Jomic.

"Yes, it is," the young lady cried back, indignant that her mathematical skills were being question *[sic]*: "Six plus two plus two plus seven plus ten plus nine plus three for one arm and three for the other plus twelve plus four plus five. Sixty-three."

"I must''ve left some out," shrugged Jomic. "The important thing is that to become skilled with a staff or club, you gotta be a master of these pain centers. Done right, a light tap could kill, or knock out without so much as a bruise."

"Fascinating," smiled Haballa. "And no one ever found out?"

"Why would they? The boy''s parents, the King and Queen, they''re both dead now. The other children always thought their brother got carried off by the Underking. That''s what everyone thinks. And all my partners are dead."

"Of natural causes?"

"Ain''t nothing natural that ever happens in the Bay, you know that. One fella got sucked up by one of them Selenu. Another died a that same plague that took the Queen and Prince Greklith. ''Nother fella got hisself beat up to death by a burglar. You gotta keep low, outta sight, like me, if you wanna stay alive." Jomic finished counting the coins. "You must want this fella out of the way bad. Who is it?"

"It''s better if I show you," said Haballa, standing up. Without a look back, she strode out of the Nameless Tavern.

Jomic drained his beer and went out. The night was cool with an unrestrained wind surging off the water of the Iliac Bay, sending leaves flying like whirling shards. Haballa stepped out of the alleyway next to the tavern, and gestured to him. As he approached her, the breeze blew open her cape, revealing the armor beneath and the crest of the King of Sentinel.

The fat man stepped back to flee, but she was too fast. In a blur, he found himself in the alley on his back, the woman''s knee pressed firmly against his throat.

"The King has spent years since he took the throne looking for you and your collaborators, Jomic. His instructions to me what to do when I found you were not specific, but you''ve given me an idea."

From her belt, Haballa removed a small sturdy cudgel.

A drunk stumbling out of the bar heard a whimpered moan accompanied by a soft whisper coming from the darkness of the alley: "Let''s keep better count this time. One. Two. Three. Four. Five. Six. Seven..."', 0
);

-- AR-III-042  The Armorer's Challenge
DELETE FROM tomes WHERE call_number = 'AR-III-042';
INSERT INTO tomes (id, call_number, title, author, school, body, restricted) VALUES (
  (SELECT IFNULL(MAX(id), 0) + 1 FROM tomes),
  'AR-III-042', 'The Armorer''s Challenge', 'Anonymous', 'Fiction',
  'Three hundred years ago, when Katariah became Empress, the first and only Dunmer to rule all of Tamriel, she faced opposition from the Imperial Council. Even after she convinced them that she would be the best regent to rule the Empire while her husband Pelagius sought treatment for his madness, there was still conflict. In particular from the Duke of Vengheto, Thane Minglumire, who took a particular delight in exposing all of the Empress''s lack of practical knowledge.

In this particular instance, Katariah and the Council were discussing the unrest in Black Marsh and the massacre of Imperial troops outside the village of Armanias. The sodden swampland and the sweltering climate, particular in summertide, would endanger the troops if they wore their usual armor.

"I know a very clever armorer," said Katariah, "His name is Hazadir, an Argonian who knows the environments our army will be facing. I knew him in Vivec where he was a slave to the master armorer there, before he moved to the Imperial City as a freedman. We should have him design armor and weaponry for the campaign."

Minglumire gave a short, barking laugh: "She wants a slave to design the armor and weaponry for our troops! Sirollus Saccus is the finest armorer in the Imperial City. Everyone knows that."

After much debate, it was finally decided to have both armorers contend for the commission. The Council also elected two champions of equal power and prowess, Nandor Beraid and Raphalas Eul, to battle using the arms and armaments of the real competitors in the struggle. Whichever champion won, the armorer who supplied him would earn the Imperial commission. It was decided that Beraid would be outfitted by Hazadir, and Eul by Saccus.

The fight was scheduled to commence in seven days.

Sirollus Saccus began work immediately. He would have preferred more time, but he recognized the nature of the test. The situation in Armanias was urgent. The Empire had to select their armorer quickly, and once selected, the preferred armorer had to act swiftly and produce the finest armor and weaponry for the Imperial army in Black Marsh. It wasn''t just the best armorer they were looking for. It was the most efficient.

Saccus had only begun steaming the half-inch strips of black virgin oak to bend into bands for the flanges of the armor joints when there was a knock at his door. His assistant Phandius ushered in the visitor. It was a tall reptilian of common markings, a dull, green-fringed hood, bright black eyes, and a dull brown cloak. It was Hazadir, Katariah''s preferred armorer.

"I wanted to wish you the best of luck on the — is that ebony?"

It was indeed. Saccus had bought the finest quality ebony weave available in the Imperial City as soon as he heard of the competition and had begun the process of smelting it. Normally it was a six-month procedure refining the ore, but he hoped that a massive convection oven stoked by white flames born of magicka would shorten the operation to three days. Saccus proudly pointed out the other advancements in his armory. The acidic lime pools to sharpen the blade of the dai-katana to an unimaginable degree of sharpness. The Akaviri forge and tongs he would use to fold the ebony back and forth upon itself. Hazadir laughed.

"Have you been to my armory? It''s two tiny smoke-filled rooms. The front is a shop. The back is filled with broken armor, some hammers, and a forge. That''s it. That''s your competition for the millions of gold pieces in Imperial commission."

"I''m sure the Empress has some reason to trust you to outfit her troops," said Sirollus Saccus, kindly. He had, after all, seen the shop and knew that what Hazadir said was true. It was a pathetic workshop in the slums, fit only for the lowliest of adventurers to get their iron daggers and cuirasses repaired. Saccus had decided to make the best quality regardless of the inferiority of his rival. It was his way and how he became the best armorer in the Imperial City.

Out of kindness, and more than a bit of pride, Saccus showed Hazadir how, by contrast, things should be done in a real professional armory. The Argonian acted as an apprentice to Saccus, helping him refine the ebony ore, and to pound it and fold it when it cooled. Over the next several days, they worked together to create a beautiful dai-katana with an edge honed sharp enough to trim a mosquito''s eyebrows, enchanted with flames along its length by one of the Imperial Battlemages, as well as a suit of armor of bound wood, leather, silver, and ebony to resist the winds of Oblivion.

On the day of the battle, Saccus, Hazadir, and Phandius finished polishing the armor and brought in Raphalas Eul for the fitting. Hazadir left only then, realizing that Nandor Beraid would be at his shop shortly to be outfitted.

The two warriors met before the Empress and Imperial Council in the arena, which had been flooded slightly to simulate the swampy conditions of Black Marsh. From the moment Saccus saw Eul in his suit of heavy ebony and blazing dai-katana and Beraid in his collection of dusty, rusted lizard-scales and spear from Hazadir''s shop, he knew who would win. And he was right.

The first blow from the dai-katana lodged in Beraid''s soft shield, as there was no metal trim to deflect it. Before Eul could pull his sword back, Beraid let go of the now-flaming shield, still stuck on the sword, and poked at the joints of Eul''s ebony armor with his spear. Eul finally retrieved his sword from the ruined shield and slashed at Beraid, but his light armor was scaled and angled, and the attacks rolled off into the water, extinguishing the dai-katana''s flames. When Beraid struck at Eul''s feet, he fell into the churned mud and was unable to move. The Empress, out of mercy, called a victor.

Hazadir received the commission and thanks to his knowledge of Argonian battle tactics and weaponry and how best to combat them, he designed implements of war that brought down the insurrection in Armanias. Katariah won the respect of Council, and even, grudgingly, that of Thane Minglumire. Sirollus Saccus went to Morrowind to learn what Hazadir learned there, and was never heard from again.', 0
);

-- AR-III-043  The Dowry
DELETE FROM tomes WHERE call_number = 'AR-III-043';
INSERT INTO tomes (id, call_number, title, author, school, body, restricted) VALUES (
  (SELECT IFNULL(MAX(id), 0) + 1 FROM tomes),
  'AR-III-043', 'The Dowry', 'Anonymous', 'Fiction',
  'Ynaleigh was the wealthiest landowner in Gunal, and he had over the years saved a tremendous dowry for the man who would marry his daughter, Genefra. When she reached the age of consent, he locked the gold away for safe-keeping, and announced his intention to have her marry. She was a comely lass, a scholar, a great athlete, but dour and brooding in aspect. This personality defect did not bother her potential suitors any more than her positive traits impressed them. Every man knew the tremendous wealth that would be his as the husband of Genefra and son-in-law of Ynaleigh. That alone was enough for hundreds to come to Gunal to pay court.

"The man who will marry my daughter," said Ynaleigh to the assembled. "Must not be doing so purely out of avarice. He must demonstrate his own wealth to my satisfaction."

This simple pronouncement removed a vast majority of the suitors, who knew they could not impress the landowner with their meager fortunes. A few dozen did come forward within a few days, clad in fine killarc cloth of spun silver, accompanied by exotic servants, traveling in magnificent carriages. Of all who came who met with Ynaleigh''s approval, none arrived in a more resplendent fashion that *[sic]* Welyn Naerillic. The young man, who no one had ever heard of, arrived in a shining ebon coach drawn by a team of dragons, his clothing of rarest manufacture, and accompanied by an army of the most fantastical servants any of Gunal had ever seen. Valets with eyes on all sides of their heads, maidservants that seemed cast in gemstones.

But such was not enough with Ynaleigh.

"The man who marries my daughter must prove himself a intelligent fellow, for I would not have an ignoramus as a son-in-law and business partner," he declared.

This eliminated a large part of the wealthy suitors, who, through their lives of luxury, had never needed to think very much if at all. Still some came forward over the next few days, demonstrating their wit and learning, quoting the great sages of the past and offering their philosophies of metaphysics and alchemy. Welyn Naerillic too came and asked Ynaleigh to dine at the villa he had rented outside of Gunal. There the landowner saw scores of scribes working on translations of Aldmeri tracts, and enjoyed the young man''s somewhat irreverent but intriguing intelligence.

Nevertheless, though he was much impressed with Welyn Naerillic, Ynaleigh had another challenge.

"I love my daughter very much," said Ynaleigh. "And I hope that the man who marries her will make her happy as well. Should any of you make her smile, she and the great dowry are yours."

The suitors lined up for days, singing her songs, proclaiming their devotion, describing her beauty in the most poetic of terms. Genefra merely glared at all with hatred and melancholia. Ynaleigh who stood by her side began to despair at last. His daughter''s suitors were failing to a man at this task. Finally Welyn Naerillic came to the chamber.

"I will make your daughter smile," he said. "I dare say, I''ll make her laugh, but only after you''ve agreed to marry us. If she is not delighted within one hour of our engagement, the wedding can be called off."

Ynaleigh turned to his daughter. She was not smiling, but her eyes had sparked with some morbid curiosity in this young man. As no other suitor had even registered that for her, he agreed.

"The dowry is naturally not to be paid ''til after you''ve wed," said Ynaleigh. "Being engaged is not enough."

"Might I see the dowry still?" asked Welyn.

Knowing how fabled the treasure was and understanding that this would likely be the closest the young man would come to possessing it, Ynaleigh agreed. He had grown quite found *[sic]* of Welyn. On his orders, Welyn, Ynaleigh, glum Genefra, and the castellan delved deep into the stronghold of Gunal. The first vault had to be opened by touching a series of runic symbols: should one of the marks be mispressed, a volley of poisoned arrows would have struck the thief. Ynaleigh was particularly proud of the next level of security -- a lock composed of blades with eighteen tumblers required three keys to be turned simultaneously to allow entry. The blades were designed to eviscerate any who merely picked one of the locks. Finally, they reached the storeroom.

It was entirely empty.

"By Lorkhan, we''ve been burgled!" cried Ynaleigh. "But how? Who could have done this?"

"A humble but, if I may say so, rather talented burglar," said Welyn. "A man who has loved your daughter from afar for many years, but did not possess the glamour or the learning to impress. That is, until the gold from her dowry afforded me the opportunity."

"You?" bellowed Ynaleigh, scarcely able to believe it. Then something even more unbelievable happened.

Genefra began to laugh. She had never even dreamed of meeting anyone like this thief. She threw herself into his arms before her father''s outraged eyes. After a moment, Ynaleigh too began to laugh.

Genefra and Welyn were married in a month''s time. Though he was in fact quite poor and had little scholarship, Ynaleigh was amazed how much his wealth increased with such a son-in-law and business partner. He made certain never to ask from whence *[sic]* the excess gold came.

***Publisher''s Note***

*The tale of a man trying to win the hand of a maiden whose father (usually a wealthy man or a king) tests each suitor is quite common. See, for instance, the more recent "Four Suitors of Benitah" by Jole Yolivess. The behavior of the characters is quite out of character for the Dwemer. No one today knows their marriage customs, or even if they had marriage at all.
*

*One rather odd theory of the Disappearance of the Dwarves came from this and a few other tales of "Marobar Sul." It was proposed that the Dwemer never, in fact, left. They did not depart Nirn, much less the continent of Tamriel, and they are still among us, disguised. These scholars use the story of "Azura and the Box" to suggest that the Dwemer feared Azura, a being they could neither understand nor control, and they adopted the dress and manner of Chimer and Altmer in order to hide from Azura''s gaze.*', 0
);

-- AR-III-044  The Ransom of Zarek
DELETE FROM tomes WHERE call_number = 'AR-III-044';
INSERT INTO tomes (id, call_number, title, author, school, body, restricted) VALUES (
  (SELECT IFNULL(MAX(id), 0) + 1 FROM tomes),
  'AR-III-044', 'The Ransom of Zarek', 'Anonymous', 'Fiction',
  'Jalemmil stood in her garden and read the letter her servant had brought to her. The bouquet of joss roses in her hand fell to the ground. For a moment it was as if all birds had ceased to sing and a cloud had passed over the sky. Her carefully cultivated and structured haven seemed to flood over with darkness.

"We have thy son," it read. "We will be in touch with thee shortly with our ransom demands."

Zarek had never made it as far as Akgun after all. One of the brigands on the road, Orcs probably, or accursed Dunmer, must have seen his well-appointed carriage, and taken him hostage. Jalemmil clutched at a post for support, wondering if her boy had been hurt. He was but a student, not the sort to fight against well-armed men, but had they beaten him? It was more than a mother''s heart could bear to imagine.

"Don''t tell me they sent the ransom note so quickly," called a family voice, and a familiar face appeared through the hedge. It was Zarek. Jalemmil hurried to embrace her boy, tears running down her face.

"What happened?" she cried. "I thought thou had been kidnapped."

"I was," said Zarek. "Three huge soaring Nords attacked by *[sic]* carriage on the Frimvorn Pass. Brothers, as I learned, named Mathais, Ulin, and Koorg. Thou should have seen these men, mother. Each one of them would have had trouble fitting through the front door, I can tell thee."

"What happened?" Jalemmil repeated. "Were thou rescued?"

"I thought about waiting for that, but I knew they''d send off a ransom note and I know how thou does worry. So I remembered what my mentor at Akgun always said about remaining calm, observing thy surroundings, and looking for thy opponent''s weakness," Zarek grinned. "It took a while, though, because these fellows were truly monsters. And then, when I listened to them, bragging to one another, I realized that vanity was their weakness."

"What did thou do?"

"They had me chained at their camp in the woods not far from Cael, on a high knoll over-looking a wide river. I heard one of them, Koorg, telling the others that it would take the better part of an hour to swim across the river and back. They were nodding in agreement, when I spoke up.

"''I could swim that river and back in thirty minutes,'' I said.

"''Impossible,'' said Koorg. ''I can swim faster than a little whelp like thee.''

"So it was agreed that we would dive off the cliff, swim to the center island, and return. As we went to our respective rocks, Koorg took it upon himself to lecture me about all the fine points of swimming. The importance of synchronized movements of the arms and legs for maximum speed. How essential it was to breathe after only third or fourth stroke, not too often to slow thyself down, but not too often to lose one''s air. I nodded and agreed to all his fine points. Then we dove off the cliffs. I made it to the island and back in a little over an hour, but Koorg never returned. He had dashed his brains at the rocks at the base of the cliff. I had noticed the telltale undulations of underwater rocks, and had taken the diving rock on the right."

"But thou returned?" asked Jalemmil, astounded. "Was that not then when thou escaped?"

"It was too risky to escape then," said Zarek. "They could have easily caught me again, and I wasn''t keen to be blamed for Koorg''s disappearance. I said I did not know what happened to him, and after some searching, they decided he had forgotten about the race and had swum ashore to hunt for food. They could not see how I could have had anything to do with his disappearance, as fully visible as I was throughout my swim. The two brothers began making camp along the rocky cliff-edge, picking an ideal location so that I would not be able to escape.

"One of the brothers, Mathais, began commenting on the quality of the soil and the gradual incline of the rock that circled around the bay below. Ideal, he said, for a foot race. I expressed my ignorance of the sport, and he was keen to give me details of the proper technique for running a race. He made absurd faces, showing how one must breathe in through the nose and out through the mouth; how to bend one''s knees to the proper angle on the rise; the importance of sure foot placement. Most important, he explained, was that the runner keep an aggressive but not too strenuous pace if one intends to win. It is fine to run in second place through the race, he said, provided one has the willpower and strength to pull out in the end.

"I was an enthusiastic student, and Mathais decided that we ought to run a quick race around the edge of the bay before night fell. Ulin told us to bring back some firewood when we came back. We began at once down the path, skirting the cliff below. I followed his advice about breath, gait, and foot placement, but I ran with all my power right from the start. Despite his much longer legs, I was a few paces ahead as we wround the first corner.

"With his eyes on my back, Mathais did not see the gape in the rock that I jumped over. He plummeted over the cliff before he had a chance to cry out. I spent a few minutes gathering some twigs before I returned to Ulin at camp."

"Now thou were just showing off," frowned Jalemmil. "Surely that would have been a good time to escape."

"Thou might think so," agreed Zarek. "But thou had to see the topography -- a few large trees, and then nothing but shrubs. Ulin would have noticed my absence and caught up with me in no time, and I would have had a hard time explaining Mathais''s absence. However, the brief forage around the area allowed me to observe some of the trees close up, and I could formulate my final plan.

"When I got back to camp with a few twigs, I told Ulin that Mathais was slow coming along, dragging a large dead tree behind him. Ulin scoffed at his brother''s strength, saying it would take him time to pull up a live tree by the roots and drop it on the bonfire. I expressed reasonable doubt.

"''I''ll show thee,'' he said, ripping up a ten foot tall specimen effortlessly.

"''But that''s scarcely a sapling,'' I objected. ''I thought thou could rip up a tree.'' His eyes followed mine to a magnificent, heavy-looking one at the edge of the clearing. Ulin grabbed it and began to shake it with a tremendous force to loosen its roots from the dirt. With that, he loosened the hive from the uppermost branches, dropping it down onto his head.

"That was when I made my escape, mother," said Zarek, in conclusion, showing a little schoolboy pride. "While Mathais and Koorg were at the base of the cliff, and Ulin was flailing about, engulfed by a swarm."

Jalemmil embraced her son once again.

***Publisher''s Note**
*

*I was reluctant to publish the works of Marobar Sul, but when the University of Gwylim Press asked me to edit this edition, I decided to use this as an opportunity to set the record straight once and for all.
*

*Scholars do not agree on the exact date of Marobar Sul''s work, but it is generally agreed that they were written by the playwright "Gor Felim," famous for popular comedies and romances during the Interregnum between the fall of the First Cyrodilic Empire and the rise of Tiber Septim. The current theory holds that Felim heard a few genuine Dwemer tales and adapted them to the stage in order to make money, along with rewritten versions of many of his own plays.
*

*Gor Felim created the persona of "Marobar Sul" who could translate the Dwemer language in order to add some sort of validity to the work and make it even more valuable to the gullible. Note that while "Marobar Sul" and his works became the subject of heated controversy, there are no reliable records of anyone actually meeting "Marobar Sul," nor was there anyone of that name employed by the Mages Guild, the School of Julianos, or any other intellectual institution.
*

*In any case, the Dwemer in most of the tales of "Marobar Sul" bear little resemblance to the fearsome, unfathomable race that frightened even the Dunmer, Nords, and Redguards into submission and built ruins that even now have yet to be understood.*', 0
);

-- AR-III-045  The Red Kitchen Reader
DELETE FROM tomes WHERE call_number = 'AR-III-045';
INSERT INTO tomes (id, call_number, title, author, school, body, restricted) VALUES (
  (SELECT IFNULL(MAX(id), 0) + 1 FROM tomes),
  'AR-III-045', 'The Red Kitchen Reader', 'Anonymous', 'Fiction',
  'Though naturally modest, I must admit to some pleasure in being dubbed by our Emperor''s father, the late Pelagius IV, as "the finest connoisseur in Tamriel." He was also good enough to appoint me the first, and to this day, the only Master of Cuisine in the Imperial Court. Other Emperors, of course, had master chefs and cooks in their staff, but only during the reign of Pelagius was there someone of rarefied tastes to plan the menus and select the finest produce to be served at court. His son Uriel requested that I continue in that position, but I was forced to graciously decline the invitation, because of age and poor health.

This book, however, is not intended to be autobiography. I have had a great many adventures in my life as a knight of fine dining, but my intention for this book is much more specific. Many times I have been asked, "What is the best thing you ever ate?"

The answer to that is not a simple one. Much of the pleasure of a great meal is not only in the food: it is in the setting, the company, the mood. Eat an indifferently cooked roast or a simple stew with your one true love, and it is a meal to be remembered. Have an excellent twelve-course feast with dull company, while feeling slightly ill, and it will be forgotten, or remembered only with distaste.

Sometimes meals are memorable for the experiences that come before them.

Fairly recently, in northern Skyrim, I had a bit of bad luck. I was with a group of fishermen, observing their technique of capturing a very rare, very delicious fish called Merringar. The fish is found only far from shore, so it was a week''s voyage out beyond civilization. Well, we found our school of Merringar, but as the fishermen began spearing them, the blood in the water attracted a family of Dreugh, who capsized the boat and everyone on it. I managed to save myself, but the fishermen and all our supplies were lost. Sailing is not, alas, a skill I have picked up over the years, and it took me three weeks, with no provisions, to find my way back to the kingdom of Solitude. I had managed to catch enough small fish to eat raw, but I was still delirious from hunger and thirst. The first meal I had on shore, of Nordic roast boar, Jazbay wine, and, yes, filet of Merringar would have been excellent under any circumstances, but because of the threat of starvation I had faced, it was divine beyond words.

Sometimes meals are even memorable for the experiences that follow them.

In a tavern in Falinesti, I was introduced to a simple peasant dish called Kollopi, delicious little balls of flesh, thick with spices and juice, so savory I asked the proprietress whence they came. Mother Pascost explained that the Kollopi were an arboreal rodent that fed exclusively on the most tender branches of the graht-oak, and I was fortunate enough to be in Valenwood at the time of the annual harvest. I was invited to join with a small colony of Imga monkeys, who alone could gather these succulent little mice. Because they lived only on the slenderest branches of the trees, and only on the ends of those same branches, the Imga had to climb beneath them and jump up to "pick" the Kollopi from their perches. Imga are, of course, naturally dexterous, but I was then relatively young and spry, and they let me help them. While I could never jump as high they could, with practice, I found that if I kept my head and upper body rigid, and launched off the ground with a scissors-like kick, I could reach the Kollopi on the lowest branches of the tree. I believe I gathered three Kollopi myself, though with considerable effort.

To this day, I salivate at the thought of Kollopi, but my mind is on the image of myself and several dozen Imgas leaping around beneath the shade of the graht-oaks.

Then, of course, there are the rare meals memorable for what came before, after, and during the meal, which brings me to the finest thing I ever ate, the meal that began my lifelong obsession with excellent cuisine.

As a child growing up in Cheydinhal, I did not care for food at all. I recognized the value of nutrition, for I was not a complete dullard, but I cannot say that mealtime brought me any pleasure at all. Partly, of course, this was the fault of my family''s cook, who believed that spices were an invention of the Daedra, and that good Imperials should like their food boiled, textureless and flavorless. Though I think she was alone in assigning a religious significance to this, my sampling of traditional Cyrodilic cuisine suggests that the philosophy is regrettably common in my homeland.

Though I did not enjoy food per se, I was not a morose, unadventurous child in other respects. I enjoyed the fights in the Arena, of course, and nothing made me happier than wandering the streets of my town, with my imagination as my only companion. It was on one such jaunt on a sunny Fredas in Mid Year that I made a discovery that changed my heart and my life.

There were several old abandoned houses down the street from my own home, and I often played around them, imagining them to be filled with desperate outlaws or haunted by hundreds of evil spirits. I never had the nerve to go inside. In fact, had I not that day seen some other children who had delighted in teasing me in the past, I would never have gone in. But I needed a sanctuary, so I ran into the closest one.

The house seemed to be as desolate on the inside as on the outside, further proof that no one lived there, and had not for some time. When I heard footsteps, I could only assume that the loathsome little urchins I hoped to avoid had followed me in. I escaped to the basement, and from there, past a broken-down wall that led to a well. I could still hear the footsteps above, and I decided that I was still loath to confront my tormentors. Knocking aside the rusty locks on the well, I slipped down below.

The well was dry, but I discovered it was far from empty. There was a sort of a sub-basement to the house, three large rooms that were clean, furnished, and evidently not abandoned at all. My senses told me someone was living in the house, after all: not only my sense of sight, but my sense of smell. For one of the rooms was a large red-painted kitchen, and spread out on the coals of the oven was a roast, carved into small morsels. Passing a beautiful and appropriate bas-relief of a mother carving a roast for her grateful children, I beheld the kitchen and the wonders within.

Like I said, food had never interested me before, but I was transfixed, and even now as I write this, words fail me in describing the rich aroma that hung in the air. It was like nothing I had ever smelled in my family''s kitchen, and I was unable to stop myself from popping one of the steaming chunks of meat into my mouth. The taste was magical, the flesh tender and sweet. Before I knew it, I had eaten everything on the stove, and I learned at that very second the truth that that food can and should be sublime.

After gorging myself and having my culinary epiphany, I was conflicted on what to do. Part of me wanted to wait down in that red kitchen until the chef returned, so I could ask him what his secret recipe was for the delicious meat. Part of me recognized that I had stolen into someone''s house and eaten their dinner, and it would be wise to leave while I could. That was what I did.

Time and again, I''ve tried to return to that strange, wonderful place, but Cheydinhal has changed over time. Old houses have been reclaimed, and new houses abandoned. I know what to look for on the inside of the house - the well, the beautiful etching of a woman preparing to carve out a roast for her children, the red kitchen itself - but I have never been able to find the house again. After a while, as I grew older, I stopped trying. It is better as it remains in my memory, the most perfect meal I ever ate.

The inspiration for my life that followed all was cooked up, together with that fabulous meat, right there in the Red Kitchen.', 0
);

-- AR-III-046  The Seed
DELETE FROM tomes WHERE call_number = 'AR-III-046';
INSERT INTO tomes (id, call_number, title, author, school, body, restricted) VALUES (
  (SELECT IFNULL(MAX(id), 0) + 1 FROM tomes),
  'AR-III-046', 'The Seed', 'Anonymous', 'Fiction',
  'The hamlet village of Lorikh was a quiet, peaceful Dwemer community nestled in the monochrome grey and tan dunes and boulders of the Dejasyte. No vegetation of any kind grew in Lorikh, though there were blackened vestiges of long dead trees scattered throughout the town. Kamdida arriving by caravan looked at her new home with despair. She was used to the forestland of the north where her father''s family had haled. Here there was no shade, little water, and a great open sky. It looked like a dead land.

Her mother''s family took Kamdida and her younger brother Nevith in, and was very kind to the orphans, but she felt lonely in the alien village. It was not until she met an old Argonian woman who worked at the water factory that Kamdida found a friend. Her name was Sigerthe, and she said that her family had lived in Lorikh centuries before the Dwemer arrived, when it was a great and beauteous forest.

"Why did the trees die?" asked Kamdida.

"When there were Argonians only in this land, we never cut trees for we had no need for fuel or wooden structures such as you use. When the Dwemer came, we allowed them to use the plants as they needed them, provided they never touched the Hist, which are sacred to us and to the land. For many years, we lived peaceably. No one wanted for anything."

"What happened?"

"Some of your scientists discovered that distilling a certain tree sap, molding it and drying it, they could create a resilient kind of armor called resin," said Sigerthe. "Most of the trees that grew here had very thin ichor in their branches, but not the Hist. Many of them fairly glistened with sap, which made the Dwemer merchants greedy. They hired a woodsman named Juhnin to start clearing the sacred arbors for profit."

The old Argonian woman looked to the dusty ground and sighed, "Of course, we Argonians cried out against it. It was our home, and the Hist, once gone, would never return. The merchants reconsidered, but Juhnin took it on his own to break our spirit. He proved one terrible, bloody day that his prodigious skill with the axe could be used against people as well as trees. Any Argonian who stood in his way was hewn asunder, children as well. The Dwemer people of Lorikh closed their doors and their ears to the cries of murder."

"Horrible," gasped Kamdida.

"It is difficult to explain," said Sigerthe. "But the deaths of our living ones was not nearly as horrible to us as the death of our trees. You must understand that to my people, the Hist are where we come from and where we are going. To destroy our bodies is nothing; to destroy our trees is to annihilate us utterly. When Juhnin then turned his axe on the Hist, he killed the land. The water disappeared, the animals died, and all the other life that the trees nourished crumbled and dried to dust."

"But you are still here?" asked Kamdida. "Why didn''t you leave?"

"For us, we are trapped. I am one of the last of a dying people. Few of us are strong enough to live away from our ancestral groves, and sometimes, even now, there is a perfume in the air of Lorikh that gives us life. It will not be long until we are all gone."

Kamdida felt tears welling up in her eyes. "Then I will be alone in this horrible place with no trees and no friends."

''We Argonians have an expression," said Sigerthe with a sad smile, taking Kamdida''s hand. "That the best soil for a seed is found in your heart."

Kamdida looked into the palm of her hand and saw that Sigerthe had given her a small black pellet. It was a seed. "It looks dead."

"It can only grow in one place in all Lorikh," said the old Argonian. "Outside an old cottage in the hills outside town. I cannot go there, for the owner would kill me on sight and like all my people, I am too frail to defend myself now. But you can go there and plant the seed."

"What will happen?" asked Kamdida. "Will the Hist return?"

"No. But some part of their power will."

That night, Kamdida stole from her house and into the hills. She knew the cottage Sigerthe had spoken of. Her aunt and uncle had told her never to go there. As she approached it, the door opened and an old but powerfully built man appeared, a mighty axe slung over his shoulder.

"What are you doing here, child?" he demanded. "In the dark, I almost took you to be a lizard man."

"I''ve lost my way in the dark," she said quickly. "I''m trying to get back to my home in Lorikh."

"Be on your way then."

"Do you have a candle I might have?" she asked piteously. "I''ve been walking in circles and I''m afraid I''ll only return back here without any light."

The old man grumbled and walked into his house. Quickly, Kamdida dug a hole in the dry dirt and buried the seed as deeply as she could. He returned with a lit candle.

"See to it you don''t come back here," he growled. "Or I''ll chop you in half."

He returned to his house and fire. The next morning when he awoke and opened the door, he found that his cottage was entirely sealed within an enormous tree. He picked up his axe and delivered blow and after blow to the wood, but he could never break through. He tried side chops, but the wood healed itself. He tried an upper chop followed by an under chop to form a wedge, but the wood sealed.

Much time went by before someone discovered old Juhnin''s emaciated body lying in front of his open door, still holding his blunted, broken axe. It was a mystery to all what he had been chopping with it, but the legend began circulating through Lorikh that Hist sap was found on the blade.

Shortly thereafter, small desert flowers began pushing through the dry dirt in the town. Trees and plants newly sown began to live tolerably well, if not luxuriantly. The Hist did not return, but Kamdida and the people of Lorikh noticed that at a certain time around twilight, long, wide shadows of great, bygone trees would fill the streets and hills.

***Publisher''s Note***

*"The Seed" is one of Marobar Sul''s tales whose origins are well known. This tale originated from the Argonian slaves of southern Morrowind. "Marobar Sul" merely replaced the Dunmer with Dwemer and claimed he found it in a Dwemer ruin. Furthermore, he later claimed that the Argonian version of the tale was merely a retelling of his "original!"*

*Lorikh, while clearly not a Dwemer name, simply does not exist, and in fact "Lorikh" was a name commonly used, incorrectly, for Dunmer men in Gor Felim''s plays. The Argonian versions of the story usually take place on Vvardenfell, usually in the Telvanni city of Sadrith Mora. Of course the so-called "scholars" of Temple Zero will probably claim this story has something to do with "Lorkhan" simply because the town starts with the letter L.*', 0
);

-- AR-III-047  Beggar
DELETE FROM tomes WHERE call_number = 'AR-III-047';
INSERT INTO tomes (id, call_number, title, author, school, body, restricted) VALUES (
  (SELECT IFNULL(MAX(id), 0) + 1 FROM tomes),
  'AR-III-047', 'Beggar', 'Anonymous', 'Fiction',
  'Eslaf Erol was the last of the litter of five born to the Queen of the prosperous Nordic kingdom of Erolgard, Lahpyrcopa, and her husband, the King of Erolgard, Ytluaf. During pregnancy, the Queen had been more than twice as wide as she was tall, and the act of delivery took three months and six days after it had begun. It is perhaps understandable that the Lahpyrcopa elected, upon expelling Eslaf to frown, say, ''Good riddance,'' and die.

Like many Nords, Ytluaf did not care very much for his wife and less for his children. His subjects were puzzled, therefore, when he announced that he would follow the ancient tradition of his people of Atmora of following his beloved spouse to the grave. They had not thought they were particularly in love, nor were they aware that such a tradition existed. Still, the simple people were grateful, for the little royal drama alleviated their boredom, which was and is a common problem in the more obscure parts of northern Skyrim, particularly in wintertide.

He gathered his household staff and his five fat, bawling little heirs in front of him, and divided his estate. To his son Ynohp, he gave his title; to his son Laernu, he gave his land; to his son Suoibud, he gave his fortune; to his daughter Laicifitra, he gave his army. Ytluaf''s advisors had suggested he keep the inheritance together for the good of the kingdom, but Ytluaf did not particularly care for his advisors, or the kingdom, for that matter. Upon making his announcement, he drew his dagger across his throat.

One of the nurses, who was rather shy, finally decided to speak as the King''s life ebbed away. ''Your highness, you forgot your fifth child, little Eslaf.''

Good Ytluaf groaned. It is somewhat hard to concentrate with blood gushing from one''s throat, after all. The King tried in vain to think of something to bequeath, but there was nothing left.

Finally he sputtered, irritably, ''Eslaf should have taken something then'' and died.

That a babe but a few days old was expected to demand his rightful inheritance was arguably unfair. But so Eslaf Erol was given his birthright with his father''s dying breath. He would have nothing, but what he had taken.

Since no one else would have him, the shy nurse, whose name was Drusba, took the baby home. It was a decrepit little shack, and over the years that followed, it became more and more decrepit. Unable to find work, Drusba sold all of her furnishings to buy food for little Eslaf. By the time he was old enough to walk and talk, she had sold the walls and the roof as well, so they had nothing but a floor to call home. And if you''ve ever been to Skyrim, you can appreciate that that is scarcely sufficient.

Drusba did not tell Eslaf the story of his birth, or that his brothers and sister were leading quite nice lives with their inheritances, for, as we have said, she was rather shy, and found it difficult to broach the subject. She was so painfully shy, in fact, that whenever he asked any questions about where he came from, Drusba would run away. That was more or less her answer to everything, to flee.

In order to communicate with her at all, Eslaf learned how to run almost as soon as he could walk. He couldn''t keep up with his adopted mother at first, but in time he learned to go toe-heel toe-heel if he anticipated a short but fast sprint, and heel-toe heel-toe if it seemed Drusba was headed for a long distance marathon flight. He never did get all the answers he needed from her, but Eslaf did learn how to run.

The kingdom of Erolgard had, in the years that Eslaf was growing, become quite a grim place. King Ynohp did not have a treasury, for Suoibud had been given that; he did not have any property for income, for Laernu had been given that; he did not have an army to protect the people, for Laicifitra had been given that. Futhermore *[sic]*, as he was but a child, all decisions in the kingdom went through Ynohp''s rather corrupt council. It had become a bureaucratic exploitative land of high taxes, rampant crime, and regular incursions from neighboring kingdoms. Not a particular unusual situation for a kingdom of Tamriel, but an unpleasant one nonetheless.

The time finally came when the taxcollector arrived to Drusba''s hovel, such as it was, to collect the only thing he could - the floor. Rather than protest, the poor shy maid ran away, and Eslaf never saw her again.

Without a home or a mother, Eslaf did not know what to do. He had grown accustomed to the cold open air in Drusba''s shack, but he was hungry.

''May I have a piece of meat?'' he asked the butcher down the street. ''I''m very hungry.''

The man had known the boy for years, often spoke to his wife about how sorry he felt for him, growing up in a home with no ceilings or walls. He smiled at Eslaf and said, ''Go away, or I''ll hit you.''

Eslaf hurriedly left the butcher and went to a nearby tavern. The tavernkeeper had been a former valet in the king''s court and knew that the boy was by right a prince. Many times, he had seen the poor ragged lad in the streets, and sighed at the way fate had treated him.

''May I have something to eat?'' Eslaf asked this tavernkeeper. ''I''m very hungry.''

''You''re lucky I don''t cook you up and eat you,'' replied the tavernkeeper.

Eslaf hurriedly left the tavern. For the rest of the day, the boy approached the good citizens of Erolgard, begging for food. One person had thrown something at him, but it turned out to be an inedible rock.

As night fell, a raggedy man came up to Eslaf and, without saying a word, handed him a piece of fruit and a piece of dried meat. The lad took it, wide-eyed, and as he devoured it, he thanked the man very sweetly.

''If I see you begging on the streets tomorrow,'' the man growled. ''I''ll kill you myself. There are only so many beggars we of the guild allow in any one town, and you make it one too many. You''re ruining business.''

It was a good thing Eslaf Erol knew how to run. He ran all night.

Eslaf Erol''s story is continued in the book *Thief*.', 0
);

-- AR-III-048  Thief
DELETE FROM tomes WHERE call_number = 'AR-III-048';
INSERT INTO tomes (id, call_number, title, author, school, body, restricted) VALUES (
  (SELECT IFNULL(MAX(id), 0) + 1 FROM tomes),
  'AR-III-048', 'Thief', 'Anonymous', 'Fiction',
  'If the reader has not yet had the pleasure of reading the first volume in these series on the life of Eslaf Erol, ''Beggar,'' he should close this book immediately, for I shan''t recap.

I will tell you this much, gentle reader. When we last saw Eslaf, he was a boy, an orphan, a failed beggar, running through the wild winter woods of Skyrim, away from his home of Erolgard. He continued running, stopping here and there, for many more years, until he was a young man.

Eslaf discovered that among the ways of getting food, asking for it was the most troublesome. Far easier was finding it in the wilderness, or taking it from unguarded market stalls. The only thing worse than begging to get food was begging for the opportunity to work for the money to buy it. That seemed needlessly complicated.

No, as far as Eslaf was concerned, he was best off being a scavenger, a beggar, and a thief.

He commited *[sic]* his first act of thievery shortly after leaving Erolgard, while in the southern woods of Tamburkar in the rugged land near Mount Jensen just east of the village of Hoarbeld. Eslaf was starving, having not eaten anything but a rather scrawny raw squirrel in four days, and he smelled meat cooking and then found the smoke. A band of minstral *[sic]* bards was making camp. He watched them from the bushes as they cooked, and joked, and flirted, and sang.

He could''ve asked them for some food, but so many others had refused him before. Instead, he rushed out, grabbed a piece of meat from the fire, and wincing from the burns, scrambled up the nearest tree to devour it while the bards stood under him and laughed.

''What is your next move, thief?'' giggled a fair, red-headed woman who was covered with tattoos. ''How do you intend to disappear without us catching and punishing you?''

As the hunger subsided, Eslaf realized she was right. The only way to get out of the tree without falling in their midst was to take the branch down to where it hung over a creek. It was a drop off a cliff of about fifty feet. That seemed like the wisest strategy, so Eslaf began crawling in that direction.

''You do know how to fall, boy?'' called out a young Khajiiti, but a few years older than Eslaf, thin but muscular, graceful in his slightest movements. ''If you don''t, you should just climb down here and take what''s coming to you. It''s idiotic to break your neck, when we''d just give you some bruises and send you on your way.''

''Of course I know how to fall,'' Eslaf called back, but he didn''t. He just thought the trick of falling was to have nothing underneath you, and let nature take its course. But fifty feet up, when you''re looking down, is enough to give anyone pause.

''I''m sorry to doubt your abilities, Master Thief,'' said the Khajiiti, grinning. ''Obviously you know to fall feet first with your body straight but loose to avoid cracking like an egg. It seems you are destined to escape us.''

Eslaf wisely followed the Khajiiti''s hints, and leapt into the river, falling without much grace but without hurting himself. In the years that followed, he had to make several more drops from even greater heights, usually after a theft, sometimes without water beneath him, and he improved the basic technique.

When he arrived in the western town of Jallenheim on the morning of his twenty-first birthday, it didn''t take him long to find out who was the richest person, most deserving of being burgled. An impregnable palace in a park near the center of town was owned by a mysterious young man named Suoibud. Eslaf wasted no time in finding the palace and watching it. A fortified palace he had come to learn was like a person, with quirks and habits beneath its hard shell.

It was not an old place, evidently whatever money this Suoibud had come into was fairly recent. It was regularly patrolled by guards, implying that the rich man was fearful of been *[sic]* burgled, with good reason. The most distinctive feature of the palace was its tower, rising a hundred feet above the stone walls, doubtless giving the occupant a good defensive view. Eslaf guessed that that *[sic]* if Suoibud was as paranoid as he guessed him to be, the tower would also provide a view of the palace storehouse. The rich man would want to keep an eye on his fortune. That meant that the loot couldn''t be directly beneath the tower, but somewhere in the courtyard within the walls.

The light in the tower shone all night long, so Eslaf boldly decided that the best time to burgle was by the light of day, when Suoibud must sleep. That would be the time the guards would least expect a thief to pounce.

And so, when the noon sun was shining over the palace, Eslaf quickly scaled the wall near the front gate and waited, hidden in the crenelations. The interior courtyard was plain and desolate, with few places to hide, but he saw that there were two wells. One the guards used from time to time to draw up water and slake their thirst, but Eslaf noticed that guards would pass by the other well, never using it.

He waited until the guards were distracted, just for a second, by the arrival of a merchant in a wagon, bearing goods for the palace. While they were searching his wagon, Eslaf leapt, elegantly, feet first, from the wall into the well.

It was not a particularly soft landing for, as Eslaf had guessed, the well was not full of water, but gold. Still, he knew how to roll after a fall, and he didn''t hurt himself. In the dank subterranean storehouse, he stuffed his pockets with gold and was about to go to the door which he assumed would lead to the tower when he noticed a gem the size of an apple, worth more than all the gold that was left. Eslaf found room for it down his pants.

The door did indeed lead to the tower, and Eslaf followed its curving stairwell up, walking quietly but quickly. At the top, he found the master of the palace''s private quarters, ornate and cold, with invaluable artwork and decorative swords and shields on the walls. Eslaf assumed the snoring lump under the sheets was Suoibud, but he didn''t investigate too closely. He crept to the windows and looked out.

It was going to be a difficult fall, for certes. He needed to jump from the tower, past the walls, and hit the tree on the other side. The tree branches would hurt, but they would break his fall, and there was a pile of hay he had left under the tree to prevent further injury.

Eslaf was about to leap when the occupant of the room woke up with a start, yelling, ''My gem!''

Eslaf and *[sic]* stared at him for a second, wide-eyed. They looked alike. Not surprising, since they were brothers.

Eslaf Erol''s story is continued in the book *Warrior*.', 0
);

-- AR-III-049  Warrior
DELETE FROM tomes WHERE call_number = 'AR-III-049';
INSERT INTO tomes (id, call_number, title, author, school, body, restricted) VALUES (
  (SELECT IFNULL(MAX(id), 0) + 1 FROM tomes),
  'AR-III-049', 'Warrior', 'Anonymous', 'Fiction',
  'This is the third book in a four-book series. If you have not read the first two books, ''Beggar'' and ''Thief,'' you would be well advised to do so.

Suoibud Erol did not know much of his past, nor did he care to.

As a child, he had lived in Erolgard, but the kingdom was very poor and taxes were as a result very high. He was too young to manage his abundant inheritance, but his servants, fearing that their master would be ruined, moved him to Jallenheim. No one knew why that location was picked. Some old maid, long dead now, had thought it was a good place to raise a child. No one else had a better idea.

There may have been children with a more pampered, more spoiled existence than young Suoibud, but that is doubtful. As he grew, he understood that he was rich, but he had nothing else. No family, no social position, no security at all. Loyalty, he found out on more than one occasion, cannot truly be bought. Knowing that he had but one asset, a vast fortune, he was determined to protect it, and, if possible, increase it.

Some otherwise perfectly nice people are greedy, but Suoibud was that rare accident of nature or breeding who has no other interest but acquiring and hoarding gold. He was willing to do anything to increase his fortune. Most recently, he had begun secretly hiring mercenaries to attack desirable properties, and then buying them when no one wanted to live there any more. The attacks would then, of course, cease, and Suoibud would have profitable land which he had purchased for a song. It had begun small with a few farms, but recently he had begun a more ambitious campaign.

In north-central Skyrim, there is an area called The Aalto, which is of unique geographical interest. It is a dormant volcanic valley surrounded on all sides by glaciers, so the earth is hot from the volcano, but the constant water drizzle and air is frigid. A grape called Jazbay grows there comfortably, and everywhere else in Tamriel it withers and dies. The strange vineyard is a *[sic]* privately owned, and the wine produced from it is thus rare and extremely expensive. It is said that the Emperor needs the permission of the Imperial Council to have a glass of it once a year.

In order to harass the owner of The Aalto into selling his land cheap, Suoibud had to hire more than a few mercenaries. He had to hire the finest private army in Skyrim.

Suoibud did not like spending money, but he had agreed to pay the general of the army, a woman called Laicifitra, a gem the size of an apple. He had not given it to her yet — payment was to be delivered on the success of the mission — but he had trouble sleeping knowing that he was going to giving *[sic]* up such a prize. He always slept during the day so he could watch his storehouse by night, when he knew thieves were about.

That brings us up to this moment when, after a fitful sleep, Suoibud woke up at about noon, and surprised a thief in his bedroom. The thief was Eslaf.

Eslaf had been contemplating a leap from the window, a hundred feet down, into the branches of a tree beyond the walls of the fortified palace, and a tumble into a stack of hay. Anyone who has ever attempted such a feat will testify that it takes some concentration and nerve to do such a thing. When he saw that the rich man sleeping in the room had awakened, both left him, and Eslaf slipped behind a tall ornamental shield on display to wait for Suoibud to go back to sleep.

Suoibud did not go back to sleep. He had heard nothing, but could feel someone in the room with him. He stood up and began pacing the room.

Suoibud paced and paced, and gradually decided that he was imagining things. No one was there. His fortune was safe and secure.

He was returning to his bed when he heard a clunk. Turning around, he saw the gem, the one he was to give to Laicifitra on the floor by the Atmoran cavalry shield. A hand reached out from behind the shield and grabbed it up.

''Thief!'' Suoibud cried out, grabbing a jeweled Akaviri katana from the wall and lunging at the shield.

The ''fight'' between Eslaf and Suoibud will not go down in the annals of great duels. Suoibud did not know how to use a sword, and Eslaf was no expert at blocking with a shield. It was clumsy, it was awkward. Suoibud was furious, but was psychologically incapable of using the sword in any way that could damage its fine filligree, reducing its market value. Eslaf kept moving, dragging the shield with him, trying to keep it between him and the blade, which is, after all, the most essential part of any block.

Suoibud screamed in frustration as he struck at the shield, bumping its way across the room. He even tried negotiating with the thief, explaining that the gem was promised to a great warrior named Laicifitra, and if he would give it back, Suoibud would happily give him something else in return. Eslaf was not a genius, but he did not believe that.

By the time Suoibud''s guards came to the bedroom in response to their master''s calls, he had succeeded in backing the shield into a window.

They fell on the shield, having considerable *[sic]* more expertise with their swords than Suoibud did, but they discovered that there was no one behind it. Eslaf had leapt out the window and escaped.

As he ran heavily through the streets of Jallenheim, making jingling noises from the gold coins in his pockets, and feeling the huge gem chafe where he had hidden it, Eslaf did not know where he should go next. He knew only that he could never go back to that town, and he must avoid this warrior named Laicifitra who had claims on the jewel.

Eslaf Erol''s story is continued in the book *King*.', 0
);

-- AR-III-050  Jornibret's Last Dance
DELETE FROM tomes WHERE call_number = 'AR-III-050';
INSERT INTO tomes (id, call_number, title, author, school, body, restricted) VALUES (
  (SELECT IFNULL(MAX(id), 0) + 1 FROM tomes),
  'AR-III-050', 'Jornibret''s Last Dance', 'Anonymous', 'Fiction',
  '(Traditional)

**Women''s Verse I**

Every winter season,
Except for the reason
Of one war or another
(Really quite a bother),
The Queen of Rimmen and her consort
Request their vassals come and cavort.
On each and every ball,
The first man at the Hall
Is Lord Ogin Jornibret of Gaer,
The Curse of all the Maidens Fair.
**Women''s Refrain**

Oh, dear ladies, beware.
Dearest, dearest ladies, take care.
Though he''s a very handsome man,
If you dare to take his handsome hand,
The nasty little spell will be cast
And your first dance with him will be the last.
**Men''s Verse I**

At this social event
Everyone who went
Knew the bows and stances
And steps to all the dances.
The Queen of Rimmen and her consort
Would order a trumpet''s wild report,
And there could be no indecision
As the revelers took position.
The first dance only ladies, separate
Away from such men as Lord Jornibret.
**Men''s Refrain**

Oh, dear fellows, explain.
Brothers, can you help make it plain:
The man''s been doing this for years,
Leaving maidens fair in tears
Before the final tune''s been blast.
And her first dance with him will be the last.
**Women''s Verse II**

Lord Ogin Jornibret of Gaer
Watched the ladies dance on air
The loveliest in the realm.
A fellow in a ursine-hide helm
Said, "The Queen of Rimmen and her consort
Have put together quite a sport.
Which lady fair do you prefer?"
Lord Jornibret pointed, "Her.
See that bosom bob and weave.
Well-suited for me to love and leave."
***Women''s Refrain***

**Men''s Verse II**

The man in the mask of a bear
Had left the Lord of Gaer
Before the ladies'' dance was ending.
Then a trumpet sounded, portending
That the Queen of Rimmen and her consort
Called for the men to come to court.
Disdainful, passing over all the rest,
Ogin approached she of bobbing breast.
She was rejected, saved a life of woe,
For a new maiden as fair as snow.
***Men''s Refrain***

**Women''s Verse III**

At the first note of the band,
The beauty took Ogin''s hand.
She complimented his stately carriage
Dancing to the tune about the marriage
Of the Queen of Rimmen and her consort.
It is very difficult indeed to comport
With grace, neither falling nor flailing,
Wearing ornate hide and leather mailing,
Dancing light as the sweetest of dreams
Without a single squeak of the seams.
***Women''s Refrain.***

**Men''s Verse III**

The rhythms rose and fell
No one dancing could excel
With masculine grace and syncopation,
Lord Jornibret even drew admiration
From the Queen of Rimmen and her consort.
Like a beauteous vessel pulling into port,
He silently slid, belying the leather''s weight.
She whispered girlishly, "The hour is late,
But I''ve never seen such grace in hide armor."
It ''twas a pity he knew he had to harm her.
***Men''s Refrain***

**Women''s Verse IV**

The tune beat was furious
He began to be curious
Where had the maiden been sequest''ed.
"Before this dance was requested
By the consort and his Queen of Rimmen
I didn''t see you dance with the women."
"My dress was torn as I came to the dance,"
She said smiling in a voice deep as a man''s,
"My maids worked quickly to repair,
While I wore a suit of hide, a helm of a bear."
***Women''s Refrain***', 0
);

-- AR-IV-048  Cherim's Heart
DELETE FROM tomes WHERE call_number = 'AR-IV-048';
INSERT INTO tomes (id, call_number, title, author, school, body, restricted) VALUES (
  (SELECT IFNULL(MAX(id), 0) + 1 FROM tomes),
  'AR-IV-048', 'Cherim''s Heart', 'Anonymous', 'History & Lore',
  'Contemporary with Maqamat Lusign (interviewed in volume seventeen of this series) is the Khajiti Cherim, whose tapestries have been hailed as masterpieces all over the Empire for nigh on thirty years now. His four factories located throughout Elsweyr make reproductions of his work, but his original tapestries command stellar prices. The Emperor himself owns ten Cherim tapestries, and his representatives are currently negotiating the sale of five more.

The muted use of color contrasted with the luminous skin tones of Cherim''s subjects is a marked contrast with the old style of tapestry. The subjects of his work in recent years have been fabulous tales of the ancient past: the Gods meeting to discuss the formation of the world; the Chimer following the Prophet Veloth into Morrowind; the Wild Elves battling Morihaus and his legions at the White Gold Tower. His earliest designs dealt with more contemporary subjects. I had the opportunity to discuss with him one of his first masterpieces, The Heart of Anequina, at his villa in Orcrest.

The Heart of Anequina presents an *[sic]* historic battle of the Five Year War between Elsweyr and Valenwood which raged from 3E 394 (or 3E 395, depending on what one considers to be the beginning of the war) until 3E 399. In most fair accounts, the war lasted 4 years and 9 months, but artistic license from the great epic poets added an additional three months to the ordeal.

The actual details of the battle itself, as interpreted by Cherim, are explicit. The faces of a hundred and twenty Wood Elf archers can be differentiated one from the other, each registering fear at the approach of the Khajiti *[sic]* army. Their hauberks catch the dim light of the sun. The menacing shadows of the Elsweyr battlecats loom on the hills, every muscle strained, ready to pounce in command. It is not surprising that he got all the details right, because Cherim was in the midst of it, as a Khajiti *[sic]* foot soldier.

Every minute part of the Khajiti *[sic]* traditional armor can be seen in the soldiers in the foreground. The embroidered edging and striped patterns on the tunics. Each lacquered plate on loose-fitting leather in the Elsweyr style. The helmets of cloth and fluted silver.

"Cherim does not understand the point of plate mail," said Cherim. "It is hot, for one, like being both burned and buried alive. Cherim wore it at the insistence of our Nord advisors during the Battle of Zelinin, and Cherim couldn''t even turn to see what my fellow Khajiit were doing. Cherim did some sketches for a tapestry of the Battle of Zelinin, but Cherim finds that to make it realistic, the figures came out very mechanical, like iron golems or dwemer centurions. Knowing our Khajiti *[sic]* commanders, Cherim would not be surprised if giving up the heavy plate was more aesthetic than practical."

"Elsweyr lost the Battle of Zelinin, didn''t she?"

"Yes, but Elsweyr won the war, starting at the next battle, the Heart of Anequina," said Cherim with a smile. "The tide turned as soon as we Khajiit sent our Nordic advisors back to Solitude. We had to get rid of all the heavy armor they brought to us and find enough traditional armor our troops felt comfortable wearing. Obviously, the principle advantage of the traditional armor was that we could move easily in it, as you can see from the natural stances of the soldiers in the tapestry.

"Now if you look at this poor perforated Cathay-raht who just keeps battling on in the bottom background, you see the other advantage. It seems strange to say, but one of the best features of traditional armor is that an arrow will either deflect completely or pass all the way through. An arrow head is like a hook, made to stick where it strikes if it doesn''t pass through. A soldier in traditional armor will find himself with a hole in his body and the bolt on the other side. Our healers can fix such a wound easily if it isn''t fatal, but if the arrow still remains in the armor, as it does with heavier armor, the wound will be reopened every time the fellow moves. Unless the Khajiit strips off the armor and pulls out the arrow, which is what we had to do at the Battle of Zelinin. A difficult and time-consuming process in the heat of battle, to say the least."

I asked him next, "Is there a self portrait in the battle?"

"Yes," Cherim said with another grin. "You see the small figure of the Khajiit stealing the rings off the dead Wood Elf? His back is facing you, but he has a brown and orange striped tail like Cherim''s. Cherim does not say that all stereotypes about the Khajiit are fair, but Cherim must sometimes acknowledge them."

A self-deprecating style in self-portraiture is also evident in the tapestries of Ranulf Hook, the next artist interviewed in volume nineteen of this series.', 0
);

-- AR-IV-049  Chimarvamidium
DELETE FROM tomes WHERE call_number = 'AR-IV-049';
INSERT INTO tomes (id, call_number, title, author, school, body, restricted) VALUES (
  (SELECT IFNULL(MAX(id), 0) + 1 FROM tomes),
  'AR-IV-049', 'Chimarvamidium', 'Anonymous', 'History & Lore',
  'After many battles, it was clear who would win the War. The Chimer had great skills in magick and bladery, but against the armored battalions of the Dwemer, clad in the finest shielding wrought by Jnaggo, there was little hope of their ever winning. In the interests of keeping some measure of peace in the Land, Sthovin the Warlord agreed to a truce with Karenithil Barif the Beast. In exchange for the Disputed Lands, Sthovin gave Barif a mighty golem, which would protect the Chimer''s territory from the excursions of the Northern Barbarians.

Barif was delighted with his gift and brought it back to his camp, where all his warriors gaped in awe at it. Sparkling gold in hue, it resembled a Dwemer cavalier with a proud aspect. To test its strength, they placed the golem in the center of an arena and flung magickal bolts of lightning at it. Its agility was such that few of the bolts struck it. It had the wherewithal to pivot on its hips to avoid the brunt of the attacks without losing its balance, feet firmly planted on the ground. A vault of fireballs followed, which the golem ably dodged, bending its knees and its legs to spin around the blasts. The few times it was struck, it made certain to be hit in the chest and waist, the strongest parts of its body.

The troops cheered at the sight of such an agile and powerful creation. With it leading the defense, the Barbarians of Skyrim would never again successfully raid their villages. They named it Chimarvamidium, the Hope of the Chimer.

Barif has the golem brought to his chambers with all his housethanes. There they tested Chimarvamidium further, its strength, its speed, its resiliency. They could find no flaw with its design.

"Imagine when the naked barbarians first meet this on one of their raids," laughed one of the housethanes.

"It is only unfortunate that it resembles a Dwemer instead of one of our own," mused Karenithil Barif. "It is revolting to think that they will have a greater respect for our other enemies than us."

"I think we should never accepted *[sic]* the peace terms that we did," said another, one of the most aggressive of the housethanes. "Is it too late to surprise the warlord Sthovin with an attack?"

"It is never too late to attack," said Barif. "But what of his great armored warriors?"

"I understand," said Barif''s spymaster. "That his soldiers always wake at dawn. If we strike an hour before, we can catch them defenseless, before they''ve had a chance to bathe, let alone don their armor."

"If we capture their armorer Jnaggo, then we too would know the secrets of blacksmithery," said Barif. "Let it be done. We attack tomorrow, an hour before dawn."

So it was settled. The Chimer army marched at night, and swarmed into the Dwemer camp. They were relying on Chimarvamidium to lead the first wave, but it malfunctioned and began attacking the Chimer''s own troops. Added to that, the Dwemer were fully armored, well-rested, and eager for battle. The surprise was turned, and most of the high-ranking Chimer, including Karenithil Barif the Beast, were captured.

Though they were too proud to ask, Sthovin explained to them that he had been warned of their attack by a Calling by one of his men.

"What man of yours is in our camp?" sneered Barif.

Chimarvamidium, standing erect by the side of the captured, removed its head. Within its metal body was Jnaggo, the armorer.

"A Dwemer child of eight can create a golem," he explained. "But only a truly great warrior and armorer can pretend to be one."

***Publisher''s Note***

*This is one of the few tales in this collection, which can actually be traced to the Dwemer. The wording of the story is quite different from older versions in Aldmeris, but the essence is the same. "Chimarvamidium" may be the Dwemer "Nchmarthurnidamz." This word occurs several times in plans of Dwemer armor and Animunculi, but it''s *[sic]* meaning is not known. It is almost certainly not "Hope of the Chimer," however.*

*The Dwemer were probably the first to use heavy armors. It is important to note how a man dressed in armor could fool many of the Chimer in this story. Also note how the Chimer warriors react. When this story was first told, armor that covered the whole body must have still been uncommon and new, whereas even then, Dwemer creations like golems and centurions were well known.*

*In a rare scholarly moment, Marobar Sul leaves a few pieces of the original story intact, such as parts of the original line in Aldmeris, "A Dwemer of eight can create a golem, but an eight of Dwemer can become one."*

*Another aspect of this legend that scholars like myself find interesting is the mention of "the Calling." In this legend and in others, there is a suggestion that the Dwemer race as a whole had some sort of silent and magickal communication. There are records of the Psijic Order which suggest they, too, share this secret. Whatever the case, there are no documented spells of "calling." The Cyrodiil historian Borgusilus Malier first proposed this as a solution to the disappearance of the Dwemer. He theorized that in 1E 668, the Dwemer enclaves were called together by one of their powerful philosopher-sorcerers ("Kagrnak" in some documents) to embark on a great journey, one of such sublime profundity that they abandoned all their cities and lands to join the quest to foreign climes as an entire culture.*', 0
);

-- AR-IV-050  Frontier, Conquest
DELETE FROM tomes WHERE call_number = 'AR-IV-050';
INSERT INTO tomes (id, call_number, title, author, school, body, restricted) VALUES (
  (SELECT IFNULL(MAX(id), 0) + 1 FROM tomes),
  'AR-IV-050', 'Frontier, Conquest', 'Anonymous', 'History & Lore',
  'Historians often portray the human settlement of Tamriel as a straightforward process of military expansion of the Nords of Skyrim. In fact, human settlers occupied nearly every corner of Tamriel before Skyrim was even founded. These so-called "Nedic peoples" include the proto-Cyrodilians, the ancestors of the Bretons, the aboriginals of Hammerfell, and perhaps a now-vanished Human population of Morrowind. Strictly speaking, the Nords are simply another of these Nedic peoples, the only one that failed to find a method of peaceful accommodation with the Elves who already occupied Tamriel.

Ysgramor was certainly not the first human settler in Tamriel. In fact, in "fleeing civil war in Atmora", as the Song of Return states, Ysgramor was following a long tradition of migration from Atmora; Tamriel had served as a "safety valve" for Atmora for centuries before Ysgramor''s arrival. Malcontents, dissidents, rebels, landless younger sons, all made the difficult crossing from Atmora to the "New World" of Tamriel. New archeological excavations date the earliest human settlements in Hammerfell, High Rock, and Cyrodiil at ME800-1000, centuries earlier than Ysgramor, even assuming that the twelve Nord "kings" prior to Harald were actual historical figures.

The Nedic peoples were a minority in a land of Elves, and had no choice but to live peacefully with the Elder Race. In High Rock, Hammerfell, Cyrodiil, and possibly Morrowind, they did just that, and the Nedic peoples flourished and expanded over the last centuries of the Merethic Era. Only in Skyrim did this accommodation break down, an event recorded in the Song of Return. Perhaps, being close to reinforcements from Atmora, the proto-Nords did not feel it necessary to submit to the authority of the Skyrim Elves. Indeed, the early Nord chronicles note that under King Harald, the first historical Nord ruler (1E 113-221), "the Atmoran mercenaries returned to their homeland" following the consolidation of Skyrim as a centralized kingdom. Whatever the case, the pattern was set -- in Skyrim, expansion would proceed militarily, with human settlement following the frontier of conquest, and the line between Human territory and Elven territory was relatively clear.

But beyond this "zone of conflict", the other Nedic peoples continued to merge with their Elven neighbors. When the Nord armies of the First Empire finally entered High Rock and Cyrodiil, they found Bretons and proto-Cyrodiils already living there among the Elves. Indeed, the Nords found it difficult to distinguish between Elf and Breton, the two races had already intermingled to such a degree. The arrival of the Nord armies upset the balance of power between the Nedic peoples and the Elves. Although the Nords'' expansion into High Rock and Cyrodiil was relatively brief (less than two centuries), the result was decisive; from then on, power in those regions shifted from the Elves to the Humans.', 0
);

-- AR-IV-051  Hanging Gardens
DELETE FROM tomes WHERE call_number = 'AR-IV-051';
INSERT INTO tomes (id, call_number, title, author, school, body, restricted) VALUES (
  (SELECT IFNULL(MAX(id), 0) + 1 FROM tomes),
  'AR-IV-051', 'Hanging Gardens', 'Anonymous', 'History & Lore',
  '*This book was apparently written in Dwemer and translated to Aldmeris. Only fragments of the Aldmeris is readable, but it may be enough for a scholar of Aldmeris to translate fragments of other Dwemer books.*

...guide Altmer-Estrial led with foot-flames for the town-center where lay dead the quadrangular gardens...

...asked the foundations and chains and vessels their naming places...

...why they did not use solid sound to teach escape from the Earth Bones nor nourished them with frozen flames...

....the word I shall have once written of, this "art" our lesser cousins speak of when their admirable ignorance...

...but neither words nor experience cleanses the essence of the strange and terrible ways of defying our ancestors'' transient rules.

*The translation ends with a comment in Dwemer in a different hand, which you may be translated as follows:*

"Put down your ardent cutting-globes, Nbthld. Your Aldmeris has the correct words, but they cannot be properly misinterpreted."', 0
);

-- AR-IV-052  Lost Legends
DELETE FROM tomes WHERE call_number = 'AR-IV-052';
INSERT INTO tomes (id, call_number, title, author, school, body, restricted) VALUES (
  (SELECT IFNULL(MAX(id), 0) + 1 FROM tomes),
  'AR-IV-052', 'Lost Legends', 'Anonymous', 'History & Lore',
  'The history of Skyrim is vast, predating even the most ancient records of man and mer. Much has been lost, fallen to the ravages of war or the turning of the ages. But nothing is ever truly forgotten. Where no records exist, legends and folk tales offer us a key to the past, a way to piece together truths half-remembered in the minds of men.

For generations, the people of Morthal have told whispered tales of the Pale Lady, a ghostly woman who wanders the northern marshes, forever seeking her lost daughter. Some say she steals children who wander astray, others that her sobbing wail strikes dead all those who hear it. But behind these tales may lie a kernel of truth, for ancient records speak of ''Aumriel'', a mysterious figure Ysgramor''s heirs battled for decades, and finally sealed away.

Reachmen tell the story of Faolan ''Red-Eagle'', an ancient king who rallied his people and drove back the armies of Cyrodiil with a flaming sword. Though accounts vary, they too seem to be based on an underlying truth: the imperial chronicles of Empress Hestra mention a rebel leader of that era who was eventually cornered and slain in battle, at the cost of a full legion of men.

But some tales prove far harder to analyze. Among scholars, perhaps the best known is the ''Forbidden Legend'' of the Archmage Gauldur.

In the dawning days of the First Era, the story goes, there lived a powerful wizard by the name of Gauldur. Wise and just, he was well-known in the courts of King Harald and the jarls of Skyrim, and his aid and counsel were sought by man and mer alike.

And then he was murdered. Some say one of his sons killed him, others that King Harald, jealous of his power, gave the order. But Gauldur''s three sons fled into the night, pursued by a company of Harald''s best warriors and the Lord Geirmund, the king''s personal battlemage.

A great chase ensued, from the wilds of the Reach to the glacial north. One brother is said to have perished in the ruins of Folgunthur, at the foot of Solitude. The others were run to ground soon thereafter. And once it was done, King Harald ordered every record of their murders destroyed, and Gauldur''s name and deeds were struck from the rolls of history.

Even today, few sources remain, and no bard will tell the tale. But perhaps the truth yet remains in some ancient ruin, waiting to be unearthed. For nothing is ever truly forgotten.', 0
);

-- AR-V-052  An Accounting of the Scrolls
DELETE FROM tomes WHERE call_number = 'AR-V-052';
INSERT INTO tomes (id, call_number, title, author, school, body, restricted) VALUES (
  (SELECT IFNULL(MAX(id), 0) + 1 FROM tomes),
  'AR-V-052', 'An Accounting of the Scrolls', 'Anonymous', 'Instruction & Research',
  'After the supposed theft of an Elder Scroll from our Imperial Library, I endeavored to find any sort of index or catalogue of the Scrolls in our possession so that such situations may be avoided (or at least properly verified) in the future. To my dismay, I discovered that the Moth Priests are notoriously inexact when it comes to the actual physical manifestations of the Scrolls, and had no idea how many they held, or how they were organized. Merely asking the question evoked chuckles, as if a child was asking why dogs cannot talk.

I will confess, my jealousy of the ones who can read the Scrolls grows, but I am not yet willing to sacrifice my sight to alleged knowledge. The older Moth Priests I attempt to engage in conversation seem as batty as any other elder who has lost their mind, so I fail to see what wisdom is imparted from the reading.

In any case, I set out to create my own index of the Elder Scrolls, in cooperation with the monks. Day by day, we went through the tower halls, with them telling me the general nature of each Elder Scroll so that I might record its location. Always careful never to glimpse the writings myself, I had only their word to go on. I meticulously drew out a map of the chambers, where Scrolls relating to various specific prophecies were located, where particular periods of history were housed. In all, it took nearly a year of plodding, but at last I had rough notes on the entirety of the library to begin my collation.

It was here that things began to go amiss. In studying my notes, I found many areas of overlap and outright contradiction. In some cases different monks would claim the same scroll to be at opposite ends of the tower. I know they have no taste for jesting, or else I would suspect I was being made the fool in some game of theirs.

I spoke to one of the older monks to relate my concerns, and he hung his head in sorrow for my wasted time. "Did I not tell you," he coughed, "when you started this that all efforts would be futile? The Scrolls do not exist in countable form."

"I had thought you meant there were too many to be counted."

"There are, but that is not the least of their complexities. Turn to the repository behind you, and tell me how many Scrolls are locked therein."

I ran my fingers over the metal casings, tallying each rounded edge that they encountered. I turned back -- "Fourteen," I said.

"Hand me the eighth one," he said, reaching out his hand.

I guided the cylinder into his palm, and he gave a slight nod to acknowledge it. "Now, count again."

Humoring him, I again passed my hands over the Scrolls, but could not believe what I was feeling.

"Now... now there are eighteen!" I gasped.

The old monk chuckled, his cheeks pushing up his blindfold until it folded over itself. "And in fact," he said, "there always were."

It was then that I enrolled as the oldest novice ever accepted into the Cult of the Ancestor Moth.', 0
);

-- AR-V-053  De Rerum Dirennis
DELETE FROM tomes WHERE call_number = 'AR-V-053';
INSERT INTO tomes (id, call_number, title, author, school, body, restricted) VALUES (
  (SELECT IFNULL(MAX(id), 0) + 1 FROM tomes),
  'AR-V-053', 'De Rerum Dirennis', 'Anonymous', 'Instruction & Research',
  'I am six-hundred-and-eleven years old. I have never had children of my own, but I have many nieces and nephews and cousins who have been raised with the tales and traditions of our ancient, illustrious, and occasionally notorious clan, the Direnni. Few families in Tamriel can boast so many famous figures, wielding so much power over the fate of so many. Our warriors and kings are stuff of legend, and it is not to dismiss their honor and their achievements to say you have heard quite enough about them.

I myself have never picked up a sword or written an important law, but I am part of a lesser known but still important Direnni tradition: the way of the wizard. My own autobiography would be of little interest to posterity — though my nephew, nieces, and cousins indulge me to tell wild tales of life in the chaotic Second Era of Tamriel — but I have a few ancestors whose stories should be told. They may have changed history as we know it as dramatically as my better known relatives, but their names are in danger of being forgotten.

Most recently, Lysandus, the King of Daggerfall, was able to conquer his ancient enemies of Sentinel in part thanks to his court sorceress, Medora Direnni. Her grandfather Jovron Direnni was Imperial Battlemage to the court of the Dunmer Empress of Tamriel, Katariah, assisting her in creating peace in a time of turmoil. His great great grandfather Pelladil Direnni had a similar role with the first Potentate, and encouraged the Guild Act without which we would not have all the professional organizations we have today. His ancestor, many times back, was the witch Raven Direnni, who with her better known cousins Aiden and Ryain, brought an end to the tyranny of the latter Alessian Empire. Before the Psijics of Artaeum, it is said, she created the art of enchantment, learning how to bind a soul into a gem and use that to ensorcel all manners of weaponry.

But it is the story of an ancestor even more ancient, more distant than Raven I wish to tell.

Asliel Direnni harkens back to the humble beginnings of our clan, in the tiny farming village of Tyrigel on the banks of the river Caomus which was then called the Diren, hence the family name. Like all on Summurset Isle in those days, he was a simple planter of the fields. But while others only grew enough to sustain their immediate kin, even distant cousins of the Dirennis worked together. They would decide as a group which fields were best for wheat, orchard, vine, livestock, or apiary, and thereby always have the best yields of any farm which worked alone, doing the best as it could with what it had.

Asliel had a particularly poor farm for most kind of agriculture, but small herbs found its stony, loamless, acidic soil very comfortable. Out of necessity more than anything else he became an expert on all manners of herbs. For the most part, of course, they were used in flavoring cooking, but as you know, hardly any plant grows on the surface of our world without a magickal potential.

Even so long ago, witches already were in existence. It would be ridiculous for me to suggest that Asliel Direnni invented alchemy. What he did, what we can all be grateful for, is that he formulated it into an art and science.

There were no witches'' covens in Tyrigel, and, of course, there would be no Mages Guild yet for thousands of years, so people would come to him for cures. He learned for himself the exact formula for combining black lichen and roobrush to create a cure for all manners of poison, and the amount of willow anther to crush and mix with chokeweed to cure diseases.

There were few much greater threats in Tyrigel in those peaceful days than disease or accidental poisonings. Yes, there were some dark forces in the wilderness, trolls, chimera, the occasional malevolent fairy folk and will-o''-the-wisp, but even the youngest, most foolish Altmer knew how to avoid them. There were, however, a few unusual threats which Asliel had a hand in defeating.

One of the tales told of him that I believe to be true is how he was brought a young niece who had been suffering from an unknown disease. Despite his ministrations, she grew weaker and weaker every morning. Finally, he gave her a bitter tasting drink, and the next morning, ashes were found all around her bed. A vampire had been feeding on the poor girl, but Asliel''s potion had turned her very blood into poison, without harming her in the least.

If only this formula had not been lost in the mists of history!

This would have been enough to make him a minor but significant figure in the annals of early Summurset, but at that point in history, a barbarian tribe called the Locvar had found their way down the Diren River, and recognized Tyrigel as a rich target for raids. The Direnni, not being warriors yet but simple farmers, were helpless and could only flee and watch the Locvar take the best of their crops, raid after raid.

Asliel, however, had been experimenting with the vampire dust, and brought his cousins to him with a plan. The next time the Locvar were sighted on the Diren, the word went out and all the most able-bodied came to Asliel''s laboratory. When the barbarians arrived in Tyrigel, they found the farms deserted, and assumed that all had fled as usual. As they set about stealing the bounty, they suddenly found themselves under attack by invisible forces. Believing the Direnni farms to be haunted, they ran away very quickly.

They attempted a few more raids, for their greed would always eventually overpower their fear, and each time, they were set upon by attackers who they could not see. As barbaric as they were, they were not stupid, and they changed their mind about the source of their defeat. It could not be that the farms were haunted, because the crops were still being tended and harvested, and the animals seemed to show no fear. The Locvar decided to send a scout to the farm to see if he could spy their secrets.

The scout sent word back to the Locvar that the Direnni farms were populated with flesh and blood, entirely visible Altmer. He continued to watch as his barbarian cohorts moved down the river, and he saw the elderly and children flee for the hills, while the able-bodied farmers and their wives went to Asliel''s laboratory. He saw them go in; he saw no one come out.

As usual, the Locvar were repelled by invisible forces, but their scout soon told them what he saw happening in the laboratory.

The next night, two of the Locvar approached Asliel''s farm very stealthily, and managed to kidnap him without alerting the rest of the Direnni. The Locvar chieftain, knowing that the farmers could no longer count on the alchemist to make them invisible, considered an immediate attack on the farms. But he was a vengeful sort, and felt he had been humiliated by these simple farmers. A crafty plan emerged in his mind. What if the Direnni, who always saw his barbarian tribe coming, for once did not? Imagine the slaughter if no one even had a chance to flee.

The scout had told the chieftain that Asliel had used the dust of a vampire to make the farmers invisible, but he was not sure what the other ingredient had been. He described an incandescent powder that Asliel had mixed into the dust. Asliel, of course, refused to help the Locvar, but they were experts in torture as well as pillage, and he knew he would have to talk or die.

Finally after hours of torture, he agreed to tell them what the incandescent powder was. He did not know the name, but he called it "Glow Dust," the only remains of a slain will-o''-the-wisp. He told them they would need a lot of it if they wanted to turn the whole tribe invisible for the raid.

The Locvar grumbled that not only did they have to find and kill a vampire to attain his dust, but find and kill several will-o''-the-wisps to get theirs. In a few days time, they came back with the ingredients the alchemist asked for. The chieftain, not being a complete idiot, made Asliel taste the potion first. He did as he was told and turned invisible, demonstrating that it did truly work. The chieftain put him to work creating more. No one apparently noticed that while he did, he was nibbling on black lichen and roobrush.

The Locvar took the potion as he doled it out, and soon, but not too soon that they didn''t suffer, they were all dead.

The scout who had seen Asliel mixing the invisibility potion had apparently mistook the glow of the candlelight in the laboratory for an incandescence which the second ingredient of the invisibility potion did not possess. The second ingredient was actually dull, simple redwort, one of the most common herbs in Tamriel. When they had insisted during torture that Asliel tell them what the incandescent powder was, Asliel remembered that he had once experimentally mixed glow dust and vampire dust together once and created a powerful poison. It was simple enough to steal a little redwort from the barbarian''s camp, mix that with the vampire and glow dust mixture, and create a potion that was in fact an invisibility poison. After curing himself, he gave the poison to the barbarians.

The Locvar, being dead, never again raided the Direnni farms, and having no other enemies, they were able to grow more and more prosperous and powerful. Generations later, they left Summurset and began their historic adventures on the Tamriel mainland. Asliel Direnni, because of his excellence as an alchemist, was invited to Artaeum and became a Psijic. It is not known how many more of the common formulas we know today were invented by him there, but I have no doubt, the science and art of alchemy as we know it today would not exist without him.

But that is all in the distant past. Asliel''s innovations, like my modest ones, like the achievements of the Dirennis throughout history, are but a stepping stone to the wonders which will come in the future. I wish I could be there to witness them, but if I can only share some of the past with the children of Direnni and the children of Tamriel, then I will consider my life well spent.', 0
);

-- AR-V-054  Racial Phylogeny
DELETE FROM tomes WHERE call_number = 'AR-V-054';
INSERT INTO tomes (id, call_number, title, author, school, body, restricted) VALUES (
  (SELECT IFNULL(MAX(id), 0) + 1 FROM tomes),
  'AR-V-054', 'Racial Phylogeny', 'Anonymous', 'Instruction & Research',
  'After much analysis of living specimens, the Council long ago determined that all "races" of elves and humans may mate with each other and bear fertile offspring. Generally the offspring bear the racial traits of the mother, though some traces of the father''s race may also be present. It is less clear whether the Argonians and Khajiit are interfertile with both humans and elves. Though there have been many reports throughout the Eras of children from these unions, as well as stories of unions with daedra, there have been no well documented offspring. Khajiit differ from humans and elves not only their skeletal and dermal physiology -- the "fur" that covers their bodies -- but their metabolism and digestion as well. Argonians, like the dreugh, appear to be a semi-aquatic troglophile form of humans, though it is by no means clear whether the Argonians should be classified with dreugh, men, mer, or (in this author''s opinion), certain tree-dwelling lizards in Black Marsh.

The reproductive biology of orcs is at present not well understood, and the same is true of goblins, trolls, harpies, dreugh, tsaesci, imga, various daedra and many others. Certainly, there have been cases of intercourse between these "races," generally in the nature of rape or magickal seduction, but there have been no documented cases of pregnancy. Still the interfertility of these creatures and the civilized hominids has yet to be empirically established or refuted, likely due to the deep cultural differences. Surely any normal Bosmer or Breton impregnated by an orc would keep that shame to herself, and there''s no reason to suppose that an orc maiden impregnated by a human would not be likewise ostracized by her society. Regrettably, our oaths as healers keep us from forcing a coupling to satisfy our scientific knowledge. We do know, however, that the sload of Thras are hermaphrodites in their youth and later reabsorb their reproductive organs once they are old enough to move about on land. It can be safely assumed that they are not interfertile with men or mer.

One might further wonder whether the proper classification of these same "races," to use the imprecise but useful term, should be made from the assumption of a common heritage and the differences between them have arisen from magickal experimentation, the manipulations of the so-called "Earth Bones," or from gradual changes from one generation to the next.', 0
);

-- AR-V-055  Response to Bero's Speech
DELETE FROM tomes WHERE call_number = 'AR-V-055';
INSERT INTO tomes (id, call_number, title, author, school, body, restricted) VALUES (
  (SELECT IFNULL(MAX(id), 0) + 1 FROM tomes),
  'AR-V-055', 'Response to Bero''s Speech', 'Anonymous', 'Instruction & Research',
  'On the 14th of Last Seed, an illusionist by the name of Berevar Bero gave a very ignorant speech at the Chantry of Julianos in the Imperial City. As ignorant speeches are hardly uncommon, there was no reason to respond to it. Unfortunately, he has since had the speech privately printed as "Bero''s Speech to the Battlemages," and it''s received some small, undeserved attention in academic circles. Let us put his misconceptions to rest.

Bero began his lecture with an occasionally factual account of famous Battlemages from Zurin Arctus, Tiber Septim''s Imperial Battlemage, to Jagar Tharn, Uriel Septim VII''s Imperial Battlemage. His intent was to show that where it matters, the Battlemage relies on other Schools of Magicka, not the School of Destruction which is supposedly a Battlemage''s particular forte. Allow me first to dispute these so-called historical facts.

Zurin Arctus did not create the golem Numidium by spells of Mysticism and Conjuration as Bero alleges. The truth is that we don''t know how Numidium was created or if it was a golem or atronach in any traditional sense of those words. Uriel V''s Battlemage Hethoth was not an Imperial Battlemage — he was simply a sorcerer in the employ of the Empire, thus which spells he cast in the various battles on Akavir are irrelevant, not to mention heresay *[sic]*. Bero calls Empress Morihatha''s Battlemage Welloc "an accomplished diplomat" but not "a powerful student of the School of Destruction." I congratulate Bero on correctly identifying an Imperial Battlemage, but there are many written examples of Welloc''s skill in the School of Destruction. The sage Celarus, for example, wrote extensively about Welloc casting the Vampiric Cloud on the rebellious army of Blackrose, causing their strength and skill to pass on to their opponents. What is this, but an impressive example of the School of Destruction?

Bero rather pathetically includes Jagar Tharn in his list of underachieving Battlemages. To use an insane traitor as example of rational behavior is an untenable position. What would Bero prefer? That Tharn used the School of Destruction to destroy Tamriel by a more traditional means?

Bero uses his misrepresentation of history as the basis for his argument. Even if he had found four excellent examples from history of Battlemages casting spells outside their School — and he didn''t — he would only have anecdotal evidence, which isn''t enough to support an argument. I could easily find four examples of illusionists casting healing spells, or nightblades teleporting. There is a time and a place for everything.

Bero''s argument, built on this shaky ground, is that the School of Destruction is not a true school. He calls it "narrow and shallow" as an avenue of study, and its students impatient, with megalomaniac tendencies. How can one respond to this? Someone who knows nothing about casting a spell of Destruction criticizing the School for being too simple? Summarizing the School of Destruction as learning how to do the "maximum amount of damage in the minimum amount of time" is clearly absurd, and he expounds on his ignorance by listing all the complicated factors studied in his own School of Illusion.

Allow me in response to list the factors studied in the School of Destruction. The means of delivering the spell matters more in the School of Destruction than any other school, whether it is cast at a touch, at a range, in concentric circles, or cast once to be triggered later. What forces must be reigned in to cast the spell: fire, lightning, or frost? And what are the advantages and dangers of each? What are the responses from different targets from the assault of different spells of destruction? What are the possible defenses and how may they be assailed? What environmental factors must be taken into consideration? What are the advantages of a spell of delayed damage? Bero suggests that the School of Destruction cannot be subtle, yet he forgets about all the Curses that fall under the mantle of the school, sometimes affecting generation after generation in subtle yet sublime ways.

The School of Alteration is a distinct and separate entity from the School of Destruction, and Bero''s argument that they should be merged into one is patently ludicrous. He insists — again, a man who knows nothing about the Schools of Alteration and Destruction, is the one insisting this — that "damage" is part of the changing of reality dealt with by the spells of Alteration. The implication is that Levitation, to list a spell of Alteration, is a close cousin of Shock Bolt, a spell of Destruction. It would make as much sense to say that the School of Alteration, being all about the actuality of change, should absorb the School of Illusion, being all about the appearance of change.

It certainly isn''t a coincidence that a master of the School of Illusion cast this attack on the School of Destruction. Illusion is, after all, all about masking the truth.', 0
);

-- AR-V-056  The Doors of Oblivion
DELETE FROM tomes WHERE call_number = 'AR-V-056';
INSERT INTO tomes (id, call_number, title, author, school, body, restricted) VALUES (
  (SELECT IFNULL(MAX(id), 0) + 1 FROM tomes),
  'AR-V-056', 'The Doors of Oblivion', 'Anonymous', 'Instruction & Research',
  'When thou enterest into Oblivion, Oblivion entereth into thee.
Nai Tyrol-Llar
The greatest mage who ever lived was my master Morian Zenas. You have heard of him as the author of the book ''On Oblivion,'' the standard text for all on matters Daedric. Despite many entreaties over the years, he refused to update his classic book with his new discoveries and theories because he found that the more one delves into these realms, the less certain one is. He did not want conjecture, he wanted facts.
For decades before and after the publication of ''On Oblivion,'' Zenas compiled a vast personal library on the subject of Oblivion, the home of the Daedra. He divided his time between this research and personal magickal growth, on the assumption that should he succeed in finding a way into the dangerous world beyond and behind ours, he would need much power to wander its dark paths.
Twelve years before Zenas began the journey he had prepared his life to make, he hired me as his assistant. I possessed the three attributes he required for the position: I was young and eager to help without question; I could read any book once and memorize its contents; and, despite my youth, I was already a Master of Conjuration.
Zenas too was a Master of Conjuration - indeed, a Master at all the known and unknown Schools - but he did not want to rely on his ability alone in the most perilous of his research. In an underground vault, he summoned Daedra to interview them on their native land, and for that he needed another Conjurer to make certain they came, were bound, and were sent away again without incident.
I will never forget that vault, not for its look which was plain and unadorned, but for what you couldn''t see. There were scents that lingered long after the summoned creatures had left, flowers and sulfur, sex and decay, power and madness. They haunt me still to this very day.
Conjuration, for the layman unacquainted with its workings, connects the caster''s mind with that of the summoned. It is a tenuous link, meant only to lure, hold, and dismiss, but in the hands of a Master, it can be much stronger. The Psijics and Dwemer can (in the Dwemer''s case, perhaps I should say, could) connect with the minds of others, and converse miles apart - a skill that is sometimes called telepathy.
Over the course of my employment, Zenas and I developed such a link between one another. It was accidental, a result of two powerful Conjurers working closely together, but we decided that it would be invaluable should he succeed in traveling to Oblivion. Since the denizens of that land could be touched even by the skills of an amateur Conjurer, it was possible we could continue to communicate while he was there, so I could record his discoveries.
The ''Doors to Oblivion,'' to use Morian Zenas''s phrase, are not easily found, and we exhausted many possibilities before we found one where we held the key.
The Psijics of Artaeum have a place they call The Dreaming Cave, where it is said one can enter into the Daedric realms and return. Iachesis, Sotha Sil, Nematigh, and many others have been recorded as using this means, but despite many entreaties to the Order, we were denied its use. Celarus, the leader of the Order, has told us it has been sealed off for the safety of all.
We had hopes of using the ruins of the Battlespire to access Oblivion. The Weir Gate still stands, though the old proving grounds of the Imperial Battlemages itself was shattered some years ago in Jagar Tharn''s time. Sadly, after an exhaustive search through the detritus, we had to conclude that when it was destroyed, all access to the realms beyond, the Soul Cairn, the Shade Perilous, and the Havoc Wellhead, had been broken. It was probably for the good, but it frustrated our goal.
The reader may have heard of other Doors, and he may be assured we attempted to find them all.
Some are pure legend, or at any rate, not traceable based on the information left behind. There are references in lore to Marukh''s Abyss, the Corryngton Mirror, the Mantellan Crux, the Crossroads, the Mouth, a riddle of an alchemical formula called Jacinth and Rising Sun, and many other places and objects that are said to be Doors, but we could not find.
Some exist, but cannot be entered safely. The whirlpool in the Abecean called the Maelstrom of Bal can make ships disappear, and may be a portal into Oblivion, but the trauma of riding its waters would surely slay any who tried. Likewise, we did not consider it worth the risk to leap from the Pillar of Thras, a thousand foot tall spiral of coral, though we witnessed the sacrifices the sloads made there. Some victims were killed by the fall, but some, indeed, seemed to vanish before being dashed on the rocks. Since the sload did not seem certain why some were taken and some died, we did not favor the odds of the plunge.
The simplest and most maddeningly complex way to go to Oblivion was simply to cease to be here, and begin to be there. Throughout history, there are examples of mages who seemed to travel to the realms beyond ours seemingly at will. Many of these voyagers are long dead, if they ever existed, but we were able to find one still living. In a tower off Zafirbel Bay on the island of Vvardenfell in the province of Morrowind there exists a very old, very reclusive wizard named Divayth Fyr.
He was not easy to reach, and he was reluctant to share with Morian Zenas the secret Door to Oblivion. Fortunately, my master''s knowledge of lore impressed Fyr, and he taught him the way. I would be breaking my promise to Zenas and Fyr to explain the procedure here, and I would not divulge it even if I could. If there is dangerous knowledge to be had, that is it. But I do not reveal too much to say that Fyr''s scheme relied on exploiting a series of portals to various realms created by a Telvanni wizard long missing and presumed dead. Against the disadvantage of this limited number of access points, we weighed the relative reliability and security of passage, and considered ourselves fortunate in our informant.
Morian Zenas then left this world to begin his exploration. I stayed at the library to transcribe his information and help him with any research he needed.
''Dust,'' he whispered to me on the first day of his voyage. Despite the inherent dreariness of the word, I could hear his excitement in his voice, echoing in my mind. ''I can see from one end of the world to the other in a million shades of gray. There is no sky or ground or air, only particles, floating, falling, whirling about me. I must levitate and breathe by magickal means …''
Zenas explored the nebulous land for some time, encountering vaporous creatures and palaces of smoke. Though he never met the Prince, we concluded that he was in Ashpit, said to be the home of Malacath, where anguish, betrayal, and broken promises like ash filled the bitter air.
''The sky is on fire,'' I heard him say as he moved on to the next realm. ''The ground is sludge, but traversable. I see blackened ruins all around me, like a war was fought here in the distant past. The air is freezing. I cast blooms of warmth all around me, but it still feels like daggers of ice stabbing me in all directions.''
This was Coldharbour, where Molag Bal was Prince. It appeared to Zenas as if it were a future Nirn, under the King of Rape, desolate and barren, filled with suffering. I could hear Morian Zenas weep at the images he saw, and shiver at the sight of the Imperial Palace, spattered with blood and excrement.
''Too much beauty,'' Zenas gasped when he went to the next realm. ''I am half blind. I see flowers and waterfalls, majestic trees, a city of silver, but it is all a blur. The colors run like water. It''s raining now, and the wind smells like perfume. This surely is Moonshadow, where Azura dwells.''
Zenas was right, and astonishingly, he even had audience with the Queen of Dusk and Dawn in her rose palace. She listened to his tale with a smile, and told him of the coming of the Nevevarine *[sic]*. My master found Moonshadow so lovely, he wished to stay there, half-blind, forever, but he knew he must move on and complete his journey of discovery.
''I am in a storm,'' he told me as he entered the next realm. He described the landscape of dark twisted trees, howling spirits, and billowing mist, and I thought he might have entered the Deadlands of Mehrunes Dagon. But then he said quickly, ''No, I am no longer in a forest. There was a flash of lightning, and now I am on a ship. The mast is tattered. The crew is slaughtered. Something is coming through the waves … oh, gods … Wait, now, I am in a dank dungeon, in a cell …''
He was not in the Deadlands, but Quagmire, the nightmare realm of Vaernima. Every few minutes, there was a flash of lightning and reality shifted, always to something more horrible and horrifying. A dark castle one moment, a den of ravening beasts the next, a moonlit swamp, a coffin where he was buried alive. Fear got the better of my master, and he quickly passed to the next realm.
I heard him laugh, ''I feel like I''m home now.''
Morian Zenas described to me an endless library, shelves stretching on in every direction, stacks on top of stacks. Pages floated on a mystical wind that he could not feel. Every book had a black cover with no title. He could see no one, but felt the presence of ghosts moving through the stacks, rifling through books, ever searching.
It was Apocrypha. The home of Hermaeus-Mora, where all forbidden knowledge can be found. I felt a shudder in my mind, but I could not tell if it was my master''s or mine.
Morian Zenas never traveled to another realm that I know of.
Throughout his visits to the first four realms, my master spoke to me constantly. Upon entering the Apocrypha, he became quieter, as he was lured into the world of research and study, the passions that had controlled his heart while on Nirn. I would frantically try to call to him, but he closed his mind to me.
Then he would whisper, ''This cannot be …''
''No one would ever guess the truth …''
''I must learn more …''
''I see the world, a last illusion''s shimmer, it is crumbling all around us …''
I would cry back to him, begging him to tell me what was happening, what he was seeing, what he was learning. I even tried using Conjuration to summon him as if he were a Daedra himself, but he refused to leave. Morian Zenas was lost.
I last received a whisper from him six months ago. Before then, it had been five years, and three before that. His thoughts are no longer intelligible in any language. Perhaps he is still in Apocrypha, lost but happy, in a trap he refuses to escape.
Perhaps he slipped between the stacks and passed into the Madhouse of Sheogorath, losing his sanity forever.
I would save him if I could.
I would silence his whispers if I could.', 1
);

-- AR-V-057  The Importance of Where
DELETE FROM tomes WHERE call_number = 'AR-V-057';
INSERT INTO tomes (id, call_number, title, author, school, body, restricted) VALUES (
  (SELECT IFNULL(MAX(id), 0) + 1 FROM tomes),
  'AR-V-057', 'The Importance of Where', 'Anonymous', 'Instruction & Research',
  'The chieftain of Othrobar gathered his wise men together and said, "Every morning a tenfold of my flock are found butchered. What is the cause?"

Fangbith the Warleader said, "A Monster may be coming down from the Mountain and devouring your flock."

Ghorick the Healer said, "A strange new disease perhaps is to blame."

Beran the Priest said, "We must sacrifice to the Goddess for her to save us."

The wise men made sacrifices, and while they waited for their answers from the Goddess, Fangbith went to Mentor Joltereg and said, "You taught me well how to forge the cudgel of Zolia, and how to wield it in combat, but I must know now when it is wise to use my skill. Do I wait for the Goddess to reply, or the medicine to work, or do I hunt the Monster which I know is in the Mountain?"

"When is not important," said Joltereg. "Where is all that is important."

So Fangbith took his Zolic cudgel in hand and walked far through the dark forest until he came to the base of the Great Mountain. There he met two Monsters. One bloodied with the flesh of the chieftain of Othrobar''s flock fought him while its mate fled. Fangbith remembered what his master had taught him, that "where" was all that was important.

He struck the Monster on each of its five vital points: head, groin, throat, back, and chest. Five blows to the five points and the Monster was slain. It was too heavy to carry with him, but still triumphant, Fangbith returned to Othrobar.

"I say I have slain the Monster that ate your flock," he cried.

"What proof have you that you have slain any Monster?" asked the chieftain.

"I say I have saved the flock with my medicine," said Ghorick the Healer.

"I say The Goddess has saved the flock by my sacrifices," said Beran the Priest.

Two mornings went by and the flocks were safe, but on the morning of the third day, another tenfold of the chieftain''s flock was found butchered. Ghorick the Healer went to his study to find a new medicine. Beran the Priest prepared more sacrifices. Fangbith took his Zolic cudgel in hand, again, and walked far through the dark forest until he came to the base of the Great Mountain. There he met the other Monster, bloodied with the flesh of the chieftain of Othrobar''s flock. They did battle, and again Fangbith remembered what his master had taught him, that "where" was all that was important.

He struck the Monster five times on the head and it fled. Chasing it along the mountain, he struck it five times in the groin and it fled. Running through the forest, Fangbith overtook the Monster and struck it five times in the throat and it fled. Entering into the fields of Othrobar, Fangbith overtook the Monster and struck it five times in the back and it fled. At the foot of the stronghold, the chieftain and his wise men emerged to the sound of the Monster wailing. There they beheld the Monster that had slain the chieftain''s flock. Fangbith struck the Monster five times in the chest and it was slain.

A great feast was held in Fangbith''s honor, and the flock of Othrobar was never again slain. Joltereg embraced his student and said, "You have at last learned the importance of where you strike your blows."

***Publisher''s Note:***

*This tale is another, which has an obvious origin among the Ashlander tribes of Vvardenfell and is one of their oldest tales. "Marobar Sul" merely changed the names of the character to sound more "Dwarven" and resold it as part of his collection. The Great Mountain in the tale is clearly "Red Mountain," despite its description of being forested. The Star-Fall and later eruptions destroyed the vegetation on Red Mountain, giving it the wasted appearance it has today.*

*This tale does have some scholarly interest, as it suggests a primitive Ashlander culture, but it talks of living in "strongholds" much like the ruined strongholds on Vvardenfell today. There are even references to a stronghold of "Othrobar" somewhere between Vvardenfell and Skyrim, but few strongholds outside of sparsely-settled Vvardenfell have survived to the present. Scholars do not agree on who built these strongholds or when, but I believe it is clear from this story and other evidence that the Ashlander tribes used these strongholds in the ancient past instead of making camps of wickwheat huts as they do today.*

*The play on words that forms the lesson of the fable -- that it is as important to know where the monster should be slain, at the stronghold, as it is to know where the monster must be struck on its body to be slain -- is typical of many Ashlander tales. Riddles, even ones as simple as this one, are loved by both the Ashlanders and the vanished Dwemer. Although the Dwemer are usually portrayed as presenting the riddles, rather than being the ones who solve it as in Ashlander tales.*', 0
);

-- AR-V-058  Words and Philosophy
DELETE FROM tomes WHERE call_number = 'AR-V-058';
INSERT INTO tomes (id, call_number, title, author, school, body, restricted) VALUES (
  (SELECT IFNULL(MAX(id), 0) + 1 FROM tomes),
  'AR-V-058', 'Words and Philosophy', 'Anonymous', 'Instruction & Research',
  'Lady Allena Benoch, former master of the Valenwood Fighter''s Guild and head of the Emperor''s personal guard in the Imperial City, has been leading a campaign to reacquaint the soldiers of Tamriel with the sword. I met with her on three different occasions for the purposes of this book. The first time was at her suite in the palace, on the balcony overlooking the gardens below.

I was early for the interview, which had taken me nearly six months to arrange, but she gently chided me for not being even earlier.

"I''ve had time to put up my defenses now," she said, her bright green eyes smiling.

Lady Benoch is a Bosmer, a Wood Elf, and like her ancestors, took to the bow in her early years. She excelled at the sport, and by the age of fourteen, she had joined the hunting party of her tribe as a Jaqspur, a long distance shooter. During the black year of 396, when the Parikh tribe began their rampage through southeastern Valenwood with the aid of powers from the Summurset Isle, Lady Benoch fought the futile battle to keep her tribe''s land.

"I killed someone for the first time when I was sixteen," she says now. "I don''t remember it very well -- he or she was just a blur on the horizon where I aimed my bow. It meant no more to me than shooting animals. I probably killed a hundred people like that during that summer and fall. I didn''t really feel like a killer until that wintertide, when I learned what it was like to look into a man''s eyes as you spilled his blood.

"It was a scout from the Parikh tribe who surprised me while I was on camp watch. We surprised each other, I suppose. I had my bow at my side, and I just panicked, trying to string an arrow when he was half a yard away from me. It was the only thing I knew to do. Of course, he struck first with his blade, and I just fell back in shock.

"You always remember the mistakes of your first victim. His mistake was assuming because he had drawn blood and I had fallen, that I was dead. I rushed at him the moment he turned from me towards the sleeping camp of my tribesmen. He was caught off guard, and I wrested his blade away from him.

"I don''t know how many times I stabbed at him. By the time I stopped, when the next watch came to relieve me, my arms were black and blue with strain, there was not a solid piece of him left. I had literally cut him into pieces. You see, I had no concept of how to fight or how much it took to kill a man."

Lady Benoch, aware of this deficiency in her education, began teaching herself swordsmanship at once.

"You can''t learn how to use a sword in Valenwood," she says. "Which isn''t to say Bosmer can''t use blades, but we''re largely self-taught. As much as it hurt when my tribe found itself homeless, pushed to the north, it did have one good aspect: it afforded me the opportunity to meet Redguards."

Studying all manners of weapon wielding under the tutelage of Warday A''kor, Lady Benoch excelled. She became a freelance adventurer, traveling through the wilds of southern Hammerfell and northern Valenwood, protecting caravans and visiting dignitaries from the various dangers indigenous to the population.

Unfortunately, before we were able to pursue her story of her early years any further, Lady Benoch was called away on urgent summons from the Emperor. Such is often the case with the Imperial Guard, and in these troubled times, perhaps, more so than in the past. When I tried to contact her for another talk, her servants informed me than *[sic]* their mistress was in Skyrim. Another month passed, and when I visited her suite, I was told she was in High Rock.

To her credit, Lady Benoch actually sought me out for our second interview on Sun''s Dusk of that year. I was in a tavern in the City called the Blood and Rooster, when I felt her hand on my shoulder. She sat down at the rude table and continued her tale as if it had never been interrupted.

She returned to the theme of her days as an adventurer, and told me about the first time she ever felt confident with a sword.

"I owned at that time an enchanted daikatana, quite a good one, of daedric metal. It wasn''t an original Akaviri, not even of design. I didn''t have that kind of money, but it served my primary purpose of delivering as much damage with as little effort on my part as possible. A''kor had taught me how to fence, but when faced with a life or death situation, I always fell back on the old overhand wallop.

"A pack of orcs had stolen some gold from a local chieftain in Meditea, and I went looking for them in one of the ubiquitous dungeons that dot the countryside in that region. There were the usual rats and giant spiders, and I was enough of a veteran by then to dispatch them with relative ease. The problem came when I found myself in a pitch black room, and all around me, I heard the grunts of orcs nearing in.

"I waved my sword around me, connecting with nothing, hearing their footsteps coming ever nearer. Somehow, I managed to hold back my fear and to remember the simple exercises Master A''kor had taught me. I listened, stepped sideways, swung, twisted, stepped forward, swung a circle, turned around, side-stepped, swung.

"My instinct was right. The orcs had gathered in a circle around me, and when I found a light, I saw that they were all dead.

"That''s when I focused on my study of swordplay. I''m stupid enough to require a near death experience to see the practical purposes, you see."

Lady Benoch spent the remainder of the interview, responding in her typically blunt way to the veracity of various myths that surrounded her and her career. It was true that she became the master of the Valenwood Fighter''s Guild after winning a duel with the former master, who was a stooge of the Imperial Battlemage, the traitor Jagar Tharn. It was not true that she was the one responsible for the Valenwood Guild''s disintegration two years later ("Actually, the membership in the Valenwood chapter was healthy, but in Tamriel overall the mood was not conducive for the continued existence of a nonpartisan organization of freelance warriors.") It was true that she first came to the Emperor''s attention when she defended Queen Akorithi of Sentinel from a Breton assassin. It was not true that the assassin was hired by someone in the high court of Daggerfall ("At least," she says wryly, "That has never been proven."). It was also true that she married her former servant Urken after he had been in her service for eleven years ("No one knows how to keep my weaponry honed like he does," she says. "It''s a practical business. I either had to give him a raise or marry him.").

The only story I asked her that she would neither admit nor refute was the one about Calaxes, the Emperor''s bastard. When I brought up the name, she shrugged, professing no knowledge of the affair. I pressed on with the details of the story. Calaxes, though not in line for succession, had been given the Archbishopric of The One: a powerful position in the Imperial City, and indeed over all Tamriel where that religion is honored. Whispering began immediately that Calaxes believed that the Gods were angered with the secular governments of Tamriel and the Emperor specifically. It was even said that Calaxes advocated full-scale rebellion to establish a theocracy over the Empire.

It is certainly true, I pressed on, that the Emperor''s relationship with Calaxes had become very stormy, and that legislation had been passed to limit the Church''s authority. That is, up until the moment when Calaxes disappeared, suddenly, without notice to his closest of friends. Many said that Lady Benoch and the Imperial Guard assassinated the Archbishop Calaxes in the sacristy of his church -- the date usually given was the 29th of Sun''s Dusk 3E 498 *[sic]*.

"Of course," responds Lady Benoch with one of her mysterious grins. "I don''t need to tell you that the Imperial Guard''s position is as protectors of the throne, not assassins."

"But surely, no one is more trusted that *[sic]* the Guard for such a sensitive operation," I say, carefully.

Lady Benoch acknowledges that, but merely says that such details of her duties must remain secret as a matter of Imperial security. Unfortunately, her ladyship had to leave early the next morning, as the Emperor had business down south -- of course, I couldn''t be told more specifics. She promised to send me word when she returned so we could continue our interview.

As it turned out, I had business of my own in the Summurset Isle, compiling a book on the Psijic Order. It was therefore with surprise that I met her ladyship three months later in Firsthold. We managed to get away from our respective duties to complete our third and final interview, on a walk along the Diceto, the great river that passes through the royal parks of the city.

Steering away from questions of her recent duties and assignments, which I guessed rightly she was loath to answer, I returned to the subject of swordfighting.

"Frandar Hunding," she says. "Lists thirty-eight grips, seven hundred and fifty offensive and eighteen hundred defensive positions, and nearly nine thousand moves essential to sword mastery. The average hack-and-slasher knows one grip, which he uses primarily to keep from dropping his blade. He knows one offensive position, facing his target, and one defensive position, fleeing. Of the multitudinous rhythms and inflections of combat, he knows less than one.

"The ways of the warrior were never meant to be the easiest path. The archetype of the idiot fighter is as solidly ingrained as that of the brilliant wizard and the shrewd thief, but it was not always so. The figure of the philosopher swordsman, the blade-wielding artist are creatures of the past, together with the swordsinger of the Redguards, who was said to be able to create and wield a blade with but the power of his mind. The future of the intelligent blade-wielder looks bleak in comparison to the glories of the past."

Not wanting to end our interviews on a sour note, I pressed Lady Allena Benoch for advice for young blade-swingers just beginning their careers.

"When confronted with a wizard," she says, throwing petals of Kanthleaf into the Diceto. "Close the distance and hit ''im hard."', 0
);

-- AR-V-059  Enchanter's Primer
DELETE FROM tomes WHERE call_number = 'AR-V-059';
INSERT INTO tomes (id, call_number, title, author, school, body, restricted) VALUES (
  (SELECT IFNULL(MAX(id), 0) + 1 FROM tomes),
  'AR-V-059', 'Enchanter''s Primer', 'Sergius Turrianus', 'Instruction & Research',
  'A guide for novices in enchanting issued by the College of Winterhold

Enchanting was raised to a fine art by the wizards of the Arcane University. Sadly, some of the nuances of this skill were lost when the Imperial City was sacked. Yet we are not without capability. This text will cover only the basics of Enchanting. It is but a primer for students of the College of Winterhold.

Before a weapon or bit of armor can be enchanted, the wizard must first learn the enchantment. This is a personal task. Enchantments cannot easily be passed from one mage to another. They must be understood at a primal level that can only be achieved by destroying an enchanted item and absorbing its nature.

The Arcane Enchanter is specifically designed for this task. Merely place an enchanted item in the device and will it to relent. The magic will flow into the mage, imbuing him with the knowledge of how the enchantment is formed. The utter destruction of the enchanted item is the unavoidable consequence of this process.

Items that already have enchantments cannot be enchanted further, so choose carefully when you enchant a blade or helmet. Before beginning an enchantment, make sure you have a filled soul gem. The enchantment will use this soul as a source of power. Place the item and the soul gem on the Arcane Echanter [sic]. Concentrate on the enchantment. The device will meld the two together, enchanting your weapon or armor.

Armor enchantments are permanent and do not need to be charged or powered. The reasons for this are not known. Some in the College have postulated that the wearer contributes small amounts of his own energy to keep the armor enchanted. Others say it is just the will of Magnus that it works that way. Regardless of the reason, enchanted armor and clothing never wear out.

Weapon enchantments are a different story. They slowly use up the soul energy in them until they are depleted. The enchantment remains, but a filled soul gem must be used to recharge the weapon. Perhaps it is the destructive nature of the weapon enchantment that makes it deplete. One intriguing theory is that the soul leaks out a little at a time into the victims that the weapon harms. As a novice enchanter, the reason is immaterial.

At first you will find that your enchantments require a lot of the soul energy. As you become more skilled, you can achieve the same effects with less and less soul energy. So practice your lessons and pay heed to your masters in the magical arts.', 0
);

-- AR-VIII-022  Song of the Alchemists
DELETE FROM tomes WHERE call_number = 'AR-VIII-022';
INSERT INTO tomes (id, call_number, title, author, school, body, restricted) VALUES (
  (SELECT IFNULL(MAX(id), 0) + 1 FROM tomes),
  'AR-VIII-022', 'Song of the Alchemists', 'Anonymous', 'Plays, Poetry & Riddles',
  'When King Maraneon''s alchemist had to leave his station
After a laboratory experiment that yielded detonation,
The word went out that the King did want
A new savant
To mix his potions and brews.
But he declared he would only choose
A fellow who knew the tricks and the tools.
The King refused to hire on more fools.

After much deliberation, discussions, and debates,
The King picked two well-learned candidates.
Ianthippus Minthurk and Umphatic Faer,
An ambitious pair,
Vied to prove which one was the best.
Said the King, "There will be a test."
They went to a large chamber with herbs, gems, tomes,
Pots, measuring cups, all under high crystalline domes.

"Make me a tonic that will make me invisible,"
Laughed the King in a tone some would call risible.
So Umphatic Faer and Ianthippus Minthurk
Began to work,
Mincing herbs, mashing metal, refining strange oils,
Cautiously setting their cauldrons to burbling boils,
Each on his own, sending mixing bowls mixing,
Sometimes peeking to see what the other was fixing.

After they had worked for nearly three-quarters an hour,
Both Ianthippus Minthurk and Umphatic Faer
Winked at the other, certain he won.
Said King Maraneon,
"Now you must taste the potions you''ve wrought,
Take a spoon and sample it right from your pot."
Minthurk vanished as his lips touched his brew,
But Faer tasted his and remained apparent in view.

"You think you mixed silver, blue diamonds, and yellow grass!"
The King laughed, "Look up, Faer, up to the ceiling glass.
The light falling makes the ingredients you choose
Quite different hues."
"What do you get," asked the floating voice, bold,
"Of a potion of red diamonds, blue grass, and gold?"
"By [Dwemer God]," said Faer, his face in a wince,
"I''ve made a potion to fortify my own intelligence."

***Publisher''s Note:***

*This poetry is so clearly in the style of Gor Felim that it really does not need any commentary. Note the simple rhyming scheme of AA/BB/CC, the sing-song but purposefully clumsy meter, and the recurring jokes at the obviously absurd names, Umphatic Faer and Ianthippus Minthurk. The final joke that the stupid alchemist invents a potion to make himself smarter by pure accident would have appealed to the anti-intellectualism of audiences in the Interregnum period, but would certainly be rejected by the Dwemer.*

*Note that even "Marobar Sul" refuses to name any Dwemer gods. The Dwemer religion, if it can even be called that, is one of the most complex and difficult puzzles of their culture.*

*Over the millennia, the song became a popular tavern song in High Rock before eventually disappearing from everything but scholarly books. Much like the Dwemer themselves.*', 0
);

-- AR-VIII-023  Mannimarco, King of Worms
DELETE FROM tomes WHERE call_number = 'AR-VIII-023';
INSERT INTO tomes (id, call_number, title, author, school, body, restricted) VALUES (
  (SELECT IFNULL(MAX(id), 0) + 1 FROM tomes),
  'AR-VIII-023', 'Mannimarco, King of Worms', 'Anonymous', 'Plays, Poetry & Riddles',
  'O sacred isle Artaeum, where rosy light infuses air,

O''er towers and through flowers, gentle breezes flow,

Softly sloping green-kissed cliffs to crashing foam below,

Always springtide afternoon housed within its border,

This mystic, mist-protected home of the Psijic Order:

Those counselors of kings, cautious, wise, and fair.

Ten score years and thirty since the mighty Remans fell,

Two brilliant students studied within the Psijics'' fold.

One''s heart was light and warm, the other dark and cold.

The madder latter, Mannimarco, whirled in a deathly dance,

His soul in bones and worms, the way of the necromance.

Entrapping and enslaving souls, he cast a wicked spell.

The former, Galerion had magic bold and bright as day.

He confronted Mannimarco beneath gray Ceporah Tower,

Saying, ''Your wicked mysticism is no way to wield your power,

Bringing horror to the spirit world, your studies must cease.''

Mannimarco scoffed, hating well the ways of life and peace,

And returned to his dark artistry; his paints, death and decay.

O sacred isle Artaeum, how slow to perceive the threat,

When the ghastly truth revealed, how weak the punishment.

The ghoulish Mannimarco from the isle of the wise was sent

To the mainland Dawn''s Beauty, more death and souls to reap.

''You have found a wolf, and sent the beast to flocks of sheep,''

Galerion told his Masters, ''A terror on Tamriel has set.''

''Speak no more of him,'' the sage Cloaks of Gray did say.

''Twas not the first time Galerion thought his Masters callous,

Unconcerned for men and mer, aloof in their island palace.

''Twas not the first time Galerion thought ''twas time to build

A new Order to bring true magic to all, a mighty Mages Guild.

But ''twas the time he left, at last, fair Artaeum''s azure bay.

O, but sung we have of Vanus Galerion many times before,

How cast he off the Psijics'' chains, bringing magic to the land.

Throughout the years, he saw the touch of Mannimarco''s hand,

Through Tamriel''s deserts, forests, towns, mountains, and seas.

The dark grip stretching out, growing like some dread disease

By his dark Necromancers, collecting cursed artifacts of yore.

They brought to him these tools, mad wizards and witches,

And brought blood-tainted herbs and oils to his cave of sin,

Sweet Akaviri poison, dust from saints, sheafs of human skin,

Toadstools, roots, and much more cluttered his alchemical shelf,

Like a spider in his web, he sucked all their power into himself,

Mannimarco, Worm King, world''s first of the undying liches.

Corruption on corruption, ''til the rot sunk to his very core,

Though he kept the name Mannimarco, his body and his mind

Were but a living, moving corpse as he left humanity behind.

The blood in his veins became instead a poison acid stew.

His power and his life increased as his fell collection grew.

Mightiest were these artifacts, long cursed since days of yore.

They say Galerion left the Guild, calling it ''a morass,''

But untruth is a powerful stream, polluting the river of time.

Galerion beheld Mannimarco''s rise through powers sublime,

To his mages and Lamp Knights, ''Before my last breath,

Face I must the tyranny of worms, and kill at last, undeath.''

He led them north to cursed lands, to a mountain pass.

O those who survived the battle say its like was never seen.

Armored with magicka, armed with ensorcelled sword and axe,

Galerion cried, echoing, ''Worm King, surrender your artifacts,

And their power to me, and you shall live as befits the dead.''

A hollow laugh answered, ''You die first,'' Mannimarco said.

The mage army then clashed with the unholy force obscene.

Imagine waves of fire and frost, and the mountain shivers,

Picture lightning arching forth, crackling in a dragon''s sigh.

Like leaves, the battlemages fly to rain down from the sky,

At the Necromancers'' call, corpses burst from earth to fight,

To be shattered into nothingness with a flood of holy light.

A maelstrom of energy unleashed, blood cascades in rivers.

Like a thunderburst in blue skies or a lion''s sudden roar,

Like sharp razors tearing over delicate embroidered lace,

So at a touch did Galerion shake the mountain to its base.

The deathly horde fell fatally, but heeding their dying cries

From the depths, the thing they called Worm King did rise.

Nirn itself did scream in the Mages'' and Necromancers'' war

His eyes burning dark fire, he opened his toothless maw,

Vomiting darkness with each exhalation of his breath,

All sucking in the fetid air felt the icy touch of death.

In the skies above the mountain, darkness overcame pale,

Then Mannimarco Worm King felt his dismal powers fail:

The artifacts of death pulled from his putrid skeletal claw.

A thousand good and evil perished then, history confirms.

Among, alas, Vanus Galerion, he who showed the way,

It seemed once that Mannimarco had truly died that day.

Scattered seemed the Necromancers, wicked, ghastly fools,

Back to the Mages Guild, victors kept the accursed tools,

Of him, living still in undeath, Mannimarco, King of Worms.

Children, listen as the shadows cross your sleeping hutch,

And the village sleeps away, streets emptied of the crowds,

And the moons do balefully glare through the nightly clouds,

And the graveyard''s people rest, we hope, in eternal sleep,

Listen and you''ll hear the whispered tap of the footsteps creep,

Then pray you''ll never feel the Worm King''s awful touch.', 1
);

-- AR-VIII-024  The Warrior's Charge
DELETE FROM tomes WHERE call_number = 'AR-VIII-024';
INSERT INTO tomes (id, call_number, title, author, school, body, restricted) VALUES (
  (SELECT IFNULL(MAX(id), 0) + 1 FROM tomes),
  'AR-VIII-024', 'The Warrior''s Charge', 'Anonymous', 'Plays, Poetry & Riddles',
  'The star sung far-flung tales

Wreathed in the silver of Yokuda fair,

Of a Warrior who, arrayed in hue sails

His charges through the serpent''s snare

And the Lord of runes, so bored so soon,

Leaves the ship for an evening''s dare,

Perchance to wake, the coiled snake,

To take its shirt of scales to wear

And the Lady East, who e''ery beast,

Asleep or a''prowl can rouse a scare,

Screams as her eye, alight in the sky

A worm no goodly sight can bear

And the mailed Steed, ajoins the deed

Not to be undone from his worthy share,

Rides the night, towards scale bright,

Leaving the seasoned Warrior''s care

Then the serpent rose, and made stead to close,

The targets lay plain and there,

But the Warrior''s blade the Snake unmade,

And the charges wander no more, they swear', 0
);

-- AR-X-037  Aevar Stone-Singer
DELETE FROM tomes WHERE call_number = 'AR-X-037';
INSERT INTO tomes (id, call_number, title, author, school, body, restricted) VALUES (
  (SELECT IFNULL(MAX(id), 0) + 1 FROM tomes),
  'AR-X-037', 'Aevar Stone-Singer', 'Anonymous', 'Religion & Prophecy',
  '"Sit quietly, Child, and listen, for the story I tell you is a story of the ages."

"But what is it, Grandfather? Is it a story of heroes and beasts?"

The Grandfather looked patiently at the Child. He was growing into a fine boy. Soon he would see the value in the stories, the lessons that were taught to each generation.
"Just listen, Child. Let the story take root in your heart."

--

In a time before now, long before now, when the Skaal were new, there was peace in the Land. The sun was hot and the crops grew long, and the people were happy in the peace that the All-Maker provided. But, the Skaal grew complacent and lazy, and they took for granted the Lands and all the gifts the All-Maker had given them. They forgot, or chose not to remember, that the Adversary is always watching, and that he delights in tormenting the All-Maker and his chosen people. And so it was that the Adversary came to be among the Skaal.

The Adversary has many aspects. He appears in the unholy beasts and the incurable plague. At the End of Seasons, we will know him as Thartaag the World-Devourer. But in these ages he came to be known as the Greedy Man.

The Greedy Man (that is what we call him, for to speak his name would certainly bring ruin on the people) lived among the Skaal for many months. Perhaps he was once just a man, but when the Adversary entered into him, he became the Greedy Man, and that is how he is remembered.

It came to be one day that the powers of the Skaal left them. The strength left the arms of the warriors, and the shaman could no longer summon the beasts to their side. The elders thought that surely the All-Maker was displeased, and some suggested that the All-Maker had left them forever. It was then that the Greedy Man appeared to them and spoke.

"You of the Skaal have grown fat and lazy. I have stolen the gifts of your All-Maker. I have stolen the Oceans, so you will forever know thirst. I have stolen the Lands and the Trees and the Sun, so your crops will wither and die. I have stolen the Beasts, so you will go hungry. And I have stolen the Winds, so you will live without the Spirit of the All-Maker.

"And until one of you can reclaim these gifts, the Skaal will live in misery and despair. For I am the Greedy Man, and that is my nature."

And the Greedy Man disappeared.

The members of the Skaal spoke for many days and nights. They knew that one of them must retrieve the Gifts of the All-Maker, but they could not decide who it should be.

"I cannot go," said the Elder, "for I us must stay to lead the Skaal, and tell our people what is the law."

"I cannot go," said the Warrior, "for I must protect the Skaal. My sword will be needed in case the Greedy Man reappears."

"I cannot go," said the Shaman, "for the people need my wisdom. I must read the portents and offer my knowledge."

It was then that a young man called Aevar lifted his voice. He was strong of arm, and fleet of foot, though he was not yet a warrior of the Skaal.

"I will go," said Aevar, and the Skaal laughed.

"Hear me out," the boy continued. "I am not yet a warrior, so my sword will not be needed. I cannot read the portents, so the people will not seek my counsel. And I am young, and not yet wise in the ways of the law. I will retrieve the Gifts of the All-Maker from the Greedy Man. If I cannot, I will not be missed."

The Skaal thought on this briefly, and decided to let Aevar go. He left the village the next morning to retrieve the Gifts.

Aevar first set out to retrieve the Gift of Water, so he traveled to the Water Stone. It was there the All-Maker first spoke to him.

"Travel west to the sea and follow the Swimmer to the Waters of Life."

So Aevar walked to the edge of the ocean, and there was the Swimmer, a Black Horker, sent from the All-Maker. The Swimmer dove into the waters and swam very far, and far again. Aevar was strong, though, and he swam hard. He followed the Swimmer to a cave, swimming deeper and deeper, his lungs burning and his limbs exhausted. At last, he found a pocket of air, and there, in the dark, he found the Waters of Life. Gathering his strength, he took the Waters and swam back to the shore.

Upon returning to the Water Stone, the All-Maker spoke. "You have returned the Gift of Water to the Skaal. The Oceans again will bear fruit, and their thirst will be quenched."

Aevar then traveled to the Earth Stone, and there the All-Maker spoke to him again.

"Enter the Cave of the Hidden Music, and hear the Song of the Earth."

So Aevar traveled north and east to the Cave of the Hidden Music. He found himself in a large cavern, where the rocks hung from the ceiling and grew from the ground itself. He listened there, and heard the Song of the Earth, but it was faint. Grabbing up his mace, he struck the rocks of the floor in time with the Song, and the Song grew louder, until it filled the cavern and his heart. Then he returned to the Earth Stone.

"The Gift of the Earth is with the Skaal again," said the All-Maker. "The Lands are rich again, and will bear life."

Aevar was tired, as the Sun burned him, the trees offered no shade, and there was no wind to cool him. Still, he traveled on to the Beast Rock, and the All-Maker spoke.

"Find the Good Beast and ease his suffering."

Aevar traveled through the woods of the Isinfier for many hours until he heard the cries of a bear from over a hill. As he crested a hill, he saw the bear, a Falmer''s arrow piercing its neck. He checked the woods for the Falmer (for that is what they were, though some say they are not), and finding none, approached the beast. He spoke soothing words and came upon it slowly, saying, "Good Beast, I mean you no harm. The All-Maker has sent me to ease your suffering."

Hearing these words, the bear ceased his struggles, and laid his head at Aevar''s feet. Aevar grasped the arrow and pulled it from the bear''s neck. Using the little nature magic he knew, Aevar tended the wound, though it took the last bit of his strength. As the bear''s wound closed, Aevar slept.

When he awoke, the bear stood over him, and the remains of a number of the Falmer were strewn about. He knew that the Good Beast had protected him during the night. He traveled back to Beast Rock, the bear by his side, and the All-Maker spoke to him again.

"You have returned the Gift of the Beasts. Once again, the Good Beasts will feed the Skaal when they are hungry, clothe them when they are cold, and protect them in times of need."

Aevar''s strength had returned, so he traveled on to the Tree Stone, though the Good Beast did not follow him. When he arrived, the All-Father spoke to him.

"The First Trees are gone, and must be replanted. Find the seed and plant the First Tree."

Aevar traveled again through the Hirstaang Forest, searching for the seeds of the First Tree, but he could find none. Then he spoke to the Tree Spirits, the living trees. They told him that the seeds had been stolen by one of the Falmer (for they are the servants of the Adversary), and this Falmer was hiding them deep in the forest, so that none would ever find them.

Aevar traveled to the deepest part of the forest, and there he found the evil Falmer, surrounded by the Lesser Tree Spirits. Aevar could see that the Spirits were in his thrall, that he had used the magic of the Seeds and spoken their secret name. Aevar knew he could not stand against such a force, and that he must retrieve the seeds in secret.

Aevar reached into his pouch and drew out his flint. Gathering leaves, he started a small fire outside the clearing where the Falmer and the ensorcelled Spirits milled. All the Skaal know the Spirits'' hatred of fires, for the fires ravage the trees they serve. At once, the Nature of the Spirits took hold, and they rushed to quell the flames. During the commotion, Aevar snuck behind the Falmer and snatched the pouch of Seeds, stealing away before the evil being knew they were gone.

When Aevar returned to the Tree Stone, he planted the tree in the ground, and the All-Maker spoke to him.

"The Gift of Trees is restored. Once again, the Trees and Plants will bloom and grow, and provide nourishment and shade."

Aevar was tired, for the Sun would only burn, and the Winds would not yet cool him, but he rested briefly in the shade of the Trees. His legs were weary and his eyes heavy, but he continued on, traveling to the Sun Stone. Again, the All-Maker spoke.

"The gentle warmth of the Sun is stolen, so now it only burns. Free the Sun from the Halls of Penumbra."

And so Aevar walked west, over the frozen lands until he reached the Halls of Penumbra. The air inside was thick and heavy, and he could see no farther than the end of his arm. Still, he felt his way along the walls, though he heard the shuffling of feet and knew that this place held the Unholy Beasts who would tear his flesh and eat his bones. For hours he crept along, until he saw a faint glow far at the end of the hall.

There, from behind a sheet of perfect ice, came a glow so bright he had to shut his eyes, lest they be forever blinded. He plucked the flaming eye from one of the Unholy Beasts and threw it at the ice with all his might. A small crack appeared in the ice, then grew larger. Slowly, the light crept out between the cracks, widening them, splitting the ice wall into pieces. With a deafening crack, the wall crumbled, and the light rushed over Aevar and through the Halls. He heard the shrieks of the Unholy Beasts as they were blinded and burned. He ran out of the Halls, following the light, and collapsed on the ground outside.

When he was able to rise again, the Sun again warmed him, and he was glad for that. He traveled back to the Sun Stone, where the All-Maker spoke to him.

"The Gift of the Sun is the Skaal''s once again. It will warm them and give them light."

Aevar had one final Gift he had to recover, the Gift of the Winds, so he traveled to the Wind Stone, far on the western coast of the island. When he arrived, the All-Maker spoke to him, giving him his final task.

"Find the Greedy Man and release the Wind from its captivity."

So, Aevar wandered the land in search of the Greedy Man. He looked in the trees, but the Greedy Man did not hide there. Nor did he hide near the oceans, or the deep caves, and the beasts had not seen him in the dark forests. Finally, Aevar came to a crooked house, and he knew that here he would find the Greedy Man.

"Who are you," shouted the Greedy Man, "that you would come to my house?"

"I am Aevar of the Skaal," said Aevar. "I am not warrior, shaman, or elder. If I do not return, I will not be missed. But I have returned the Oceans and the Earth, the Trees, the Beasts, and the Sun, and I will return the Winds to my people, that we may feel the spirit of the All-Maker in our souls again."

And with that, he grabbed up the Greedy Man''s bag and tore it open. The Winds rushed out with gale force, sweeping the Greedy Man up and carrying him off, far from the island. Aevar breathed in the Winds and was glad. He walked back to the Wind Stone, where the All-Maker spoke to him a final time.

"You have done well, Aevar. You, the least of the Skaal, have returned my gifts to them. The Greedy Man is gone for now, and should not trouble your people again in your lifetime. Your All-Maker is pleased. Go now, and live according to your Nature."

And Aevar started back to the Skaal village.

--

"And then what happened, Grandfather?"

"What do you mean, Child? He went home."

"No. When he returned to the village," the Child continued. "Was he made a warrior? Or taught the ways of the shaman? Did he lead the Skaal in battle?"

"I do not know. That is where the story ends," said the Grandfather.

"But that is not an ending! That is not how stories end!"

The old man laughed and got up from his chair.

"Is it not?"', 0
);

-- AR-X-038  Azura and the Box
DELETE FROM tomes WHERE call_number = 'AR-X-038';
INSERT INTO tomes (id, call_number, title, author, school, body, restricted) VALUES (
  (SELECT IFNULL(MAX(id), 0) + 1 FROM tomes),
  'AR-X-038', 'Azura and the Box', 'Anonymous', 'Religion & Prophecy',
  'Nchylbar had enjoyed an adventurous youth, but had grown to be a very wise, very old Dwemer who spent his life searching for the truth and dispelling superstitions. He invented much and created many theorems and logic structures that bore his name. But much of the world still puzzled him, and nothing was a greater enigma to him than the nature of the Aedra and Daedra. Over the course of his research, he came to the conclusion that many of the Gods were entirely fabricated by man and mer.

Nothing, however, was a greater question to Nchylbar than the limits of divine power. Were the Greater Beings the masters of the entire world, or did the humbler creatures have the strength to forge their own destinies? As Nchylbar found himself nearing the end of his life, he felt he must understand this last basic truth.

Among the sage''s acquaintances was a holy Chimer priest named Athynic. When the priest was visiting Bthalag-Zturamz, Nchylbar told him what he intended to do to find the nature of divine power. Athynic was terrified and pleaded with his friend not to break this great mystery, but Nchylbar was resolute. Finally, the priest agreed to assist out of love for his friend, though he feared the results of this blasphemy.

Athynic summoned Azura. After the usual rituals by which the priest declared his faith in her powers and Azura agreed to do no harm to him, Nchylbar and a dozen of his students entered the summoning chamber, carrying with them a large box.

"As we see you in our land, Azura, you are the Goddess of the Dusk and Dawn and all the mysteries therein," said Nchylbar, trying to appear as kindly and obsequious as he could be. "It is said that your knowledge is absolute."

"So it is," smiled the Daedra.

"You would know, for example, what is in this wooden box," said Nchylbar.

Azura turned to Athynic, her brow furrowed. The priest was quick to explain, "Goddess, this Dwemer is a very wise and respected man. Believe me, please, the intention is not to mock your greatness, but to demonstrate it to this scientist and to the rest of his skeptical race. I have tried to explain your power to him, but his philosophy is such that he must see it demonstrated."

"If I am to demonstrate my might in a way to bring the Dwemer race to understanding, it might have been a more impressive feat you would have me do," growled Azura, and turned to look Nchylbar in the eyes. "There is a red-petalled flower in the box."

Nchylbar did not smile or frown. He simply opened the box and revealed to all that it was empty.

When the students turned to look to Azura, she was gone. Only Athynic had seen the Goddess''s expression before she vanished, and he could not speak, he was trembling so. A curse had fallen, he knew that truly, but even crueler was the knowledge of divine power that had been demonstrated. Nchylbar also looked pale, uncertain on his feet, but his face shone with not fear, but bliss. The smile of a Dwemer finding evidence for a truth only suspected.

Two of his students supported him, and two more supported the priest as they left the chamber.

"I have studied very much over the years, performed countless experiments, taught myself a thousand languages, and yet the skill that has taught me the finally truth is the one that I learned when I was but a poor, young man, trying only to have enough gold to eat," whispered the sage.

As he was escorted up the stairs to his bed, a red flower petal fell from the sleeve of his voluminous robe. Nchylbar died that night, a portrait of peace that comes from contented knowledge.

***Publisher''s Note***

*This is another tale whose origin is unmistakably Dwemer. Again, the words of some Aldmeris translations are quite different, but the essence of the story is the same. The Dunmer have a similar tale about Nchylbar, but in the Dunmer version, Azura recognizes the trick and refuses to answer the question. She slays the Dwemer present for their skepticism and curses the Dunmer for blasphemy.*

*In the Aldmeris versions, Azura is tricked not by an empty box, but by a box containing a sphere which somehow becomes a flat square. Of course the Aldmeris versions, being a few steps closer to the original Dwemer, are much more difficult to understand. Perhaps this "stage magic" explanation was added by Gor Felim because of Felim''s own experience with such tricks in his plays when a mage was not available.*

*"Marobar Sul" left even the character of Nchylbar alone, and he represents many "Dwemer" virtues. His skepticism, while not nearly as absolute as in the Aldmeris version, is celebrated even though it brings a curse upon the Dwemer and the unnamed House of the poor priest.*

*Whatever the true nature of the Gods, and how right or wrong the Dwemer were about them, this tale might explain why the dwarves vanished from the face of Tamriel. Though Nchylbar and his kind may not have intended to mock the Aedra and Daedra, their skepticism certainly offended the Divine Orders.*', 0
);

-- AR-X-039  Gods and Worship
DELETE FROM tomes WHERE call_number = 'AR-X-039';
INSERT INTO tomes (id, call_number, title, author, school, body, restricted) VALUES (
  (SELECT IFNULL(MAX(id), 0) + 1 FROM tomes),
  'AR-X-039', 'Gods and Worship', 'Anonymous', 'Religion & Prophecy',
  'Editor''s Note:
Brother Hetchfeld is an Associate Scribe at the Imperial University, Office of Introductory Studies

Gods are commonly judged upon the evidence of their interest in worldly matters. A central belief in the active participation of Deities in mundane matters can be challenged by the reference to apparent apathy and indifference on the part of Gods during times of plague or famine.

From intervention in legendary quests to manifestations in common daily life, no pattern for the Gods of Tamriel activities is readily perceived. The concerns of Gods in many ways may seem unrelated or at best unconcerned with the daily trials of the mortal realm. The exceptions do exist, however.

Many historical records and legends point to the direct intervention of one or more gods at times of great need. Many heroic tales recount blessings of the divinity bestowed upon heroic figures who worked or quested for the good of a Deity or the Deity''s temple. Some of the more powerful artifacts in the known world were originally bestowed upon their owners through such reward. It has also been reported that priests of high ranking in their temples may on occasion call upon their Deity for blessings or help in time of need. The exact nature of such contact and the blessings bestowed is given to much speculation, as the temples hold such associations secret and holy. This direct contact gives weight to the belief that the Gods are aware of the mortal realm. In many circumstances, however, these same Gods will do nothing in the face of suffering and death, seeming to feel no need to interfere. It is thus possible to conclude that we, as mortals, may not be capable of understanding more than a small fraction of the reasoning and logic such beings use.

One defining characteristic of all Gods and Goddesses is their interest in worship and deeds. Deeds in the form of holy quests are just one of the many things that bring the attention of a Deity. Deeds in everyday life, by conforming to the statutes and obligations of individual temples are commonly supposed to please a Deity. Performance of ceremony in a temple may also bring a Deity''s attention. Ceremonies vary according to the individual Deity. The results are not always apparent but sacrifice and offerings are usually required to have any hope of gaining a Deity''s attention.

While direct intervention in daily temple life has been recorded, the exact nature of the presence of a God in daily mundane life is a subject of controversy. A traditional saying of the Wood Elves is that "One man''s miracle is another man''s accident." While some gods are believed to take an active part of daily life, others are well known for their lack of interest in temporal affairs.

It has been theorized that gods do in fact gain strength from such things as worship through praise, sacrifice and deed. It may even be theorized that the number of worshippers a given Deity has may reflect on His overall position among the other Gods. This my own conjecture, garnered from the apparent ability of the larger temples to attain blessings and assistance from their God with greater ease than smaller religious institutions.

There are reports of the existence of spirits in our world that have the same capacity to use the actions and deeds of mortals to strengthen themselves as do the Gods. The understanding of the exact nature of such creatures would allow us to understand with more clarity the connection between a Deity and the Deity''s worshipers.

The implication of the existence of such spirits leads to the speculation that these spirits may even be capable of raising themselves to the level of a God or Goddess. Motusuo of the Imperial Seminary has suggested that these spirits may be the remains of Gods and Goddesses who through time lost all or most of their following, reverting to their earliest most basic form. Practioners *[sic]* of the Old Ways say that there are no Gods, just greater and lesser spirits. Perhaps it is possible for all three theories to be true.', 0
);

-- AR-X-040  N'Gasta! Kvata! Kvakis!
DELETE FROM tomes WHERE call_number = 'AR-X-040';
INSERT INTO tomes (id, call_number, title, author, school, body, restricted) VALUES (
  (SELECT IFNULL(MAX(id), 0) + 1 FROM tomes),
  'AR-X-040', 'N''Gasta! Kvata! Kvakis!', 'Anonymous', 'Religion & Prophecy',
  '*[an obscure text in the language of the Sload, purportedly written by the Second Era Western necromancer, N''Gasta.]*

N''Gasta! Kvata! Kvakis! ahkstas so novajxletero (oix jhemile) so Ranetauw. Ricevas gxin pagintaj membrauw kaj aliaj individuauw, kiujn iamaniere tusxas so raneta aktivado. En gxi aperas informauw unuavice pri so lokauw so cxiumonataj kunvenauw, sed nature ankoix pri aliaj aktuasoj aktivecauw so societo. Ne malofte enahkstas krome plej diversaspekta materialo eduka oix distra.

So interreta Kvako (retletera kaj verjheauw) ahkstas unufsonke alternativaj kanasouw por distribui so enhavon so papera Kva! Kvak!. Sed alifsonke so enhavauw so diversaj verjheauw antoixvible ne povas kaj ecx ne vus cxiam ahksti centprocente so sama. En malvaste cirkusonta paperfolio ekzemple ebsos publikigi ilustrajxauwn, kiuj pro kopirajtaj kiasouw ne ahkstas uzebsoj en so interreto. Alifsonke so masoltaj kostauw reta distribuo forigas so spacajn limigauwn kaj permahksas pli ampleksan enhavon, por ne paroli pri gxishora aktualeco.

Tiuj cirkonstancauw rahkspeguligxos en so aspekto so Kvakoa, kiu ja cetere servos ankoix kiel gxeneraso retejo so ranetauw.', 0
);

-- AR-X-041  Words of Clan Mother Ahnissi
DELETE FROM tomes WHERE call_number = 'AR-X-041';
INSERT INTO tomes (id, call_number, title, author, school, body, restricted) VALUES (
  (SELECT IFNULL(MAX(id), 0) + 1 FROM tomes),
  'AR-X-041', 'Words of Clan Mother Ahnissi', 'Anonymous', 'Religion & Prophecy',
  'Ahnissi tells you. You are no longer a mewing kitten and you have learned to keep secrets from Ahnissi, and so Ahnissi tells you.

In the beginning there were two littermates, Ahnurr and Fadomai. After many phases, Fadomai said to Ahnurr, "Let us wed and make children to share our happiness."

And they gave birth to Alkosh, the First Cat. And Ahnurr said, "Alkosh, we give you Time, for what is as fast or as slow as a cat?"

And they gave birth to Khenarthi, the Winds. "Khenarthi, to you we give the sky, for what can fly higher than the wind?"

And they gave birth to Magrus, the Cat''s Eye. "Magrus, to you we give the sun, for what is brighter than the eye of a cat?"

And they gave birth to Mara, the Mother Cat. "Mara, you are love, for what is more loving than a mother?"

And they gave birth to S''rendarr, the Runt. "S''rendarr, we give you mercy, for how does a runt survive, except by mercy?"

And many phases passed and Ahnurr and Fadomai were happy.

And Ahnurr said, "We should have more children to share our happiness." And Fadomai agreed. And she gave birth to Hermorah. And she gave birth to Hircine. And she gave birth to Merrunz and Mafala and Sangiin and Sheggorath and many others.

And Fadomai said:

"Hermorah, you are the Tides, for who can say whether the moons predict the tides or the tides predict the moons?"

"Hircine, you are the Hungry Cat, for what hunts better than a cat with an empty belly?"

"Merrunz, you are the Ja''Khajiit, for what is more destructive than an *[sic]* kitten?"

"Mafala, you are the Clan Mother, for what is more secretive than the ways of the Clan Mothers?"

"Sangiin, you are the Blood Cat, for who can control the urges of blood?"

"Sheggorath, you are the Skooma Cat, for what is crazier than a cat on skooma?"

And Ahnurr said, "Two litters is enough, for too many children will steal our happiness."

But Khenarthi went to Fadomai and said, "Fadomai-mother, Khenarthi grows lonely so high above the world where not even my brother Alkosh can fly." Fadomai took pity on her and tricked Ahnurr to make her pregnant again.

And Fadomai gave birth to the Moons and their Motions. And she gave birth to Nirni, the majestic sands and lush forests. And she gave birth to Azurah, the dusk and the dawn.

And from the beginning, Nirni and Azurah fought for their mother''s favor.

Ahnurr caught Fadomai while she was still birthing, and he was angry. Ahnurr struck Fadomai and she fled to birth the last of her litter far away in the Great Darkness. Fadomai''s children heard what had happened, and they all came to be with her and protect her from Ahnurr''s anger.

And Fadomai gave birth to Lorkhaj, the last of her litter, in the Great Darkness. And the Heart of Lorkhaj was filled with the Great Darkness. And when he was born, the Great Darkness knew its name and it was Namiira.

And Fadomai knew her time was near. Fadomai said:

"Ja-Kha''jay, to you Fadomai gives the Lattice, for what is steadier than the phases of the moons? Your eternal motions will protect us from Ahnurr''s anger." And the moons left to take their place in the heavens. And Ahnurr growled and shook the Great Darkness, but he could not cross the Lattice.

And Fadomai said:

"Nirni, to you Fadomai leaves her greatest gift. You will give birth to many people as Fadomai gave birth today." When Nirni saw that Azurah had nothing, Nirni left smiling.

And all Fadomai''s children left except Azurah. And Fadomai said, "To you, my favored daughter, Fadomai leaves her greatest gift. To you Fadomai leaves her secrets." And Fadomai told her favored daughter three things.

And Fadomai said, "When Nirni is filled with her children, take one of them and change them. Make the fastest, cleverest, most beautiful people, and call them Khajiit."

And Fadomai said, "The Khajiit must be the best climbers, for if Masser and Secunda fail, they must climb Khenarthi''s breath to set the moons back in their courses."

And Fadomai said, "The Khajiit must be the best deceivers, for they must always hide their nature from the children of Ahnurr."

And Fadomai said, "The Khajiit must be the best survivors, for Nirni will be jealous, and she will make the sands harsh and the forests unforgiving, and the Khajiit will always be hungry and at war with Nirni."

And with these words, Fadomai died.

After many phases, Nirni came to Lorkhaj and said, "Lorkhaj, Fadomai told me to give birth to many children, but there is no place for them."

And Lorkhaj said, "Lorkhaj makes a place for children and Lorkhaj puts you there so you can give birth." But the Heart of Lorkhaj was filled with the Great Darkness, and Lorkhaj tricked his siblings so that they were forced into this new place with Nirni. And many of Fadomai''s children escaped and became the stars. And many of Fadomai''s children died to make Nirni''s path stable. And the survivors stayed and punished Lorkhaj.

The children of Fadomai tore out the Heart of Lorkhaj and hid it deep within Nirni. And they said, "We curse you, noisy Lorkhaj, to walk Nirni for many phases."

But Nirni soon forgave Lorkhaj for Nirni could make children. And she filled herself with children, but cried because her favorite children, the forest people, did not know their shape.

And Azurah came to her and said, "Poor Nirni, stop your tears. Azurah makes for you a gift of a new people." Nirni stopped weeping, and Azurah spoke the First Secret to the Moons and they parted and let Azurah pass. And Azurah took some forest people who were torn between man and beast, and she placed them in the best deserts and forests on Nirni. And Azurah in her wisdom made them of many shapes, one for every purpose. And Azurah named them Khajiit and told them her Second Secret and taught them the value of secrets. And Azurah bound the new Khajiit to the Lunar Lattice, as is proper for Nirni''s secret defenders. Then Azurah spoke the Third Secret, and the Moons shone down on the marshes and their light became sugar.

But Y''ffer heard the First Secret and snuck in behind Azurah. And Y''ffer could not appreciate secrets, and he told Nirni of Azurah''s trick. So Nirni made the deserts hot and the sands biting. And Nirni made the forests wet and filled with poisons. And Nirni thanked Y''ffer and let him change the forest people also. And Y''ffer did not have Azurah''s subtle wisdom, so Y''ffer made the forest people Elves always and never beasts. And Y''ffer named them Bosmer. And from that moment they were no longer in the same litter as the Khajiit.

And because Y''ffer had no appreciation for secrets, he shouted the First Secret across all the heavens with his last breath so that all of Fadomai''s children could cross the Lattice. But Azurah, in her wisdom, closed the ears of angry Ahnurr and noisy Lorkhaj so they alone did not hear the word.', 0
);

-- The corpus carried the source transcription's spelling, `Dragur`.
-- The book is `Amongst the Draugr`; AR-V-003 is in an earlier migration,
-- so the correction is stated here rather than by regenerating that one.
UPDATE tomes SET title = 'Amongst the Draugr'
 WHERE call_number = 'AR-V-003' AND title = 'Amongst the Dragur';

-- External-content FTS: rows inserted behind its back are invisible to
-- MATCH until it is told.
INSERT INTO tomes_fts(tomes_fts) VALUES('rebuild');
