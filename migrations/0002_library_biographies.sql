-- Migration 0002 — Biographies.
--
-- GENERATED FILE. Do not edit by hand: edit the markdown in
-- content/library/ and re-run `npm run seed`.
--
-- The prose is Bethesda's, ported from the Library of Skyrim.
-- See PROVENANCE.md.

-- The first shelf clears the shelves. This generator rewrites in place,
-- so re-applying it is a reset rather than a delta.
DELETE FROM citations;
DELETE FROM tomes;

-- AR-I-001 — Biography of Barenziah
INSERT INTO tomes (id, call_number, title, author, school, body, restricted) VALUES
  (1, 'AR-I-001', 'Biography of Barenziah', 'Stern Gamboge', 'Biographies',
   '## Volume One

Late in the Second Era, a girl-child, Barenziah, was born to the rulers of the kingdom of Mournhold in what is now the Imperial Province of Morrowind. She was reared in all the luxury and security befitting a royal Dark Elven child until she reached five years of age. At that time, His Excellency Tiber Septim I, the first Emperor of Tamriel, demanded that the decadent rulers of Morrowind yield to him and institute imperial reforms. Trusting to their vaunted magic, the Dark Elves impudently refused until Tiber Septim’s army was on the borders. An Armistice was hastily signed by the now-eager Dunmer, but not before there were several battles, one of which laid waste to Mournhold, now called Almalexia.

Little Princess Barenziah and her nurse were found among the wreckage. The Imperial General Symmachus, himself a Dark Elf, suggested to Tiber Septim that the child might someday be valuable, and she was therefore placed with a loyal supporter who had recently retired from the Imperial Army.

Sven Advensen had been granted the title of Count upon his retirement; his fiefdom, Darkmoor, was a small town in central Skyrim. Count Sven and his wife reared the princess as their own daughter, seeing to it that she was educated appropriately-and more importantly, that the imperial virtues of obedience, discretion, loyalty, and piety were instilled in the child. In short, she was made fit to take her place as a member of the new ruling class of Morrowind.

The girl Barenziah grew in beauty, grace, and intelligence. She was sweet-tempered, a joy to her adoptive parents and their five young sons, who loved her as their elder sister. Other than her appearance, she differed from young girls of her class only in that she had a strong empathy for the woods and fields, and was wont to escape her household duties to wander there at times.

Barenziah was happy and content until her sixteenth year, when a wicked orphan stable-boy, whom she had befriended out of pity, told her he had overheard a conspiracy between her guardian, Count Sven, and a Redguard visitor to sell her as a concubine in Rihad, as no Nord or Breton would marry her on account of her black skin, and no Dark Elf would have her because of her foreign upbringing.

“Whatever shall I do?” the poor girl said, weeping and trembling, for she had been brought up in innocence and trust, and it never occurred to her that her friend the stable-boy would lie to her.

The wicked boy, who was called Straw, said that she must run away if she valued her virtue, but that he would come with her as her protector. Sorrowfully, Barenziah agreed to this plan; and that very night, she disguised herself as a boy and the pair escaped to the nearby city of Whiterun. After a few days there, they managed to get jobs as guards for a disreputable merchant caravan. The caravan was heading east by side roads in a mendacious attempt to elude the lawful tolls charged on the imperial highways. Thus the pair eluded pursuit until they reached the city of Rifton, where they ceased their travels for a time. They felt safe in Rifton, close as it was to the Morrowind border so that Dark Elves were enough of a common sight.

## Volume Two

The first volume of this series told the story of Barenziah’s origin-heiress to the throne of Mournhold until her father rebelled against His Excellency Tiber Septim I and brought ruin to the province of Morrowind. Thanks largely to the benevolence of the Emperor, the child Barenziah was not destroyed with her parents, but reared by Count Sven of Darkmoor, a loyal Imperial trustee. She grew up into a beautiful and pious child, trustful of her guardian’s care. This trust, however, was exploited by a wicked orphan stable boy at Count Sven’s estate, who with lies and fabrications tricked her into fleeing Darkmoor with him when she turned sixteen. After many adventures on the road, they settled in Riften, a Skyrim city near the Morrowind borders.

The stable boy, Straw, was not altogether evil. He loved Barenziah in his own selfish fashion, and deception was the only way he could think of that would cement possession of her. She, of course, felt only friendship toward him, but he was hopeful that she would gradually change her mind. He wanted to buy a small farm and settle down into a comfortable marriage, but at the time his earnings were barely enough to feed and shelter them.

After only a short time in Riften, Straw fell in with a bold, villainous Khajiit thief named Therris, who proposed that they rob the Imperial Commandant’s house in the central part of the city. Therris said that he had a client, a traitor to the Empire, who would pay well for any information they could gather there. Barenziah happened to overhear this plan and was appalled. She stole away from their rooms and walked the streets of Riften in desperation, torn between her loyalty to the Empire and her love for her friends.

In the end, loyalty to the Empire prevailed over personal friendship, and she approached the Commandant’s house, revealed her true identity, and warned him of her friends’ plan. The Commandant listened to her tale, praised her courage, and assured her that no harm would come to her. He was none other than General Symmachus, who had been scouring the countryside in search of her since her disappearance, and had just arrived in Riften, hot in pursuit. He took her into his custody, and informed her that, far from being sent away to be sold, she was to be reinstated as the Queen of Mournhold as soon as she turned eighteen. Until that time, she was to live with the Septim family in the newly built Imperial City, where she would learn something of government and be presented at the Imperial Court.

At the Imperial City, Barenziah befriended the Emperor Tiber Septim during the middle years of his reign. Tiber’s children, particularly his eldest son and heir Pelagius, came to love her as a sister. The ballads of the day praised her beauty, chastity, wit, and learning. On her eighteenth birthday, the entire Imperial City turned out to watch her farewell procession preliminary to her return to her native land. Sorrowful as they were at her departure, all knew that she was ready for her glorious destiny as sovereign of the kingdom of Mournhold.

## Volume Three

In the second volume of this series, it was told how Barenziah was kindly welcomed to the newly constructed Imperial City by the Emperor Tiber Septim and his family, who treated her like a long-lost daughter during her almost one-year stay. After several happy months there learning her duties as vassal queen under the Empire, the Imperial General Symmachus escorted her to Mournhold where she took up her duties as Queen of her people under his wise guidance. Gradually they came to love one another and were married and crowned in a splendid ceremony at which the Emperor himself officiated.

After several hundred years of marriage, a son, Helseth, was born to the royal couple amid celebration and joyous prayer. Although it was not publicly known at the time, it was shortly before this blessed event that the Staff of Chaos had been stolen from its hiding place deep in the Mournhold mines by a clever, enigmatic bard known only as the Nightingale.

Eight years after Helseth’s birth, Barenziah bore a daughter, Morgiah, named after Symmachus’ mother, and the royal couple’s joy seemed complete. Alas, shortly after that, relations with the Empire mysteriously deteriorated, leading to much civil unrest in Mournhold. After fruitless investigations and attempts at reconciliation, in despair Barenziah took her young children and travelled to the Imperial City herself to seek the ear of then Emperor Uriel Septim VII. Symmachus remained in Mournhold to deal with the grumbling peasants and annoyed nobility, and do what he could to stave off an impending insurrection.

During her audience with the Emperor, Barenziah, through her magical arts, came to realize to her horror and dismay that the so-called Emperor was an impostor, none other than the bard Nightingale who had stolen the Staff of Chaos. Exercising great self-control she concealed this realization from him. That evening, news came that Symmachus had fallen in battle with the revolting peasants of Mournhold, and that the kingdom had been taken over by the rebels. Barenziah, at this point, did not know where to seek help, or from whom.

The gods, that fateful night, were evidently looking out for her as if in redress of her loss. King Eadwyre of High Rock, an old friend of Uriel Septim and Symmachus, came by on a social call. He comforted her, pledged his friendship-and furthermore, confirmed her suspicions that the Emperor was indeed a fraud, and none other than Jagar Tharn, the Imperial Battlemage, and one of the Nightingale’s many alter egos. Tharn had supposedly retired into seclusion from public work and installed his assistant, Ria Silmane, in his stead. The hapless assistant was later put to death under mysterious circumstances-supposedly a plot implicating her had been uncovered, and she had been summarily executed. However, her ghost had appeared to Eadwyre in a dream and revealed to him that the true Emperor had been kidnapped by Tharn and imprisoned in an alternate dimension. Tharn had then used the Staff of Chaos to kill her when she attempted to warn the Elder Council of his nefarious plot.

Together, Eadwyre and Barenziah plotted to gain the false Emperor’s confidence. Meanwhile, another friend of Ria’s, known only as the Champion, who apparently possessed great, albeit then untapped, potential, was incarcerated at the Imperial Dungeons. However, she had access to his dreams, and she told him to bide his time until she could devise a plan that would effect his escape. Then he could begin on his mission to unmask the impostor.

Barenziah continued to charm, and eventually befriended, the ersatz Emperor. By contriving to read his secret diary, she learned that he had broken the Staff of Chaos into eight pieces and hidden them in far-flung locations scattered across Tamriel. She managed to obtain a copy of the key to Ria’s friend’s cell and bribed a guard to leave it there as if by accident. Their Champion, whose name was unknown even to Barenziah and Eadwyre, made his escape through a shift gate Ria had opened in an obscure corner of the Imperial Dungeons using her already failing powers. The Champion was free at last, and almost immediately went to work.

It took Barenziah several more months to learn the hiding places of all eight Staff pieces through snatches of overheard conversation and rare glances at Tharn’s diary. Once she had the vital information, however – which she communicated to Ria forthwith, who in turn passed it on to the Champion-she and Eadwyre lost no time. They fled to Wayrest, his ancestral kingdom in the province of High Rock, where they managed to fend off the sporadic efforts of Tharn’s henchmen to haul them back to the Imperial City, or at the very least obtain revenge. Tharn, whatever else might be said of him, was no one’s fool-save perhaps Barenziah’s – and he concentrated most of his efforts toward tracking down and destroying the Champion.

As all now know, the courageous, indefatigable, and forever nameless Champion was successful in reuniting the eight sundered pieces of the Staff of Chaos. With it, he destroyed Tharn and rescued the true Emperor, Uriel Septim VII. Following what has come to be known as the Restoration, a grand state memorial service was held for Symmachus at the Imperial City, befitting the man who had served the Septim Dynasty for so long and so well.

Barenziah and good King Eadwyre had come to care deeply for one another during their trials and adventures, and were married in the same year shortly after their flight from the Imperial City. Her two children from her previous marriage with Symmachus remained with her, and a regent was appointed to rule Mournhold in her absence.

Up to the present time, Queen Barenziah has been in Wayrest with Prince Helseth and Princess Morgiah. She plans to return to Mournhold after Eadwyre’s death. Since he was already elderly when they wed, she knows that that event, alas, could not be far off as the Elves reckon time. Until then, she shares in the government of the kingdom of Wayrest with her husband, and seems glad and content with her finally quiet, and happily unremarkable, life.', 0);

-- AR-I-002 — Biography of the Wolf Queen
INSERT INTO tomes (id, call_number, title, author, school, body, restricted) VALUES
  (2, 'AR-I-002', 'Biography of the Wolf Queen', 'Katar Eriphanes', 'Biographies',
   'Few historic figures are viewed as unambiguously evil, but Potema, the so-called Wolf Queen of Solitude, surely qualifies for that dishonor. Born to the Imperial Family in the sixty-seventh year of the third era, Potema was immediately presented to her grandfather, the Emperor Uriel Septim II, a famously kindhearted man, who viewed the solemn, intense babe and whispered, “She looks like a she-wolf about ready to pounce.”

Potema’s childhood in the Imperial City was certainly difficult from the start. Her father, Prince Pelagius Septim, and her mother, Qizara, showed little affection for their brood. Her eldest brother Antiochus, sixteen at Potema’s birth, was already a drunkard and womanizer, infamous in the empire. Her younger brothers Cephorus and Magnus were born much later, so for years she was the only child in the Imperial Court.

By the age of 14, Potema was a famous beauty with many suitors, but she was married to cement relations with King Mantiarco of the Nordic kingdom of Solitude. She entered the court, it was said, as a pawn, but she quickly became a queen. The elderly King Mantiarco loved her and allowed her all the power she wished, which was total.

When Uriel Septim II died the following year, her father was made emperor, and he faced a greatly depleted treasury, thanks to his father’s poor management. Pelagius II dismissed the Elder Council, forcing them to buy back their positions. In 3E 97, after many miscarriages, the Queen of Solitude gave birth to a son, who she named Uriel after her grandfather. Mantiarco quickly made Uriel his heir, but the Queen had much larger ambitions for her child.

Two years later, Pelagius II died – many say poisoned by a vengeful former Council member – and his son, Potema’s brother Antiochus took the throne. At age forty-eight, it could be said that Antiochus’s wild seeds had yet to be sown, and the history books are nearly pornographic in their depictions of life at the Imperial court during the years of his reign. Potema, whose passion was for power not fornication, was scandalized every time she visited the Imperial City.

Mantiarco, King of Solitude, died the springtide after Pelagius II. Uriel ascended to the throne, ruling jointly with his mother. Doubtless, Uriel had the right and would have preferred to rule alone, but Potema convinced him that his position was only temporary. He would have the Empire, not merely the kingdom. In Castle Solitude, she entertained dozens of diplomats from other kingdoms of Skyrim, sowing seeds of discontent. Her guest list over the years expanded to include kings and queens of High Rock and Morrowind as well.

For thirteen years, Antiochus ruled Tamriel, and proved an able leader despite his moral laxity. Several historians point to proof that Potema cast the spell that ended her brother’s life, but evidence one way or another is lost in the sands of time. In any event, both she and her son Uriel were visiting the Imperial court in 3E 112 when Antiochus died, and immediately challenged the rule of his daughter and heir, Kintyra.

Potema’s speech to the Elder Council is perhaps helpful to students of public speaking.

She began with flattery and self-abasement: “My most august and wise friends, members of the Elder Council, I am but a provincial queen, and I can only assume to bring to issue what you yourselves must have already pondered.”

She continued on to praise the late Emperor, who was a popular ruler in spite of his flaws: “He was a true Septim and a great warrior, destroying – with your counsel – the near invincible armada of Pyandonea.”

But little time was wasted, before she came to her point: “The Empress Magna unfortunately did nothing to temper my brother’s lustful spirits. In point of fact, no whore in the slums of the city spread out on more beds than she. Had she attended to her duties in the Imperial bedchamber more faithfully, we would have a true heir to the Empire, not the halfwit, milksop bastards who call themselves the Emperor’s children. The girl called Kintyra is popularly believed to be the daughter of Magna and the Captain of the Guard. It may be that she is the daughter of Magna and the boy who cleans the cistern. We can never know for certain. Not as certainly as we can know the lineage of my son, Uriel. The last of the Septim Dynasty.”

Despite Potema’s eloquence, the Elder Council allowed Kintyra to assume the throne as the Empress Kintyra II. Potema and Uriel angrily returned to Skyrim and began assembling the rebellion.

Details of the War of the Red Diamond are included in other histories: we need not recount the Empress Kintyra II’s capture and eventual execution in High Rock in the year 3E 114, nor the ascension of Potema’s son, Uriel III, seven years later. Her surviving brothers, Cephorus and Magnus, fought the Emperor and his mother for years, tearing the Empire apart in a civil war.

When Uriel III fought his uncle Cephorus in Hammerfell at the Battle of Ichidag in 3E 127, Potema was fighting her other brother, Uriel’s uncle Magnus in Skyrim at the Battle of Falconstar. She received word of her son’s defeat and capture just as she was preparing to mount an attack on Magnus’s weakest flank. The sixty-one-year-old Wolf Queen flew into a rage and led the assault herself. It was a success, and Magnus and his army fled. In the midst the victory celebration, Potema heard the news that her son the Emperor had been killed by an angry mob before he had even made it for trial in the Imperial City. He had been burned to death within his carriage.

When Cephorus was proclaimed Emperor, Potema’s fury was terrible to behold. She summoned daedra to fight for her, had her necromancers resurrect her fallen enemies as undead warriors, and mounted attack after attack on the forces of the Emperor Cephorus I. Her allies began leaving her as her madness grew, and her only companions were the zombies and skeletons she had amassed over the years. The kingdom of Solitude became a land of death. Stories of the ancient Wolf Queen being waited on by rotting skeletal chambermaids and holding war plans with vampiric generals terrified her subjects.

Potema died after a month long siege on her castle in the year 3E 137 at the age of 90. While she lived, she had been the Wolf Queen of Solitude, Daughter of the Emperor Pelagius II, Wife of King Mantiarco, Aunt of the Empress Kintyra II, Mother of Emperor Uriel III, and Sister of the Emperors Antiochus and Cephorus. Three years after her death, Antiochus died, and his – and Potema’s – brother Magnus took the throne.

Her death has hardly diminished her notoriety. Though there is little direct evidence of this, some theologians maintain that her spirit was so strong, she became a daedra after her death, inspiring mortals to mad ambition and treason. It is also said that her madness so infused Castle Solitude that it infected the next king to rule there. Ironically, that was her 18-year-old nephew Pelagius, the son of Magnus. Whatever the truth of the legend, it is undeniable that when Pelagius left Solitude in 3E 145 to assume the title of the Emperor Pelagius III, he quickly became known as Pelagius The Mad. It is even widely rumored that he murdered his father Magnus.

The Wolf Queen must surely have had the last laugh.', 0);

-- AR-I-003 — Galerion the Mystic
INSERT INTO tomes (id, call_number, title, author, school, body, restricted) VALUES
  (3, 'AR-I-003', 'Galerion the Mystic', 'Asgrim Kolsgreg', 'Biographies',
   'During the early bloody years of the Second Era, Vanus Galerion was born under the name Trechtus, a serf on the estate of a minor nobleman, Lord Gyrnasse of Sollicich-on-Ker. Trechtus’ father and mother were common laborers, but his father had secretly, against the law of Lord Gyrnasse, taught himself and then Trechtus to read. Lord Gyrnasse had been advised that literate serfs were an abomination of nature and dangerous to themselves and their lords, and had closed all bookstalls within Sollicich-on-Ker. All booksellers, poets, and teachers were forbidden, except within Gyrnasse’s keep. Nevertheless, a small-scale smuggling operation kept a number of books and scrolls in circulation right under Gyrnasse’s shadow.

When Trechtus was eight, the smugglers were found and imprisoned. Some said that Trechtus’s mother, an ignorant and religious woman fearful of her husband, was the betrayer of the smugglers, but there were other rumors as well. The trial of the smugglers was nonexistant, and the punishment swift. The body of Trechtus’ father was kept hanging for weeks during the hottest summer Sollicich-on-Ker had seen in centuries.

Three months later, Trechtus ran away from Lord Gyrnasse’s estate. He made it as far as Alinor, half-way across Summerset Isle. A band of troubadours found him nearly dead, curled up in a ditch by the side of the road. They nursed him to health and employed him as an errand boy in return for food and shelter. One of the troubadours, a soothsayer named Heliand, began testing Trechtus’ mind and found the boy, though shy, to be preternaturally intelligent and sophisticated given his circumstances. Heliand recognized in the boy a commonality, for Heliand had been trained on the Isle of Artaeum as a mystic.

When the troupe was performing in the village of Potansa on the far eastern end of Summurset, Heliand took Trechtus, then a boy of eleven, to the Isle of Artaeum. The Magister of the Isle, Iachesis, recognized potential in Trechtus and took him on as pupil, giving him the name of Vanus Galarion. Vanus trained his mind on the Isle of Artaeum, as well as his body.

Thus was the first Archmagister of the Mages Guild trained. From the Psijics of the Isle of Artaeum, he received his training. From his childhood of want and injustice, he received his philosophy of sharing knowledge.', 0);

-- AR-I-004 — Life of Uriel Septim VII
INSERT INTO tomes (id, call_number, title, author, school, body, restricted) VALUES
  (4, 'AR-I-004', 'Life of Uriel Septim VII', 'Rufus Hayn', 'Biographies',
   '3E 368-389: Strategist and Conciliator

The early decades of Emperor Uriel’s life were marked by aggressive expansion and consolidation of Imperial influence throughout the empire, but especially in the East, in Morrowind and Black Marsh, where the Empire’s power was limited, Imperial culture was weak, and native customs and traditions were strong and staunchly opposed to assimilation. During this period Uriel greatly benefitted from the arcane support and shrewd council of his close advisor, the Imperial Battlemage, Jagar Tharn.

The story of Uriel’s marriage to the Princess Caula Voria is a less happy tale. Though she was a beautiful and charming woman, and greatly loved and admired by the people, the Empress was a deeply unpleasant, arrogant, ambitious, grasping woman. She snared Uriel Septim with her feminine wiles, but Uriel Septim thereafter soon regretted his mistake, and was repelled by her. They heartily detested one another, and went out of their ways to hurt one another. Their children were the victims of this unhappy marriage.

With his agile mind and vaunting ambition, Uriel soon outstripped his master in the balanced skills of threat and diplomacy. Uriel’s success in co-opting House Hlaalu as an advance guard of Imperial culture and economic development in Morrowind is a noteworthy example. However, Uriel also grew in pride and self-assurance. Jagar Tharn fed Uriel’s pride, and hiding behind the mask of an out-paced former master counselor, Tharn purchased the complete trust that led finally to Uriel’s betrayal and imprisonment in Oblivion and Tharn’s secret usurpation of the Imperial throne.

3E 389-399: Betrayed and Imprisoned

Little is known of Uriel’s experience while trapped in Oblivion. He says he remembers nothing but an endless sequence of waking and sleeping nightmares. He says he believed himself to be dreaming, and had no notion of passage of time. Publicly, he long claimed to have no memory of the dreams and nightmares of his imprisonment, but from time to time, during the interviews with the Emperor that form the basis of this biography, he would relate details of nightmares he had, and would describe them as similar to the nightmares he had when he was imprisoned in Oblivion. He seemed not so much unwilling as incapable of describing the experience.

But it is clear that the experience changed him. In 3E 389 he was a young man, full of pride, energy, and ambition. During the Restoration, after his rescue and return to the throne, he was an old man, grave, patient, and cautious. He also became conservative and pessimistic, where the policies of his early life were markedly bold, even rash. Uriel accounts for this change as a reaction to and revulsion for the early teachings and counsel of Jagar Tharn. However, Uriel’s exile in Oblivion also clearly drained and wasted him in body and spirit, though his mind retained the shrewd cunning and flexibility of his youth.

The story of Tharn’s magical impersonation of the emperor, the unmasking of Tharn’s imposture by Queen Barenziah, and the roles played by King Eadwyre, Ria Silmane, and her Champion in assembling the Staff of Chaos, defeating the renegade Imperial Battlemage Jagar Tharn, and restoring Uriel to the throne, is treated at length in Stern Gamboge’s excellent three-Volume Biography of Barenziah. There is no reason to recount that narrative here. Summarized briefly, Jagar Tharn’s neglect and mismanagement of Imperial affairs resulted in a steady decline in the Empire’s economic prosperity, allowed many petty lords and kings to challenge the authority of the Empire, and permitted strong local rulers in the East and the West to indulge in open warfare over lands and sovereign rights.

3E 399-415: Restoration, the Miracle of Peace, and Vvardenfell

During the Restoration, Uriel Septim turned from the aggressive campaign of military intimidation and diplomatic accommodation of his earlier years, and relied instead on clandestine manipulation of affairs behind the scenes, primarily through the agencies of the various branches of the Blades. A complete assessment of the methods and objectives of this period must wait until after the Emperor’s death, when the voluminous diaries archived at his country estate may be opened to the public, and when the Blades no longer need to maintain secrecy to protect the identities of its agents.

Two signal achievements of this period point to the efficacy of Uriel’s subtle policies: the ‘Miracle of Peace’ (also popularly known as ‘The Warp in the West’) that transformed the Iliac Bay region from an ruly assortment of warring petty kingdoms into the well-ordered and peaceful modern counties of Hammerfell, Sentinel, Wayrest, and Orsinium, and the colonization of Vvardenfell, presided over by the skillful machinations of King Helseth of Morrowind and Lady Barenziah, the Queen-Mother, which brought Morrowind more closely into the sphere of Imperial influence.

3E 415-430: The Golden Peace, King Helseth’s Court, and the Nine in the East

Following the ‘Miracle of Peace’ (best described in Per Vetersen’s *Daggerfall: A Modern History*), the Empire entered a period of peace and prosperity comparable to the early years of Uriel’s reign. With the Imperial Heartland and West solidly integrated into the Empire, Uriel was able to turn his full attention to the East – to Morrowind.

Exploiting conflicts at the heart of Morrowind’s monolithic Tribunal religion and the long-established Great House system of government, and taking advantage of the terrible threat that the corrupted divine beings at the heart of the Tribunal religion presented to the growing colonies on Vvardenfell, Uriel worked through shadowy agents of the Blades and through the court of King Helseth in Mournhold to shift the center of political power in Morrowind from the Great House councils to Helseth’s court, and took advantage of the collapse of the orthodox Tribunal cults to establish the Nine Divines as the dominant faiths in Hlaalu and Vvardenfell Districts.

Hasphat Anabolis’s treatment of the establishment of the Nine in the East in his four-volume *Life and Times of the Nerevarine* is comprehensive; however, he fails to resolve the central mystery of this period – how much did Uriel know about the prophecies of the Nerevarine, and how did he learn of their significance? The definitive resolution of this and other mysteries must await the future release of the Emperor’s private papers, or a relenting of the Blades’ strict policies of secrecy concerning their agents.', 0);

-- AR-I-005 — The Madness of Pelagius
INSERT INTO tomes (id, call_number, title, author, school, body, restricted) VALUES
  (5, 'AR-I-005', 'The Madness of Pelagius', 'Tsathenes', 'Biographies',
   'The man who would be Emperor of all Tamriel was born Thoriz Pelagius Septim, a prince of the royal family of Wayrest in 3E 119 at the end of the glorious reign of his uncle, Antiochus I. Wayrest had been showered by much preference during the years before Pelagius’ birth, for King Magnus was Antiochus’ favorite brother.

It is hard to say when Pelagius’ madness first manifested itself, for, in truth, the first ten years of his life were marked by much insanity in the land itself. When Pelagius was just over a year old, Antiochus died and a daughter, Kintyra, assumed the throne to the acclaim of all. Kintyra II was Pelagius’ cousin and an accomplished mystic and sorceress. If she had sufficient means to peer into the future, she would have surely fled the palace.

The story of the War of the Red Diamond has been told in many other scholarly journals, but as most historians agree, Kintyra II’s reign was usurped by her and Pelagius’ cousin Uriel, by the power of his mother, Potema – the so-called wolf queen of Solitude. The year after her coronation, Kintyra was trapped in Glenpoint and imprisoned in the Imperial dungeons there.

All of Tamriel exploded into warfare as Prince Uriel took the throne as Uriel III, and High Rock, because of the imprisoned Empress’ presence there, was the location of some of the bloodiest battles. Pelagius’ father, King Magnus, allied himself with his brother Cephorus against the usurper Emperor, and brought the wrath of Uriel III and Queen Potema down on Wayrest. Pelagius, his brothers and sisters, and his mother Utheilla fled to the Isle of Balfiera. Utheilla was of the line of Direnni, and her family manse is still located on that ancient isle even to this day.

There is thankfully much written record of Pelagius’ childhood in Balfiera recorded by nurses and visitors. All who met him described him as a handsome, personable boy, interested in sport, magic, and music. Even assuming diplomats’ lack of candor, Pelagius seemed, if anything, a blessing to the future of the Septim Dynasty.

When Pelagius was eight, Cephorus slew Uriel III at the Battle of Ichidag and proclaimed himself Emperor Cephorus I. For the next ten years of his reign, Cephorus battled Potema. Pelagius’ first battle was the Siege of Solitude, which ended with Potema’s death and the final end of the war. In gratitude, Cephorus placed Pelagius on the throne of Solitude.

As king of Solitude, Pelagius’ eccentricities of behavior began to be noticeable. As a favorite nephew of the Emperor, few diplomats to Solitude made critical commentary about Pelagius. For the first two years of his reign, Pelagius was at the very least noted for his alarming shifts in weight. Four months after taking the throne, a diplomat from Ebonheart called Pelagius “a hale and hearty soul with a heart so big, it widens his waist”; five months after that, the visiting princess of Firsthold wrote to her brother that “the king’s gripped my hand and it felt like I was being clutched by a skeleton. Pelagius is greatly emaciated, indeed.”

Cephorus never married and died childless three years after the Siege of Solitude. As the only surviving sibling, Pelagius’ father Magnus left the throne of Wayrest and took residence at the Imperial City as the Emperor Magnus I. Magnus was elderly and Pelagius was his oldest living child, so the attention of Tamriel focused on Sentinel. By this time, Pelagius’ eccentricities were becoming infamous.

There are many legends about his acts as King of Sentinel, but few well-documented cases exist. It is known that Pelagius locked the young princes and princesses of Silvenar in his room with him, only releasing them when an unsigned Declaration of War was slipped under the door. When he tore off his clothes during a speech he was giving at a local festival, his advisors apparently decided to watch him more carefully. On the orders of Magnus, Pelagius was married to the beautiful heiress of an ancient Dark Elf noble family, Katariah Ra’athim.

Nordic kings who marry Dark Elves seldom improve their popularity. There are two reasons most scholars give for the union. Magnus was trying to cement relations with Ebonheart, where the Ra’athim clan hailed. Ebonheart’s neighbor, Mournhold, had been a historical ally of the Empire since the very beginning, and the royal consort of Queen Barenziah had won many battles in the War of the Red Diamond. Ebonheart had a poorly-kept secret of aiding Uriel III and Potema.

The other reason for the marriage was more personal: Katariah was as shrewd a diplomat as she was beautiful. If any creature was capable of hiding Pelagius’ madness, it was she.

On the 8th of Second Seed, 3E 145, Magnus I died quietly in his sleep. Jolethe, Pelagius’ sister took over the throne of Solitude, and Pelagius and Katariah rode to the Imperial City to be crowned Emperor and Empress of Tamriel. It is said that Pelagius fainted when the crown was placed on his head, but Katariah held him up so only those closest to the thrones could see what had happened. Like so many Pelagius stories, this cannot be verified.

Pelagius III never truly ruled Tamriel. Katariah and the Elder Council made all the decisions and only tried to keep Pelagius from embarrassing all. Still, stories of Pelagius III’s reign exist.

It was said that when the Argonian ambassador from Blackrose came to court, Pelagius insisted on speaking in all grunts and squeaks, as that was the Argonian’s natural language.

It is known that Pelagius was obsessed with cleanliness, and many guests reported waking to the noise of an early-morning scrubdown of the Imperial Palace. The legend of Pelagius while inspecting the servants’ work, suddenly defecating on the floor to give them something to do, is probably apocryphal.

When Pelagius began actually biting and attacking visitors to the Imperial Palace, it was decided to send him to a private asylum. Katariah was proclaimed regent two years after Pelagius took the throne. For the next six years, the Emperor stayed in a series of institutions and asylums.

Traitors to the Empire have many lies to spread about this period. Whispered stories of hideous experiments and tortures performed on Pelagius have almost become accepted as fact. The noble lady Katariah became pregnant shortly after the Emperor was sent away, and rumors of infidelity and, even more absurd, conspiracies to keep the sane Emperor locked away, ran amok. As Katariah proved, her pregnancy came about after a visit to her husband’s cell. With no other evidence, as loyal subjects, we are bound to accept the Empress’ word on the matter. Her second child, who would reign for many years as Uriel IV, was the child of her union with her consort Lariate, and publicly acknowledged as such.

On a warm night in Suns Dawn, in his 34th year, Pelagius III died after a brief fever in his cell at the Temple of Kynareth in the Isle of Betony. Katariah I reigned for another forty six years before passing the scepter onto the only child she had with Pelagius, Cassynder.

Pelagius’ wild behavior has made him perversely dear to the province of his birth and death. The 2nd of Suns Dawn, which may or may not be the anniversary of his death (records are not very clear) is celebrated as Mad Pelagius, the time when foolishness of all sorts is encouraged. And so, one of the least desirable Emperors in the history of the Septim Dynasty, has become one of the most famous ones.', 0);

-- AR-I-006 — The Night Mother’s Truth
INSERT INTO tomes (id, call_number, title, author, school, body, restricted) VALUES
  (6, 'AR-I-006', 'The Night Mother’s Truth', 'Gaston Bellefort', 'Biographies',
   'Although various works have been written on the subjects of both Morrowind’s Morag Tong, and Tamriel’s more widespread Dark Brotherhood, there remains confusion as to precisely when and how these two feared assassins’ guilds formed. Or, more specifically, when and how the Dark Brotherhood split from the Morag Tong, as the former is widely accepted to have sprung from the latter.

The largest point of contention seems to be the figure of the Night Mother, a woman who figures prominently in both organizations. Through extensive research and interviews, and not inconsiderable risk to my own life (for the Dark Brotherhood holds this information sacred), I have finally solved this ages-old mystery. I have finally uncovered the Night Mother’s Truth.

Although her name has been lost to time, the Night Mother was once a mere mortal, a Dark Elf woman who lived in a small village once located where the city of Bravil stands now, in the Imperial Province of Cyrodiil. She was a respected member of the Morag Tong and, like her fellow members, this woman made her trade as an assassin in service to the Daedric Prince Mephala. In fact, the woman held the title of Night Mother, reserved for the highest ranking female member of the organization. To be Night Mother of a particular sect was to be that group’s matron - the favored of Mephala, both respected and feared.

However, it was not Mephala who facilitated the transformation from woman to spectre, but another, some would say far deeper form of evil - Sithis, the Dread Lord, embodiment of the unending Void.

Following the Potentate’s assassination in 2E 324, strife descended upon the Morag Tong, and the guild was all but eradicated in Cyrodiil and much of the Empire. It was shortly after these events that the Dunmer woman claimed to hear the voice of Sithis himself. The Dread Lord, she claimed, was displeased. He was unhappy with the Morag Tong’s lack of success. The Void, he told her, was hungry for souls - and it was her destiny to set things right.

And so, according to Dark Brotherhood legend, Sithis visited the Night Mother in her bed chamber, and begat her five children. Two years passed, before the unthinkable happened. The Dark Elf woman followed through with the Dread Lord’s ultimate plan - one night, she murdered her children, and sent their souls straight to the Void. Straight to their father.

When they learned of this affront to decency, the people of the village rallied against the woman. For such an act was considered incomprehensible, even for a Night Mother of the Morag Tong. In one night of vengeance, they descended upon the woman, killing her, and burning down the house in which the atrocity took place. And that was the end of the story. Or so everyone thought.

A little more than thirty years later, an unnamed man heard a strange, comforting voice inside his very head, just as the Dunmer woman claimed to hear the voice of Sithis inside hers. The voice identified herself as the Night Mother, and named the man “Listener” - the first of many.

And so the Unholy Matron set her servant on his path - he would found a new organization, a guild of assassins known as the Dark Brotherhood, in service not to Mephala, but to the Dread Lord Sithis. The Morag Tong, now surviving only in Morrowind, was an artifact of a forgotten age. The Dark Brotherhood would marry business with death. The organization would grow in wealth and power, and the Void would swell with fresh souls. It was, the Night Mother told her Listener, the perfect arrangement.

In the early days of the Dark Brotherhood, the bodies of the Night Mother and her children were recovered from their original burial site, and interred in a crypt beneath the site of her house. And there they remain, even today.

So if, in your travels, you find yourself in the city of Bravil, and make a wish at the statue of the Lucky Old Lady (as is the local custom), know that you stand on sacred, if evil, ground. For you stand above the Night Mother, the Unholy Matron herself, and your luck has just run out.', 0);

-- AR-I-007 — The Real Barenziah
INSERT INTO tomes (id, call_number, title, author, school, body, restricted) VALUES
  (7, 'AR-I-007', 'The Real Barenziah', 'Plitinius Mero', 'Biographies',
   '## Volume 1

Five hundred years ago in Mournhold, City of Gems, there lived a blind widow and her only child, a tall, strapping young man. He was a miner, as was his father before him, a common laborer in the mines of the Lord of Mournhold, for his ability in magicka was small. The work was honorable but paid poorly. His mother made and sold comberry cakes at the city market to help eke out their living. They did well enough, she said, they had enough to fill their bellies, no one could wear more than one suit of clothing at a time, and the roof leaked only when it rained. But Symmachus would have liked more. He hoped for a lucky strike at the mines, which would garner him a large bonus. In his free hours he enjoyed hoisting a mug of ale in the tavern with his friends, and gambling with them at cards. He also drew the eyes and sighs of more than one pretty Elven lass, although none held his interest for long. He was a typical young Dark Elf of peasant descent, remarkable only for his size. It was rumored that he had a bit of Nordic blood in him.

In Symmachus’ thirtieth year, there was great rejoicing in Mournhold-a girl-child had been born to the Lord and Lady. A Queen, the people sang, a Queen is born to us! For among the people of Mournhold, the birth of an heiress is a sure sign of future peace and prosperity.

When the time came round for the royal child’s Rite of Naming, the mines were closed and Symmachus dashed home to bathe and dress in his best. “I’ll rush straight home and tell you all about it,” he promised his mother, who would not be able to attend. She had been ailing, and besides there would be a great crush of people as all Mournhold turned out to be part of the blessed event; and being blind she would be unable to see anything anyway.

“My son,” she said. “Afore you go, fetch me a priest or a healer, else I may pass from the mortal plane ere you return.”

Symmachus crossed to her pallet at once and noted anxiously that her forehead was very hot and her breathing shallow. He pried loose a slat of the wooden floor under which their small hoard of savings was kept. There wasn’t nearly enough to pay a priest for healing. He would have to give what they had and owe the rest. Symmachus snatched up his cloak and hurried away.

The streets were full of folk hurrying to the sacred grove, but the temples were locked and barred. “Closed for the ceremony,” read all the signs.

Symmachus elbowed his way through the mob and managed to overtake a brown-robed priest. “After the rite, brother,” the priest said, “if you have gold I shall gladly attend to your mother. Milord has bidden all clerics attend-and I, for one, have no wish to offend him.”

“My mother’s desperately ill,” Symmachus pled. “Surely Milord will not miss one lowly priest.”

“True, but the Archcanon will,” the priest said nervously, tearing his robe loose from Symmachus’ desperate grip and vanishing into the crowd.

Symmachus tried other priests, and even a few mages, but with no better result. Armored guards marched through the street and pushed him aside with their lances, and Symmachus realized that the royal procession was approaching.

As the carriage bearing the city’s rulers drew abreast, Symmachus rushed out from the crowd and shouted, “Milord, Milord! My mother’s dying-!”

“I forbid her to do so on this glorious night!” the Lord shouted, laughing and scattering coin into the throng. Symmachus was close enough to smell wine on the royal breath. On the other side of the carriage his Lady clutched the babe to her breast, and stared slit-eyed at Symmachus, her nostrils flared in disdain.

“Guards!” she cried. “Remove this oaf.” Rough hands seized Symmachus. He was beaten and left dazed by the side of the road.

Symmachus, head aching, followed in the wake of the crowd and witnessed the Rite of Naming from the top of a hill. He could see the brown-robed clerics and blue-robed mages gathered near the highborn folk far below.

Barenziah.

The name came dimly to Symmachus’ ears as the High Priest lifted the swaddled babe and proffered her to the twin moons on either side of the horizon: Jone rising, Jode setting.

“Behold the Lady Barenziah, born to the land of Mournhold! Grant her thy blessings and thy counsel, ye kind gods, that she may ever rule well over Mournhold, its ken and its weal, its kith and its ilk.”

“Bless her, bless her,” all the people intoned along with their Lord and Lady, hands upraised.

Only Symmachus stood silent, head bowed, knowing in his heart that his dear mother was gone. And in silence he swore a mighty oath-that he should be his Lord’s bane, and in vengeance for his mother’s needless death, the child Barenziah he should have for his own bride, and that his mother’s grandchildren should be born to rule over Mournhold.

After the ceremony, he watched impassively as the royal procession returned to the palace. He saw the priest to whom he’d first spoken. The man came gladly enough now in return for the gold Symmachus had, and a promise of more afterward.

They found his mother dead.

The priest sighed and tucked the pouch of gold coins away. “I’m sorry, brother. It’s all right, you can forget the rest of the gold, there’s aught I can do here. Likely-”

“Give me back my money!” Symmachus snarled. “You’ve done naught to earn it!” He lifted his right arm threateningly.

The priest backed away, about to utter a curse, but Symmachus struck him across the face before more than three words had left his mouth. He went down heavily, striking his head sharply on one of the stones that formed the fire pit. He died instantly.

Symmachus snatched up the gold and fled the city. As he ran, he muttered one word over and over, like a sorcerer’s chant. “Barenziah,” he said. “Barenziah. Barenziah.”

Barenziah stood on one of the balconies of the palace, staring down into the courtyard where soldiers milled, dazzling in their armor. Presently they formed into ordered ranks and cheered as her parents, the Lord and Lady, emerged from the palace, clad from head to toe in ebony armor, long purple-dyed fur cloaks flowing behind. Splendidly caparisoned, shining black horses were brought for them, and they mounted and rode to the courtyard gates, and turned to salute her.

“Barenziah!” they cried. “Barenziah our beloved, farewell!”

The little girl blinked back tears and waved one hand bravely, her favorite stuffed animal, a gray wolfcub she called Wuffen, clutched to her breast with the other. She had never been parted from her parents before and had no idea what it meant, save that there was war in the west and the name Tiber Septim was on everyone’s lips, spoken in hate and dread.

“Barenziah!” the soldiers cried, lifting their lances and swords and bows. Then her dear parents turned and rode away, knights trailing in their wake, until the courtyard was nearly emptied.

Sometime after came a day when Barenziah was shaken awake by her nurse, dressed hurriedly, and borne from the palace.

All she could remember of that dreadful time was seeing a huge shadow with burning eyes filling the sky. She was passed from hand to hand. Foreign soldiers appeared, disappeared, and sometimes reappeared. Her nurse vanished and was replaced by strangers, some more strange than others. There were days, or it may have been weeks, of travel.

One morning she awoke to step out of the coach into a cold place with a large gray stone castle amid empty, endless gray-green hills covered patchily with gray-white snow. She clutched Wuffen to her breast in both hands and stood blinking and shivering in the gray dawn, feeling very small and very dark in all this endless space, this endless gray-white space.

She and Hana, a brown-skinned, black-haired maid who had been traveling with her for several days, went inside the keep. A large gray-white woman with icy gray-golden hair was standing by a hearth in one of the rooms. She stared at Barenziah with dreadful, bright blue eyes.

“She’s very – black, isn’t she?” the woman remarked to Hana. “I’ve never seen a Dark Elf before.”

“I don’t know much about them myself, Milady,” Hana said. “But this one’s got red hair and a temper to match, I can tell you that. Take care. She bites. And worse.”

“I’ll soon train her out of that,” the other woman sniffed. “And what’s that filthy thing she’s got? Ugh!” The woman snatched Wuffen away and threw him into the blazing hearth.

Barenziah shrieked and would have flung herself after him, but was held back despite her attempts to bite and claw at her captors. Poor Wuffen was reduced to a tiny heap of charred ash.

Barenziah grew like a weed transplanted to a Skyrim garden, a ward of Count Sven and his wife the Lady Inga. Outwardly, that is, she thrived – but always there was a cold and empty place within.

“I’ve raised her as my own daughter,” Lady Inga was wont to sigh as she sat gossiping when neighboring ladies came to visit. “But she’s a Dark Elf. What can you expect?”

Barenziah was not meant to overhear these words. At least she thought she was not. Her hearing was keener than that of her Nordic hosts. Other, less desirable Dark Elven traits evidently included pilfering, lying, and a little misplaced magic, just a small fire spell here and a little levitation spell there. And, as she grew older, a keen interest in boys and men, who could provide very pleasant sensations – and to her astonishment, gifts as well. Inga disapproved of this last for reasons incomprehensible to Barenziah, so she was careful to keep it as secret as possible.

“She’s wonderful with the children,” Inga added, referring to her five sons, all younger than Barenziah. “I don’t think she’d ever let them come to harm.” A tutor had been hired when Jonni was six and Barenziah eight, and they took their lessons together. She would have liked to train in arms as well, but the very idea scandalized Count Sven and Lady Inga. So Barenziah was given a small bow and allowed to play at target shooting with the boys. She watched them at arms practice when she could, sparred with them when no grownup folk were about, and knew she was good as or better than they.

“She’s very... proud, though, isn’t she?” one of the ladies would whisper to Inga; and Barenziah, pretending not to hear, would nod silently in agreement. She could not help but feel superior to the Count and his Lady. There was something about them that provoked contempt.

Afterward she came to learn that Sven and Inga were distant cousins of Darkmoor Keep’s last titled residents, and she finally understood. They were poseurs, impostors, not rulers at all. At least, they were not raised to rule. This thought made her strangely furious at them, a good clean hatred quite detached from resentment. She came to see them as disgusting and repellent insects who could be despised but never feared.

Once a month a courier came from the Emperor, bringing a small bag of gold for Sven and Inga and a large bag of dried mushrooms from Morrowind for Barenziah, her favorite treat. On these occasions, she was always made to look presentable-or at least as presentable as a skinny Dark Elf could be made to look in Inga’s eyes-before being summoned into the courier’s presence for a brief interview. The same courier seldom came twice, but all of them looked her over in much the same way a farmer would look over a hog he is readying for market.

In the spring of her sixteenth year, Barenziah thought the courier looked as if she were at last ready for market. Upon reflection, she decided she did not wish to be marketed. The stable-boy, Straw, a big, muscular blond lad, clumsy, gentle, affectionate, and rather simple, had been urging her to run off for some weeks now. Barenziah stole the bag of gold the courier had left, took the mushrooms from the storeroom, disguised herself as a boy in one of Jonni’s old tunics and a pair of his cast-off breeches... and on one fine spring night she and Straw took the two best horses from the stable and rode hard through the night toward Whiterun, the nearest city of any importance and the place where Straw wanted to be. But Mournhold and Morrowind also lay eastward and they drew Barenziah as a lodestone draws iron.

In the morning they abandoned the horses at Barenziah’s insistence. She knew they would be missed and tracked down, and she hoped to throw off any pursuers.

They continued on foot until late afternoon, keeping to side roads, and slept for several hours in an abandoned hut. They went on at dusk and came to Whiterun’s city gates just before dawn. Barenziah had prepared a pass of sorts for Straw, a makeshift document stating an errand to a temple in the city for a local village lord. She herself glided over the wall with the help of a levitation spell. She had reasoned-correctly, as it turned out-that by now the gate guards would have been alerted to keep an eye out for a young Dark Elven girl and a Nordic boy traveling together. On the other hand, unaccompanied country yokels like Straw were a common enough sight. Alone and with papers, it was unlikely that he would draw attention.

Her simple plan went smoothly. She met Straw at the temple, which was not far from the gate; she had been to Whiterun on a few previous occasions. Straw, however, had never been more than a few miles from Sven’s estate, which was his birthplace.

Together they made their way to a rundown inn in the poorer quarters of Whiterun. Gloved, cloaked, and hooded against the morning chill, Barenziah’s dark skin and red eyes were not apparent and no one paid any heed to them. They entered the inn separately. Straw paid the innkeeper for a single cubicle, an immense meal, and two jugs of ale. Barenziah sneaked in a few minutes later.

They ate and drank together gleefully, rejoicing in their escape, and made love vigorously on the narrow cot. Afterward they fell into an exhausted, dreamless sleep.

They stayed for a week at Whiterun. Straw earned a bit of money running errands and Barenziah burgled a few houses at night. She continued to dress as a boy. She cut her hair short and dyed her flame-red tresses jet black to further the disguise, and kept out of sight as much as possible. There were few Dark Elves in Whiterun.

One day Straw got them work as temporary guards for a merchant caravan traveling east. The one-armed sergeant looked her over dubiously.

“Heh,” he chuckled, “Dark Elf, ain’tcha? Like settin’ a wolf t’guard the sheep, that is. Still, I need arms, and we ain’t goin’ near ‘nough Morrowind so’s ye can betray us to yer folk. Our homegrown bandits would as fain cut yer throat as mine.”

The sergeant turned to give Straw an appraising look. Then he spun back abruptly toward Barenziah, whipping out his shortsword. But she had her dagger out in the twinkling of an eye and was in a defensive stance. Straw drew his own knife and circled round to the man’s rear. The sergeant dropped his blade and chuckled again.

“Not bad, kids, not bad. How are ye with yon bow, Dark Elf?” Barenziah demonstrated her prowess briefly. “Aye, not bad, not bad ‘tall. And ye’ll be keen of eye by night, boy, and of hearin’ ‘tall times. A trusty Dark Elf makes as good a fightin’ man as any could ask for. I know. I served under Symmachus hisself afore I lost this arm and got invalided outter the Emp’ror’s army.”

“We could betray them. I know folk who’d pay well,” Straw said later as they bedded down for their last night at the ramshackle lodge. “Or rob them ourselves. They’re very rich, those merchants are, Berry.”

Barenziah laughed. “Whatever would we do with so much money? And besides, we need their protection for traveling quite as much as they need ours.”

“We could buy a little farm, you and me, Berry – and settle down, all nice like.”

Peasant! Barenziah thought scornfully. Straw was a peasant and harbored nothing but peasant dreams. But all she said was, “Not here, Straw, we’re too close to Darkmoor still. We’ll have other chances farther east.”

The caravan went only as far east as Sunguard. The Emperor Tiber Septim I had done much in the way of building relatively safe and regularly patrolled highways. But the tolls were steep, and this particular caravan kept to the side roads as much as possible to avoid them. This exposed them to the hazards of wayside robbers, both human and Orcish, and roving brigand bands of various races. But such were the perils of trade and profit.

They had two such encounters before reaching Sunguard – an ambush which Barenziah’s keen ears warned them of in plenty of time for them to circle about and surprise the lurkers, and a night attack by a mixed band of Khajiit, humans, and Wood Elves. The latter were a skilled band and even Barenziah did not hear them sneaking up in time to give much warning. This time the fighting was fierce. The attackers were driven off, but two of the caravan’s other guards were slain and Straw got a nasty cut on his thigh before he and Barenziah managed to gash his Khajiit assailant’s throat.

Barenziah rather enjoyed the life. The garrulous sergeant had taken a liking to her, and she spent most of her evenings sitting around the campfire listening to his tales of campaigning in Morrowind with Tiber Septim and General Symmachus. This Symmachus had been made general after Mournhold fell, the sergeant said. “He’s a fine soldier, boy, Symmachus is. But there was more’n soldiery involved’n that Morrowind business, if y’take my meanin’. But, well, y’know all ‘bout that, I ‘spect.”

“No. No, I don’t remember,” Barenziah said, trying to sound nonchalant. “I’ve lived most of my life in Skyrim. My mother married a Skyrim man. They’re both dead, though. Tell me, what happened to the Lord and Lady of Mournhold?”

The sergeant shrugged. “I ain’t never heard. Dead, I ‘spect. ‘Twas a lot of fightin’ afore the Armistice got signed. It’s pretty quiet now. Maybe too quiet. Like a calm afore a storm. Say, boy, you goin’ back there?”

“Maybe,” Barenziah said. The truth was that she was drawn irresistibly to Morrowind, and Mournhold, like a moth to a burning house. Straw sensed it and was unhappy about it. He was unhappy anyway since they could not bed together, as she was supposed to be a boy. Barenziah rather missed it too, but not as much as Straw did, seemingly.

The sergeant wanted them to sign on for the return trip, but gave them a bonus nonetheless when they turned the offer down, and parchments of recommendation.

Straw wanted to settle down permanently near Sunguard, but Barenziah insisted on continuing their travels east. “I’m the Queen of Mournhold by rights,” she said, unsure whether it was true – or was it just a daydream she had made up as a lost, bewildered child? “I want to go home. I need to go home.” That at least was true.

After a few weeks they managed to get places in another caravan heading east. By early winter they were at Riften, and nearing the Morrowind border. But the weather had grown severe as the days passed and they were told no merchant caravans would be setting forth till mid-spring.

Barenziah stood on top of the city walls and stared across the deep gorge that separated Riften from the snow-clad mountain wall guarding Morrowind beyond.

“Berry,” Straw said gently. “Mournhold’s a long way off yet, nearly as far as we’ve come already. And the lands between are wild, full of wolves and bandits and Orcs and still worse creatures. We’ll have to wait for spring.”

“There’s Silgrod Tower,” Berry said, referring to the Dark Elven township that had grown up around an ancient minaret guarding the border between Skyrim and Morrowind.

“The bridge guards won’t let me across, Berry. They’re crack Imperial troops. They can’t be bribed. If you go, you go alone. I won’t try and stop you. But what will you do? Silgrod Tower is full of Imperial soldiers. Will you become a washing-woman for them? Or a camp follower?”

“No,” Barenziah said slowly, thoughtfully. Actually the idea was not entirely unappealing. She was sure she could earn a modest living by sleeping with the soldiers. She’d had a few adventures of that sort as they crossed Skyrim, when she’d dressed as a woman and slipped away from Straw. She’d only been looking for a bit of variety. Straw was sweet but dull. She’d been startled, but extremely pleased, when the men she picked up offered her money afterward. Straw had been unhappy about it, though, and would shout for a while then sulk for days afterward if he caught her at it. He was quite jealous. He’d even threatened to leave her. Not that he ever did. Or could.

But the Imperial Guards were a tough and brutal lot by all accounts, and Barenziah had heard some very ugly stories during their treks. The ugliest of them by far had come from the lips of ex-army veterans around the caravan campfire, and were proudly recounted. They’d been trying to shock her and Straw, she realized-but she also comprehended that there was some truth behind the wild tales. Straw hated that kind of dirty talk, and hated it more that she had to hear it. But there was a part of him that was fascinated nevertheless.

Barenziah sensed this and had encouraged Straw to seek out other women. But he said he didn’t want anyone else but her. She told him candidly she didn’t feel that way about him, but she did like him better than anyone else. “Then why do you go with other men?” Straw had asked on one occasion.

“I don’t know.”

Straw sighed. “They say Dark Elven women are like that.”

Barenziah smiled and shrugged. “I don’t know. Or, no ... maybe I do. Yes, I do know.” She turned and kissed him affectionately. “I guess that’s all the explanation there is.”

## Volume 2

Barenziah and Straw settled into Rifton for the winter, taking a cheap room in the slummier section of town. Barenziah wanted to join the Thieves Guild, knowing there would be trouble if she were caught freelancing. One day in a barroom she caught the eye of a known member of the Guild, a bold young Khajiit named Therris. She offered to bed him if he would sponsor her membership. He looked her over, grinning, and agreed, but said she’d still have to pass an initiation.

“What sort of initiation?”

“Ah,” Therris said. “Pay up first, sweetness.”

[This passage has been censored by order of the Temple.]

Straw was going to kill her, and maybe Therris too. What in Tamriel had possessed her to do such a thing? She cast an apprehensive look around the room, but the other patrons had lost interest and gone back to their own business. She did not recognize any of them; this wasn’t the inn where she and Straw were staying. With luck it’d be a while, or never, before Straw found out.

Therris was by far the most exciting and attractive man she had yet met. He not only told her about the skills she needed to become a member of the Thieves Guild, but also trained her in them himself or else introduced her to people who could.

Among these was a woman who knew something about magic. Katisha was a plump and matronly Nord. She was married to a smith, had two teenage children, and was perfectly ordinary and respectable–except that she was very fond of cats (and by logical inference, their humanoid counterparts the Khajiit), had a talent for certain kinds of magic, and cultivated rather odd friends. She taught Barenziah an invisibility spell and schooled her in other forms of stealth and disguise. Katisha mingled magical and non-magical talents freely, using one set to enhance the other. She was not a member of the Thieves Guild but was fond of Therris in a motherly sort of way. Barenziah warmed to her as she never had toward any woman, and over the next few weeks she told Katisha all about herself.

She brought Straw there too sometimes. Straw approved of Katisha. But not of Therris. Therris found Straw “interesting” and suggested to Barenziah that they arrange what he called a “threesome.”

“Absolutely not,” Barenziah said firmly, grateful that Therris had broached the subject in private for once. “He wouldn’t like it. I wouldn’t like it!”

Therris smiled his charming, triangular feline smile and sprawled lazily on his chair, stretching his limbs and curling his tail. “You might be surprised. Both of you. Pairing is so boring.”

Barenziah answered him with a glare.

“Or maybe you wouldn’t like it with that country bumpkin of yours, sweetness. Would you mind if I brought along another friend?”

“Yes, I would. If you’re bored with me, you and your friend can find someone else.” She was a member of the Thieves Guild now. She had passed their initiation. She found Therris useful but not essential. Maybe she was a bit bored with him too.

She talked to Katisha about her problems with men. Or what she thought of as her problems with men. Katisha shook her head and told her she was looking for love, not sex, that she’d know the right man when she found him, that neither Straw nor Therris was the right one for her.

Barenziah cocked her head to one side quizzically. “They say Dark Elven women are pro– pro– something. Prostitutes?” she said, although she was dubious.

“You mean promiscuous. Although some do become prostitutes, I suppose,” Katisha said as an afterthought. “Elves are promiscuous when they’re young. But you’ll outgrow it. Perhaps you’re beginning to already,” she added hopefully. She liked Barenziah, had grown to be quite fond of her. “You ought to meet some nice Elven boys, though. If you go on keeping company with Khajiits and humans and what have you, you’ll find yourself pregnant in next to no time.”

Barenziah smiled involuntarily at the thought. “I’d like that. I think. But it would be inconvenient, wouldn’t it? Babies are a lot of trouble, and I don’t even have my own house yet.”

“How old are you, Berry? Seventeen? Well, you’ve a year or two yet before you’re fertile, unless you’re very unlucky. Elves don’t have children readily with other Elves after that, even, so you’ll be all right if you stick with them.”

Barenziah remembered something else. “Straw wants to buy a farm and marry me.”

“Is that what you want?”

“No. Not yet. Maybe someday. Yes, someday. But not if I can’t be queen. And not just any queen. The Queen of Mournhold.” She said this determinedly, almost stubbornly, as if to drown out any doubt.

Katisha chose to ignore this last comment. She was amused at the girl’s hyperactive imagination, took it as a sign of a well-functioning mind. “I think Straw will be a very old man before ‘someday’ comes, Berry. Elves live for a very long time.” Katisha’s face briefly wore the envious, wistful look humans got when contemplating the thousand-year lifespan Elves had been granted by the gods. True, few ever actually lived that long as disease and violence took their respective tolls. But they could. And one or two of them actually did.

“I like old men too,” Berry said.

Katisha laughed.

Barenziah fidgeted impatiently while Therris sorted through the papers on the desk. He was being meticulous and methodical, carefully replacing everything just as he’d found it.

They’d broken into a nobleman’s household, leaving Straw to hover outside as lookout. Therris had said it was a simple job but very hush-hush. He hadn’t even wanted to bring any other Guild members along. He said he knew he could trust Berry and Straw, but no one else.

“Tell me what you’re looking for and I’ll find it,” Berry whispered urgently. Therris’ night sight wasn’t as good as hers and he didn’t want her to magick up even a small orb of light.

She had never been in such a luxurious place. Not even the Darkmoor castle of Count Sven and Lady Inga where she had spent her childhood compared to it. She’d gazed around in wonder as they made their way through the ornately decorated and hugely echoing downstairs rooms. But Therris didn’t seem interested in anything but the desk in the small book-lined study on the upper floor.

“Sssst,” he hissed angrily.

“Someone’s coming!” Berry said, a moment before the door opened and two dark figures stepped into the room. Therris gave her a violent shove toward them and sprang to the window. Barenziah’s muscles went rigid; she couldn’t move or even speak. She watched helplessly as one of the figures, the smaller one, leaped after Therris. There were two quick, silent stabs of blue light, then Therris folded over into a still heap.

Outside the study the house had come alive with hastening footsteps and voices calling out in alarm and the clank of armor hurriedly put on.

The bigger man, a Dark Elf by the looks of him, half-lifted, half-dragged Therris to the door and thrust him into the waiting arms of another Elf. A jerk of the first Elf’s head sent his smaller blue-robed companion after them. Then he sauntered over to inspect Barenziah, who was once again able to move although her head throbbed maddeningly when she tried to.

“Open your shirt, Barenziah,” the Elf said. Barenziah gawked at him and clutched it closed. “You’re a girl, aren’t you, Berry?” he said softly. “You should have stopped dressing as a boy months ago, you know. You were only drawing attention to yourself. And calling yourself Berry! Is your friend Straw too stupid to remember anything else?”

“It’s a common Elven name,” Barenziah defended.

The man shook his head sadly. “Not among Dark Elves it isn’t, my dear. But you wouldn’t know much about Dark Elves, would you? I regret that, but it couldn’t be helped. No matter. I shall try to remedy it.”

“Who are you?” Barenziah demanded.

“Ai. So much for fame,” the man shrugged, smiling wryly. “I am Symmachus, Milady Barenziah. General Symmachus of His Awesome and Terrible Majesty Tiber Septim I’s Imperial Army. And I must say it’s a merry chase you’ve led me throughout Tamriel. Or this part of it, anyway. Although I guessed, and guessed correctly, that you’d head for Morrowind eventually. You had a bit of luck. A body was found in Whiterun that was thought to be Straw’s. So we stopped looking for the pair of you. That was careless of me. Yet I’d not have thought you’d', 0);
UPDATE tomes SET body = body || ' have stayed together this long.”

“Where is he? Is he all right?” she asked in genuine trepidation.

“Oh, he’s fine. For now. In custody, of course.” He turned away. “You ... care for him, then?” he said, and then suddenly stared at her with fierce curiosity. Out of red eyes that seemed strange to her, except in her own seldom-seen reflection.

“He’s my friend,” Barenziah said. The words came out in a tone that sounded dull and hopeless to her own ears. Symmachus! A general in the Imperial Army, no less–said to have the friendship and ears of Tiber Septim himself.

“Ai. You seem to have several unsuitable friends–if you’ll forgive my saying so, Milady.”

“Stop calling me that.” She was irritated at the general’s seeming sarcasm. But he only smiled.

As they talked the bustle and flurry in the house died away. Although she could still hear people, presumably the residents, whispering together not far off. The tall Elf perched himself on a corner of the desk. He seemed quite relaxed and prepared to stay awhile.

Then it occurred to her. Several unsuitable friends, had he said? This man knew all about her! Or seemed to know enough, anyway. Which amounted to the same thing. “W-what’s going to happen to them? To m-me?”

“Ah. As you know, this house belongs to the commander of the Imperial troops in this area. Which means to say that it belongs to me.” Barenziah gasped and Symmachus looked up sharply. “What, you didn’t know? Tsk, tsk. Why, you are rash, Milady, even for seventeen. You must always know what it is you do, or get yourself into.”

“B-but the G-guild w-wouldn’t ... wouldn’t h-have–” Barenziah was trembling. The Thieves Guild would never have attempted a mission that crossed Imperial policy. No one dared oppose Tiber Septim, at least no one she knew of. Someone at the Guild had bungled. Badly. And now she was going to pay for it.

“I daresay. It’s unlikely that Therris had Guild approval for this. In fact, I wonder–” Symmachus examined the desk carefully, pulling out drawers. He selected one, placed it on top of the desk, and removed a false bottom. There was a folded sheet of parchment inside. It seemed to be a map of some sort. Barenziah edged closer. Symmachus held it away from her, laughing. “Rash indeed!” He glanced it over, then folded and replaced it.

“You advised me a moment ago to seek after knowledge.”

“So I did, so I did.” Suddenly he seemed to be in high good humor. “We must be going, my dear Lady.”

He shepherded her to the door, down the stairs, and out into the night air. No one was about. Barenziah’s eyes darted toward the shadows. She wondered if she could outrun him, or elude him somehow.

“You’re not thinking of attempting to escape, are you? Ai. Don’t you want to hear first what my plans for you are?” She thought that he sounded a bit hurt.

“Now that you mention it–yes.”

“Perhaps you’d rather hear about your friends first.”

“No.”

He looked gratified at this. It was evidently the answer he wanted, thought Barenziah, but it was also the truth. While she was concerned for her friends, especially Straw, she was far more concerned for herself.

“You will take your place as the rightful Queen of Mournhold.”

Symmachus explained that this had been his, and Tiber Septim’s, plan for her all along. That Mournhold, which had been under military rule for the dozen or so years since she had been away, was gradually to be returned to civilian government–under the Empire’s guidance, of course, and as part of the Imperial Province of Morrowind.

“But why was I sent to Darkmoor?” Barenziah asked, hardly believing anything she had just been told.

“For safekeeping, naturally. Why did you run away?”

Barenziah shrugged. “I saw no reason to stay. I should have been told.”

“You would have been by now. I had in fact sent for you to be removed to the Imperial City to spend some time as part of the Emperor’s household. But of course you had, shall we say, absconded by then. As for your destiny, it should be, and should have been, quite obvious to you. Tiber Septim does not keep those he has no use for – and what else could you be that would be of use to him?”

“I know nothing of him. Nor, for that matter, of you.”

“Then know this: Tiber Septim rewards friends and foes alike according to their deserts.”

Barenziah chewed on that for a few moments. “Straw has deserved well of me and has never done anyone any harm. He is not a member of the Thieves Guild. He came along to protect me. He earns our keep by running errands, and he ... he ...”

Symmachus waved her impatiently to silence. “Ai. I know all about Straw,” he said, “and about Therris.” He stared at her intently. “So? What would you?”

She took a deep breath. “Straw wants a little farm. If I’m to be rich, then I would like for one to be given to him.”

“Very well.” He seemed astonished at this, and then pleased. “Done. He shall have it. And Therris?”

“He betrayed me,” Barenziah said coldly. Therris should have told her what risks the job entailed. Besides, he’d pushed her right into their enemies’ arms in an attempt to save himself. Not a man to be rewarded. Not, in fact, a man to be trusted.

“Yes. And?”

“Well, he should be made to suffer for it ... shouldn’t he?”

“That seems reasonable. What form should said suffering take?”

Barenziah balled her hands into fists. She would’ve liked to beat and claw at the Khajiit herself. But considering the turn events had taken, that didn’t seem very queenly. “A whipping. Er ... would twenty stripes be too many, do you think? I don’t want to do him any permanent injury, you understand. Just teach him a lesson.”

“Ai. Of course.” Symmachus grinned at this. Then his features suddenly set, and became serious. “It shall be done, Your Highness, Milady Queen Barenziah of Mournhold.” Then he bowed to her, a sweeping, courtly, ridiculously wonderful bow.

Barenziah’s heart leapt.

She spent two days at Symmachus’ apartment, during which she was kept very busy. There was a Dark Elven woman named Drelliane who saw to her needs, although she did not exactly seem a servant since she took her meals with them. Nor did she seem to be Symmachus’ wife, or lover. Drelliane looked amused when Barenziah asked her about it. She simply said she was in the general’s employ and did whatever was asked of her.

With Drelliane’s assistance, several fine gowns and pairs of shoes were ordered for her, plus a riding habit and boots, along with other small necessities. Barenziah was given a room to herself.

Symmachus was out a great deal. She saw him at most mealtimes, but he said little about himself or what he had been doing. He was cordial and polite, quite willing to converse on most subjects, and seemed interested in anything she had to say. Drelliane was much the same. Barenziah found them pleasant enough, but “hard to get to know,” as Katisha would have put it. She felt an odd twinge of disappointment. These were the first Dark Elves with whom she’d associated closely. She had expected to feel comfortable with them, to feel at last that she belonged somewhere, with somebody, as part of something. Instead she found herself yearning for her Nordic friends, Katisha and Straw.

When Symmachus told her they were to set out for the Imperial City on the morrow, she asked if she could say good-bye to them.

“Katisha?” he asked. “Ai. But then ... I suppose I owe her something. She it was who led me to you by telling me of a lonely Dark Elven girl named Berry who needed Elven friends – and who sometimes dressed as a boy. She has no association with the Thieves Guild, apparently. And no one associated with the Thieves Guild seems to know your true identity, save Therris. That is well. I prefer that your former Guild membership not be made public knowledge. Please speak of it to no one, Your Highness. Such a past does not ... become an Imperial Queen.”

“No one knows but Straw and Therris. And they won’t tell anyone.”

“No.” He smiled a curious little smile. “No, they won’t.”

He didn’t know that Katisha knew, then. But still, there was something about the way he said it ...

Straw came to their apartment on the morning of their departure. They were left alone in the salon, although Barenziah knew that other Elves were within earshot. He looked drawn and pale. They hugged one another silently for a few minutes. Straw’s shoulders were shaking and tears were rolling down his cheeks, but he said nothing.

Barenziah tried a smile. “So we both get what we want, eh? I’m to be Queen of Mournhold and you’ll be lord of your own farmstead.” She took his hand, smiled at him warmly, genuinely. “I’ll write you, Straw. I promise. You must find a scribe so you can write me too.”

Straw shook his head sadly. When Barenziah persisted, he opened his mouth and pointed at it, making inarticulate noises. Then she realized what it was. His tongue was gone, had been cut off.

Barenziah collapsed onto a chair and wept noisily.

“But why?” she demanded of Symmachus when Straw had been ushered away. “Why?”

Symmachus shrugged. “He knows too much. He could be dangerous. At least he’s alive, and he won’t need his tongue to ... raise pigs or whatever.”

“I hate you!” Barenziah screamed at him, then abruptly doubled over and vomited on the floor. She continued to revile him between intermittent bouts of nausea. He listened stolidly for some time while Drelliane cleaned up after her. Finally, he told her to cease or he would gag her for her journey to the Emperor.

They stopped at Katisha’s house on their way out of the city. Symmachus and Drelliane didn’t dismount. All seemed normal but Barenziah was frightened as she knocked on the door. Katisha answered the knock. Barenziah thanked the gods silently that at least she was all right. But she’d also obviously been weeping. In any case, she embraced Barenziah warmly.

“Why are you crying?” Barenziah asked.

“For Therris, of course. You haven’t heard? Oh dear. Poor Therris. He’s dead.” Barenziah felt icy fingers creeping round her heart. “He was caught stealing from the Commandant’s house. Poor fellow, but that was so foolish of him. Oh, Berry, he was drawn and quartered this very dawn by the Commandant’s order!” She started to sob. “I went. He asked for me. It was terrible. He suffered so before he died. I’ll never forget it. I looked for you and Straw, but no one knew where you’d both gone to.” She glanced behind Barenziah. “That’s the Commandant, isn’t it? Symmachus.” Then Katisha did a strange thing. She stopped crying and grinned. “You know, the moment I saw him, I thought, This is the one for Barenziah!” Katisha took a fold of her apron and wiped it across her eyes. “I told him about you, you know.”

“Yes,” Barenziah said, “I know.” She took Katisha’s hands in each of hers and looked at her earnestly. “Katisha, I love you. I’m going to miss you. But please don’t ever tell anyone else anything about me. Ever. Swear you won’t. Especially not to Symmachus. And look after Straw for me. Promise me that.”

Katisha promised, puzzled though willing. “Berry, it wasn’t somehow because of me that Therris was caught, was it? I never said anything about Therris to ... to ... him.” She glanced over at the general.

Barenziah assured her that it wasn’t, that an informant had told the Imperial Guard of Therris’ plans. Which was probably a lie, but she could see that Katisha plainly needed some kind of comfort.

“Oh, I’m glad of that, if I can be glad of anything just now. I’d hate to think– But how could I have known?” She leaned over and whispered in Barenziah’s ear, “Symmachus is very handsome, don’t you think? And so charming.”

“I wouldn’t know about that,” Barenziah said dryly. “I haven’t really thought about it. There’ve been other things to think about.” She explained hurriedly about being Queen of Mournhold and going to live in the Imperial City for a while. “He was looking for me, that’s all. On orders from the Emperor. I was the object of a quest, nothing more than some sort of... of a... goal. I don’t think he thinks of me as a woman at all. He said I didn’t look like a boy, though,” she added in the face of Katisha’s incredulity. Katisha knew that Barenziah evaluated every male she met in terms of sexual desirability, and availability. “I suppose it’s the shock of finding out that I really am a queen,” she added, and Katisha agreed that yes, that’s true, that must’ve been something of a shock, although one there was no likelihood of her experiencing firsthand. She smiled. Barenziah smiled with her. Then they hugged again, tearfully, for the last time. She never saw Katisha again. Or Straw.

The royal party left Rifton by the great southern gate. Once through, Symmachus tapped her shoulder and pointed back at the portals. “I thought you might want to say good-bye to Therris too, Your Highness,” he said.

Barenziah stared briefly but steadily at the head impaled on a spike above the gate. The birds had been at it, but the face was still recognizable. “I don’t think he’ll hear me, although I’m quite sure he’ll be pleased to know I’m fine,” she said, seeming to sound light. “Let’s be on our way, General, shall we?”

Symmachus was clearly disappointed by her lack of reaction. “Ai. You heard of this from your friend Katisha, I suppose?”

“You suppose correctly. She attended the execution,” Barenziah said casually. If he didn’t know already, he’d find out soon enough, she was sure of that.

“Did she know Therris belonged to the Guild?”

She shrugged. “Everyone knew that. It’s only lower-ranking members like me who are supposed to keep their membership secret. The ones higher up are well known.” She turned to smile archly at him. “But you must know all that, shouldn’t you, General?” she said sweetly.

He seemed unaffected by this. “So you told her who you were and whence you came, but not about the Guild.”

“The Guild membership was not my secret to tell. The other was. There’s a difference. Besides, Katisha is a very honest woman. Had I told her, it would have lessened me in her eyes. She was always after Therris to take up a more honest line of work. I value her good opinion.” She afforded him a glacial stare. “Not that it’s any concern of yours, but do you know what else she thought? She also thought I’d be happier if I settled down with just one man. One of my own race. One of my own race with all the right qualities. One of my own race with all the right qualities, who knows to say all the right things. You, in fact.” She grabbed the reins preparatory to assuming a brisker pace–but not without sinking one final irresistible barb. “Isn’t it odd how wishes come true sometimes–but not in the way you want them to? Or maybe I should say, not in the way you would ever want them to?”

His answer so took her by surprise that she quite forgot about cantering off. “Yes. Very odd,” he replied, and his tone matched his words exactly. Then he excused himself and fell behind.

She held her head high and urged her mount onward, trying to look unimpressed. Now what was it about his response that bothered her? Not what he said. No, that wasn’t it. But something about the way he said it. Something about it made her think that she, Barenziah, was one of his wishes that had come true. Unlikely as this seemed, she gave it due deliberation. He had found her at last, after months of searching, it seemed, under pressure from the Emperor, no doubt. So his wish had come true. Yes, that must be it.

But in a way, apparently, not altogether to his liking.

## Volume 3

For several days, Barenziah felt a weight of sorrow at her separation from her friends. But by the second week out her spirits began to rise a little. She found that she enjoyed being on the road again, although she missed Straw’s companionship more than she would have thought. They were escorted by a troop of Redguard knights with whom she felt comfortable, although these were much more disciplined, and decorous, than the guards of the merchant caravans she had spent time with. They were genial but respectful toward her despite her attempts at flirtation.

Symmachus scolded her privately, saying a queen must maintain royal dignity at all times.

“You mean I’m never to have any fun?” she inquired petulantly.

“Ai. Not with such as these. They are beneath you. Graciousness is to be desired from those in authority, Milady. Familiarity is not. You will remain chaste and modest while you are at the Imperial City.”

Barenziah made a face. “I might as well be back at Darkmoor Keep. Elves are promiscuous by nature, you know. Everyone says so.”

“‘Everyone’ is wrong, then. Some are, some aren’t. The Emperor – and I – expect you to display both discrimination and good taste. Let me remind you, Your Highness, that you hold the throne of Mournhold not by right of blood but solely at the pleasure of Tiber Septim. If he judges you unsuitable, your reign will end ere it begins. He requires intelligence, obedience, discretion, and total loyalty of all his appointees, and he favors chastity and modesty in women. I strongly suggest you model your deportment after our good Drelliane. Milady.”

“I’d as lief be back in Darkmoor!” Barenziah snapped resentfully, offended at the thought of emulating the frigid, prudish Drelliane in any way.

“That is not an option. Your Highness. If you are of no use to Tiber Septim, he will see to it that you are of no use to his enemies either,” the general said portentously. “If you would keep your head on your shoulders, take heed. Let me add that power offers pleasures other than those of carnality and cavorting with base company.”

He began to speak of art, literature, drama, music, and the grand balls thrown at the Imperial Court. Barenziah listened with growing interest, spurred on not entirely by his threats. But afterward she asked timidly if she might continue her study of magic while at the Imperial City. Symmachus seemed pleased at this and promised to arrange it. Encouraged, she then said that she noted three of their knights escort were women, and asked if she might train a little with them, just for the sake of exercise. The general looked less delighted at this, but gave his consent, though stressing it would only be with the women.

The late winter weather held fair, though slightly frosty, for the rest of their journey so that they traveled quickly over firm roads. On the last day of their trip, spring seemed to have arrived at last for there were hints of a thaw. The road grew muddy underfoot, and everywhere one could hear water trickling and dripping faintly but steadily. It was a welcome sound.

They came to the great bridge that crossed into the Imperial City at sunset. The rosy glow turned the stark white marble edifices of the metropolis a delicate pink. It all looked very new and grand and immaculate. A broad avenue led north toward the Palace. A crowd of people of all sorts and races filled the wide concourse. Lights winked out in the shops and on in the inns as dusk fell and stars came out singly then by twos and threes. Even the side streets were broad and brightly illuminated. Near the Palace the towers of an immense Mages Guildhall reared toward the east, while westward the stained glass windows of a huge tabernacle glittered in the dying light.

Symmachus had apartments in a magnificent house two blocks from the palace, past the temple. (“The Temple of the One,” he identified as they passed it, an ancient Nordic cult which Tiber Septim had revived. He said that Barenziah would be expected to become a member should she prove acceptable to the Emperor.) The place was quite splendid–although little to Barenziah’s taste. The walls and furnishings were done in utter pristine white, relieved only by touches of dull gold, and the floors in dully gleaming black marble. Barenziah’s eyes ached for color and the interplay of subtle shadings.

In the morning Symmachus and Drelliane escorted her to the Imperial Palace. Barenziah noted that everyone they met greeted Symmachus with a deferential respect in some cases bordering on obsequiousness. The general seemed to take it for granted.

They were ushered directly into the imperial presence. Morning sun flooded a small room through a large window with tiny panes, washing over a sumptuously laden breakfast table and the single man who sat there, dark against the light. He leapt to his feet as they entered and hurried toward them. “Ah, Symmachus our most loyal friend, we welcome your return most gladly.” His hands held Symmachus’ shoulders briefly, fondly, halting the deep genuflection the Dark Elf had been in the process of effecting.

Barenziah curtseyed as Tiber Septim turned to her.

“Barenziah, our naughty little runaway. How do you do, child? Here, let us have a look at you. Why, Symmachus, she’s charming, absolutely charming. Why have you hidden her from us all these years? Is the light too much, child? Shall we draw the hangings? Yes, of course.” He waved aside Symmachus’ protests and drew the curtains himself, not troubling to summon a servant. “You will pardon us for this discourtesy toward yourselves, our dear guests. We’ve much to think of, though that’s scant excuse for hospitality’s neglect. But ah! pray join us. There’s some excellent nectarines from Black Marsh.”

They settled themselves at the table. Barenziah was dumbfounded. Tiber Septim was nothing like the grim, grey, giant warrior she’d pictured. He was of average height, fully half a head shorter than tall Symmachus, although he was well-knit of figure and lithe of movement. He had a winning smile, bright – indeed piercing – blue eyes, and a full head of stark white hair above a lined and weathered face. He might have been any age from forty to sixty. He pressed food and drink upon them, then repeated the question the general had asked her days ago: Why had she left home? Had her guardians been unkind to her?

“No, Excellency,” Barenziah replied, “in truth, no – although I fancied so at times.” Symmachus had fabricated a story for her, and Barenziah told it now, although with a certain misgiving. The stable-boy, Straw, had convinced her that her guardians, unable to find a suitable husband for her, meant to sell her off as a concubine in Rihad; and when a Redguard had indeed come, she had panicked and fled with Straw.

Tiber Septim seemed fascinated and listened raptly as she provided details of her life as a merchant caravan escort. “Why, ‘tis like a ballad!” he said. “By the One, we’ll have the Court Bard set it to music. What a charming boy you must have made.”

“General Symmachus said–” Barenziah stopped in some confusion, then proceeded. “He said – well, that I no longer look much like a boy. I have... grown in the past few months.” She lowered her gaze in what she hoped approximated maidenly modesty.

“He’s a very discerning fellow, is our loyal friend Symmachus.”

“I know I’ve been a very foolish girl, Excellency. I must crave your pardon, and that of my kind guardians. I... I realized that some time ago, but I was too ashamed to go back home. But I don’t want to return to Darkmoor now. Excellency, I long for Mournhold. My soul pines for my own country.”

“Our dear child. You shall go home, we promise you. But we pray you remain with us a little longer, that you may prepare yourself for the grave and solemn task with which we shall charge you.”

Barenziah gazed at him earnestly, heart beating fast. It was all working just as Symmachus had said it would. She felt a warm flush of gratitude toward him, but was careful to keep her attention focused on the Emperor. “I am honored, Excellency, and wish most earnestly to serve you and this great Empire you have built in any way I can.” It was the politic thing to say, to be sure – but Barenziah really meant it. She was awed at the magnificence of the city and the discipline and order evident everywhere, and moreover was excited at the prospect of being a part of it all. And she felt quite taken by the gentle Tiber Septim.

After a few days Symmachus left for Mournhold to take up the duties of a governor until Barenziah was ready to assume the throne, after which he would become her Prime Minister. Barenziah, with Drelliane as chaperone, took up residence in a suite of rooms at the Imperial Palace. Several tutors were provided her, in all the fields deemed seemly for a queenly education. During this time she became deeply interested in the magical arts, but she found the study of history and politics not at all to her preference.

On occasion she met with Tiber Septim in the Palace gardens and he would unfailingly and politely inquire as to her progress – and chide her, although with a smile, for her disinterest at matters of state. However, he was always happy to instruct her on the finer points of magic, and he could make even history and politics seem interesting. “They’re people, child, not dry facts in a dusty volume,” he said.

As her understanding broadened, their discussions grew longer, deeper, more frequent. He spoke to her of his vision of a united Tamriel, each race separate and distinct but with shared ideals and goals, all contributing to the common weal. “Some things are universal, shared by all sentient folk of good will,” he said. “So the One teaches us. We must unite against the malicious and the brutish, the miscreated – the Orcs, trolls, goblins, and other worse creatures – and not strive against one another.” His blue eyes would light up as he stared into his dream, and Barenziah was delighted just to sit and listen to him. If he drew close to her, the side of her body next to him would glow as if he were a smoldering blaze. If their hands met she would tingle all over as if his body were charged with a shock spell.

One day, quite unexpectedly, he took her face in his hands and kissed her gently on the mouth. She drew back after a few moments, astonished by the violence of her feelings, and he apologized instantly. “I... we... we didn’t mean to do that. It’s just – you are so beautiful, dear. So very beautiful.” He was looking at her with hopeless yearning in his generous eyes.

She turned away, tears streaming down her face.

“Are you angry with us? Speak to us. Please.”

Barenziah shook her head. “I could never be angry with you, Excellency. I... I love you. I know it’s wrong, but I can’t help it.”

“We have a consort,” he said. “She is a good and virtuous woman, the mother of our children and future heirs. We could never put her aside – yet there is nothing between us and her, no sharing of the spirit. She would have us be other than what we are. We are the most powerful person in all of Tamriel, and... Barenziah, we... I... I think I am the most lonely as well.” He stood up suddenly. “Power!” he said with sublime contempt. “I’d trade a goodly share of it for youth and love if the gods would only sanction it.”

“But you are strong and vigorous and vital, more than any man I’ve ever known.”

He shook his head vehemently. “Today, perhaps. Yet I am less than I was yesterday, last year, ten years ago. I feel the sting of my mortality, and it is painful.”

“If I can ease your pain, let me.” Barenziah moved toward him, hands outstretched.

“No. I would not take your innocence from you.”

“I’m not that innocent.”

“How so?” The Emperor’s voice suddenly grated harshly, his brows knitted.

Barenziah’s mouth went dry. What had she just said? But she couldn’t turn back know. He would know. “There was Straw,” she faltered. “I... I was lonely too. Am lonely. And not so strong as you.” She cast her eyes down in abashment. “I... I guess I’m not worthy, Excellency–”

“No, no. Not so. Barenziah. My Barenziah. It cannot last for long. You have a duty toward Mournhold, and a duty toward the Empire. I must tend toward mine as well. But while we may – shall we share what we have, what we can, and pray the One forgives us our frailty?”

Tiber Septim held out his arms – and wordlessly, willingly, Barenziah stepped into his embrace.

[pagebreak]

“You caper on the edge of a volcano, child,” Drelliane admonished as Barenziah admired the splendid star sapphire ring her imperial lover had given her to celebrate their one-month anniversary.

“How so? We make one another happy. We harm no one. Symmachus bade me be discriminating and discreet. Who better could I choose? And we’ve been most discreet. He treats me like a daughter in public.” Tiber Septim’s nightly visits were made through a secret passage that only few in the Palace were privy to – himself and a handful of trusted bodyguards.

“He slavers over you like a cur his supper. Have you not noticed the coolness of the Empress and her son toward you?”

Barenziah shrugged. Even before she and Septim had become lovers, she’d received no more from his family than bare civility. Threadbare civility. “What matter? It is Tiber who holds the power.”

“But it is his son who holds the future. Do not put his mother up to public scorn, I beg you.”

“Can I help it if that dry stick of a woman cannot hold her husband’s interest even in conversation at dinner?”

“Have less to say in public. That is all I ask. She matters little, it is true – but her children love her, and you do not want them as enemies. Tiber Septim has not long to live. I mean,” Drelliane amended quickly at Barenziah’s scowl, “humans are all short-lived. Ephemeral, as we of the Elder Races say. They come and go as the seasons – but the families of the powerful ones live on for a time. You must be a friend to this family if you would see lasting profit from your relationship. Ah, but how can I make you see truly, you who are so young and human-bred as well! If you take heed, and wisely, you and Mournhold are like to live to see the fall of Septim’s dynasty, if indeed he has founded one, just as you have witnessed its rise. It is the way of human history. They ebb and flow like the inconstant tides. Their cities and dominions bloom like spring flowers, only to wither and die in the summer sun' WHERE id = 7;
UPDATE tomes SET body = body || '. But the Elves endure. We are as a year to their hour, a decade to their day.”

Barenziah just laughed. She knew that rumors abounded about her and Tiber Septim. She enjoyed the attention, for all save the Empress and her son seemed captivated by her. Minstrels sang of her dark beauty and her charming ways. She was in fashion, and in love – and if it was temporary, well, what was not? She was happy for the first time she could remember, each of her days filled with joy and pleasure. And the nights were even better.

“What is wrong with me?” Barenziah lamented. “Look, not one of my skirts fit. What’s become of my waistline? Am I getting fat?” Barenziah regarded her thin arms and legs and her undeniably thickened waist in the mirror with displeasure.

Drelliane shrugged. “You appear to be with child, young as you are. Constant pairing with a human has brought you to early fertility. I see no choice but for you to speak with the Emperor about it. You are in his power. It would be best, I think, for you to go directly to Mournhold if he would agree to it, and bear the child there.”

“Alone?” Barenziah placed her hands on her swollen belly, tears forming in her eyes. Everything in her yearned to share the fruit of her love with her lover. “He’ll never agree to that. He won’t be parted from me now. You’ll see.”

Drelliane shook her head. Although she said no more, a look of sympathy and sorrow had replaced her usual cool scorn.

That night Barenziah told Tiber Septim when he came to her for their usual assignation.

“With child?” He looked shocked. No, stunned. “You’re sure of it? But I was told Elves do not bear at so young an age...”

Barenziah forced a smile. “How can I be sure? I’ve never–”

“I shall have my healer fetched.”

The healer, a High Elf of middle years, confirmed that Barenziah was indeed pregnant, and that such a thing had never before been known to happen. It was a testimony to His Excellency’s potency, the healer said in sycophantic tones. Tiber Septim roared at him.

“This must not be!” he said. “Undo it. We command you.”

“Sire,” the healer gaped at him. “I cannot... I may not–”

“Of course you can, you incompetent dullard,” the Emperor snapped. “It is our express wish that you do so.”

Barenziah, till then silent and wide-eyed with terror, suddenly sat up in bed. “No!” she screamed. “No! What are you saying?”

“Child,” Tiber Septim sat down beside her, his face wearing one of his winning smiles. “I’m so sorry. Truly. But this cannot be. Your issue would be a threat to my son and his sons. I shall no more put it plainly than that.”

“The child I bear is yours!” she wailed.

“No. It is now but a possibility, a might-be, not yet gifted with a soul or quickened into life. I will not have it so. I forbid it.” He gave the healer another hard stare and the Elf began to tremble.

“Sire. It is her child. Children are few among the Elves. No Elven woman conceives more than four times, and that is very rare. Two is the usual number. Some bear none, even, and some only one. If I take this one from her, Sire, she may not conceive again.”

“You promised us she would not bear to us. We’ve little faith in your prognostications.”

Barenziah scrambled naked from the bed and ran for the door, not knowing where she was going, only that she could not stay. She never reached it. Darkness overtook her.

She awoke to pain, and a feeling of emptiness. A void where something used to be, something that used to be alive, but now was dead and gone forever. Drelliane was there to soothe the pain and clean up the blood that still pooled at times between her legs. But there was nothing to fill the emptiness. There was nothing to take the place of the void.

The Emperor sent magnificent gifts and vast arrangements of flowers, and came on short visits, always well-attended. Barenziah received these visits with pleasure at first. But Tiber Septim came no more at night – and after some time nor did she wish him to.

Some weeks passed, and when she was completely physically recovered, Drelliane informed her that Symmachus had written to request she come to Mournhold earlier than planned. It was announced that she would leave forthwith.

She was given a grand retinue, an extensive trousseau befitting a queen, and an elaborate and impressive ceremonial departure from the gates of the Imperial City. Some people were sorry to see her leave, and expressed their sadness in tears and expostulations. But some others were not, and did not.

## Volume 4

Everything I have ever loved, I have lost,” Barenziah thought despondently, looking at the mounted knights behind and ahead, her tirewomen near her in a carriage. “Yet I have gained a measure of wealth and power, and the promise of more to come. Dearly have I bought it. Now I do understand better Tiber Septim’s love of it, if he has often paid such prices. For surely worth is measured by the price we pay.” By her wish, she rode on a shiny roan mare, clad as a warrior in resplendent chain mail of Dark Elven make.

As the days slowly slipped by and her train rode the winding road eastward into the setting sun, around her gradually rose the steep-sided mountain slopes of Morrowind. The air was thin, and a chill late autumn wind blew constantly. But it was also rich with the sweet spicy smell of the late-blooming black rose, which was native to Morrowind and grew in every shadowy nook and crevice of its highlands, finding nourishment even in the stoniest banks and ridges. In small villages and towns, ragged Dark Elven folk gathered along the road to cry her name or simply gape. Most of her knightly escort were Redguards, with a few High Elves, Nords, and Bretons. As they wove their way into the heart of Morrowind, they grew increasingly uncomfortable and clung together in protective clusters. Even the Elven knights seemed wary.

But Barenziah felt at home, at last. She felt the welcome extended to her by the land. Her land.

Symmachus met her at the Mournhold border with an escort of knights, about half of whom were Dark Elven. In Imperial battle dress, she noted.

There was a grand parade of entry into the city and speeches of welcome from stately dignitaries.

“I’ve had the queen’s suite refurbished for you,” the general told her later when they reached the palace, “but you may change anything not to your taste, of course.” He went on about the details of the coronation, which was to be held in a week. He was his old commanding self – but she sensed something else as well. He was eager for her approval of the arrangements, was in fact fishing for it. That was new. He had never required her commendation before.

He asked her nothing about her stay in the Imperial City, or of her affair with Tiber Septim – although Barenziah was certain Drelliane had told him, or earlier written him, everything in detail.

The ceremony itself, like so much else, was a mixture of old and new – parts of it from the ancient Dark Elven tradition of Mournhold, the others dictated by Imperial decree. She was sworn to the service of the Empire and Tiber Septim as well as to the land of Mournhold and its people. She accepted oaths of fealty and allegiance from the people, the nobility, and the council. This last was composed of a blend of Imperial emissaries (“advisors” they were called) and native representatives of the Mournhold people, who were mostly elders in accordance with Elven custom.

Barenziah later found that much of her time was occupied in attempting to reconcile these two factions and their cronies. The elders were expected to do most of the conciliating, in light of reforms introduced by the Empire pertaining to land ownership and surface farming. But most of these went clean against Dark Elven observances. Tiber Septim, “in the name of the One,” had ordained a new tradition – and apparently even the gods and goddesses themselves were expected to obey.

The new Queen threw herself into her work and her studies. She was through with love and men for a long, long time – if not forever. There were other pleasures, she discovered, as Symmachus had promised her long ago: those of the mind, and those of power. She developed (surprisingly, for she had always rebelled against her tutors at the Imperial City) a deep love for Dark Elven history and mythology, a hunger to know more fully the people from whom she had sprung. She was gratified to learn that they had been proud warriors and skilled craftsmen and cunning mages since time immemorial.

Tiber Septim lived for another half-century, during which she saw him on several occasions as she was bidden to the Imperial City on one reason of state or another. He greeted her with warmth during these visits, and they even had long talks together about events in the Empire when opportunity would permit. He seemed to have quite forgotten that there had ever been anything between them more than easy friendship and a profound political alliance. He changed little as the years passed. Rumor had it that his mages had developed spells to extend his vitality, and that even the One had granted him immortality. Then one day a messenger came with the news that Tiber Septim was dead, and his grandson Pelagius was now Emperor in his place.

They had heard the news in private, she and Symmachus. The sometime Imperial General and now her trusted Prime Minister took it stoically, as he took most everything.

“Somehow it doesn’t seem possible,” Barenziah said.

“I told you. Ai. It’s the way of humans. They are a short-lived people. It doesn’t really matter. His power lives on, and his son now wields it.”

“You called him your friend once. Do you feel nothing? No grief?”

He shrugged. “There was a time when you called him somewhat more. What do you feel, Barenziah?” They had long ago ceased to address each other in private by their formal titles.

“Emptiness. Loneliness,” she said, then she too shrugged. “But that’s not new.”

“Ai. I know,” he said softly, taking her hand. “Barenziah...” He turned her face up and kissed her.

The act filled her with astonishment. She couldn’t remember his ever touching her before. She’d never thought of him in that way – and yet, undeniably, an old familiar warmth spread through her. She’d forgotten how good it felt, that warmth. Not the scorching heat she’d felt with Tiber Septim, but the comforting, robust ardor she somehow associated with... with Straw! Straw. Poor Straw. She hadn’t thought of him in so long. He’d be middle-aged now if he were still alive. Probably with a dozen children, she thought affectionately... and a hearty wife who hopefully could talk for two.

“Marry me, Barenziah,” Symmachus was saying, he seemed to have picked up her thoughts on marriage, children... wives, “I’ve worked and toiled and waited long enough, haven’t I?”

Marriage. A peasant with peasant dreams. The thought appeared in her mind, clear and unbidden. Hadn’t she used those very same words to describe Straw, so very long ago? And yet, why not? If not Symmachus, who else?

Many of the great noble families of Morrowind had been wiped out in Tiber Septim’s great war of unification, before the treaty. Dark Elven rule had been restored, it was true – but not the old, not the true nobility. Most of them were upstarts like Symmachus, and not even half as good or deserving as he was. He had fought to keep Mournhold whole and hale when their so-called counselors would have picked at its bones, sucked them dry as Ebonheart had been sucked dry. He’d fought for Mournhold, fought for her, while she and the kingdom grew and thrived. She felt a sudden rush of gratitude – and, undeniably, affection. He was steady and reliable. And he’d served her well. And loved her well.

“Why not?” she said, smiling. And took his hand. And kissed him.

The union was a good one, in its political as well as personal aspects. While Tiber Septim’s grandson, the Emperor Pelagius I, viewed her with a jaundiced eye, his trust in his father’s old friend was absolute.

Symmachus, however, was still viewed with suspicion by Morrowind’s stiff-necked folk, chary at his peasant ancestry and his close ties to the Empire. But the Queen was quite unshakably popular. “The Lady Barenziah’s one of our own,” it was whispered, “held captive as we.”

Barenziah felt content. There was work and there was pleasure – and what more could one ask of life?

The years passed swiftly, with crises to be dealt with, and storms and famines and failures to be weathered, and plots to be foiled, and conspirators to be executed. Mournhold prospered steadily. Her people were secure and fed, her mines and farms productive. All was well – save that the royal marriage had produced no children. No heirs.

Elven children are slow to come, and most demanding of their welcome – and noble children more so than others. Thus many decades had come to pass before they grew concerned.

“The fault lies with me, Symmachus. I’m damaged goods,” Barenziah said bitterly. “If you want to take another...”

“I want no other,” Symmachus said gently, “nor do I know for certain that the fault is yours. Perhaps it is mine. Ai. Whichever. We will seek a cure. If there is damage, surely it may be repaired.”

“How so? When we dare not entrust anyone with the true story? Healer’s oaths do not always hold.”

“It won’t matter if we change the time and circumstances a bit. Whatever we say or fail to say, Jephre the Storyteller never rests. The god’s inventive mind and quick tongue are ever busy spreading gossip and rumor.”

Priests and healers and mages came and went, but all their prayers, potions, and philtres produced not even a promise of bloom, let alone a single fruit. Eventually they thrust it from their minds and left it in the gods’ hands. They were yet young, as Elves went, with centuries ahead of them. There was time. With Elves there was always time.

Barenziah sat at dinner in the Great Hall, pushing food about on a plate, feeling bored and restless. Symmachus was away, having been summoned to the Imperial City by Tiber Septim’s great-great-grandson, Uriel Septim. Or was it his great-great-great-grandson? She’d lost count, she realized. Their faces seemed to blur one into the next. Perhaps she should have gone with him, but there’d been the delegation from Tear on a tiresome matter that nevertheless required delicate handling.

A bard was singing in an alcove off the hall, but Barenziah wasn’t listening. Lately all the songs seemed the same to her, whether new or old. Then a turn of phrase caught her attention. He was singing of freedom, of adventure, of freeing Morrowind from its chains. How dare he! Barenziah sat up straight and turned to glare at him. Worse, she realized he was singing of some ancient, and now immaterial, war with the Skyrim Nords, praising the heroism of Kings Edward and Moraelyn and their brave Companions. The tale was old enough, certainly, yet the song was new ... and its meaning ... Barenziah couldn’t be sure.

A bold fellow, this bard, but with a strong, passionate voice and a good ear for music. Rather handsome too, in a raffish sort of way. He didn’t look to be well-off exactly, nor was he all that young. Certainly he couldn’t be under a century of age. Why hadn’t she heard him before, or at least heard of him?

“Who is he?” she inquired of a lady-in-waiting.

The woman shrugged and said, “Calls himself the Nightingale, Milady. No one seems to know anything about him.”

“Bid him speak with me when he has done.”

The man called the Nightingale came to her, thanked her for the honor of the Queen’s audience and the fat purse she handed him. His manner wasn’t bold at all, she decided, rather quiet and unassuming. He was quick enough with gossip about others, but she learned nothing about him – he turned all questions away with a joking riposte or a ribald tale. Yet these were recounted so charmingly it was impossible to take offence.

“My true name? Milady, I am no one. No, no, my parents named me Know Wan – or was it No Buddy? What matters it? It matters not. How may parents give name to that which they know not? Ah! I believe that was the name, Know Not. I have been the Nightingale for so long I do not remember, since, oh, last month at the very least – or was it last week? All my memory goes into song and tale, you see, Milady. I’ve none left for myself. I’m really quite dull. Where was I born? Why, Knoweyr. I plan to settle in Dunroamin when I get there ... but I’m in no hurry.”

“I see. And will you then marry Atallshur?”

“Very perceptive of you, Milady. Perhaps, perhaps. Although I find Innhayst quite charming too, at whiles.”

“Ah. You are fickle, then?”

“Like the wind, Milady. I blow hither and yon, hot and cold, as chance suits. Chance is my suit. Naught else wears well on me.”

Barenziah smiled. “Stay with us awhile, then ... if you will, Milord Erhatick.”

“As you wish, Milady Bryte.”

After that brief exchange, Barenziah found her interest in life somehow rekindled. All that had seemed stale became fresh and new again. She greeted each day with zest, looking forward to conversation with the Nightingale and the gift of his song. Unlike other bards, he never sang her praises, nor other women’s, but only of high adventure and bold deeds.

When she asked him about this, he said, “What greater praise of your beauty could you ask, Milady, than that which your own mirror gives you? And if words you would have, you have those of the greatest, of those greater than my callow self. How should I vie with them, I who was born but a week gone by?”

For once they were speaking privately. The Queen, unable to sleep, had summoned him to her chamber that his music might soothe her. “You are lazy and a coward, sera, else I hold no charm for you.”

“Milady, to praise you I must know you. I can never know you. You are wrapped in enigma, in clouds of enchantment.”

“Nay, not so. Your words are what weave enchantment. Your words... and your eyes. And your body. Know me if you will. Know me if you dare.”

He came to her then. They lay close, they kissed, they embraced. “Not even Barenziah truly knows Barenziah,” he whispered softly, “so how may I? Milady, you seek and know it not, nor yet for what. What would you have, that you have not?”

“Passion,” she answered back. “Passion. And children born of it.”

“And for your children, what? What birthright might be theirs?”

“Freedom,” she said, “the freedom to be what they would be. Tell me, you who seem wisest to these eyes and ears, and the soul that knits them. Where may I find these things?”

“One lies beside you, the other beneath you. But would you dare stretch out your hand, that you might take what could be yours, and your children’s?”

“Symmachus...”

“In my person lies the answer to part of what you seek. The other lies hidden below us in these your very kingdom’s mines, that which will grant us the power to fulfill and achieve our dreams. That which Edward and Moraelyn between them used to free High Rock and their spirits from the hateful domination of the Nords. If it be properly used, Milady, none may stand against it, not even the power the Emperor controls. Freedom, you say? Barenziah, freedom it gives from the chains that bind you. Think on it, Milady.” He kissed her again, softly, and withdrew.

“You’re not leaving... ?” she cried out. Her body yearned for him.

“For now,” he said. “Pleasures of the flesh are nothing beside what we might have together. I would have you think on what I have just said.”

“I don’t need to think. What must we do? What preparations must be made?”

“Why – none. The mines may not be entered freely, it is true. But with the Queen at my side, who will stand athwart? Once below I can guide you to where this thing lies, and lift it from its resting place.”

Then the memory of her endless studies slid into place. “The Horn of Summoning,” she whispered in awe. “Is it true? Could it be? How do you know? I’ve read that it’s buried beneath the measureless caves of Daggerfall.”

“Nay, long have I studied this matter. Ere his death King Edward gave the Horn for safekeeping into the hand of his old friend King Moraelyn. He in turn secreted it here in Mournhold under the guardianship of the god Ephen, whose birthplace and bailiwick this is. Now you know what it has cost me many a long year and weary mile to discover.”

“But the god? What of Ephen?”

“Trust me, Milady heart. All will be well.” Laughing softly, he blew her a last kiss and was gone.

On the morrow they passed the guards at the great portals that led into the mines, and further below. Under pretence of her customary tour of inspection, Barenziah, unattended but for the Nightingale, ventured into cavern after subterranean cavern. Eventually they reached what looked like a forgotten sealed doorway, and upon entering found that it led to an ancient part of the workings, long abandoned. The going was treacherous for some of the old shafts had collapsed, and they had to clear a passage through the rubble or find a way around the more impassable piles. Vicious rats and huge spiders scurried here and there, sometimes even attacking them. But they proved no match for Barenziah’s firebolt spells or the Nightingale’s quick dagger.

“We’ve been gone too long,” Barenziah said at length. “They’ll be looking for us. What will I tell them?”

“Whatever you please,” the Nightingale laughed. “You are the Queen, aren’t you?”

“The Lord Symmachus–”

“That peasant obeys whoever holds power. Always has, always will. We shall hold the power, Milady love.” His lips were sweetest wine, his touch both fire and ice.

“Now,” she said, “take me now. I’m ready.” Her body seemed to hum, every nerve and muscle taut.

“Not yet. Not here, not like this.” He waved around, indicating the aged dusty debris and grim walls of rock. “Just a little while longer.” Reluctantly, Barenziah nodded her assent. They resumed walking.

“Here,” he said at last, pausing before a blank barrier. “Here it lies.” He scratched a rune in the dust, his other hand weaving a spell as he did so.

The wall dissolved. It revealed an entrance to some ancient shrine. In the midst stood a statue of a god, hammer in hand, poised above an admantium anvil.

“By my blood, Ephen,” the Nightingale cried, “I bid thee waken! Moraelyn’s heir of Ebonheart am I, last of the royal line, sharer of thy blood. At Morrowind’s last need, with all of Elvendom in dread peril of their selves and souls, release to me that guerdon which thou guardst! Now I do bid thee, strike!”

At his final words the statue glowed and quickened, the blank stone eyes shone a bright red. The massive head nodded, the hammer smote the anvil, and it split asunder with a thunderous crash, the stone god itself crumbling. Barenziah clapped her hands over her ears and crouched down, shaking terribly and moaning out loud.

The Nightingale strode forward boldly and clasped the thing that lay among the ruins with a roar of ecstasy. He lifted it high.

“Someone’s coming!” Barenziah cried in alarm, then noticed for the first time what it was he was holding aloft. “Wait, that’s not the Horn, it – it’s a staff!”

“Indeed, Milady. You see truly, at last!” The Nightingale laughed aloud. “I am sorry, Milady sweet, but I must leave you now. Perhaps we shall meet again one day. Until then... Ah, until then, Symmachus,” he said to the mail-clad figure who had appeared behind them, “she is all yours. You may claim her back.”

“No!” Barenziah screamed. She sprang up and ran toward him, but he was gone. Winked out of existence – just as Symmachus, claymore drawn, reached him. His blade cleaved a single stroke through empty air. Then he stood still, as if taking the stone god’s place.

Barenziah said nothing, heard nothing, saw nothing... felt nothing...

Symmachus told the half dozen or so Elves who had accompanied him that the Nightingale and Queen Barenziah had lost their way, and had been set upon by giant spiders. That the Nightingale had lost his footing and fallen into a deep crevice, which closed over him. That his body could not be recovered. That the Queen had been badly shaken by the encounter and deeply mourned the loss of her friend, who had fallen in her defense. Such was Symmachus’ presence and power of command that the slack-jawed knights, none of whom had caught more than a glimpse of what happened, were convinced that it was all exactly as he said.

The Queen was escorted back to the palace and taken to her chamber, whereupon she dismissed her servants-in-waiting. She sat still before her mirror for a long time, stunned, too distraught even to weep. Symmachus stood watching over her.

“Do you have any idea at all what you have just done?” he said finally – flatly, coldly.

“You should have told me,” Barenziah whispered. “The Staff of Chaos! I never dreamed it lay here. He said– he said– “ A mewling escaped her lips and she doubled over in despair. “Oh, what have I done? What have I done? What happens now? What’s to become of me? Of us?”

“Did you love him?”

“Yes. Yes, yes, yes! Oh my Symmachus, the gods have mercy on me, but I did love him. Did. But now... now... I don’t know... I’m not sure... I...”

Symmachus’ hard-lined face softened slightly, and his eyes glittered with new light, and he sighed. “Ai. That’s something then. You will become a mother yet if it’s within my power. As for the rest – Barenziah, my dearest Barenziah, I expect you have loosed a storm upon the land. It’ll be a while yet in the brewing. But when it comes, we’ll weather it together. As we always have.”

He came over to her then, and stripped her of her clothing, and carried her to the bed. Out of grief and longing, her enfeebled body responded to his brawny one as it never had before, pouring forth all that the Nightingale had wakened to life in her. And in so doing calming the restless ghosts of all he had destroyed.

She was empty, and emptied. And then she was filled, for a child was planted and grew within her. As her son flourished in the womb, so did her feeling toward patient, faithful, devoted Symmachus, which had been rooted in long friendship and unbroken affection – and which now, at last, ripened into the fullness of true love. Eight years later they were again blessed, this time with a daughter.

Directly after the Nightingale’s theft of the Staff of Chaos, Symmachus had sent urgent secret communiques to Uriel Septim. He had not gone himself, as he would normally have, choosing instead to stay with Barenziah during her fertile period to father a son upon her. For this, and for the theft, he suffered Uriel Septim’s temporary disfavor and unjust suspicion. Spies were sent in search of the thief, but the Nightingale seemed to have vanished whence he had come – wherever that was.

“Dark Elf in part, perhaps,” said Barenziah, “but part human too, I think, in disguise. Else would I not have come so quickly to fertility.”

“Part Dark Elf, for sure, and of ancient Ra’athim lineage at that, else he would not have been able to free the Staff,” Symmachus reasoned. He turned to peer at her fixedly. “I don’t think he would have lain with you. As an Elf he did not dare, for then he would not have been able to part from you.” He smiled. Then he turned serious once more. “Ai! He knew the Staff lay there, not the Horn, and that he must teleport to safety. The Staff is not a weapon that would have seen him clear, unlike the Horn. Praise the gods at least that he does not have that! It seems all was as he expected – but how did he know? I placed the Staff there myself, with the aid of the ragtail end of the Ra’athim Clan who now sits king in Castle Ebonheart as a reward. Tiber Septim claimed the Horn, but left the Staff for safekeeping. Ai! Now the Nightingale can use the Staff to sow seeds of strife and dissension wherever he goes, if he wishes. Yet that alone will not gain him power. That lies with the Horn and the ability to use it.”

“I’m not so sure it’s power the Nightingale seeks,” Barenziah said.

“All seek power,” Symmachus said, “each in our own way.”

“Not I,” she answered. “I, Milord, have found that for which I sought.”

## Volume 5

As Symmachus had predicted, the theft of the Staff of Chaos had few short-term consequences. The current Emperor, Uriel Septim, sent some rather stiff messages expressing shock and displeasure at the Staff’s disappearance, and urging Symmachus to make every effort to locate its whereabouts and communicate developments to the newly appointed Imperial Battlemage, Jagar Tharn, in whose hands the matter had been placed.

“Tharn!” Symmachus thundered in disgust and frustration as he paced about the small chamber where Barenziah, now some months pregnant, was sitting serenely embroidering a baby blanket. “Jagar Tharn, indeed. Ai! I wouldn’t give him directions for crossing the street, not if he were a doddering old blind sot.”

“What have you against him, love?”

“I just don’t trust that mongrel Elf. Part Dark Elf, part High Elf, and part the gods only know what. All the worst qualities of all his combined bloods, I’ll warrant.” He snorted. “No one knows much about him. Claims he was born in southern Valenwood, of a Wood Elven mother. Seems to have been everywhere since – “

Barenziah, sunk in the contentment and lassitude of pregnancy, had only been humoring Symmachus thus far. But now she suddenly dropped her needlework and looked at him. Something had piqued her interest. “Symmachus. Could this Jagar Tharn have been the Nightingale, disguised?”

Symmachus thought this over before replying. “Nay, my love. Human blood seems to be the one missing component in Tharn’s ancestry.” To Symmachus, Barenziah knew, that was a flaw. Her husband despised Wood Elves as lazy thieves and High Elves as effete intellectuals. But he admired humans, especially Bretons, for their combination of pragmatism, intelligence, and energy. “The Nightingale’s of Ebonheart, of the Ra’athim Clan - House Hlaalu, the House of Mora in part' WHERE id = 7;
UPDATE tomes SET body = body || 'icular, I’ll be bound. That house has had human blood in it since her time. Ebonheart was jealous that the Staff was laid here when Tiber Septim took the Horn of Summoning from us.”

Barenziah sighed a little. The rivalry between Ebonheart and Mournhold reached back almost to the dawn of Morrowind’s history. Once the two nations had been one, all the lucrative mines held in fief by the Ra’athims, whose nobility retained the High Kingship of Morrowind. Ebonheart had split into two separate city-states, Ebonheart and Mournhold, when Queen Lian’s twin sons – grandsons of the legendary King Moraelyn – were left as joint heirs. At about the same time the office of High King was vacated in favor of a temporary War Leader to be named by a council in times of provincial emergency.

Still, Ebonheart remained jealous of her prerogatives as the eldest city-state of Morrowind (“first among equals” was the phrase its rulers often quoted) and claimed that rightful guardianship of the Staff of Chaos should have been entrusted to its ruling house. Mournhold responded that King Moraelyn himself had placed the Staff in the keeping of the god Ephen – and Mournhold was unarguably the god’s birthplace.

“Why not tell Jagar Tharn of your suspicions, then? Let him recover the thing. As long as it’s safe, what does it matter who recovers it, or where it lies?”

Symmachus stared at her without comprehension. “It matters,” he said softly after a while, “but I suppose not that much. Ai.” He added, “Certainly not enough for you to concern yourself further with it. You just sit there and tend to your,” and here he smiled at her wickedly, “embroidery.”

Barenziah flung the sampler at him. It hit Symmachus square in the face – needle, thimble, and all.

In a few more months Barenziah gave birth to a fine son, whom they named Helseth. Nothing more was heard of the Staff of Chaos, or the Nightingale. If Ebonheart had the Staff in its possession, they certainly did not boast of it.

The years passed swiftly and happily. Helseth grew tall and strong. He was much like his father, whom he worshipped. When Helseth was eight years old Barenziah bore a second child, a daughter, to Symmachus’ lasting delight. Helseth was his pride, but little Morgiah – named for Symmachus’ mother – held his heart.

Sadly, the birth of Morgiah was not the harbinger of better times ahead. Relations with the Empire slowly deteriorated, for no apparent reason. Taxes were raised and quotas increased with each passing year. Symmachus felt that the Emperor suspected him of having had a hand in the Staff’s disappearance and sought to prove his loyalty by making every effort to comply with the escalating demands. He lengthened working hours and raised tariffs, and even made up some of the difference from both the royal exchequer and their own private holdings. But the levies multiplied, and commoners and nobles alike began to complain. It was an ominous rumble.

“I want you to take the children and journey to the Imperial City,” Symmachus said at last in desperation one evening after dinner. “You must make the Emperor listen, else all Mournhold will be up in revolt come spring.” He grinned forcibly. “You have a way with men, love. You always did.”

Barenziah forced a smile of her own. “Even with you, I take it.”

“Yes. Especially with me,” he acknowledged amiably.

“Both children?” Barenziah looked over toward a corner window, where Helseth was strumming a lute and crooning a duet with his little sister. Helseth was fifteen by then, Morgiah eight.

“They might soften his heart. Besides, it’s high time Helseth was presented before the Imperial Court.”

“Perhaps. But that’s not your true reason.” Barenziah took a deep breath and grasped the nettle. “You don’t think you can keep them safe here. If that’s the case, then you’re not safe here either. Come with us,” she urged.

He took her hands in his. “Barenziah. My love. Heart of my heart. If I leave now, there’ll be nothing for us to return to. Don’t worry about me. I’ll be all right. Ai! I can take care of myself – and I can do it better if I’m not worrying about you or the children.”

Barenziah laid her head against his chest. “Just remember that we need you. I need you. We can do without the rest of it if we have each other. Empty hands and empty bellies are easier to bear than an empty heart.” She started to cry, thinking of the Nightingale and that sordid business with the Staff. “My foolishness has brought us to this pass.”

He smiled at her tenderly. “If so, ‘tis not so bad a place to be.” His eyes rested indulgently on their children. “None of us shall ever go without, or want for anything. Ever. Ever, my love, I promise you. I cost you everything once, Barenziah, I and Tiber Septim. Ai. Without my aid the Empire would never have begun. I helped its rise.” His voice hardened. “I can bring about its fall. You may tell Uriel Septim that. That, and that my patience is not infinite.”

Barenziah gasped. Symmachus was not given to empty threats. She’d no more imagined that he would ever turn against the Empire than that the old house wolf lying by the grate would turn on her. “How?” she demanded breathlessly. But he shook his head.

“Better that you not know,” he said. “Just tell him what I told you should he prove recalcitrant, and do not fear. He’s Septim enough that he will not take it out on the messenger.” He smiled grimly. “For if he does, if he ever harms the least hair on you, my love, or the children – so help me all the gods of Tamriel, he’ll pray that he hadn’t been born. Ai. I’ll hunt him down, him and his entire family. And I won’t rest until the last Septim is dead.” The red Dark Elven eyes of Symmachus gleamed brightly in the ebbing firelight. “I plight you that oath, my love. My Queen ... my Barenziah.”

Barenziah held him, held him as tight as she could. But in spite of the warmth in his embrace, she couldn’t help shivering.

Barenziah stood before the Emperor’s throne, trying to explain Mournhold’s straits. She’d waited weeks for an audience with Uriel Septim, having been fobbed off on this pretext or that. “His Majesty is indisposed.” “An urgent matter demands His Excellency’s attention.” “I am sorry, Your Highness, there must be some mistake. Your appointment is for next week. No, see...” And now it wasn’t even going well. The Emperor did not even make the slightest pretence at listening to her. He hadn’t invited her to sit, nor had he dismissed the children. Helseth stood still as a carven image, but little Morgiah had begun to fuss.

The state of her own mind didn’t help her any. Shortly upon arrival at her lodgings, the Mournholdian ambassador to the Imperial City had demanded entry, bringing with him a sheaf of dispatches from Symmachus. Bad news, and plenty of it. The revolt had finally begun. The peasants had organized around a few disgruntled members of Mournhold’s minor nobility, and were demanding Symmachus step down and hand over the reins of government. Only the Imperial Guard and a handful of troops whose families had been retainers of Barenziah’s house for generations stood between Symmachus and the rabble. Hostilities had already broken out, but apparently Symmachus was safe and still in control. Not for long, he wrote. He entreated Barenziah to try her best with the Emperor – but in any case she was to stay in the Imperial City until he wrote to tell her it was safe to go back home with the children.

She had tried to barge her way through the Imperial bureaucracy – with little success. And to add to her growing panic, all news from Mournhold had come to a sudden stop. Tottering between rage at the Emperor’s numerous major-domos and fear of the fate awaiting her and her family, the weeks had passed by tensely, agonizingly, remorselessly. Then one day the Mournholdian ambassador came calling to tell her she should expect news from Symmachus the following night at the latest, not through the regular channels but by nighthawk. Seemingly by the same stroke of luck, she was informed that same day by a clerk from the Imperial Court that Uriel Septim had finally consented to grant her an audience early on the morrow.

The Emperor had greeted the three of them when they came into the audience chamber with a too-bright smile of welcome that nonetheless didn’t reach his eyes. Then, as she presented her children, he had gazed at them with a fixed attention that was real yet somehow inappropriate. Barenziah had been dealing with humans for nearly five hundred years now, and had developed the skill of reading their expressions and movements that was far beyond what any human could ever perceive. Try as the Emperor might to conceal it, there was hunger in his eyes – and something else. Regret? Yes. Regret. But why? He had several fine children of his own. Why covet hers? And why look at her with such a vicious – however brief – yearning? Perhaps he had tired of his consort. Humans were notoriously, though predictably, inconstant. After that one long, burning glance, his gaze had shifted away as she began to speak of her mission and the violence that had erupted in Mournhold. He sat still as stone throughout her entire account.

Puzzled at his inertia, and vexed no end, Barenziah stared into the pale, set face, looking for some trace of the Septims she’d known in the past. She didn’t know Uriel Septim well, having met him once when he was still a child, and then again at his coronation twenty years later. Twice, that was all. He’d been a stern and dignified presence at the ceremony, even as a young adult – yet not icily remote as this more mature man was. In fact, despite the physical resemblance, he didn’t seem to be the same man at all. Not the same, yet something about him was familiar to her, more familiar than it should be, some trick of posture or gesture...

Suddenly she felt very hot, as if lava had been poured over her. Illusion! She had studied the arts of illusion well since the Nightingale had deceived her so badly. She had learned to detect it – and she felt it now, as certainly as a blind man could feel the sun on his face. Illusion! But why? Her mind worked furiously even as her mouth went on reciting details about Mournhold’s troubles. Vanity? Humans were oft as ashamed at the signs of ageing as Elves were proud to exhibit them. Yet the face Uriel Septim wore seemed consistent with his age.

Barenziah dared use none of her own magic. Even petty nobles had means of detecting magicka, if not actually shielding themselves from its effects, within their own halls. The use of sorcery here would bring down the Emperor’s wrath as surely as drawing a dagger would.

Magic.

Illusion.

Suddenly she was brought to mind of the Nightingale. And then he was sitting before her. Then the vision changed, and it was Uriel Septim. He looked sad. Trapped. And then the vision faded once more, and another man sat in his place, like the Nightingale, and yet unlike. Pale skin, bloodshot eyes, Elven ears – and about him a fierce glow of concentrated malice, an aura of eldritch energy – a horrible, destructive shimmer. This man was capable of anything!

And then once again she was looking into the face of Uriel Septim.

How could she be sure she wasn’t imagining things? Perhaps her mind was playing tricks on her. She felt a sudden vast weariness, as if she’d been carrying a heavy burden too long and too far. She decided to abandon her earnest narrative of Mournhold’s ills – as it was quite plainly getting her nowhere – and switch back to pleasantry. Pleasantry, however, with a hidden agenda.

“Do you remember, Sire, Symmachus and I had dinner with your family shortly after your father’s coronation? You were no older than tiny Morgiah here. We were greatly honored to be the only guests that evening – except for your best friend Justin, of course.”

“Ah yes,” the Emperor said, smiling cautiously. Very cautiously. “I do believe I recall that.”

“You and Justin were such friends, Your Majesty. I was told he died not long after. A great pity.”

“Indeed. I still do not like to speak of him.” His eyes turned blank – or blanker, if it had been possible. “As for your request, Milady, we shall take it under advisement and let you know.”

Barenziah bowed, as did the children. A nod from the Emperor dismissed them, and they backed away from the imperial presence.

She took a deep breath when they emerged from the throne room. “Justin” had been an imaginary playmate, although young Uriel had insisted a place be set for Justin at every meal. Not only that, Justin, despite the boyish name, had been a girl! Symmachus had kept up the joke long after she had gone the way of imaginary childhood friends – inquiring after Justin’s health whenever he and Uriel Septim met, and being responded to in as mock-serious a fashion. The last Barenziah had heard of Justin, several years ago, the Emperor had evidently joked elaborately to Symmachus that she had met an adventurous though incorrigible Khajiit youth, married him, and settled down in Lilandril to raise fire ferns and mugworts.

The man sitting on the Emperor’s divan was not Uriel Septim! The Nightingale? Could it be...? Yes. Yes! A chord of recognition rang through her and Barenziah knew she was right. It was him. It was! The Nightingale! Masquerading as the Emperor! Symmachus had been wrong, so wrong...

What now? she wondered frantically. What had become of Uriel Septim – and more to the point, what did it mean for her and Symmachus, and all of Mournhold? Thinking back, Barenziah guessed that their troubles were due to this false Emperor, this Nightingale-spawned glamour – or whatever he really was. He must have taken Uriel Septim’s place shortly before the unreasonable demands on Mournhold had begun. That would explain why relations had deteriorated for so long (as humans reckoned time), long after her disapproved liaison with Tiber Septim. The Nightingale knew of Symmachus’ famed loyalty to, and knowledge of, the Septim House, and was effecting a pre-emptive strike. If that were the case, they were all in terrible danger. She and the children were in his power here in the Imperial City, and Symmachus was left alone to deal with troubles of the Nightingale’s brewing in Mournhold.

What must she do? Barenziah impelled the children ahead of her, a hand on each shoulder, trying to stay cool, collected, her ladies-in-waiting and personal knights escort trailing behind. Finally they reached their waiting carriage. Even though their suite of rooms was only a few blocks from the Palace, royal dignity forbade travel on foot for even short distances – and for once, Barenziah was glad of it. The carriage seemed a kind of refuge now, false as she knew the feeling must be.

A boy dashed up to one of the guards and handed him a scroll, then pointed toward the carriage. The guard brought it to her. The boy waited, eyes wide and shining. The epistle was brief and complimentary, and simply inquired if King Eadwyre of Wayrest, of the Province of High Rock, might be granted an audience with the famed Queen Barenziah of Mournhold, as he had heard much of her and would be pleased to make her acquaintance.

Barenziah’s first impulse was to refuse. She wanted only to leave this city! Certainly she had no inclination toward any dalliance with a dazzled human. She looked up, frowning, and one of the guards said, “Milady, the boy says his master awaits your reply yonder.” She looked in the direction indicated and saw a handsome elderly man on horseback, surrounded by a half dozen courtiers and cavaliers. He caught her eye and bowed respectfully, taking off a plumed hat.

“Very well,” Barenziah said to the boy on impulse. “Tell your master he may call on me tonight, after the dinner hour.” King Eadwyre looked polite and grave, and rather worried – but not in the least lovestruck. At least that was something, she thought pensively.

Barenziah stood at the tower window, waiting. She could sense the familiar’s nearness. But though the night sky was clear as day to her eyes, she could not yet see him. Then suddenly he was there, a swift moving dot beneath the wispy night clouds. A few more minutes and the great nighthawk finished its descent, wings folding, talons reaching for her thick leather armband.

She carried the bird to its perch, where it waited, panting, as her impatient fingers felt for the message secured in a capsule on one leg. The hawk drank mightily from the water till when she had done, then ruffled its feathers and preened, secure in her presence. A tiny part of her consciousness shared its satisfaction at a job well done, mission accomplished, and rest earned ... yet beneath it all was unease. Things were not right, even to its humble avian mind.

Her fingers shook as she unfolded the thin parchment and pored over the cramped writing. Not Symmachus’ bold hand! Barenziah sat slowly, fingers smoothing the document while she prepared her mind and body to accept disaster calmly, if disaster it would be.

Disaster it was.

The Imperial Guard had deserted Symmachus and joined the rebels. Symmachus was dead. The remaining loyal troops had suffered a decisive defeat. Symmachus was dead. The rebel leader had been recognized as King of Mournhold by Imperial envoys. Symmachus was dead. Barenziah and the children had been declared traitors to the Empire and a price set on their heads.

Symmachus was dead.

So the audience with the Emperor earlier that morning had been nothing but a blind, a ruse. A charade. The Emperor must have already known. She was just being strung along, told to stay put, take things easy, Milady Queen, enjoy the Imperial City and the delights it has to offer, do make your stay as long as you want. Her stay? Her detention. Her captivity. And in all probability, her impending arrest. She had no delusions about her situation. She knew the Emperor and his minions would never let her leave the Imperial City, ever again. At least, not alive.

Symmachus was dead.

“Milady?”

Barenziah jumped, startled by the servant’s approach. “What is it?”

“The Breton is here, Milady. King Eadwyre,” the woman added helpfully, noting Barenziah’s incomprehension. She hesitated. “Is there news, Milady?” she said, nodding toward the nighthawk.

“Nothing that will not wait,” Barenziah said quickly, and her voice seemed to echo in the emptiness that suddenly yawned like a gaping abyss inside her. “See to the bird.” She stood up, smoothed her gown, and prepared to attend on her royal visitor.

She felt numb. Numb as the stone walls around her, numb as the quiescence of the night air... numb as a lifeless corpse.

Symmachus was dead!

King Eadwyre greeted her gravely and courteously, if a bit fulsomely. He claimed to be a fervent admirer of Symmachus, who figured prominently in his family’s legends. Gradually he turned the conversation to her business with the Emperor. He inquired after details, and asked if the outcome had been favorable to Mournhold. Finding her noncommittal, he suddenly blurted out, “Milady Queen, you must believe me. The man who claims himself the Emperor is an impostor! I know it sounds mad, but I – “

“No,” Barenziah said, with sudden decisiveness. “You are entirely correct, Milord King. I know.”

Eadwyre relaxed into his seat for the first time, eyes suddenly shrewd. “You know? You’re not just humoring someone you might think a madman?”

“I assure you, Milord, I am not.” She took a deep breath. “And who do you surmise is dissembling as the Emperor?”

“The Imperial Battlemage, Jagar Tharn.”

“Ah. Milord King, have you, perchance, heard of someone called the Nightingale?”

“Yes, Milady, as a matter of fact I have. My allies and I believe him to be one and the same man as the renegade Tharn.”

“I knew it!” Barenziah stood up and tried to mask her upheaval. The Nightingale – Jagar Tharn! Oh, but the man was a demon! Diabolical and insidious. And so very clever. He had contrived their downfall seamlessly, perfectly! Symmachus, my Symmachus...!

Eadwyre coughed diffidently. “Milady, I... we... we need your aid.”

Barenziah smiled grimly at the irony. “I do believe I should be the one saying those words. But go on, please. Of what assistance might I be, Milord King?”

Quickly the monarch outlined a plot. The mage Ria Silmane, of late apprenticed to the vile Jagar Tharn, had been killed and declared a traitor by the false Emperor. Yet she had retained a bit of her powers and could still contact a few of those she had known well on the mortal plane. She had chosen a Champion who would undertake to find the Staff of Chaos, which had been hidden by the traitorous sorcerer in an unknown site. This Champion was to wield the Staff’s power to destroy Jagar Tharn, who was otherwise invulnerable, and rescue the true Emperor being held prisoner in another dimension. However, the Champion, while thankfully still alive, now languished in the Imperial Dungeons. Tharn’s attention must be diverted while the chosen one gained freedom with Ria’s spirit’s help. Barenziah had the false Emperor’s ears – and seemingly his eyes. Would she provide the necessary distraction?

“I suppose I could obtain another audience with him,” Barenziah said carefully. “But would that be sufficient? I must tell you that my children and I have just recently been declared traitors to the Empire.”

“In Mournhold, perhaps, Milady, and Morrowind. Things are different in the Imperial City and the Imperial Province. The same administrative morass that makes it near impossible to obtain an audience with the Emperor and his ministers also quite assures that you would never be unlawfully imprisoned or otherwise punished without benefit of due legal process. In your case, Milady, and your children’s, the situation is further exacerbated by your royal rank. As Queen and heirs apparent, your persons are considered inviolable – sacrosanct, in fact.” The King grinned. “The Imperial bureaucracy, Milady, is a double-edged claymore.”

So. At least she and the children were safe for the time being. Then a thought struck her. “Milord King, what did you mean earlier when you said I had the false Emperor’s eyes? And seemingly, at that?”

Eadwyre looked uncomfortable. “It was whispered among the servants that Jagar Tharn kept your likeness in a sort of shrine in his chambers.”

“I see.” Her thoughts wandered momentarily to that insane romance of hers with the Nightingale. She had been madly in love with him. Foolish woman. And the man she had once loved had caused to be killed the man she truly did love. Did love. Loved. He’s gone now, he’s... he... She still couldn’t bring herself to accept the fact that Symmachus was dead. But even if he is, she told herself firmly, my love is alive, and remains. He would always be with her. As would the pain. The pain of living the rest of her life without him. The pain of trying to survive each day, each night, without his presence, his comfort, his love. The pain of knowing he would never see his children grow into a fine pair of adults, who would never know their father, how brave he was, how strong, how wonderful, how loving... especially little Morgiah.

And for that, for all that, for all you have done to my family, Nightingale – you must die.

“Does that surprise you?”

Eadwyre’s words broke into her thoughts. “What? Does what surprise me?”

“Your likeness. In Tharn’s room.”

“Oh.” Her features set imperturbably. “Yes. And no.”

Eadwyre could see from her expression that she wished to change the subject. He turned once again to their plans. “Our chosen one may need a few days to escape, Milady. Can you gain him a bit more time?”

“You trust me in this, Milord King? Why?”

“We are desperate, Milady. We have no choice. But even if we did – why, yes. Yes, I would trust you. I do trust you. Your husband has been good to my family over the years. The Lord Symmachus–”

“Is dead.”

“What?”

Barenziah related the recent events quickly and coolly.

“Milady... Queen... but how dreadful! I... I’m so sorry...”

For the first time Barenziah’s glacial poise was shaken. In the face of sympathy, she felt her outward calm start to crumble. She gathered her composure, and willed herself to stillness.

“Under the circumstances, Milady, we can hardly ask–”

“Nay, good Milord. Under the circumstances I must do what I may to avenge myself upon the murderer of my children’s father.” A single tear escaped the fortress of her eyes. She brushed it away impatiently. “In return I ask only that you protect my orphaned children as you may.”

Eadwyre drew himself up. His eyes shone. “Willingly do I so pledge, most brave and noble Queen. The gods of our beloved land, indeed Tamriel itself, be my witnesses.”

His words touched her absurdly, yet profoundly. “I thank you from my heart and my soul, good Milord King Eadwyre. You have mine and m-my children’s e-everlasting g-gra – grati – “

She broke down.

She did not sleep that night, but sat in a chair beside her bed, hands folded in her lap, thinking deep and long into the waxing and waning of the darkness. She would not tell the children – not yet, not until she must.

She had no need to seek another audience with the Emperor. A summons arrived at first light.

She told the children she expected to be gone a few days, bade them give the servants no trouble, and kissed them good-bye. Morgiah whimpered a bit; she was bored and lonely in the Imperial City. Helseth looked dour but said nothing. He was very like his father. His father...

At the Imperial Palace, Barenziah was escorted not into the great audience hall but to a small parlour where the Emperor sat at a solitary breakfast. He nodded a greeting and waved his hand toward the window. “Magnificent view, isn’t it?”

Barenziah stared out over the towers of the great city. It dawned on her that this was the very chamber where she’d first met Tiber Septim all those years ago. Centuries ago. Tiber Septim. Another man she had loved. Who else had she loved? Symmachus, Tiber Septim... and Straw. She remembered the big blond stable-boy with sudden and intense affection. She never realized it till now, but she had loved Straw. Only she had never let him know. She had been so young then, those had been carefree days, halcyon days... before everything, before all this... before... him. Not Symmachus. The Nightingale. She was shocked in spite of herself. The man could still affect her. Even now. Even after all that had happened. A strong wave of inchoate emotion swept over her.

When she turned back at last, Uriel Septim had vanished – and the Nightingale sat in his place.

“You knew,” he said quietly, scanning her face. “You knew. Instantly. I wanted to surprise you. You might at least have pretended.”

Barenziah spread her arms, trying to pacify the maelstrom churning deep inside her. “I’m afraid my skill at pretence is no match for yours, my liege.”

He sighed. “You’re angry.”

“Just a little, I must admit,” she said icily. “I don’t know about you, but I find betrayal a trifle offensive.”

“How human of you.”

She took a deep breath. “What do you want of me?”

“Now you are pretending.” He stood up to face her directly. “You know what I want of you.”

“You want to torment me. Go ahead. I’m in your power. But leave my children alone.”

“No, no, no. I don’t want that at all, Barenziah.” He came near, speaking low in the old caressing voice that had sent shivers cascading through her body. The same voice that was doing the same thing to her, here and now. “Don’t you see? This was the only way.” His hands closed on her arms.

She felt her resolve fading, her disgust at him weakening. “You could have taken me with you.” Unbidden tears gathered in her eyes.

He shook his head. “I didn’t have the power. Ah, but now, now...! I have it all. Mine to have, mine to share, mine to give – to you.” He once more waved his hand toward the window and the city beyond. “All Tamriel is mine to lay at your feet – and that is only the beginning.”

“It’s too late. Too late. You left me to him.”

“He’s dead. The peasant’s dead. A scant few years – what do they matter?”

“The children–”

“Can be adopted by me. And we’ll have others together, Barenziah. Oh, and what children they’ll be! What things we shall pass on to them! Your beauty, and my magic. I have powers you haven’t even dreamt of, not in your most untamed imaginings!” He moved to kiss her.

She slipped his grasp and turned away. “I don’t believe you.”

“You do, you know. You’re still angry, that’s all.” He smiled. But it didn’t reach his eyes. “Tell me what you want, Barenziah. Barenziah my beloved. Tell me. It shall be yours.”

Her whole life flashed in front of her. The past, the present, and the future still to come. Different times, different lives, different Barenziahs. Which one was the real one? Which one was the real Barenziah? For by that choice she would determine the shape of her fate.

She made it. She knew. She knew who the real Barenziah was, and what she wanted.

“A walk in the garden, my liege,” she said. “A song or two, perhaps.”

The Nightingale laughed. “You want to be courted.”

“And why not? You do it so well. It’s been long, besides, since I’ve had the pleasure.”

He smiled. “As you wish, Milady Queen Barenziah. Your wish is my command.” He took her hand and kissed it. “Now, and forever.”

And so they spent their days in courtship – walking, talking, singing and laughing together, while the Empire’s business was left to subordinates.

“I’d like to see the Staff,” Barenziah said idly one day. “I only had a glimpse of it, you’ll recall.”

He frowned. “Nothing would give me greater pleasure, heart’s delight – but that would be impossible.”

“You don’t trust me,” Barenziah pouted, but softened her lips when he leaned over for a kiss.

“Nonsense, love. Of course I do. But it isn’t here.” He chuckled. “In fact, it isn’t anywhere.” He kissed her again, more passionately this time.

“You’re talking in riddles a' WHERE id = 7;
UPDATE tomes SET body = body || 'gain. I want to see it. You couldn’t have destroyed it.”

“Ah. You’ve gained in wisdom since last we met.”

“You inspired my hunger for knowledge somewhat.” She stood up. “The Staff of Chaos can’t be destroyed. And it can’t be removed from Tamriel, not without the direst consequences to the land itself.”

“Ahhh. You impress me, my love. All true. It is not destroyed, and it is not removed from Tamriel. And yet, as I said, it isn’t anywhere. Can you solve the puzzle?” He pulled her to him and she leaned into his embrace. “Here’s a greater riddle still,” he whispered. “How does one make one of two? That I can, and will, show you.” Their bodies merged, limbs tangled together.

Later, when they had drawn a bit apart and he lay dozing, she thought sleepily, “One of two, two of one, three of two, two of three... what cannot be destroyed or banished might be split apart, perhaps...”

She stood up, eyes blazing. She started to smile.

The Nightingale kept a journal. He scribbled entries onto it every night after quick reports from underlings. It was locked in a bureau. But the lock was a simple one. She had, after all, been a member of the Thieves Guild in a past life... in another life... another Barenziah...

One morning Barenziah managed to sneak a quick look at it while he was occupied at his toilet. She discovered that the first piece of the Staff of Chaos was hidden in an ancient Dwarvish mine called Fang Lair – although its location was given only in the vaguest of terms. The diary was crammed with jotted events in an odd shorthand, and was very hard to decipher.

All Tamriel, she thought, in his hands and mine, and more perhaps – and yet...

For all his exterior charm there was a cold emptiness where his heart should have been, a vacuum of which he was quite unaware, she thought. One could glimpse it now and then, when his eyes would go blank and hard. And yet, though he had a different concept of it, he yearned for happiness too, and contentment. Peasant dreams, Barenziah thought, and Straw flashed before her eyes again, looking lost and sad. And then Therris, with a feline Khajiit smile. Tiber Septim, powerful and lonely. Symmachus, solid, stolid Symmachus, who did what ought to be done, quietly and efficiently. The Nightingale. The Nightingale, a riddle and a certainty, both the darkness and the light. The Nightingale, who would rule all, and more – and spread chaos in the name of order.

Barenziah got reluctant leave from him to visit her children, who had yet to be told of their father’s death – and of the Emperor’s offer of protection. She finally did, and it wasn’t easy. Morgiah clung to her for what seemed an era, sobbing wretchedly, while Helseth ran off into the garden to be alone, afterward refusing all her attempts to speak to him on the subject of his father, or even to let her hold him to her breast.

Eadwyre called on her while she was there. She told him what she had discovered so far, explaining that she must remain awhile yet and learn more as she could.

The Nightingale teased her about her elderly admirer. He was quite aware of Eadwyre’s suspicion – but he wasn’t the least bit perturbed, for no one took the old fool seriously. Barenziah even managed to arrange a reconciliation of sorts between them. Eadwyre publicly recanted his misgivings, and his “old friend” the Emperor forgave him. He was afterward invited to dine with them at least once a week.

The children liked Eadwyre, even Helseth, who disapproved of his mother’s liaison with the Emperor and consequently detested him. He had become surly and temperamental as the days passed, and frequently quarreled with both his mother and her lover. Eadwyre was not happy with the affair either, and the Nightingale took great delight at times in openly displaying his affection for Barenziah just to nettle the old man.

They could not marry, of course, for Uriel Septim was already married. At least, not yet. The Nightingale had exiled the Empress shortly after taking the Emperor’s place, but had not dared harm her. She was given sanctuary by the Temple of the One. It had been given out that she was suffering from ill health, and rumors had been circulated by the Nightingale’s agents that she had mental problems. The Emperor’s children had likewise been dispatched to various prisons all across Tamriel disguised as “schools.”

“She’ll grow worse in time,” Nightingale said carelessly, referring to the Empress and eyeing Barenziah’s swollen breasts and swelling belly with satisfaction. “As for their children... Well, life is full of hazards, isn’t it? We’ll be married. Your child will be my true heir.”

He did want the child. Barenziah was sure of that. She was far less sure, however, of his feelings for her. They argued continually now, often violently, usually about Helseth, whom he wanted to send away to school in Summurset Isle, the province farthest from the Imperial City. Barenziah made no effort to avoid these altercations. The Nightingale, after all, had no interest in a smooth, unruffled life; and besides, he thoroughly enjoyed making up afterward...

Occasionally Barenziah would take the children and retreat to their old apartment, declaring she wanted no more to do with him. But he would always come to fetch her back, and she would always let herself be fetched back. It was ineffable, like the rising and setting of Tamriel’s twin moons.

She was six months pregnant before she finally deciphered the location of the last Staff piece – an easy one, since every Dark Elf knew where the Mount of Dagoth-Ur was.

When she next quarreled with the Nightingale, she simply left the city with Eadwyre and rode hard for High Rock, and Wayrest. The Nightingale was furious, but there was little he could do. His assassins were rather inept, and he dared not leave his seat of power to pursue them in person. Nor could he openly declare war on Wayrest. He had no legitimate claim on her or her unborn child. True to form, the Imperial City’s nobility had disapproved of his liaison with Barenziah – as they had so many years ago of Tiber Septim’s – and were glad to see her go.

Wayrest was equally distrustful of her, but Eadwyre was fanatically loved by his prosperous little city-state, and allowances were readily made for his... eccentricities. Barenziah and Eadwyre were married a year after the birth of her son by the Nightingale. In spite of this unfortunate fact, Eadwyre doted on her and her children. She in her turn did not love him – but she was fond of him, and that was something. It was nice to have someone, and Wayrest was a very good place, a good place for children to grow up, while they waited, and bided their time, and prayed for the Champion’s success in his mission.

Barenziah could only hope that he wouldn’t take very long, whoever this unnamed Champion was. She was a Dark Elf, and she had all the time in the world. All the time. But no more love left to give, and no more hatred left to burn. She had nothing left, nothing but pain, and memories... and her children. She only wanted to raise her family, and provide them a good life, and be left to live out what remained of hers. She had no doubt it was going to be a long life yet. And during it she wanted peace, and quiet, and serenity, of her soul as well as of her heart. Peasant dreams. That was what she wanted. That was what the real Barenziah wanted. That was what the real Barenziah was. Peasant dreams.' WHERE id = 7;

-- AR-I-008 — Sacred Witness
INSERT INTO tomes (id, call_number, title, author, school, body, restricted) VALUES
  (8, 'AR-I-008', 'Sacred Witness', 'Enric Milnes', 'Biographies',
   'I have met countesses and courtesans, empresses and witches, ladies of war and slatterns of peace, but I have never met a woman like The Night Mother. And I never will again.

I am a writer, a poet of some small renown. If I told you my name, you may have heard of me, but very likely, not. For decades until very recently, I had adopted the city of Sentinel on the coast of Hammerfell as my home, and kept the company of other artists, painters, tapestrists, and writers. No one I knew would have known an assassin by sight, least of all the queen of them, the Blood Flower, the Lady Death, the Night Mother.

Not that I had not heard of her.

Some years ago, I had the good fortune of meeting Pelarne Assi, a respected scholar, who had come to Hammerfell to do research for a book about the Order of Diagna. His essay, ‘The Brothers of Darkness’ together with Ynir Gorming’s ‘Fire and Darkness: The Brotherhoods of Death’ are considered to be the canon tomes on the subject of Tamriel’s orders of assassins. By luck, Gorming himself was also in Sentinel, and I was priveleged to sit with the two in a dark skooma den in the musty slums of the city, as we smoked and talked about the Dark Brotherhood, the Morag Tong, and the Night Mother.

While not disputing the possibility that the Night Mother may be immortal or at least very long-lived, Assi thought it most likely that several women - and perhaps some men - throughout the ages had assumed the honorary title. It was no more logical to say there was only one Night Mother, he asserted, than to say there was only one King of Sentinel.

Gorming argued that there never was a Night Mother, at least no human one. The Night Mother was Mephala herself, whom the Brotherhood revered second only to Sithis.

‘I don’t suppose there’s any way of knowing for certain,’ I said, in a note of diplomacy.

‘Certainly there is,’ whispered Gorming with a grin. ‘You could talk to that cloaked fellow in the corner.’

I had not noticed the man before, who sat by himself, eyes hidden by his cloak, seemingly as much a part of the dingy place as the rough stone and unswept floor. Turning back to Ynir, I asked him why that man would know about the Night Mother.

‘He’s a Dark Brother,’ hissed Pellarne Assi. ‘That’s as plain as the moons. Don’t even joke about speaking with him about Her.’

We moved on to other arguments about the Morag Tong and the Brotherhood, but I never forgot the image of the lone man, looking at nothing and everything, in the corner of the dirty room, with fumes of skooma smoke floating around him like ghosts. When I saw him weeks later on the streets of Sentinel, I followed him.

Yes, I followed him. The reader may reasonably ask ‘why’ and ‘how.’ I don’t blame you for that.

‘How’ was simply a question of knowing my city as well as I do. I’m not a thief, not particularly sure-footed and quiet, but I know the alleys and streets of Sentinel intimately from decades worth of ambling. I know which bridges creak, which buildings cast long irregular shadows, the intervals at which the native birds begin the ululations of their evening songs. With relative ease, I kept pace with the Dark Brother and out of his sight and hearing.

The answer to ‘Why’ is even simpler. I have the natural curiosity of the born writer. When I see a strange new animal, I must observe. It is the writer’s curse.

I trailed the cloaked man deeper into the city, down an alleyway so narrow it was scarcely a crack between two tenements, past a crooked fence, and suddenly, miraculously, I was in a place I had never seen before. A little courtyard cemetery, with a dozen old half-rotted wooden tombstones. None of the surrounding buildings had windows that faced it, so no one knew this miniature necropolis existed.

No one, except the six men and one woman standing in it. And me.

The woman saw me immediately, and gestured for me to come closer. I could have run, but - no, I couldn’t have. I had pierced a mystery right in my adopted Sentinel, and I could not leave it.

She knew my name, and she said it with a sweet smile. The Night Mother was a little old lady with fluffy white hair, cheeks like wrinkled apples that still carried the flush of youth, friendly eyes, blue as the Iliac Bay. She softly took my arm as we sat down amidst the graves and discussed murder.

She was not always in Hammerfell, not always available for direct assignment, but it seemed she enjoyed actually talking to her clientele.

‘I did not come here to hire the Brotherhood,’ I said respectfully.

‘Then why are you here?’ the Night Mother asked, her eyes never leaving mine.

I told her I wanted to know about her. I did not expect an answer to that, but she told me.

‘I do not mind the stories you writers dream up about me,’ she chuckled. ‘Some of them are very amusing, and some of them are good for business. I like the sexy dark woman lounging on the divan in Carlovac Townway’s fiction particularly. The truth is that my history would not make a very dramatic tale. I was a thief, long, long ago, back when the Thieves Guild was only beginning. It’s such a bother to sneak around a house when performing a burglary, and many of us found it most efficacious to strangle the occupant of the house. Just for convenience. I suggested to the Guild that a segment of our order be dedicated to the arts and sciences of murder.

‘It did not seem like such a controversial idea to me,’ the Night Mother shrugged. ‘We had specialists in catburglary, pick-pocketing, lock-picking, fencing, all the other essential parts of the job. But the Guild thought that encouraging murder would be bad for business. Too much, too much, they argued.

‘They might have been right,’ the old woman continued. ‘But I discovered there is a profit to be made, just the same, from sudden death. Not only can one rob the deceased, but, if your victim has enemies, which rich people often do, you can be paid for it even more. I began to murder people differently when I discovered that. After I strangled them, I would put two stones in their eyes, one black and one white.’

‘Why?’ I asked.

‘It was a sort of calling card of mine. You’re a writer - don’t you want your name on your books? I couldn’t use my name, but I wanted potential clients to know me and my work. I don’t do it anymore, no need to, but at the time, it was my signature. Word spread, and I soon had quite a successful business.’

‘And that became the Morag Tong?’ I asked.

‘Oh, dear me, no,’ the Night Mother smiled. ‘The Morag Tong was around long before my time. I know I’m old, but I’m not that old. I merely hired on some of their assassins when they began to fall apart after the murder of the last Potentate. They did not want to be members of the Tong anymore, and since I was the only other murder syndicate of any note, they just joined on.’

I phrased my next question carefully. ‘Will you kill me now that you’ve told me all this?’

She nodded sadly, letting out a little grandmotherly sigh. ‘You are such a nice, polite young man, I hate to end our acquaintanceship. I don’t suppose you would agree to a concession or two in exchange for your life, would you?’

To my everlasting shame, I did agree. I said I would say nothing about our meeting, which, as the reader can see, was a promise I eventually, years later, chose not to keep. Why have I endangered my life thus?

Because of the promises I did keep.

I helped the Night Mother and the Dark Brotherhood in acts too despicable, too bloody for me to set to paper. My hand quivers as I think about the people I betrayed, beginning with that night. I tried to write my poetry, but ink seemed to turn to blood. Finally, I fled, changing my name, going to a land where no one would know me.

And I wrote this. The true history of the Night Mother, from the interview she gave me on the night we met. It will be the last thing I ever write, this I know. And every word is true.

Pray for me.', 0);

-- AR-I-009 — Saint Jiub’s Opus
INSERT INTO tomes (id, call_number, title, author, school, body, restricted) VALUES
  (9, 'AR-I-009', 'Saint Jiub’s Opus', 'Jiub', 'Biographies',
   'I am a hunter. I am a redeemer. I am Jiub.

The tale of my rise to glory begins in the ash wastes of Morrowind. I rode alone, weapon at my side and the burning wind stinging my face. My quest was arduous, but necessary to ensure the survival of the Dunmer people. A pestilence was creeping across the ashlands, a menace with an insatiable hunger that plagued innocent travelers simply trying to get home. It was my self-sworn task to hunt them down one-by-one and drive them from the skies. Their fury knew no bounds and their war cry resonated across the land. They were the notorious cliff racers, and they had to be destroyed.

On a particularly hot day during Sun’s Height, I was tracking what I called a Lingerer... a cliff racer without a nest. He was a particularly feisty one too, leading me on a merry chase across almost three miles of ash dunes. I had managed to take a piece out of one of his wings in an earlier scuffle so he couldn’t maintain much of a climb, but he still had quite a bit of stamina left and he was trying to make me tire of the chase. Almost two solid hours passed and my silt strider was tiring, but I couldn’t give up... I had sworn to eliminate the foul beasts to the last and I wasn’t about to let it go. If I was going to stop the thing, I’d have to do it fast.

I pulled my longbow from my back and nocked my last arrow. I took a deep breath and pulled, trying to keep the cliff racer in my sights. It was literally a longshot with the beast gaining distance and the silt strider bouncing me around at full gallop. Finally, with a silent prayer, I released the string. The arrow sang through the air like a howling demon as it sliced its way towards its target. Finally, just as it crested the lip of a foyada, the arrow struck it in the midsection. It let out a horrible cry and fell out of sight.

My cries of triumph were quickly stifled by the sound of over a hundred wings. Rising from the foyada was an entire colony of cliff racers and they were out for blood. The blasted thing had led me right to their nest and sacrificed itself with the intent of feeding me to its brood. It was a trap. The damned things had become much too clever. Knowing this was likely the end, I jumped down from the silt strider and hit the back of its leg with the flat of my glass blade. There was no need for the innocent thing to die here today because of my stupidity. As the ash cloud cleared from being stirred up by its massive legs, the cliff racer brood approached. I held my sword high and prepared for the worst.

The battle lasted two full days. I was beaten, clawed, bitten and knocked down more times than I care to remember. In the end, seventy-six cliff racers were slaughtered. I was knee-deep in their corpses and my body on the verge of collapse. But I had survived. I smiled to the heavens and all went black.

When I awoke, all I felt was my back on a cold stone floor. Every muscle in my body was on fire, and my vision was blurred. Slowly, I tried to climb to my feet. It took several agonizing minutes, but I finally managed to do it. As my eyes adjusted to the dim light of my new surroundings, I realized that I was standing before Lord Vivec himself. He was simply staring at me... floating above his throne and staring at me with his piercing eyes. When I began to prostrate myself as a sign of respect, he held up one of his hands as if to say it wasn’t necessary. Was I dead? Was Lord Vivec pleased with me? Was he about to strike me down in anger for my somewhat sordid past?

Suddenly I understood everything. Suddenly I realized that I was brought here for a reason. I should have died in those ash wastes, but Lord Vivec must have seen something inside me that he hadn’t seen in millennia and decided to spare me from my fate.

Thus began my ascent to Sainthood. Thus began the rise of Jiub!', 0);

-- AR-I-010 — The Wolf Queen
INSERT INTO tomes (id, call_number, title, author, school, body, restricted) VALUES
  (10, 'AR-I-010', 'The Wolf Queen', 'Waughin Jarth', 'Biographies',
   '## Book One

*From the pen of the first century third era sage Montocai:*

3E 63:

In the autumntide of the year, Prince Pelagius, son of Prince Uriel, who is son of the Empress Kintyra, who is niece of the great Emperor Tiber Septim, came to the High Rock city-state of Camlorn to pay court to the daughter of King Vulstaed. Her name was Quintilla, the most beauteous princess in Tamriel, skilled at all the maidenly skills and an accomplished sorceress.

Eleven years a widower with a young son named Antiochus, Pelagius arrived at court to find that the city-state was being terrorized by a great demon werewolf. Instead of wooing, Pelagius and Quintilla together went out to save the kingdom. With his sword and her sorcery, the beast was slain and by the powers of mysticism, Quintilla chained the beast’s soul to a gem. Pelagius had the gem made into a ring and married her.

But it was said that the soul of the wolf stayed with the couple until the birth of their first child.

3E 80

“The ambassador from Solitude has arrived, your majesty,” whispered the steward Balvus.

“Right in the middle of dinner?” muttered the Emperor weakly. “Tell him to wait.”

“No, father, it’s important that you see him,” said Pelagius, rising. “You can’t make him wait and then give him bad news. It’s undiplomatic.”

“Don’t go then, you’re much better at diplomacy than I am. We should have all the family here,” Emperor Uriel II added, suddenly aware how few people were present at his dinner table. “Where’s your mother?”

“Sleeping with the archpriest of Kynareth,” Pelagius would have said, but he was, as his father said, diplomatic. Instead he said, “At prayer.”

“And your brother and sister?”

“Amiel is in Firsthold, meeting with the Archmagister of the Mages Guild. And Galana, though we won’t be telling this to the ambassador, of course, is preparing for her wedding to the Duke of Narsis. Since the ambassador expects her to be marrying his patron the King of Solitude instead, we’ll tell him that she’s at the spa, having a cluster of pestilent boils removed. Tell him that, and he won’t press too hard for the marriage, politically expedient though it may be,” Pelagius smiled. “You know how queasy Nords are about warty women.”

“But dash it, I feel like I should have some family around, so I don’t look like some old fool despised by his nearest and dearest,” growled the Emperor, correctly suspecting this to be the case. “What about your wife? Where’s she and the grandchildren?”

“Quintilla’s in the nursery with Cephorus and Magnus. Antiochus is probably whoring around the City. I don’t know where Potema is, probably at her studies. I thought you didn’t like children around.”

“I do during meetings with ambassadors in damp staterooms,” sighed the Emperor. “They lend an air of, I don’t know, innocence and civility. Ah, show the blasted ambassador in,” he said to Balvus.

Potema was bored. It was the rainy season in the Imperial Province, wintertide, and the streets and the gardens of the City were all flooded. She could not remember a time when it was not raining. Had it been only days, or had it been weeks or months since the sun shone? There was no judging of time any more in the constant flickering torch-light of the palace, and as Potema walked through marble and stone hallways, listening to the pelting of the rain, she could think nothing but that she was bored.

Asthephe, her tutor, would be looking for her now. Ordinarily, she did not mind studying. Rote memorization came easily to her. She quizzed herself as she walked down through the empty ballroom. When did Orsinium fall? 1E 980. Who wrote Tamrilean Tractates? Khosey. When was Tiber Septim born? 2E 288. Who is the current King of Daggerfall? Mortyn, son of Gothlyr. Who is the current Silvenar? Varbarenth, son of Varbaril. Who is the Warlord of Lilmoth? Trick question: it’s a lady, Ioa.

What will I get if I’m a good girl, and don’t get into any trouble, and my tutor says I’m an excellent student? Mother and father will renege on their promise to buy me a daedric katana of my own, saying they never remembered that promise, and it’s far too expensive and dangerous for a girl my age.

There were voices coming from the Emperor’s stateroom. Her father, her grandfather, and a man with a strange accent, a Nord. Potema moved a stone she had loosened behind a tapestry and listened in.

“Let us be frank, your imperial majesty,” came the Nord’s voice. “My sire, the King of Solitude, doesn’t care if Princess Galana looked like an orc. He wants an alliance with the Imperial family, and you agreed to give him Galana or give back the millions of gold he gave to you to quell the Khajiiti rebellion in Torval. This was the agreement you swore to honor.”

“I remember no such agreement,” came her father’s voice, “Can you, my liege?”

There was a mumbling noise that Potema took to be her grandfather, the ancient Emperor.

“Perhaps we should take a walk to the Hall of Records, my mind may be going,” the Nord’s voice sounded sarcastic. “I distinctly remember your seal being placed on the agreement before it was locked away. Of course, I may verily be mistaken.”

“We will send a page to the Hall to get the document you refer to,” replied her father’s voice, with the cruel, soothing quality he used whenever he was about to break a promise. Potema knew it well. She replaced the loose stone and hurried out of the ballroom. She knew well how slowly the pages walked, used to running errands for a doddering emperor. She could make it to the Hall of Records in no time at all.

The massive ebony door was locked, of course, but she knew what to do. A year ago, she caught her mother’s Bosmer maid pilfering some jewelry, and in exchange for her silence, forced the young woman to teach her how to pick locks. Potema pulled two pins off her red diamond broach and slid the first into the first lock, holding her hand steady, and memorizing the pattern of tumblers and grooves within the mechanism.

Each lock had a geography of its own.

The lock to the kitchen larder: six free tumblers, a frozen seventh, and a counter bolt. She had broken into that just for fun, but if she had been a poisoner, the whole Imperial household would be dead by now, she thought, smiling.

The lock to her brother Antiochus’ secret stash of Khajiiti pornography: just two free tumblers and a pathetic poisoned quill trap easily dismantled with pressure on the counterweight. That had been a profitable score. It was strange that Antiochus, who seemed to have no shame, proved so easy to blackmail. She was, after all, only twelve, and the differences between the perversions of the cat people and the perversions of the Cyrodiils seemed pretty academic. Still, Antiochus had to give her the diamond broach, which she treasured.

She had never been caught. Not when she broke into the archmage’s study and stole his oldest spellbook. Not when she broke into the guest room of the King of Gilane, and stole his crown the morning before Magnus’s official Welcoming ceremony. It had become too easy to torment her family with these little crimes. But here was a document the Emperor wanted, for a very important meeting. She would get it first.

But this, this was the hardest lock she ever opened. Over and over, she massaged the tumblers, gently pushing aside the forked clamp that snatched at her pins, drumming the counterweights. It nearly took her a half a minute to break through the door to the Hall of Records, where the Elder Scrolls were housed.

The documents were well organized by year, province, and kingdom, and it took Potema only a short while to find the Promise of Marriage between Uriel Septim II, by the Grace of the Gods, Emperor of the Holy Cyrodiilic Empire of Tamriel and his daughter the Princess Galana, and His Majesty King Mantiarco of Solitude. She grabbed her prize and was out of the Hall with the door well-locked before the page was even in sight.

Back in the ball room, she loosened the stone and listened eagerly to the conversation within. For a few minutes, the three men, the Nord, the Emperor, and her father just spoke of the weather and some boring diplomatic details. Then there was the sound of footsteps and a young voice, the page.

“Your Imperial Majesty, I have searched the Hall of Records and cannot find the document you asked for.”

“There, you see,” came Potema’s father’s voice. “I told you it didn’t exist.”

“But I saw it!” The Nord’s voice was furious. “I was there when my liege and the emperor signed it! I was there!”

“I hope you aren’t doubting the word of my father, the sovereign Emperor of all Tamriel, not when there’s now proof that you must have been ... mistaken,” Pelagius’s voice was low, dangerous.

“Of course not,” said the Nord, conceding quickly. “But what will I tell my king? He is to have no connection with the Imperial family, and no gold returned to him, as the agreement – as he and I believed the agreement to be?”

“We don’t want any bad feelings between the kingdom of Solitude and us,” came the Emperor’s voice, rather feeble, but clear enough. “What if we offered King Mantiarco our granddaughter instead?”

Potema felt the chill of the room descend on her.

“The Princess Potema? Is she not too young?” asked the Nord.

“She is thirteen years old,” said her father. “That’s old enough to wed.”

“She would an ideal mate for your king,” said the Emperor. “She is, admittedly, from what I see of her, very shy and innocent, but I’m certain she would quickly grasp the ways of court – she is, after all, a Septim. I think she would be an excellent Queen of Solitude. Not too exciting, but noble.”

“The granddaughter of the Emperor is not as close as his daughter,” said the Nord, rather miserably. “But I don’t see how we can refuse the offer. I will send word to my king.”

“You have our leave,” said the Emperor, and Potema heard the sound of the Nord leaving the stateroom.

Tears streamed down Potema’s eyes. She knew who the King of Solitude was from her studies. Mantiarco. Sixty-two years old, and quite fat. And she knew how far Solitude was, and how cold, in the northernmost clime. Her father and grandfather were abandoning her to the barbaric Nords. The voices in the room continued talking.

“Well-acted, my boy. Now, make sure you burn that document,” said her father.

“My Prince?” asked the page’s querulous voice.

“The agreement between the Emperor and the King of Solitude, you fool. We don’t want its existence known.”

“My Prince, I told the truth. I couldn’t find the document in the Hall of Records. It seems to be missing.”

“By Lorkhan!” roared her father. “Why is everything in this palace always misplaced? Go back to the Hall and keep searching until you find it!”

Potema looked at the document. Millions of gold pieces promised to the kingdom of Solitude in the event of Princess Galana not marrying the king. She could bring it into her father, and perhaps as a reward he would not marry her to Mantiarco. Or perhaps not. She could blackmail her father and the Emperor with it, and make a tidy sum of money. Or she could produce it when she became Queen of Solitude to fill her coffers, and buy anything she wanted. More than a daedric katana, that was for certain.

So many possibilities, Potema thought. And she found herself not bored anymore.

## Book Two

*From the pen of the first century third era sage Montocai:*

3E 82:

A year after the wedding of his 14-year-old granddaughter the Princess Potema to King Mantiarco of the Nordic kingdom of Solitude, the Emperor Uriel Septim II passed on. His son Pelagius Septim II was made emperor, and he faced a greatly depleted treasury, thanks to his father’s poor management.

As the new Queen of Solitude, Potema faced opposition from the old Nordic houses, who viewed her as an outsider. Mantiarco had been widowed, and his former queen was loved. She had left him a son, Prince Bathorgh, who was two years older than his stepmother, and loved her not. But the king loved his queen, and suffered with her through miscarriage after miscarriage, until her 29th year, when she bore him a son.

3E 97:

“You must do something to help the pain!” Potema cried, baring her teeth. The healer Kelmeth immediately thought of a she-wolf in labor, but he put the image from his mind. Her enemies called her the Wolf Queen for certes, but not because of any physical resemblance.

“Your Majesty, there is no injury for me to heal. The pain you feel is natural and helpful for the birth,” he was going to add more words of consolation, but he had to break off to duck the mirror she flung at him.

“I’m not a pignosed peasant girl!” She snarled, “I am the Queen of Solitude, daughter of the Emperor! Summon the daedra! I’ll trade the soul of every last subject of mine for a little comfort!”

“My Lady,” said the healer nervously, drawing the curtains and blotting out the cold morning sun. “It is not wise to make such offers even in jest. The eyes of Oblivion are forever watching for just such a rash interjection.”

“What would you know of Oblivion, healer?” she growled, but her voice was calmer, quieter. The pain had relaxed. “Would you fetch me that mirror I hurled at you?”

“Are you going to throw it again, your Majesty?” said the healer with a taut smile, obeying her.

“Very likely,” she said, looking at her reflection. “And next time I won’t miss. But I do look a fright. Is Lord Vhokken still waiting for me in the hall?”

“Yes, your Majesty.”

“Well, tell him I just need to fix my hair and I’ll be with him. And leave us. I’ll howl for you when the pain returns.”

“Yes, your Majesty.”

A few minutes later, Lord Vhokken was shown into the chamber. He was an enormous bald man whose friends and enemies called Mount Vhokken, and when he spoke it was with the low grumble of thunder. The Queen was one of the very few people Vhokken knew who was not the least bit intimidated by him, and he offered her a smile.

“My queen, how are you feeling?” he asked.

“Damned. But you’re looking like Springtide has come to Mount Vhokken. I take it from your merry disposition that you’ve been made warchief.”

“Only temporarily, while your husband the King investigates whether there is evidence behind the rumors of treason on the part of my predecessor Lord Thone.”

“If you’ve planted it as I’ve instructed, he’ll find it,” Potema smiled, propping herself up in the bed. “Tell me, is Prince Bathorgh still in the city?”

“What a question, your highness,” laughed the mountain. “It’s the Tournament of Stamina today, you know the prince would never miss that. The fellow invents new strategies of self-defense every year to show off during the games. Don’t you recall last year, where he entered the ring unarmored and after twenty minutes of fending off six bladesmen, left the games without a scratch? He dedicated that bout to his late mother, Queen Amodetha.”

“Yes, I recall.”

“He’s no friend to me or you, your highness, but you must give the man his due respect. He moves like lightning. You wouldn’t think it of him, but he always seems to use his awkwardness to his advantage, to throw his opponents off. Some say he learned the style from the orcs to the south. They say he learned from them how to anticipate a foe’s attack by some sort of supernatural power.”

“There’s nothing supernatural about it,” said the Queen, quietly. “He gets it from his father.”

“Mantiarco never moved like that,” Vhokken chuckled.

“I never said he did,” said Potema. Her eyes closed and her teeth gritted together. “The pain’s returning. You must fetch the healer, but first, I must ask you one other thing – has the new summer palace construction begun?”

“I think so, your Highness.”

“Do not think!” she cried, gripping the sheets, biting her lips so a stream of blood dripped down her chin. “Do! Make certain that the construction begins at once, today! Your future, my future, and the future of this child depend on it! Go!”

Four hours later, King Mantiarco entered the room to see his son. His queen smiled weakly as he gave her a kiss on the forehead. When she handed him the child, a tear ran down his face. Another one quickly followed, and then another.

“My Lord,” she said fondly. “I know you’re sentimental, but really!”

“It’s not only the child, though he is beautiful, with all the fair features of his mother,” Mantiarco turned to his wife, sadly, his aged features twisted in agony. “My dear wife, there is trouble at the palace. In truth, this birth is the only thing that keeps this day from being the darkest in my reign.”

“What is it? Something at the tournament?” Potema pulled herself up in bed. “Something with Bathorgh?”

“No, it’s isn’t the tournament, but it does relate to Bathorgh. I shouldn’t worry you at a time like this. You need your rest.”

“My husband, tell me!”

“I wanted to surprise you with a gift after the birth of our child, so I had the old summer palace completely renovated. It’s a beautiful place, or at least it was. I thought you might like it. Truth to tell, it was Lord Vhokken idea. It used to be Amodetha’s favorite place.” Bitterness crept into the king’s voice. “Now I’ve learned why.”

“What have you learned?” asked Potema quietly.

“Amodetha deceived me there, with my trusted warchief, Lord Thone. There were letters between them, the most perverse things you’ve ever read. And that’s not the worst of it.”

“No?”

“The dates on the letters correspond with the time of Bathorgh’s birth. The boy I raised and loved as a son,” Mantiarco’s voice choked up with emotion. “He was Thone’s child, not mine.”

“My darling,” said Potema, almost feeling sorry for the old man. She wrapped her arms around his neck, as he heaved his sobs down on her and their child.

“Henceforth,” he said quietly. “Bathorgh is no longer my heir. He will be banished from the kingdom. This child you have borne me today will grow to rule Solitude.”

“And perhaps more,” said Potema. “He is the Emperor’s grandson as well.”

“We will name him Mantiarco the Second.”

“My darling, I would love that,” said Potema, kissing the king’s tear-streaked face. “But may I suggest Uriel, after my grandfather the Emperor, who brought us together in marriage?”

King Mantiarco smiled at his wife and nodded his head. There was a knock at the door.

“My liege,” said Mount Vhokken. “His highness Prince Bathorgh has finished the tournament and awaits you to present his award. He has successfully withstood attacks by nine archers and the giant scorpion we brought in from Hammerfell. The crowd is roaring his name. They are calling him The Man Who Cannot Be Hit.”

“I will see him,” said King Mantiarco sadly, and left the chamber.

“Oh he can be hit, all right,” said Potema wearily. “But it does take some doing.”

## Book Three

*From the pen of the first century third era sage Montocai:*

3E 98

The Emperor Pelagius Septim II died a few weeks before the end of the year, on the 15th of Evening Star during the festival of North Wind’s Prayer, which was considered a bad omen for the Empire. He had ruled over a difficult seventeen years. In order to fill the bankrupt treasury, Pelagius had dismissed the Elder Council, forcing them to buy back their positions. Several good but poor councilors had been lost. Many say the Emperor had died as a result of being poisoned by a vengeful former Council member.

His children came to attend his funeral and the coronation of the next Emperor. His youngest son Prince Magnus, 19 years of age, arrived from Almalexia, where he had been a councilor to the royal court. 21-year-old Prince Cephorus arrived from Gilane with his Redguard bride, Queen Bianki. Prince Antiochus at 43 years of age, the eldest child and heir presumptive, had been with his father in the Imperial City. The last to appear was his only daughter, Potema, the so-called Wolf Queen of Solitude. Thirty years old and radiantly beautiful, she arrived with a magnificent entourage, accompanied by her husband, the elderly King Mantiarco and her year-old son, Uriel.

All expected Antiochus to assume the throne of the Empire, but no one knew what to expect from the Wolf Queen.

3E 99

“Lord Vhokken has been bringing several men to your sister’s chambers late at night every night this week,” offered the Spymaster. “Perhaps if her husband were made aware –”

“My sister is a devotee of the conqueror gods Reman and Talos, not the love goddess Dibella. She is plotting with those men, not having orgies with them. I’d wager I’ve slept with more men than she has,” laughed Antiochus, and then grew serious. “She’s behind the delay of the council offering me the crown, I know it. Six weeks now. They say they need to update records and prepare for the coronation. I’m the Emperor! Crown me, and to Oblivion with the formalities!”

“Your sister is surely no friend of yours, your majesty, but there are other factors at play. Do not forget how your father treated the Council. It is they who need following, and if need be, strong convincing,” The Spymaster added, with a suggestive stab of his dagger.

“Do so, but keep your eye on the damnable Wolf Queen as well. You know where to find me.”

“At which brothel, your highness?” inquired the Spymaster.

“Today being Fredas, I’ll be at the Cat and Goblin.”

The Spymaster noted in his report that night that Queen Potema had no visitors, for she was dining across the Imperial Garden at the Blue Palace with her mother, the Dowager Empress Quintilla. It was a warm night for wintertide and surprisingly cloudless though the day had been stormy. The saturated ground could not take any more, so the formal, structured gardens looked as if they had been glazed with water. The two women took their wine to the wide balcony to look over the grounds.

“I believe you are trying to sabotage your half-brother’s coronation,” said Quintilla, not looking at her daughter. Potema saw how the years had not so much wrinkled her mother as faded her, like the sun on a stone.

“It’s not true,” said Potema. “But would it bother you very much if it were true?”

“Antiochus is not my son. He was eleven years old when I married your father, and we’ve never been close. I think that being heir presumptive has stunted his growth. He is old enough to have a family with grown children, and yet he spends all his time at debauchery and fornication. He will not make a very good Emperor,” Quintilla sighed and then turned to Potema. “But it is bad for the family for seeds of discontent to be sown. It is easy to divide up into factions, but very difficult to unite again. I fear for the future of the Empire.”

“Those sound like the words – are you, by any chance, dying, mother?”

“I’ve read the omens,” said Quintilla with a faint, ironic smile. “Don’t forget – I was a renowned sorceress in Camlorn. I will dead in a few months time, and then, not a year later, your husband will die. I only regret that I will not live to see your child Uriel assume the throne of Solitude.”

“Have you seen whether –” Potema stopped, not wanting to reveal too many of her plans, even to a dying woman.

“Whether he will be Emperor? Aye, I know the answer to that too, daughter. Don’t fear: you’ll live to see the answer, one way or the other. I have a gift for him when he is of age,” The Dowager Empress removed a necklace with a single great yellow gem from around her neck. “It’s a soul gem, infused with the spirit of a great werewolf your father and I defeated in battle thirty-six years ago. I’ve enchanted it with spells from the School of Illusion so its wearer may charm whoever he choses. An important skill for a king.”

“And an emperor,” said Potema, taking the necklace. “Thank you, mother.”

An hour later, passing the black branches of the sculpted douad shrubs, Potema noticed a dark figure, which vanished into the shadows under the eaves at her approach. She had noticed people following her before: it was one of the hazards of life in the Imperial court. But this man was too close to her chambers. She slipped the necklace around her neck.

“Come out where I can see you,” she commanded.

The man emerged from the shadows. A dark little fellow of middle-age dressed in black-dyed goatskin. His eyes were fixed, frozen, under her spell.

“Who do you work for?”

“Prince Antiochus is my master,” he said in a dead voice. “I am his spy.”

A plan formed. “Is the Prince in his study?”

“No, milady.”

“And you have access?”

“Yes, milady.”

Potema smiled widely. She had him. “Lead the way.”

The next morning, the storm reappeared in all its fury. The pelting on the walls and ceiling was agony to Antiochus, who was discovering that he no longer had his youthful immunity to a late night of hard drinking. He shoved hard against the Argonian wench sharing his bed.

“Make yourself useful and close the window,” he moaned.

No sooner had the window been bolted then there was a knock at the door. It was the Spymaster. He smiled at the Prince and handed him a sheet of paper.

“What is this?” said Antiochus, squinting his eyes. “I must still be drunk. It looks like orcish.”

“I think you will find it useful, your majesty. Your sister is here to see you.”

Antiochus considered getting dressed or sending his bedmate out, but thought better of it. “Show her in. Let her be scandalized.”

If Potema was scandalized, she did not show it. Swathed in orange and silver silk, she entered the room with a triumphant smile, followed by the man-mountain Lord Vhokken.

“Dear brother, I spoke to my mother last night, and she advised me very wisely. She said I should not battle with you in public, for the good of our family and the Empire. Therefore,” she said, producing from the folds of her robe a piece of paper. “I am offering you a choice.”

“A choice?” said Antiochus, returning her smile. “That does sound friendly.”

“Abdicate your rights to the Imperial throne voluntarily, and there is no need for me to show the Council this,” Potema said, handing her brother the letter. “It is a letter with your seal on it, saying that you knew that your father was not Pelagius Septim II, but the royal steward Fondoukth. Now, before you deny writing the letter, you cannot deny the rumors, nor that the Imperial Council will believe that your father, the old fool, was quite capable of being cuckolded. Whether it’s true or not, or whether the letter is a forgery or not, the scandal of it would ruin your chances of being the Emperor.”

Antiochus’s face had gone white with fury.

“Don’t fear, brother,” said Potema, taking back the letter from his shaking hands. “I will see to it that you have a very comfortable life, and all the whores your heart, or any other organ, desires.”

Suddenly Antiochus laughed. He looked over at his Spymaster and winked. “I remember when you broke into my stash of Khajiiti erotica and blackmailed me. That was close to twenty years ago. We’ve got better locks now, you must have noticed. It must have killed you that you couldn’t use your own skills to get what you wanted.”

Potema merely smiled. It didn’t matter. She had him.

“You must have charmed my servant here into getting you into my study to use my seal,” Antiochus smirked. “A spell, perhaps, from your mother, the witch?”

Potema continued to smile. Her brother was cleverer than she thought.

“Did you know that Charm spells, even powerful ones, only last so long? Of course, you didn’t. You never were one for magic. Let me tell you, a generous salary is a stronger motivation for keeping a servant in the long run, sister,” Antiochus took out his own sheet of paper. “Now I have a choice for you.”

“What is that?” said Potema, her smile faltering.

“It looks like nonsense, but if you know what you’re looking for, it’s very clear. It’s a practice sheet – your handwriting attempting to look like my handwriting. It’s a good gift you have. I wonder if you haven’t done this before, imitating another person’s handwriting. I understand a letter was found from your husband’s dead wife saying that his first son was a bastard. I wonder if you wrote that letter. I wonder if I showed this evidence of your gift to your husband whether he would believe you wrote that letter. In the future, dear Wolf Queen, don’t lay the same trap twice.”

Potema shook her head, furious, unable to speak.

“Give me your forgery and go take a walk in the rain. And then, later today, unhatch whatever other plots you have to keep me from the throne.” Antiochus fixed his eyes on Potema’s. “I will be Emperor, Wolf Queen. Now go.”

Potema handed her brother the letter and left the room. For a few moments, out in the hallway, she said nothing. She merely glared at the slivers of rainwater dripping down the marble wall from a tiny, unseen crack.

“Yes, you will, brother,” she said. “But not for very long.”

## Book Four

*From the pen of the first century third era sage Montocai:*

3E 109:

Ten years after being crowned Emperor of Tamriel, Antiochus Septim had impressed his subjects with little but the enormity of his lust for carnal pleasures. By his second wife, Gysilla, he had a daughter in the year 104, who he named Kintyra, after his great-great-great grandaunt, the Empress. Enormously fat and marked by every venereal disease known to the Healers, Antiochus spent little time on politics. His siblings, by marked contrast, excelled in this field. Magnus had married Hellena, the Cyrodiil Queen of Lilmoth – the Argonian priest-king having been executed – and was representing the Imperial interests in Black Marsh admirably. Cephorus and his wife Bianki were ruling the Hammerfell kingdom of Gilane with a healthy brood of children. But no one was more politically active than Potema, the Wolf-Queen of the Skyrim kingdom of Solitude.

Nine years after the death of her husband, King Mantiarco, Potema still ruled as regent for her young son, Uriel. Their court had become very fashionable, particularly for rulers who had a grudge to bear against the Emperor. All the kings of Skyrim ', 0);
UPDATE tomes SET body = body || 'visited Castle Solitude regularly, and over the years, emissaries from the lands of Morrowind and High Rock did as well. Some guests came from even farther away.

3E 110:

Potema stood at the harbor and watched the boat from Pyandonea arrive. Against the gray, breaking waves where she had seen so many vessels of Tamrielic manufacture, it looked less than exotic. Insectoid, certainly, with its membranous sails and rugged chitin hull, but she had seen similar if not identical seacraft in Morrowind. No, if not for the flag which was markedly alien, she would not have picked out the ship from others in the harbor. As the salty mist ballooned around her, she held out her hand in welcome to the visitors from another island empire.

The men aboard were not merely pale, they were entirely colorless, as if their flesh were made of some white limpid jelly, but she had been forewarned. At the arrival of the King and his translator, she looked directly into their blank eyes and offered her hand. The King made noises.

“His Great Majesty, King Orgnum,” said the translator, haltingly. “Expresses his delight at your beauty. He thanks you for giving him refuge from these dangerous seas.”

“You speak Cyrodilic very well,” said Potema.

“I am fluent in the languages of four continents,” said the translator. “I can speak to the denizens of my own country Pyandonea, as well as those of Atmora, Akavir, and here, in Tamriel. Yours is the easiest, actually. I was looking forward to this voyage.”

“Please tell his highness that he is welcome here, and that I am entirely at his disposal,” said Potema, smiling. Then she added, “You understand the context? That I am just being polite?”

“Of course,” said the translator, and then made several noises at the King, which the King reacted to with a smile. While they conversed, Potema looked up the dock and saw the now familiar gray cloaks watching her while they spoke with Levlet, Antiochus’s man. The Psijic Order from the Summerset Isle. Very bothersome.

“My diplomatic emissary Lord Vhokken will show you to your rooms,” said Potema. “Unfortunately, I have some other guests as well who require my attention. I hope your great majesty understands.”

His Great Majesty King Orgnum did understand, and Potema made arrangements to dine with the Pyandoneans that evening. Meeting with the Psijic Order required all of her concentration. She dressed in her simplest black and gold robe and went to her stateroom to prepare. Her son, Uriel, was on the throne, playing with his pet joughat.

“Good morning, mom.”

“Good morning, darling,” said Potema, lifting her son in the air with feigned stain. “Talos, but you’re heavy. I don’t think I’ve ever carried such a heavy ten-year-old.”

“That’s probably because I’m eleven,” said Uriel, perfectly aware of his mother’s tricks. “And you’re going to say that as an eleven-year-old, I should probably be with my tutor.”

“I was fanatical about studying at your age,” said Potema.

“I am king,” said Uriel petulantly.

“But don’t be satisfied with that,” said Potema. “By all rights, you should be emperor already, you understand that, don’t you?”

Uriel nodded his head. Potema took a moment to marvel at his likeness to the portraits of Tiber Septim. The same ruthless brow and powerful chin. When he was older and lost his baby fat, he’d be a splitting image of his great great great great great granduncle. Behind her, she heard the door opening and an usher bringing in several gray cloaks. She stiffened slightly, and Uriel, on cue, jumped down from the throne and left the stateroom, pausing to greet the most important of the Psijics.

“Good Morning, Master Iachesis,” he said, enunciating each syllable with a regal accent that made Potema’s heart soar. “I hope your accommodations at Castle Solitude meet with your approval.”

“They do, King Uriel, thank you,” said Iachesis, delighted and charmed.

Iachesis and his Psijics entered the chamber and the door was shut behind them. Potema sat only for a moment on the throne before stepping off the dais and greeting her guests.

“I am so sorry to have kept you waiting,” said Potema. “To think that you sailed all the way from the Summerset Isles and I should keep you waiting any longer. You must forgive me.”

“It’s not all that long a voyage,” said one of the gray cloaks, angrily. “It isn’t as if we sailed all the way from Pyandonea.”

“Ah. You’ve seen my most recent guests, King Orgnum and his retinue,” said Potema breezily. “I suppose you think it unusual, me entertaining them, as we all know the Pyandoneans mean to invade Tamriel. You are, I take it, as neutral in this as you are in all political matters?”

“Of course,” said Iachesis proudly. “We have nothing to gain or lose by the invasion. The Psijic Order preceded the organization of Tamriel under the Septim Dynasty and we shall survive under any political regime.”

“Rather like a flea on whatever mongrel happens along, are you?” said Potema, narrowing her eyes. “Don’t overestimate your importance, Iachesis. Your order’s child, the Mages Guild, has twice the power you have, and they are entirely on my side. We are in the process of making an agreement with King Orgnum. When the Pyandoneans take over and I am in my proper place as Empress of this continent, then you shall know your proper place in the order of things.”

With a majestic stride, Potema left the stateroom, leaving the grey cloaks to look from one to the other.

“We must speak to Lord Levlet,” said one of the grey cloaks.

“Yes,” said Iachesis. “Perhaps we should.”

Levlet was quickly found at his usual place at the Moon and Nausea tavern. As the three grey cloaks entered, led by Iachesis, the smoke and the noise seemed to die in their path. Even the smell of tobacco and flin dissipated in their wake. He rose and then escorted them to a small room upstairs.

“You’ve reconsidered,” said Levlet with a broad smile.

“Your Emperor,” said Iachesis, and then corrected himself, “Our Emperor originally asked for our support in defending the west coast of Tamriel from the Pyandonean fleet in return for twelve million gold pieces. We offered our services at fifty. Upon reflection on the dangers that a Pyandonean invasion would have, we accept his earlier offer.”

“The Mages Guild has generously – “

“Perhaps for as low ten million gold pieces,” said Iachesis quickly.

Over the course of dinner, Potema promised King Orgnum through the interpreter, to lead an insurrection against her brother. She was delighted to discover that her capacity for lying worked in many different cultures. Potema shared her bed that night with King Orgnum, as it seemed the polite and diplomatic thing to do. As it turned out, he was one of the better lovers she had ever had. He gave her some herbs before beginning that made her feel as if she was floating on the surface of time, conscious only of the gestures of love after she had found herself making them. She felt herself like the cooling mist, quenching the fire of his lust over and over and over again. In the morning, when he kissed her on the cheek, and said with his bald white eyes that he was leaving her, she felt a stab of regret.

The ship left harbor that morning, en route to the Summerset Isles and the imminent invasions. She waved them off to sea as she footsteps behind her. It was Levlet.

“They will do it for eight million, your highness” he said.

“Thank Mara,” said Potema. “I need more time for an insurrection. Pay them from my treasury, and then go to the Imperial City and get the twelve million from Antiochus. We should make a good profit from this game, and you, of course, will have your share.”

Three months later, Potema heard that the fleet of the Pyandoneans had been utterly destroyed by a storm that had appeared suddenly off the Isle of Artaeum. The home port of the Psijic Order. King Orgnum and all of his ships had been utterly annihilated.

“Sometimes making people hate you,” she said, holding her son Uriel close, “Is how you make a profit .”

## Book Five

*From the pen of Inzolicus, Second Century Sage and Student of Montocai:*

3E 119:

For twenty-one years, The Emperor Antiochus Septim ruled Tamriel, and proved an able leader despite his moral laxity. His greatest victory was in the War of the Isle in the year 110, when the Imperial fleet and the royal navies of Summerset Isle, together with the magical powers of the Psijic Order, succeeded in destroying the Pyandonean invading armada. His siblings, King Magnus of Lilmoth, King Cephorus of Gilane, and Potema, the Wolf Queen of Solitude, ruled well and relations between the Empire and the kingdoms of Tamriel were much improved. Still, centuries of neglect had not repaired all the scars that existed between the Empire and the kings of High Rock and Skyrim.

During a rare visitation from his sister and nephew Uriel, Antiochus, who had suffered from several illnesses over his reign, lapsed into a coma. For months, he lingered in between life and death while the Elder Council prepared for the ascension of his fifteen-year-old daughter Kintyra to the throne.

3E 120:

“Mother, I can’t marry Kintyra,” said Uriel, more amused by the suggestion than offended. “She’s my first cousin. And besides, I believe she’s engaged to one of the lords of council, Modellus.”

“You’re so squeamish. There’s a time and a place for propriety,” said Potema. “But you’re correct at any rate about Modellus, and we shouldn’t offend the Elder Council at this critical juncture. How do you feel about Princess Rakma? You spent a good deal of time in her company in Farrun.”

“She’s all right,” said Uriel. “Don’t tell me you want to hear all the dirty details.”

“Please spare me your study of her anatomy,” Potema grimaced. “But would you marry her?”

“I suppose so.”

“Very good. I’ll make the arrangements then,” Potema made a note for herself before continuing. “King Lleromo has been a difficult ally to keep, and a political marriage should keep Farrun on our side. Should we need them. When is the funeral?”

“What funeral?” asked Uriel. “You mean for Uncle Antiochus?”

“Of course,” sighed Potema. “Anyone else of note die recently?”

“There were a bunch of little Redguard children running through the halls, so I guess Cephorus has arrived. Magnus arrived at court yesterday, so it ought to be any day now.”

“It’s time to address the Council then,” said Potema, smiling.

She dressed in black, not her usual colorful ensembles. It was important to look the part of the grieving sister. Regarding herself in the mirror, she felt that she looked all of her fifty-three years. A shock of silver wound its way through her auburn hair. The long, cold, dry winters in northern Skyrim had created a map of wrinkles, thin as a spiderweb, all across her face. Still, she knew that when she smiled, she could win hearts, and when she frowned, she could inspire fear. It was enough for her purposes.

Potema’s speech to the Elder Council is perhaps helpful to students of public speaking.

She began with flattery and self-abasement: “My most august and wise friends, members of the Elder Council, I am but a provincial queen, and I can only assume to bring to issue what you yourselves must have already pondered.”

She continued on to praise the late Emperor, who had been a popular ruler, despite his flaws: “He was a true Septim and a great warrior, destroying – with your counsel – the near invincible armada of Pyandonea.”

But little time was wasted, before she came to her point: “The Empress Gysilla unfortunately did nothing to temper my brother’s lustful spirits. In point of fact, no whore in the slums of the city spread out on more beds than she. Had she attended to her duties in the Imperial bedchamber more faithfully, we would have a true heir to the Empire, not the halfwit, milksop bastards who call themselves the Emperor’s children. The girl called Kintyra is popularly believed to be the daughter of Gysilla and the Captain of the Guard. It may be that she is the daughter of Gysilla and the boy who cleans the cistern. We can never know for certain. Not as certainly as we can know the lineage of my son, Uriel. The eldest true son of the Septim Dynasty. My lords, the princes of the Empire will not stand for a bastard on the throne, that I can assure you.”

She ended mildly, but with a call to action: “Posterity will judge you. You know what must be done.”

That evening, Potema entertained her brothers and their wives in the Map Room, her favorite of the Imperial dining chambers. The walls were splashed with bright, if fading representations of the Empire and all the known lands beyond, Atmora, Yokunda, Akavir, Pyandonea, Thras. Overhead the great glass domed ceiling, wet with rain, displayed distorted images of the stars overhead. Lightning flashed every other minute, casting strange phantom shadows on the walls.

“When will you speak to the Council?” asked Potema as dinner was served.

“I don’t know if I will,” said Magnus. “I don’t believe I have anything to say.”

“I’ll speak to them when they announce the coronation of Kintyra,” said Cephorus. “Merely as a formality to show my support and the support of Hammerfell.”

“You can speak for all of Hammerfell?” asked Potema, with a teasing smile. “The Redguards must love you very much.”

“We have a unique relationship with the Empire in Hammerfell,” said Cephorus’s wife, Bianki. “Since the treaty of Stros M’kai, it’s been understood that we are part of the Empire, but not a subject.”

“I understand you’ve already spoken to the Council,” said Magnus’s wife, Hellena, pointedly. She was a diplomat by nature, but as the Cyrodilic ruler of an Argonian kingdom, she knew how to recognize and confront adversity.

“Yes, I have,” said Potema, pausing to savor a slice of braised jalfbird. “I gave them a short speech about the coronation this afternoon.”

“Our sister is an excellent public speaker,” said Cephorus.

“You’re too kind,” said Potema, laughing. “I do many things better than speaking.”

“Such as?” asked Bianki, smiling.

“Might I ask what you said in your speech?” asked Magnus, suspiciously.

There was a knock on the chamber door. The head steward whispered something to Potema, who smiled in response and rose from the table.

“I told the Council that I would give my full support to the coronation, provided they proceed with wisdom. What could be sinister about that?” Potema said, and took her glass of wine with her to the door. “If you’ll pardon me, my niece Kintyra wishes to have a word with me.”

Kintyra stood in the hall with the Imperial Guard. She was but a child, but on reflection, Potema realized that at her age, she was already married two years to Mantiarco. There was a similarity, to be certain. Potema could see Kintyra as the young queen, with dark eyes and pallid skin smooth and resolute like marble. Anger flashed momentarily in Kintyra’s eyes on seeing her aunt, but emotion left her, replaced with calm Imperial presence.

“Queen Potema,” she said serenely. “I have been informed that my coronation will take place in two days time. Your presence at the ceremony will not be welcome. I have already given orders to your servants to have your belongings packed, and an escort will be accompanying you back to your kingdom tonight. That is all. Goodbye, aunt.”

Potema began to reply, but Kintyra and her guard turned and moved back down the corridor to the stateroom. The Wolf Queen watched them go, and then reentered the Map Room.

“Sister-in-Law,” said Potema, addressing Bianki with deep malevolence. “You asked what I do better than speaking? The answer is: war.”

## Book Six

*From the pen of Inzolicus, Second Century Sage:*

3E 120:

The fifteen-year-old Empress Kintyra Septim II, daughter of Antiochus, was coroneted on the 3rd day of First Seed. Her uncles Magnus, King of Lilmoth, and Cephorus, King of Gilane, were in attendance, but her aunt, Potema, the Wolf Queen of Solitude, had been banished from the court. Once back in her kingdom, Queen Potema began assembling the rebellion, which was to be known as the War of the Red Diamond. All the allies she had made over the years of disgruntled kings and nobles joined forces with her against the new Empress.

The first early strikes against the Empire were entirely successful. Throughout Skyrim and northern High Rock, the Imperial army found themselves under attack. Potema and her forces washed over Tamriel like a plague, inciting riots and insurrections everywhere they touched. In the autumn of the year, the loyal Duke of Glenpoint on the coast of High Rock sent an urgent request for reinforcements from the Imperial Army, and Kintyra, to inspire the resistance to the Wolf Queen, led the army herself.

3E 121:

“We don’t know where they are,” said the Duke, deeply embarrassed. “I’ve sent scouts out all over the countryside. I can only assume that they’ve retreated up north upon hearing of your army’s arrival.”

“I hate to say it, but I was hoping for a battle,” said Kintyra. “I’d like to put my aunt’s head on a spike and parade it around the Empire. Her son Uriel and his army are right on the border to the Imperial Province, mocking me. How are they able to be so successful? Are they just that good in battle or do my subjects truly hate me?”

She was tired after many months of struggling through the mud of autumn and winter. Crossing the Dragontail Mountains, her army nearly marched into an ambush. A blizzard snap in the normally temperate Barony of Dwynnen was so unexpected and severe that it must certainly have been cast by one of Potema’s wizard allies. Everywhere she turned, she felt her aunt’s touch. And now, her chance of facing the Wolf Queen at last had been thwarted. It was almost too much to bear.

“It is fear, pure and simple,” said the Duke. “That is her greatest weapon.”

“I need to ask,” said Kintyra, hoping that by sheer will she could keep her voice from revealing any of the fear the Duke spoke of. “You’ve seen the army. Is it true that she has summoned a force of undead warriors to do her bidding?”

“No, as a matter of fact, it’s not true, but she certainly fosters that rumor. Her army attacks at night, partly for strategic reasons, and partly to advance fears like that. She has, so far as I know, no supernatural aid other than the standard battlemages and nightblades of any modern army.”

“Always at night,” said Kintyra thoughtfully. “I suppose that’s to disguise their numbers.”

“And to move her troops into position before we’re aware of them” added the Duke. “She’s the master of the sneak attack. When you hear a march to the east, you can be certain she’s already on top of you from the south. But listen, we’ll discuss this all tomorrow morning. I’ve prepared the castle’s best rooms for you and your men.”

Kintyra sat in her tower suite and by the light of the moon and a single tallow candle, she penned a letter to her husband-to-be, Lord Modellus, back in the Imperial City. She hoped to be married to him in the summer at the Blue Palace her grandmother Quintilla had loved so much, but the war may not permit it. As she wrote, she gazed out the window at the courtyard below and the haunted, leafless trees of winter. Two of her guards stood on the battlements, several feet away from one another. Just like Modellus and Kintyra, she thought, and proceeded to expound on the metaphor in her letter.

A knock on the door interrupted her poetry.

“A letter, your majesty, from Lord Modellus,” said the young courier, handing the note to her.

It was short, and she read it quickly before the courier had a chance to retire. “I’m confused by something. When did he write this?”

“One week ago,” said the courier. “He said it was urgent that I make it here as quickly as possible while he mobilized the army. I imagine they’ve left the City already.”

Kintyra dismissed the courier. Modellus said that he had received a letter from her, urgently calling for reinforcements to the battle at Glenpoint. But there was no battle at Glenpoint, and she had only just arrived today. Then who wrote the letter in her handwriting, and why would they want Modellus to bring a second army out of the Imperial City into High Rock?

Feeling a chill from the night air at the window, Kintyra went to shut the latch. The two guards on the battlements were gone. She leaned over at the sound of a muffled struggle behind one of the barren trees, and did not hear the door open.

When she turned, she saw Queen Potema and Mentin, Duke of Glenpoint, in the room with a host of guards.

“You move quietly, aunt,” she said after a moment’s pause. She turned to the Duke. “What turned you against your loyalty to the Empire? Fear?”

“And gold,” said the Duke simply.

“What happened to my army?” asked Kintyra, trying to look Potema steadily in the face. “Is the battle over so soon?”

“All your men are dead,” smiled Potema. “But there was no battle here. Merely quiet and efficient assassination. There will be battles ahead, against Modellus in the Dragontail Mountains and against the remnants of the Imperial Army in the City. I’ll send you regular updates on the progress of the war.”

“So I am to be kept here as your hostage?” asked Kintyra, flatly, suddenly aware of the solidity of the stones and the great height of her tower room. “Damn you, look at me! I am your Empress!”

“Think of it this way, I’m taking you from being a fifth rate ruler to a first rate martyr,” said Potema with a wink. “But I understand if you don’t want to thank me for that.”

## Book Seven

*From the pen of Inzolicus, Second Century Sage:*

3E 125:

The exact date of the Empress Kintyra Septim II’s execution in the tower at Glenpoint Castle is open to some speculation. Some believe she was slain shortly after her imprisonment in the 121st year, while others maintain that she was likely kept alive as a hostage until shortly before her uncle Cephorus, King of Gilane, reconquered western High Rock in the summer of the 125th year. The certainty of Kintyra’s demise rallied many against the Wolf Queen Potema and her son, who had been crowned Emperor Uriel Septim III four years previously when he invaded the under-guarded Imperial City.

Cephorus concentrated his army on the war in High Rock, while his brother Magnus, King of Lilmoth, brought his Argonian troops through loyal Morrowind and into Skyrim to fight in Potema’s home province. The reptilian troops fought well in the summer months, but during the winter, they retired south to regroup and attack again when the weather was warm. At this stalemate, the War lasted out two more years.

Also, in the 125th year, Magnus’s wife Hellena gave birth to their first child, a boy who they named Pelagius, after the Emperor who fathered Magnus, Cephorus, the late Emperor Antiochus, and the dread Wolf Queen of Solitude.

3E 127:

Potema sat on soft silk cushions in the warm grass in front of her tent and watched the sun rise over the dark woods on the other side of the meadow. It was a peculiarly vibrant morning, typical of Skyrim summertide. The high chirrup of insects buzzed all around her and the sky surged with thousands of fallowing birds, rolling over one another and forming a multitude of patterns. Nature was unaware of the war coming to Falconstar, she surmised.

“Your highness, a message from the army in Hammerfell,” said one of her maids, bringing in a courier. He was breathing hard, stained with sweat and mud. Evidence of a long, fast ride over many, many miles.

“My queen,” said the courier, looking to the ground. “I bring grave news of your son, the Emperor. He met your brother King Cephorus’s army in Hammerfell in the countryside of Ichidag and there did battle. You would be proud, for he fought well, but in the end, the Imperial army was defeated and your son, our Emperor, was captured. King Cephorus is bringing him to Gilane.”

Potema listened to the news, scowling. “That clumsy fool,” she said at last.

Potema stood up and strolled into camp, where the men were arming themselves, preparing for battle. Long ago, the soldiers understood that their lady did not stand on ceremony, and she would prefer that they work rather than salute her. Lord Vhokken was ahead of her, already meeting with the commander of the battlemages, discussing last minute strategy.

“My queen,” said the courier, who had been following her. “What are you going to do?”

“I’m going to win this battle with Magnus, despite his superior position holding the ruins of Kogmenthist Castle,” said Potema. “And then when I know what Cephorus means to do with the Emperor, I’ll respond accordingly. If there’s a ransom to be paid, I’ll pay it; if there’s a prison exchange needed, so be it. Now, please, bath yourself and rest, and try not to get in the way of the war.”

“It’s not an ideal scenario,” said Lord Vhokken when Potema had entered the commander’s tent. “If we attack the castle from the west, we’ll be running directly into the fire from their mages and archers. If we come from the east, we’ll be going through swamps, and the Argonians do better in that type of environment than we do. A lot better.”

“What about the north and south? Just hills, correct?”

“Very steep hills, your highness,” said the commander. “We should post bowmen there, but we’ll be too vulnerable putting out the majority of our force.”

“So it’s the swamp,” said Potema, and added, pragmatically. “Unless we withdraw and wait for them to come out before fighting.”

“If we wait, Cephorus will have his army here from High Rock, and we’ll be trapped between the two of them,” said Lord Vhokken. “Not a preferable situation.”

“I’ll talk to the troops,” said the commander. “Try to prepare them for the swamp attack.”

“No,” said Potema. “I’ll speak to them.”

In full battlegear, the soldiers gathered in the center of camp. They were a motley collection of men and women, Cyrodiils, Nords, Bretons, and Dunmer, youngbloods and old veterans, the sons and daughters of nobles, shopkeepers, serfs, priests, prostitutes, farmers, academics, adventurers. All of them under the banner of the Red Diamond, the symbol of the Imperial Family of Tamriel.

“My children,” Potema said, her voice ringing out, hanging in the still morning mist. “We have fought in many battles together, over mountaintops and beach heads, through forests and deserts. I have seen great acts of valor from each one of you, which does my heart proud. I have also seen dirty fighting, backstabbing, cruel and wanton feats of savagery, which pleases me equally well. For you are all warriors.”

Warming to her theme, Potema walked the line from soldier to soldier, looking each one in the eye: “War is in your blood, in your brain, in your muscles, in everything you think and everything you do. When this war is over, when the forces are vanquished that seek to deny the throne to the true emperor, Uriel Septim III, you may cease to be warriors. You may choose to return to your lives before the war, to your farms and your cities, and show off your scars and tell tales of the deeds you did this day to your wondering neighbors. But on this day, make no mistake, you are warriors. You are war.”

She could see her words were working. All around her, bloodshot eyes were focusing on the slaughter to come, arms tensing around weapons. She continued in her loudest cry, “And you will move through the swamplands, like an unstoppable power from the blackest part of Oblivion, and you will rip the scales from the reptilian things in Kogmenthist Castle. You are warriors, and you need not only fight, you must win. You must win!”

The soldiers roared in response, shocking the birds from the trees all around the camp.

From a vantage point on the hills to the south, Potema and Lord Vhokken had excellent views of the battle as it raged. It looked like two swarms of two colors of insect moving back and forth over a clump of dirt which was the castle ruins. Occasionally, a burst of flame or a cloud of acid from one of the mages would flicker over the battle arresting their attention, but hour after hour, the fighting seemed like nothing but chaos.

“A rider approaches,” said Lord Vhokken, breaking the silence.

The young Redguard woman was wearing the crest of Gilane, but carried a white flag. Potema allowed her to approach. Like the courier from the morning, the rider was well travel-worn.

“Your Highness,” she said, out of breath. “I have been sent from your brother, my lord King Cephorus, to bring you dire news. Your son Uriel was captured in Ichidag on the field in battle and from there transported to Gilane.”

“I know all this,” said Potema scornfully. “I have couriers of my own. You can tell your master that after I’ve won this battle, I’ll pay whatever ransom or exchange –”

“Your Highness, an angry crowd met the caravan your son was in before it made it to Gilane,” the rider said quickly, “Your son is dead. He had been burned to death within his carriage. He is dead.”

Potema turned from the young woman and looked down at the battle. Her soldiers were going to win. Magnus’s army was in retreat.

“One other item of news, your highness,” said the rider. “King Cephorus is being proclaimed Emperor.”

Potema did not look at the woman. Her army was celebrating their victory.

## Book Eight

*From the pen of Inzolicus, Second Century Sage:*

3E 127:

Following the Battle of Ichidag, the Emperor Uriel Septim III was captured and, before he was able to be brought to his uncle’s castle in the Hammerfell kingdom of Gilane, he met his death at the hands of an angry mob. This uncle, Cephorus, was thereafter proclaimed emperor and rode to the Imperial City. The troops formerly loyal to Emperor Uriel and his mother, the Wolf Queen Potema, pledged themselves to the new Emperor. In return for their support, the nobility of Skyrim, High Rock, Hammerfell, the Summerset Isle, Valenwood, Black Marsh, and Morrowind demanded and received a new level of autonomy and indepe' WHERE id = 10;
UPDATE tomes SET body = body || 'ndence from the Empire. The War of the Red Diamond was at an end.

Potema continued to fight a losing battle, her area of influence dwindling and dwindling until only her kingdom of Solitude remained in her power. She summoned daedra to fight for her, had her necromancers resurrect her fallen enemies as undead warriors, and mounted attack after attack on the forces of her brothers, the Emperor Cephorus Septim I and King Magnus of Lilmoth. Her allies began leaving her as her madness grew, and her only companions were the zombies and skeletons she had amassed over the years. The kingdom of Solitude became a land of death. Stories of the ancient Wolf Queen being waited on by rotting skeletal chambermaids and holding war plans with vampiric generals terrified her subjects.

3E 137:

Magnus opened up the small window in his room. For the first time in weeks, he heard the sounds of a city: carts squeaking, horses clopping over the cobblestones, and somewhere a child laughing. He smiled as he returned to his bedside to wash his face and finish dressing. There was a distinctive knock on the door.

“Come in, Pel,” he said.

Pelagius bounded into the room. It was obvious that he had been up for hours. Magnus marveled at his energy, and wondered how much longer battles would last if they were run by twelve-year-old boys.

“Did you see outside yet?” Pelagius asked. “All the townspeople have come back! There are shops, and a Mages Guild, and down by the harbor, I saw a hundred shops come in from all over the place!”

“They don’t have to be afraid anymore. We’ve taken care of all the zombies and ghosts that used to be their neighbors, and they know it’s safe to come back.”

“Is Uncle Cephorus going to turn into a zombie when he dies?” asked Pelagius.

“I wouldn’t put that past him,” laughed Magnus. “Why do you ask?”

“I heard some people saying that he was old and sick,” said Pelagius.

“He’s not that old,” said Magnus. “He’s sixty years old. That’s just two years older than I.”

“And how old is Aunt Potema?” asked Pelagius.

“Seventy,” said Magnus. “And yes, that is old. Any more questions will have to wait. I have to go meet with the commander now, but we can talk at supper. You can make yourself busy, and not get into any trouble?”

“Yes, sir,” said Pelagius. He understood that his father had to continue to hold siege on aunt Potema’s castle. After they took it over and locked her up, they would move out of the inn and into the castle. Pelagius was not looking forward to that. The whole town had a funny, sweet, dead smell, but he could not get even as close as the castle moat without gagging from the stench. They could dump a million flowers on the place and it wouldn’t make any difference at all.

He walked through the city for hours, buying some food and then some ribbons for his sister and mother back in Lilmoth. He thought about who else he needed to buy gifts for and was stumped. All his cousins, the children of Uncle Cephorus, Uncle Antiochus, and Aunt Potema, had died during the war, some of them in battle and some of them during the famines because so many crops had been burned. Aunt Bianki had died last year. There was only he, his mother, his sister, his father, and his uncle the Emperor left. And Aunt Potema. But she didn’t really count.

When he came upon the Mages Guild earlier that morning, he had decided not to go in. Those places always spooked him with their strange smoke and crystals and old books. This time, it occurred to Pelagius that he might buy a gift for Uncle Cephorus. A souvenir of Solitude’s Mages Guild.

An old woman was having trouble with the front door, so Pelagius opened it for her.

“Thank you,” she said.

She was easily the oldest thing he had ever seen. Her face looked like an old rotted apple framed with a wild whirl of bright white hair. He instinctively moved away from her gnarled talon when she started to pat him on the head. But there was a gem around her neck that immediately fascinated him. It was a single bright yellow jewel, but it almost looked there was something trapped within. When the light hit it from the candles, it brought out the form of a four-legged beast, pacing.

“It’s a soul gem,” she said. “Infused with the spirit of a great demon werewolf. It was enchanted long, long ago with the power to charm people, but I’ve been thinking about giving it another spell. Perhaps something from the School of Alteration like Lock or Shield.” She paused and looked at the boy carefully with yellowed, rheumy eyes. “You look familiar to me, boy. What’s your name?”

“Pelagius,” he said. He normally would have said “Prince Pelagius,” but he was told not to draw attention to himself while in town.

“I used to know someone named Pelagius,” the old woman said, and slowly smiled. “Are you here alone, Pelagius?”

“My father is... with the army, storming the castle. But he’ll be back when the walls have been breached.”

“Which I dare say won’t take too much longer,” sighed the old woman. “Nothing, no matter how well built, tends to last. Are you buying something in the Mages Guild?”

“I wanted to buy a gift for my uncle,” said Pelagius. “But I don’t know if I have enough gold.”

The old woman left the boy to look over the wares while she went to the Guild enchanter. He was a young Nord, ambitious, and new to the kingdom of Solitude. It took little persuasion and a lot of gold to convince him to remove the charm spell from the soul gem and imbue it with a powerful curse, a slow poison that would drain wisdom from its wearer year by year until he or she lost all reason. She also purchased a cheap ring of fire resistance.

“For your kindness to an old woman, I’ve bought you these,” she said, giving the boy the necklace and the ring. “You can give the ring to your uncle, and tell him it has been enchanted with a levitation spell, so if ever he needs to leap from high places, it will protect him. The soulgem is for you.”

“Thank you,” said the boy. “But this is too kind of you.”

“Kindness has nothing to do with it,” she answered, quite honestly. “You see, I was in the Hall of Records at the Imperial Palace once or twice, and I read about you in the foretellings of the Elder Scrolls. You will be Emperor one day, my boy, the Emperor Pelagius Septim III, and with this soul gem to guide you, posterity will always remember you and your deeds.”

With those words, the old woman disappeared down an alley behind the Mages Guild. Pelagius looked after her, but he did not think to search behind a heap of stones. If he had, he would have found a tunnel under the city into the very heart of Castle Solitude. And if he had found his way there, he would have found, past the shambling undead and the moldering remains of a once grand palace, the bedroom of the queen.

In that bedroom, he would find the Wolf Queen of Solitude in repose, listening to the sounds of her castle collapsing. And he would see a toothless grin growing on her face as she breathed her last.

*From the pen of Inzolicus, Second Century Sage:*

3E 137:

Potema Septim died after a month long siege on her castle. While she lived, she had been the Wolf Queen of Solitude, Daughter of the Emperor Pelagius II, Wife of King Mantiarco, Aunt of the Empress Kintyra II, Mother of Emperor Uriel III, and Sister of the Emperors Antiochus and Cephorus. At her death, Magnus appointed his son, Pelagius, as the titular head of Solitude, under guidance from the royal council.

3E 140:

The Emperor Cephorus Septim died after falling from his horse. His brother was proclaimed the Emperor Magnus Septim.

3E 141:

Pelagius, King of Solitude, is recorded as “occasionally eccentric” in the Imperial Annals. He marries Katarish, Duchess of Vvardenfell.

3E 145:

The Emperor Magnus Septim dies. His son, who will be known as Pelagius the Mad, is coronated.' WHERE id = 10;

-- Cross-references, derived from the titles named in these bodies.
INSERT INTO citations (from_tome, cites_call_number) VALUES (2, 'AR-I-010');
INSERT INTO citations (from_tome, cites_call_number) VALUES (4, 'AR-I-001');
INSERT INTO citations (from_tome, cites_call_number) VALUES (6, 'AR-II-004');
INSERT INTO citations (from_tome, cites_call_number) VALUES (8, 'AR-II-002');
INSERT INTO citations (from_tome, cites_call_number) VALUES (8, 'AR-II-004');
