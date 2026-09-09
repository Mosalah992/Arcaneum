-- Migration 0007 — Journals & Logs.
--
-- GENERATED FILE. Do not edit by hand: edit the markdown in
-- content/library/ and re-run `npm run seed`.
--
-- The prose is Bethesda's, ported from the Library of Skyrim.
-- See PROVENANCE.md.

-- AR-VI-001 — Cicero’s Journal
INSERT INTO tomes (id, call_number, title, author, school, body, restricted) VALUES
  (154, 'AR-VI-001', 'Cicero’s Journal', 'Anonymous', 'Journals & Logs',
   '## Cicero’s Journal: Volume 1

## 18th of Evening Star, 4E 186

As I begin this new phase of my life, I have decided to finally keep a journal. So much has happened to me thus far, both within the Brotherhood and without - when I think there is no record of what has transpired, it almost seems an affront to Sithis himself. So I am determined to make amends. Yes, the Dark Brotherhood has its own scribes and chroniclers, but it is their solemn task to record those events deemed important to the organization as a whole. Let this volume serve as the personal record of one man, a lowly assassin who has pledged his blade and his life for the Dark Brotherhood.

23rd of Evening Star, 4E 186
 I have arrived safely in the Cheydinhal Sanctuary, and have been greeted warmly by Rasha and the others. Indeed, the level of support and acceptance shown by my new family is rather overwhelming. For this Sanctuary knows suffering, knows sorrow, for the ghosts of Purification still haunt its halls. So, who better to understand the plight of a brother who has lost home and heart? Who better to comfort one whose Sanctuary is no more? The Bruma Sanctuary may be gone, but my dearest brothers and sisters will live forever in my dreams, just as their souls live forever by the Dread Father’s side.

1st of Rain’s Hand, 4E 187
 Completed the baroness contract. She died well. Her handmaiden, less so.

12th of Rain’s Hand, 4E 187
 Cheydinhal suits me. With the destruction or abandonment of the other Sanctuaries, our contracts are plentiful, as are our bonuses. Still, we seem to be losing our footholds throughout Tamriel at an alarming rate. There are rumors that the Black Hand is split on our continued direction. Some favor expansion, the others consolidation. My personal feeling is that the Dark Brotherhood needs to, at the very least, maintain the illusion of being everywhere at once. It has become exceedingly difficult to fulfill (or even establish) contracts in provinces where we no longer have a physical presence, like Hammerfell. The more we ignore Tamriel, the more people lose faith in the Dark Brotherhood - our power, our services, our dedication to the Void.

27th of Rain’s Hand, 4E 187
 The Listener, Alisanne Dupre, has been visiting with us for several days, down from her private residence in Bravil. She and Rasha had been discussing the possibility of re-opening the Shadowscale training facility of Archon, in Black Marsh, but ultimately decided we lacked the resources to follow through with the plan.

27th of Rain’s Hand, 4E 187
 Completed the Arena contract. I ultimately decided to pose as a starstruck fan, and immediately got into the Grand Champion’s good graces. While escorting the arrogant fool through the Great Forest, I slashed his throat and left the corpse for the bears.

Cicero’s Journal: Volume 2

7th of Sun’s Height, 4E 188
 Wayrest is lost. The city fell to corsairs, and it’s just a matter of time before the Sanctuary is breached. May the Night Mother watch over her children in their hour of need.

5th of Last Seed, 4E 188
 We received word today - the Wayrest Sanctuary was raided and destroyed by the corsairs. There were no survivors.

There are now only three active Dark Brotherhood strongholds remaining: The Cheydinhal Sanctuary, here in the Imperial Province; a remote Sanctuary located in a forest in Skyrim; and the Corinthe Sanctuary of Elsweyr.

The Black Hand has ordered the Corinthe Sanctuary closed, and its members integrated into our own ranks here, in Cheydinhal. I will embrace those new family members as warmly as I was, when I first made my home here.

27th of Hearthfire, 4E 188
 The situation in Bravil grows more dire. The city has erupted in violence, due to a war of control being waged by Cyrodiil’s two largest skooma traffickers. The Listener, Alisanne Dupre, has been forced to employ sellswords to protect her own residence.

1st of Sun’s Dusk, 4E 188
 Things in Bravil have come to a head. The statue of the Lucky Old Lady has been destroyed, and Alisanne Dupre has left her residence to guard the crypt of the Night Mother, hidden below the remains of the statue. If the crypt is discovered, Alisanne Dupre will, of course, protect the remains of the Unholy Matron until her dying breath.

Rasha is sending Garnag and Andronica to aid in the crypt’s defense. I begged to accompany them, but Rasha wouldn’t have it. He says my place is here, defending this Sanctuary, and I must of course respect that decision.

12th of Sun’s Dusk, 4E 188
 Botched my contract and forfeited the bonus. The silk merchant was already cold, and I was halfway through the window, when her daughter stepped into the room. I had little choice at that point.

21st of Sun’s Dusk, 4E 188
 So much has happened since my last entry. After Garnag and Andronica left for Bravil, we stopped receiving communications from the city. We feared the worst. This morning, those fears were confirmed, when Garnag returned alone, transporting a most precious cargo - the great stone coffin of the Night Mother herself.

The story Garnag told could curl the blood of even the most hardened of Sithis’ servants. The crypt of the Night Mother, raided. Dearest sister Andronica, cut to pieces. And the Listener herself, the most honored Alisanne Dupre, burned alive in a storm of mage fire.

Garnag, though gravely injured (he will most certainly lose his right eye), managed to fend off the attackers, and transport the Night Mother’s coffin safely out of the city. He has been on the road, making his way back here, since that tragic night.

Cicero’s Journal: Volume 3

23rd of Sun’s Dusk, 4E 188
 Now that things have settled down, the reality of our situation has finally come to bear - we are a Dark Brotherhood without a Listener. With no Listener, the Black Sacrament will go unheard. Surely the Night Mother will speak to someone soon, thus choosing a new Listener to take Alisanne Dupre’s place. Until that happens, though, we must take to the streets. We must hear the pleas of the desperate and vengeful. The people of Tamriel must not know, must never know, that their prayers to the Night Mother are going unheeded.

24th of Morning Star, 4E 189
 It is a new year, and two months since the Night Mother first arrived here at the Cheydinhal Sanctuary, and still the Unholy Matron has not seen fit to speak to any one of us.

And so, Rasha has decided to revive an ancient Dark Brotherhood tradition - the appointing of a Keeper, a guardian whose sole duty is the safeguarding of the Night Mother’s remains. The remaining members of the Black Hand will make their decision tomorrow.

25th of Morning Star, 4E 189
 I have been chosen. By some incomprehensible twist of fate, the Black Hand has named me the Night Mother’s Keeper. In all honesty, I am both incredibly honored and deeply saddened. This means the end of my contracts. I’ll be lucky to lift a blade again. Thankfully, Rasha has promised me one final contract before I accept my new duties.

30th of Morning Star, 4E 189
 The jester lies dead. My final contract has been completed. Oh, how he laughed and laughed. Until he didn’t.

3rd of First Seed, 4E 189

I have settled well into my new role as Keeper. It is my duty to not only keep the Night Mother’s shrine clean, and the candles lit, but to tend to the body as well.

The Night Mother’s crypt was a consecrated place - shroud-kissed, absent of sunlight, and safe from the world above. Removed from there, the remains are subject to the filth and corruption of the living. The body is perfectly preserved, so the concern is not physical, but rather spiritual - the remains must be sanctified regularly, so that they may continue to serve as a conduit for the Night Mother’s soul. Our Matron’s eternal spirit may travel the Void freely, but it is through her own earthly remains that she communicates with the Listener.

And so, I wash the corpse weekly with the requisite oils, recite the ancient incantations, and personally see to the extermination of any insects or rodents. If the Night Mother does not speak, it will be because she chooses not to - not because she is unable. This is my responsibility. This is my vow.

12th of Mid Year, 4E 189
 Months and months and months and no Listener. Why won’t the Night Mother speak to me? I am worthy as Keeper, but not as Listener? I protect our Lady, keep her sanctified, but still she will not grace me with her voice?

4th of Sun’s Height, 4E 189
 So long since I worked my blade. So long since I saved a soul. But I am now Keeper. No longer a taker.

I think back fondly on my hours with the jester. His laughter, his screams, his pitiful cries. And then, as the end drew near, his laughter once more. Merry in death as well as life. I was honored to know him.

Cicero’s Journal: Volume 4

1st of Hearthfire, 4E 189
 Cheydinhal has erupted into violence and chaos, like so many other cities before it. The Sanctuary has remained unbreached, but for how long?

Our numbers are few, and with no Speaker, the contracts have dwindled almost to nothingness. Rasha’s hold on the Sanctuary is slipping.

26th of Frostfall, 4E 189

Silence! Deafening silence! In my head in my head in my head. It is the silence of death, the silence of the Void. Seeping into me, through the Mother. The silence is hatred. The silence is rage. The silence is love.

4th of Evening Star, 4E 189

Today, Rasha declared himself Listener, claiming the Night Mother spoke to him at last. But when questioned, he could not name the Binding Words. Liar! Deceiver! His charade must not stand.

5th of Evening Star, 4E 189
 Rasha is dead.

As commanded by the silence, so did I obey. I did not wield the knife, oh no, but dipped the honey softly sweet, into Garnag’s eager ear. He is a good brother. A loyal brother. To both Cicero and our Matron. He did the deed, gladly.

10th of Sun’s Dawn, 4E 190
 Only three of us left. Cicero, Garnag, Pontius.

15th of Sun’s Dawn, 4E 190
 The Night Mother remains silent. I remain unworthy. The Sanctuary remains doomed.

3rd of First Seed, 4E 190
 I can hear it. Deeper, and deeper. Louder and louder, punctuating the silence like thunder on a calm evening. Laughter.

4th of First Seed, 4E 190
 Laughing, laughing, laughing, laughing! It is the jester! A voice from the Void, to cheer poor Cicero! I accept your gift, dearest Night Mother. Thank you for my laughter. Thank you for my friend.

16th of Rain’s Hand, 4E 191
 Pontius is dead. A Dark Brotherhood assassin was killed by a common bandit while walking the streets of Cheydinhal. How can something so sad be so funny?

17th of Rain’s Hand, 4E 191
 I love the laughter, dearest Night Mother, but still I long to hear your voice. It’s not too late! Speak to me, my mother! Speak to me, that I may set things right! I can save the Sanctuary, I can save the Brotherhood!

You can have the laughter! Take it back! An exchange, then? The laughter for your voice?

2nd of Second Seed, 4E 191
 It’s not safe to leave the Sanctuary. We’ll stay here. All is well.

29th of Last Seed, 4E 191
 Garnag is gone. Gone gone gone gone gone. Left to get food, but he’ll be back. It’s only been three months. Three months. Tree months? Twelve moths? Four sloths!

21st of Sun’s Dusk, 4E 192
 Cicero is dead! Cicero is born!

The laughter has filled me, filled me so very completely. I am the laughter. I am the jester. The soul that has served as my constant companion for so long has breached the veil of the Void finally and forever. It is now in me. It is me.

The world has seen the last of Cicero the man. Behold Cicero, Fool of Hearts - laughter incarnate!

28th of Sun’s Dusk, 4E 200
 Found the old journal, decided to write, a treatise on silence, sound, darkness and light!

How long has it been since the Night Mother first came here? How long since I was made Keeper? How long since I became the fool? Since I’ve been alone? Since Cheydinhal fell? Since they started pounding on the door, like so many hammered heartbeats?

It’s dark in here, and quiet. Poor Cicero no longer hears the laughter, for he is the laughter. There is no Listener in Cheydinhal. No Listener in Cyrodiil. No Listener in me.

We must leave here. Before the Sanctuary falls. Before the Night Mother burns. Before the Dark Brotherhood withers. Before the laughter dies.

29th of Sun’s Dusk, 4E 200
 I took a stroll, and spied a maid, but Matron’s duty stayed my blade. So busy now, I miss the thrill, if only I had time to kill.

Cicero’s Journal, The Final Volume
 30th of Sun’s Dusk, 4E 200
 I have written the letters. So polite. So official! To Astrid, in Skyrim. Her Sanctuary still stands. Still operates. But how? No Listener means no Black Sacrament, no Black Sacrament means no contracts. Her family can abandon the Old Ways, and still survive, still kill, but is that family still Brotherhood? Or something else? Something new. Something different. Something wrong?

Something wrong.

Still, we must go! Tomorrow, we set sail. Float on a boat through the moat called the sea her and me!

22nd of Evening Star, 4E 200
 Sick sick sick of the rocking tossing rolling throwing upon the gray gray waves!

I’ve been reading of Skyrim, of the good days, the old days, of the Old Ways. There was another Sanctuary once. A Dawnstar Sanctuary. Good, ancient and strong. Blessed by Sithis. Cicero will go there! No need of Astrid!

The Mother and I will settle, and she will speak to me, finally, and we will build the Old Ways anew, together.

23rd of Evening Star, 4E 200
 The passphrase is mine! I have found it, in a letter ancient as the Sanctuary itself.

The Black Door will ask - “What is life’s greatest illusion?”

I am to answer - “Innocence, my brother.”

Finally, a space, a place, to call my own! A joker’s retreat for the Fool of Hearts!!!!

4th of First Seed, 4E 201
 The Sanctuary is home! As I had dared hope! Cool and dark and lovely. My Sanctuary, Sanctuary from all.

I know its every corner, every hall, every shadowed nook and alcove. My Sanctuary. The guardians know me, recognize me as Keeper. They leave poor Cicero alone. The big ugly beast - a different story. He’d eat me if he could, but to bind me, grind me, he’d need to find me. And Cicero will make sure that does not happen. For I have Sanctuary!

Sanctuary from all.

13th of First Seed, 4E 201
 The Sanctuary is safety, and salvation. But silent, so silent. I give my love to the Unholy Matron. I give my laughter freely. But I do not hear her. The silence has returned. Now that I am laughter, and no longer hear laughter, I once again hear the silence. The silence of the Void. It reaches across time and space. Its silence is deafening, once more.

1st of Rain’s Hand, 4E 201
 Mother and Keeper must go. I am not the Listener, and never will be. But I am the Keeper. I must serve my Mother’s will above my own. I must find her Listener. I must teach Astrid the error of her ways, the beauty and necessity of the Old Ways.

I have sent the letter to Astrid. We leave soon. But Cicero will keep this Sanctuary as his Sanctuary!

A place to rest and ply my trade, for I once more take up the blade, and send some lucky souls to Him, when laughter strikes, as fits my whim!', 0);

-- AR-VI-002 — Confessions of a Khajiit Fur Trader
INSERT INTO tomes (id, call_number, title, author, school, body, restricted) VALUES
  (155, 'AR-VI-002', 'Confessions of a Khajiit Fur Trader', 'The Fur Trader', 'Journals & Logs',
   'My execution is tomorrow. The turnkey asks what I’d like for my last meal.

Bring me paper, I say. A quill and a candle.

Perhaps the Jarl would like a confession. I would rather pass the time.

When my father’s harem burned down and our family fortune was lost to the ashes, my brother and I set to begging in the gutters of Elsweyr. I will never forget the first time we stole a traveler’s purse. It was almost by accident. Just a slip of the claw and the pouch fell into our hands. We ate like kings that night. We slept in a warm bed for the first time in months.

Soon after, my brother and I took up the knife. The gang we joined treated us as the dirty orphans we were. We robbed, we scammed, we cut and ran and years of debauchery and hard living took their toll. I lost half my left ear in a knife fight with a blind drunk Argonian.

I wanted to give up, but my brother, he dreamed bigger, better.

My brother wanted to make it to Cyrodiil and become legit merchants. We had a plan. One final heist of a northbound caravan said to be filled with jewels.

Something went wrong. My brother could not stop the horses on time, and I stood helplessly by and watched the wagon plummet over a cliff. But as I picked through the wreckage, my devastation turned to excitement. There were no jewels, but there were plenty of luxurious wolf pelts, horker tusks and mammoth hides, more than enough to buy my way to Cyrodiil. I’d follow in the footsteps of so many of my kind. A traveling merchant, someone with a respectable profession.

I had all the furs bundled in my pack when I saw my brother’s broken body. His ears were still warm, and I shut his eyes for the last time. This was his dream. And he would want me to go. But what I wanted, well, the caravan guards were coming. I had to go, but I couldn’t just leave his body to rot.

My brother gave me my first skin. It was to be a memento. But in the darkness of the fence’s cabin, the coin hit my hand heavy. Then she looked at my brother’s pelt and offered three times the amount of any other fur. Disgust caught in my throat, but did not live very long. I realized the cost of such a forbidden luxury. The value, the demand, the respect.

This is what I wanted.

It became easier. A dark alley, a gag in one hand and a quick slice across the throat. Gently hold the body as it bleeds. I became faster, my cuts precise and fluid. I peel the skin with one motion and kept the merchandise pristine, in one piece.

I became rich. Far richer than anyone in my family had ever been. Yet I was careful. My stronghold was well-hidden, and practically impenetrable. I hired the men that used to employ me. We moved frequently on less traveled roads when we hunted in the wild. We stalked the back alleys we used to sleep in when we hunted in the city. I grew so rich that I no longer needed to dirty my own hands.

Patchwork colored furs fetched the best price among the Bosmer. Argonians preferred the pelts completely skinned and tanned. Orcs prized the thick, waterproof leather of the Argonians. Humans most often bought tails and ears. I had to employ an alchemist and a master craftsman for a couple odd requests, but I didn’t ask questions when the gold piled up.

And now I’m a prisoner. Maybe I became careless. Maybe I let too many secrets slip between the sheets. The raid of my fortress was a massacre. They took me alive, barely. That was their mistake. My enemies should have killed me when they had the chance.

I have one lockpick. And the northern wall of my cell is weak from disrepair. My head shall not roll tomorrow.

I am not finished with the trade. There will always be buyers. Someday, I will sell my own skin for a king’s ransom, as my name is legend. And yours shall rot in the gutters with your bones.

-The Fur Trader', 0);

-- AR-VI-003 — Diary of Faire Agarwen
INSERT INTO tomes (id, call_number, title, author, school, body, restricted) VALUES
  (156, 'AR-VI-003', 'Diary of Faire Agarwen', 'Faire Agarwen; Calcelmo of Markarth, trans.', 'Journals & Logs',
   '## Forward

The dates noted in this diary are translated literally. This verbiage matches no known modern measure of time, and is assumed to be a custom form of counting the days and months. Excavations of ancient Falmer slave quarters have turned up brass vessels, very similar to a deep bowl, with twenty markings crudely etched onto the inside. Falmer scholars theorize that this bowl would be placed under a drip of water coming from an overhanging rock and as the bowl filled, the water’s level would reach these markings, thus indicating a crude passage of time. Because of this diary, the vessel has been called a “kulniir,” a primitive Falmer timekeeping device.

Third Marking, Tenth Kulniir
 It feels like years since we were forced into hiding. I dare not write where we stay for fear of endangering the good people of this house should this diary be discovered. We have been shown a kindness by this family once known to the Snow Prince. Even in death his great influence has ensured our safety. We were separated from many of our kin along the road when it became increasingly difficult to travel discreetly in our numbers. We were forced to go our separate ways and travel only at night. I have heard no news of where the others may have gone and fear I never shall. Our lives are forever changed.

Seventh Marking, Tenth Kulniir
 In the night I find it difficult not to focus on times past. There are moments in my rest when I still hear the laughter of Young Ones at play in the valley. Other times I see the pale flicker of happy moments which were once so common in the land of the Snow Elves. I try not to dwell on these memories too long. Often our surroundings make it impossible to dwell on any happiness. We have been locked together in such close quarters for so long we grow tired of each other’s company. Even the strongest of us have faltered with nothing to do but think on what is lost. I wake each day to forlorn faces and am reminded of where we are and all we have left behind. We are all yearning for a day when we can emerge from hiding and walk freely in the light once more. But I fear we are losing all hope that such a day will ever come.

Tenth Marking, Tenth Kulniir
 I tire of the tears of women and children. My own have run dry. The men have begun to look upon us as if we are all weak yet we have survived the same trials as they. I cannot bring myself to think on the numbers we lost in battle. Yet I cannot force the images of my own losses from my mind. And now in a time when our people should be banding together it feels we are drifting apart. The Nords have truly won. Our once great pride and unity are shattered. If we lose hope now we will never survive. Today many, myself included, have tried to speak out in voices of reason. There can be no hope without talk of our future. We can make no difference if our spirits remain broken.

Eighteenth Marking, Tenth Kulniir
 We know that we can never again be the Snow Elves and live freely in this world. We will forever be in hiding in one form or another. But there is no reason we cannot live life with the sun and the wind against our skin. There are those here who are friends to us and plan to help us once the threat has ended. We know now to survive we must be born anew. Outside, we will appear as though we belong here. Inside, we will carry our truth and our scars.', 0);

-- AR-VI-004 — A Dream of Sovngarde
INSERT INTO tomes (id, call_number, title, author, school, body, restricted) VALUES
  (157, 'AR-VI-004', 'A Dream of Sovngarde', 'Skardan Free-Winter', 'Journals & Logs',
   'In a few hours, I will likely be dead.

My men and I, Nords of Skyrim all, will soon join with the Emperor’s legions to attack the Imperial City. The Aldmeri are entrenched within and our losses will be severe. It is a desperate gambit, for if we do not reclaim the city, we will lose the war.

Last night I prayed to mighty Talos for courage and strength in the battle to come. In these last cold hours before the sun rises, I sit down to write this account of a dream I had not long after.

I believe this dream was the answer to my prayers, and I would pass along the wisdom it contained to my kinsmen, for the battles they will fight in the years after my passing.

In the dream, I walked through mists toward the sound of laughter, merriment and the songs of the north. The mists soon cleared, and before me lay a great chasm. Waters thundered over its brim, and so deep it was, I could not see the bottom.

A great bridge made all of whale-bone was the only means to cross, and so I took it.

It was only a few steps onto the bridge that I encountered a warrior, grim and strong. “I am Tsun, master of trials,” he said to me, his voice booming and echoing upon the walls of the high mountains all around us.

With a wave, he bade me pass on. I knew in my heart that I was granted passage only because I was a visitor. Should the hour come when I return here after my mortal life, the legends say that I must best this dread warrior in single combat.

Beyond the bridge, a great stone longhouse rose up before me, so tall as to nearly touch the clouds. Though it took all my strength, I pushed open the towering oaken door and beheld the torch-lit feast hall.

Here were assembled the greatest heroes of the Nords, all drinking mead poured from great kegs and singing battle-songs. Suckling pigs turned on a long iron spit over a roaring fire. My mouth watered at the smell of roast meat, and my heart was glad to hear the songs of old.

“Come forth!” cried out a hoary man who sat upon a high wooden chair. This I knew to be Ysgramor, father of Skyrim and the Nords. I approached and knelt before him.

“You find yourself in Sovngarde, hall of the honored dead. Now, what would you have of me, son of the north?” he bellowed.

“I seek counsel,” said I, “for tomorrow we fight a desperate battle and my heart is full of fear.”

Ysgramor raised his tankard to his lips and drank until the cup was empty. Then he spoke once more.

“Remember this always, son of the north - a Nord is judged not by the manner in which he lived, but the manner in which he died.”

With that, he cast aside his flagon, raised his fist in the air and roared a great cheer. The other heroes rose to their feet and cheered in answer.

The sound still rang in my ears when I awoke. I gathered my men and told them of my vision. The words seemed to fill their hearts with courage.

The horns are blowing, and the banners are raised. The time has come to muster. May Talos grant us victory this day, and if I am found worthy, may I once again look upon that great feast hall.

- Skardan Free-Winter', 0);

-- AR-VI-005 — Flight from the Thalmor
INSERT INTO tomes (id, call_number, title, author, school, body, restricted) VALUES
  (158, 'AR-VI-005', 'Flight from the Thalmor', 'Hadrik Oaken-Heart; Ashad Ibn Khaled, ed.', 'Journals & Logs',
   'It''s been nine days. Nine days since I slipped my bonds. Nine days since I strangled my captor with my own chains. And nine days since I rushed headlong into the night, always listening, but never looking back.

But in order to understand my current predicament, one must first understand where I came from, and just where this story began.

My name is Hadrik Oaken-Heart, and I am a proud Nord of Skyrim. I am a skald by trade, and received my formal training at the Bards College in Solitude. For years, I made my occupation as a traveling musician and minstrel, and even served several stints as war-bard in service to the armies of the various Jarls.

And it''s fairly safe to say that if I weren''t a bard, I never would have gotten into this mess to begin with.

My troubles began when I first started singing about Talos, the Ninth and greatest Divine, beloved of the people of Skyrim. Turns out, he''s not so beloved by the Thalmor.

Ah yes, the Thalmor. As common as a head cold in Skyrim these days, and just as annoying. Or so I thought at the time, before their true power and inlfuence made itself known.

For those not in the know, the Thalmor are Skyrim''s recently honored "guests" - high elves of the Aldmeri Dominion who were gracious enough not to wipe us all out during the Great War.

But, as every Nord of Skyrim knows, Thalmor graciousness comes at a terrible price. One of the stipulations of the White-Gold Concordat - the peace treaty between our peoples - was the abolishment of Talos worship. A man ascend to godhood? Preposterous, claim the Thalmor. And so, the open worship of Talos has been outlawed in Skyrim, and actively enforced in those cities where the Thalmor have a tangible presence. Cities, I might add, in which the Empire has the most secure foothold.

It was in one of these cities - Markarth, to be exact - where I made the conscious decision to defy the ban on Talos worship. And my defiance came in the form of - what else? - a song. For what bard who has spent time writing and rehearsing an original work can possible refrain from performing it? So perform it I did. Not once, not twice, but seven times. Once a day, for an entire week.

Now here''s something most of my kinsman are unaware of: not all Thalmor in Skyrim are equal in station, or purpose. In fact, there is one group in particular that operates secretly, in the shadows - watching and waiting for those Nords who break the law, and continue their worship of almighty Talos. These are the Justiciars, and it is their job to enforce this, the most terrible of conditions of the White-Gold Concordat.

And so, I would have performed my song for an eighth time had I been given the opportunity. Sadly, I was not. For the Justiciars had been watching, had been waiting. Instead, I received a black sack over my head in the wee hours of the morning, a dreadfully uncomfortable wagon ride, and sinister promises that I would enjoy my "new home," which I came to realize was some sort of secret Thalmor prison or detention camp. One I was certain I would never leave alive.

It was at that moment I realized I needed to make my escape. No matter what - even if I died in the attempt - I had to slip the grasp of my captors. Better that than rot in some godsforsaken Thalmor jail until the end of time.

I finally got my chance when the wagon stopped, and we made camp for the night. One of my two Thalmor guards set off into the forest to hunt, leaving me alone with the other. And so, my account comes full circle.

It is now nine days later, and in that time, I have realized the true extent of my foolishness. I couldn''t have sung the song just once? Or maybe twice? Or not at all? I couldn''t have swallowed my stubborn Nord pride and realized just how much power and influence the Thalmor truly have over the Jarls?

No. I could not. So now I run. Like a hare from the hound, I run. Always moving, rarely resting, never sleeping. But the Thalmor dog my every move. Where will I go? How will I escape their grasp? I honestly don''t know. The only thing I now understand for certain is this: if the agents of the Aldmeri Dominion cannot have your soul, then they will take your very life.

My name is Hadrik Oaken-Heart, and I am a proud Nord of Skyrim. Remember me. For soon I will be dead.', 0);

-- AR-VI-006 — Gallus’s Encoded Journal
INSERT INTO tomes (id, call_number, title, author, school, body, restricted) VALUES
  (159, 'AR-VI-006', 'Gallus’s Encoded Journal', 'Gallus Desidenius', 'Journals & Logs',
   '[Literal Translation: MERCER FREY CONTINUES TO ELUDE MY EVERY STEP I THINK HES AWARE IM FOLLOWING HIM AND APPEARS TO BE TAKING NO UNNECESSARY CHANCES IM BRINGING ALL OF MY SKILLS TO THE FOREFRONT IN ORDER TO DECEIVE HIM IT STILL PAINS ME THAT THE DECEPTION IS NECESSARY WHEN I BECAME A NIGHTINGALE USING MY NEWFOUND TALENTS AGAINST MY OWN WAS THE FURTHEST THOUGHT FROM MY MIND

THERE WAS A CLOSE CALL TODAY I WAS SETTLING DOWN FOR A NIGHTS REST IN THE CISTERN WHEN MERCER FREY ENTERED UNEXPECTEDLY HE WAS CREEPING ALONG THE WALL BUT I SPOTTED HIM IMMEDIATELY HE EDGED CLOSER TO THE VAULT DOOR MAKING HIS WAY CAREFULLY AROUND THE PERIMETER OF THE ROOM BUT SUDDENLY STOPPED AND TURNED TOWARDS MY HIDING PLACE I FROZE INSTANTLY EVEN HOLDING MY BREATH FOR A MOMENT BUT MY POSITION WAS ALREADY COMPROMISED HE ABRUPTLY TURNED AND WALKED BACK TOWARDS THE FLAGON WHAT WAS HE DOING

AT LAST I HAVE A PIECE OF EVIDENCE THAT MIGHT EXPLAIN MERCER FREYS ACTIONS INSTEAD OF TRYING TO FOLLOW HIM OR BREAK INTO HIS MANOR I USED EVERY LOOSE-TONGUED SOURCE AT MY DISPOSAL TO SCOUR THE RATWAY LOOKING FOR ANSWERS IT TOOK SEVERAL WEEKS BUT MAUL WAS ABLE TO PROVIDE AN INTERESTING BIT OF INFORMATION MERCER HAD BEEN SPENDING INORDINATELY LARGE SUMS OF COIN ON ALL MANNER OF THINGS UNRELATED TO THE GUILD HOW HE WAS ABLE TO AFFORD THIS WAS A MYSTERY TO ME THE VAULT WAS IMPREGNABLE SO WHAT WAS THE SOURCE OF HIS COIN

ITS BEEN CONFIRMED BY MY SOURCES MERCERS BEEN LIVING AN UNDULY LAVISH LIFESTYLE REPLETE WITH SPENDING VAST AMOUNTS OF GOLD ON PERSONAL PLEASURES I HAVE MORE THAN MY SHARE OF EVIDENCE TO CONFRONT HIM NOW HE MUST BE STEALING FROM THE GUILD BUT WITHOUT PROOF ALL I HAVE IS BASELESS ACCUSATION MERCER CAME FROM WEALTHY STOCK BUT THE AMOUNT OF COIN HES BEEN SPENDING IS IMMENSE

IVE BEEN GIVING IT SOME SERIOUS THOUGHT THERES ONLY A SINGLE WAY THAT MERCER COULD HAVE ACCESS TO VAST AMOUNTS OF COIN I HESITATE TO EVEN BELIEVE ITS POSSIBLE HOW COULD HE POSSIBLY DESECRATE THE TWILIGHT SEPULCHER THIS GOES FAR BEYOND MERE GREED AND TRANSCENDS COMMON THEFT HIS ACTIONS COULD REPRESENT THE FAILURE OF THE NIGHTINGALES SOMETHING THAT HASNT OCCURRED IN HUNDREDS OF YEARS WHY WHY WOULD HE READILY THROW AWAY EVERYTHING HE BELIEVES IN ALL I NEED IS PROOF

MERCER FREY HAS REQUESTED I MEET HIM AT SNOW VEIL SANCTUM TODAY HE SENT A NOTE BY COURIER SO I CAN ONLY ASSUME HES ALREADY THERE ALL MY SENSES TELL ME ITS A TRAP BUT I HAVE NO CHOICE HIS MESSAGE INDICATED THE MEETING WAS OF THE UTMOST URGENCY AND INVOLVED GUILD BUSINESS SO IM OBLIGATED TO GO I CANT RISK BRINGING ANYONE ELSE WITH ME BUT IM ALMOST CERTAIN KARLIAH WILL DISOBEY AND FOLLOW]', 0);

-- AR-VI-007 — Journal of Mirtil Angoth
INSERT INTO tomes (id, call_number, title, author, school, body, restricted) VALUES
  (160, 'AR-VI-007', 'Journal of Mirtil Angoth', 'Mirtil Angoth; Calcelmo of Markarth, trans.', 'Journals & Logs',
   '## 4th of Evening Star

I used to dream of fighting in battles like my Father. He had begun teaching me to fight the moment I was able to pick up a blade. Mother had argued that I was too young, but he paid her no mind. I can still remember the elation I felt the first time I bested Father in a match and the look of pride on his face. If it were up to him I know he would have allowed me to join him in battle. With me at his side he may have fared better. Now with Father and so many others slain, the Old Ones claim we are left with too few warriors to continue the fight. I was not the only Young One to speak out in protest, but our small voices went unheard. It has been decided that we must flee to seek help and protection.

8th of Evening Star

News has reached us that the great Snow Prince has fallen in battle. The urgency to go into hiding has left many of us scattered and those of us still together unsure of which direction to turn. In the long hours of night we keep huddled together always fearing the worst until the first light of the blessed sun. May Auri-El guide our footsteps.

13th of Evening Star

In the night I overheard the Old Ones whispering secrets of the underground and the Dwemer who dwell there. I thought back on stories Father once told me of these dwarves, heroic tales of honor and glory. The Old Ones must know of these stories for it has been decided that we will change course upon first light. I feel hopeful that the Dwemer will help us to avenge our fallen and reclaim our land.', 0);

-- AR-VI-008 — Rising Threat
INSERT INTO tomes (id, call_number, title, author, school, body, restricted) VALUES
  (161, 'AR-VI-008', 'Rising Threat', 'Lathenil of Sunhold; Praxis Erratuim, ed.', 'Journals & Logs',
   '## Rising Threat, Vol. I

I was barely more than a child when the Great Anguish fell upon us. The very air was torn asunder, leaving gaping, infected wounds that spewed daedra from the bowels of Oblivion. Many flocked to the shores, seeking escape from Dagon’s murderous host - but the seas betrayed our people, raising up to smash our ships and our ports, leaving us to fates so vile and wicked that death would seem a mercy.

The Crystal Tower stood as our last bastion of hope, in both the literal and figurative sense.

Refugees filled the Crystal Tower until it could hold no more. I could taste the fear hanging in the air; feel the pall of despair suffocating us. We could see the daedra moving through the trees in the distance, but they did not come. Days passed, and still the daedra would not approach within arrow-shot of the battlements. Hope began to grow. “They fear us,” some would say, “even a daedra knows not to trifle with the wisdom and magicks of the Crystal-Like-Law!”

It was as if the foul denizens of Oblivion had been waiting for this very spirit to stoke our hearts before they acted.

As we slept, innumerable legions of daedra amassed around us... and they were not alone. Hundreds of Altmer prisoners were gathered with them. As dawn broke, we were awoken by their screams as the daedra began to flail them and flay them. We watched in abject horror as our kinfolk were defiled completely... carved up and eaten alive, impaled on their depraved war machines, and worried apart as meals for their profane beasts.

This bloodletting was only a prelude to whet their appetites.

Once the daedra finished with our kinfolk, they turned their eyes to the Crystal Tower. Our great and noble bastion proved as much of an impediment as a mighty oak to a landslide - standing tall for but a few moments, appearing almost able to ride the tide of destruction around it, but ultimately being swept away.

Our exalted wizards decimated the fiends, roasting them by the dozens. Archers were finding the narrowest of chinks in their daedric armor at over a hundred paces, felling their captains and commanders. The might and skillfulness of our heroic defenders was astonishing to behold, but it was not enough. The daedra clambered over the corpses of their cohort. They marched headlong into death and destruction that would make the mightiest armies in all of Tamriel quake with fear.

When they breached the walls, I fled along with the other cowards. I take no pride in that act. It has haunted my existence ever since, and I burn with shame to admit it, but it is truth. We fled in mindless panic - abandoning those stalwart Altmer who held the line against the onslaught, to preserve and defend our illustrious Crystal Tower.

We raced through cleverly concealed passageways and emerged well away from the chaos that had descended upon the tower. That is when it happened. It started like a gust rustling through the leaves of a dense forest, but the sound did not taper off. It rose into a roar as the very ground on which I stood began to shudder. I turned to look, and the world held its breath...

I stood transfixed as the heart of my homeland was torn as if from my own breast. The unthinkable, the incomprehensible... the tower of Crystal-Like-Law cast to the ground, with all the dignity of a beggar meeting an iron-clad fist. An eternity I watched, trying to reconcile what I knew with what I saw.

Sobs racked my chest, and weeping filled the air around me as the spell loosened its hold and I realized where I was. There were scores of other refugees mesmerized by the horror that had likewise ensorcelled me. “Go,” I croaked out as my heart - the heart of my land - shattered. No one moved, not even me.

I mustered what will I could and bellowed all the fear and hatred and agony at what had just happened, turning the word into a mindless shriek: “GO!” I ran then, feeling more than seeing that the others had followed.

Rising Threat, Vol. II

What happened after the tower of Crystal-like-law fell was a daze. It was as if my mind simply... stopped. Instinct took over, as my every thought sank into a black abyss of despair. Time lost all meaning, and to this day I know not how long I was in this state. Eventually a conscious thought managed to break my fugue: the daedric horde had vanished! Gone as suddenly as they had come.

Before my numbed mind could comprehend the tumult that consumed my beloved Summerset Isle, before I could formulate the question “how?” they were there, dripping honeyed poison in our ears: the Thalmor. They were the ones that saved us, they claimed, working deep and subtle magicks. It was their efforts, their sacrifices that delivered the Altmer from extinction.

Oh, what fools we were. We wanted so desperately someone to thank for ending our tribulations, we lavished it upon the first to step up and claim the glory. With that simple act of gratitude, we allowed a vile rot to seep into our homeland, to putrefy our once noble and distinguished civilization.

It was months before I began to suspect the error we had made. Small twinges of unease would vex me, but each one alone was easy enough to disregard and push aside. The exile of the great seer-mage Rynandor the Bold was the final doubt that I could not ignore. You see, Rynandor was one of the very few who survived the collapse of the Crystal Tower - I saw some of his bravery and heroics with my own eyes. It was his leadership and sorcery that made the daedra pay such a high price for their destruction of the Crystal Tower.

The Thalmor besmirched his name when he had the audacity to publicly doubt and question their role in ending the Oblivion Crisis on Summerset Isle. Rynandor made the mistake of ignoring the consensus gentium, trusting instead to logic and facts. The shrewdness of the Thalmor, however, was not such to allow something as trivial as the truth stand in their way. As soon as they shifted the collective opinion ever so slightly against Rynandor, they had him sequestered and intensified their efforts to tarnish his reputation. Unable to mount any sort of defense to the Thalmor’s attacks, Rynandor was quickly denounced and exiled.

Rising Threat, Vol. III

Ever so cautiously, I formed a cabal made up of others who distrusted the motives and methods of the Thalmor. Over several months, I liquidated my ancestral holdings and took whatever inheritance I could without raising any suspicions. I would follow after Rynandor and help him restore his reputation and status. We would then return to best the Thalmor at their own game and win back the mores and morals of the Altmer! The rest of my cabal would stay on Summerset Isle and win the trust of the Thalmor on whatever level best suited each of them, sending clandestine missives to me when possible.

After weeks of painstaking investigations and exorbitant bribes, I was able to learn that Rynandor was placed on a ship to Anvil. I booked my own passage to Anvil. My search almost ended there, for Rynandor had never arrived in Anvil Harbor. My instinct that Rynandor met a duplicitous end was confirmed when I sought out several of the deckhands who were reported to be aboard Rynandor’s vessel. All died under mysterious and violent circumstances.

The first of many attempts on my life occurred soon after. Needless to say, I survived, but my grand plan to stymie the Thalmor fell apart without an esteemed leader to rally behind. I went into hiding, waiting anxiously for word of the Thalmor’s activities back on Summerset Isle.

Over the following years, I tried to bend the ear of the Empire through various avenues and warn them of the Thalmor’s doings. The Empire, however, was having enough troubles dealing with the aftermath of the Oblivion crisis within its own borders without seeking trouble in far away Summerset. With the assassination of Emperor Uriel Septim VII and his heirs, and the self-sacrifice of Martin Septim (the true savior of Summerset Isle and the rest of Tamriel!) the Empire’s leadership was left defunct.

High Chancellor Ocato convened the full Elder Council in an unsuccessful bid to select a new Emperor. Without an Emperor, the Empire beyond the reach of Cyrodiil began to splinter. Ocato reluctantly agreed to become the Potentate under the terms of the Elder Council Charter until Imperial rule could be reestablished, but a reluctant leader is rarely a strong leader.

Potentate Ocato made admirable efforts to rein in the bedlam that threatened to rip the Empire apart, and was even making headway when Red Mountain erupted and destroyed much of Vvardenfell (likely from Thalmor tampering, but I have yet to find proof of their misdeeds in this). What was left of Morrowind was thrown into absolute chaos. The effects of the eruption were felt even in Black Marsh, destroying roads and cutting off the Imperial garrisons there.

None were prepared for what happened next.

Rising Threat, Vol. IV
 While Morrowind and the Imperial forces in Black Marsh were still reeling from the consecutive catastrophes of the Oblivion Crisis and the destruction of Vvardenfell, the Thalmor incited the Argonians to mount a massive uprising. Black Marsh and southern Morrowind were completely lost to the Argonians, but luckily the Thalmor too lost what influence they had over the reptilians.

All the while, the Thalmor consolidated their hold over my beloved homeland.

It took almost a decade before my own machinations put me into contact with Ocato. He seemed more interested than most in what I had to say about the Thalmor, maybe because he was himself an Altmer and recognized the threat they represented. It wasn’t long before the Thalmor had Ocato assassinated.

Potentate Ocato’s murder began the Stormcrown Interregnum. The Elder Council fractured, leading into years of ruthless in-fighting, plots and backstabbing. Many tried to claim the Ruby Throne. Most were pretenders to the crown, a few had legitimate claims, others still were little more than brutal dullards who thought mere strength of arms was all the entitlement they needed. Violent, unnatural storms lashed the Imperial City several times during this anarchy, always with the eye of the storm looking directly down upon White-Gold Tower, as if this was the judgment of the Nine Divines.

With the Empire submerged in this mayhem, the Thalmor were quick to act. They overthrew the rightful Kings and Queens of the Altmer. I remember the revulsion and horror that took hold when word reached me - that this dementia had gripped my homeland. Once so proud and majestic, many of our great race actually embraced this insanity!

Then the first of many pogroms descended on Summerset Isle. They slaughtered any who were not “of the blood of the Aldmer”. A fine excuse to purge the dissidents, as well - the Thalmor have never been ones to waste such an opportunity.

After seven long, bloody years the Stormcrown Interregnum was ended when a Colovian warlord by the name of Titus Mede seized the crown. Whether he had rightful claim or not is moot. Without Titus Mede, there would not be an Empire today. He proved a shrewd and capable leader, such that Skyrim endorsed him as Emperor.

With the Empire stabilizing under the auspicious efforts Emperor Titus Mede, I resumed my efforts to warn them of the Thalmor threat. Again, the Thalmor remained a step ahead. Before my efforts could come to fruition, the Thalmor struck: another coup, this time in Valenwood. The Empire was not prepared for the Thalmor’s subterfuge and stratagem.

There are those who claim the combined Altmer and Bosmer forces greatly out-matched the Empire, but this is a farce. This short, savage campaign was won by the Thalmor even before first blood was drawn. They waited and watched their enemy, they chose where and when they would attack. The Thalmor were able to bring the full fury of their small contingent of Altmer and Bosmer to any of several Imperial strongholds.

Contrary to the posturing of the Empire’s generals, the Thalmor did not command greater numbers. They had better spies and greater mobility, and knew how best to use them. This is the menace that the Thalmor represent! They are cruel and merciless, but they are no fools! They are devious and subtle, and so very patient.

In one fell stroke, the Thalmor took a strategic foothold on the mainland of Tamriel and prevented any significant attempt the Empire could have made to invade Summerset Isle and depose the tyranny of the Thalmor. At the same time, they took a better vantage to continue to watch the Empire and wait. In so doing, they also revived the Aldmeri Dominion with their alliance to the Bosmer of Valenwood!

Over the decades, the Thalmor have grown quiet - but this is not the end. It has only just begun. They merely consolidate their power and tighten their grip on the hearts and minds of the Altmer. The Empire may wish to forget the wounds its pride has suffered at the hands of the Thalmor, but they are still out there. Plotting. Watching. Waiting.

While the Empire is content to secure inconsequential corners of its vast holdings, the threat of the Thalmor continues to rise. Not since Potentate Ocato has anyone in the Empire listened to me. I beseech any and all citizens of this renowned Empire to heed my words! The Thalmor must be stopped, before it is too late.

***

Soon after Lathenil of Sunhold commissioned to have these volumes printed and distributed far and wide in the Empire with his own coin, he himself met a violent end. In light of the events that followed his death, we must consider that he may very well have been murdered by Thalmor assassins.

-- Praxis Erratuim, Imperial Historian', 0);

-- AR-VI-009 — Ruins of Kemel-Ze
INSERT INTO tomes (id, call_number, title, author, school, body, restricted) VALUES
  (162, 'AR-VI-009', 'Ruins of Kemel-Ze', 'Rolard Nordssen', 'Journals & Logs',
   'With the acclamations of the Fellows of the Imperial Society still ringing in my ears, I decided to return to Morrowind immediately. It was not without some regret that I bade farewell to the fleshpots of the Imperial City, but I knew that the wonders I had brought back from Raled-Makai had only scratched the surface of the Dwemer ruins in Morrowind. Even more spectacular treasures were out there, I felt, just waiting to be found, and I was eager to be off. I also had before me the salutary example of poor Bannerman, who was still dining out on his single expedition to Black Marsh twenty years ago. That would never be me, I vowed.

With my letter from the Empress in hand, this time I would have the full cooperation of the Imperial authorities. No more need to worry about attacks from superstitious locals. But where should I look next? The ruins at Kemel-Ze were the obvious choice. Unlike Raled-Makai, getting to the ruins would not be a problem. Also known as the “Cliff City”, Kemel-Ze lies on the mainland side of the Vvardenfel Rift, sprawling down the sheer coastal cliff. Travelers from the east coast of Vvardenfel often visit the site by boat, and it can also be reached overland from the nearby villages without undue hardship.

Once my expedition had assembled in Seyda Neen, with the usual tedious complications involved in operating in this half-civilized land, we set out for the village of Marog near the ruins, where we hoped to hire a party of diggers. My interpreter, Tuen Panai, an unusually jolly fellow for a Dark Elf who I had hired in Seyda Neen at the recommendation of the local garrison commander, assured me that the local villagers would be very familiar with Kemel-Ze, having looted the site for generations. Incidentally, Ten Penny (as we soon came to call him, to his constant amusement) proved invaluable and I would recommend him without hesitation to any of my colleagues who were planning similar expeditions to the wilds of Morrowind.

At Marog, we ran into our first trouble. The hetman of the village, a reserved, elegant old fellow, seemed willing to cooperate, but the local priest (a representative of the absurd religion they have here, worshiping something called the Tribunal who they claim actually live in palaces in Morrowind) was fervently against us excavating the ruins. He looked likely to sway the villagers to his side with his talk of “religious taboos”, but I waved the Empress’s letter under his nose and mentioned something about my friend the garrison commander at Seyda Neen and he quieted right down. No doubt this was just a standard negotiating tactic arranged among the villagers to increase their pay. In any event, once the priest had stalked off muttering to himself, no doubt calling down curses upon the heads of the foreign devils, we soon had a line of villagers eager to sign on to the expedition.

While my assistant was working out the mundane details of contracts, supplies, etc., Master Arum and I rode on to the ruins. By land, they can only be reached using narrow paths that wind down the face of the cliff from above, where any misstep threatens to send one tumbling into the sea foaming about the jagged rocks below. The city’s original entrance to the surface must have been in the part of the city to the northeast - the part that fell into the sea long ago when the eruption of Red Mountain created this mind-bogglingly vast crater. After successfully navigating the treacherous path, we found ourselves in a large chamber, open to the sky on one side, disappearing into the darkness on the other. As we stepped forward, our boots crunched on piles of broken metal, as common in Dwarven ruins as potsherds in other ancient sites. This was obviously where the looters brought their finds from deeper levels, stripping off the valuable outer casings of the Dwarven mechanisms and leaving their innards here - easier than lugging the intact mechanisms back up to the top of the cliff. I laughed to myself, thinking of the many warriors unwittingly walking around Tamriel with pieces of Dwarven mechanisms on their backs. For that, of course, is what most “Dwarven armor” really is - just the armored shells of ancient mechanical men. I sobered when I thought of how exceedingly valuable an intact mechanism would be. This place was obviously full of Dwarven devices, judging from the litter covering the floor of this vast chamber - or had been, I reminded myself. Looters had been working over this site for centuries. Just the casing alone would be worth a small fortune, sold as armor. Most Dwarven armor is made of mismatched pieces from various devices, hence its reputation for being bulky and unwieldy. But a matched set from an intact mechanism is worth more than its weight in gold, for the pieces all fit together smoothly and the wearer hardly notices the bulk. Of course, I had no intention of destroying my finds for armor, no matter how valuable. I would bring it back to the Society for scientific study. I imagined the astonished cries of my colleagues as I unveiled it at my next lecture, and smiled again.

I picked up a discarded gear from the piles at my feet. It still gleamed brightly, as if new-made, the Dwarven alloys resisting the corrosion of time. I wondered what secrets remained hidden in the maze of chambers that lay before me, defying the efforts of looters, waiting to gleam again in the light they had not seen in long eons. Waiting for me. It remained only to find them! With an impatient gesture to Master Arum to follow, I strode forward into the gloom.

Master Arum, Ten Penny and I spent several days exploring the ruins while my assistants set up camp at the top of the cliff and hauled supplies and equipment from the village. I was looking for a promising area to begin excavation -- a blocked passage or corridor untouched by looters that might lead to completely untouched areas of the ruins.

We found two such areas early on, but soon discovered that the many winding passages bypassed the blockage and gave access to the rooms behind. Nevertheless, even these outer areas, for the most part stripped clean of artifacts by generations of looters, were full of interest to the professional archaeologist. Behind a massive bronze door, burst from its hinges by some ancient turmoil of the earth, we discovered a large chamber filled with exquisite wall-carvings, which impressed even the jaded Ten Penny, who claimed to have explored every Dwarven ruin in Morrowind. They seemed to depict an ancient ritual of some kind, with a long line of classically-bearded Dwarven elders processing down the side walls, all seemingly bowing to the giant form of a god carved into the front wall of the chamber, which was caught in the act of stepping forth from the crater of a mountain in a cloud of smoke or steam. According to Master Arum, there are no known depictions of Dwarven religious rituals, so this was an exciting find indeed. I set a team to work prying the carved panels from the wall, but they were unable to even crack the surface. On closer examination the chamber appeared to be faced with a metallic substance with the texture and feel of stone, impervious to any of our tools. I considered having Master Arum try his blasting magic on the walls, but decided that the risk of destroying the carvings was too great. Much as I would have preferred to bring them back to the Imperial City, I had to settle for taking rubbings of the carvings. If my colleagues in the Society showed enough interest, I was sure a specialist could be found, perhaps a master alchemist, who could find a way to safely remove the panels.

I found another curious room at the top of a long winding stair, barely passable due to the fall of rubble from the roof. At the top of the stair was a domed chamber with a large ruined mechanism at its center. Painted constellations were still visible in some places on the surface of the dome. Master Arum and I agreed that this must have been some kind of observatory, and the mechanism was therefore the remains of a Dwarven telescope. To remove it from ruins down the narrow stairway would require its complete disassembly (which fact no doubt had preserved it from the attention of looters), so I decided to leave it in place for the time being. The existence of this observatory suggested, however, that this room had once been above the surface. Closer examination of the structure revealed that this was indeed a building, not an excavated chamber. The only other doorways from the room were completely blocked, and careful measurements from the top of the cliff to the entry room and then to the observatory revealed that we were still more than 250 feet below the present ground level. A sobering reminder of the forgotten fury of Red Mountain.

This discovery led us to focus our attentions downward. Since we now knew approximately where the ancient surface lay, we could rule out many of the higher blocked passages. One wide passage, impressively flanked with carven pillars, particularly drew my interest. It ended in a massive rockfall, but we could see where looters had begun and then abandoned a tunnel through this debris. With my team of diggers and Master Arum’s magery to assist, I believed we could succeed where our predecessors had failed. I therefore set my team of Dark Elves to work on clearing the passage, relieved finally to be beginning the real exploration of Kemel-Ze. Soon, I hoped, my boots would be stirring up dust that had lain undisturbed since the dawn of time.

With this exciting prospect before me, I may have driven my diggers a bit too hard. Ten Penny reported that they were beginning to grumble about the long days, and that some were talking of quitting. Knowing from experience that nothing puts heart back into these Dark Elves like a taste of the lash, I had the ringleaders whipped and the rest confined to the ruins until they had finished clearing the passageway. Thank Stendarr for my foresight in requisitioning a few legionnaires from Seyda Neen! They were sullen at first, but with the promise of an extra day’s wages when they broke through, they soon set to work with a will. While these measures may sound harsh to my readers back in the comforts of civilization, let me assure you that there is no other way to get these people to stick to a task.

The blockage was much worse than I had first thought, and in the end it took almost two weeks to clear the passage. The diggers were as excited as I was when their picks finally broke through the far end into emptiness, and we shared a round of the local liquor together (a foul concoction, in truth) to show that all was forgiven. I could hardly restrain my eagerness as they enlarged the hole to allow entry into the chamber beyond. Would the passage lead to entire new levels of the ancient city, filled with artifacts left by the vanished Dwarves? Or would it be only a dead end, some side passage leading nowhere? My excitement grew as I slid through the hole and crouched for a moment in the darkness beyond. From the echoing sounds of the stones rattling beneath my feet, I was in a large room. Perhaps very large. I stood up carefully, and unhooded my lantern. As the light flooded the chamber, I looked around in astonishment. Here were wonders beyond even my wildest dreams!

As the light from my lamp filled the chamber beyond the rock fall, I looked around in astonishment. Everywhere was the warm glitter of Dwarven alloys. I had found an untouched section of the ancient city! My heart pounding with excitement, I looked around me. The room was vast, the roof soaring up into darkness beyond the reach of my lamp, the far end lost in shadows with only a tantalizing glimmer hinting at treasures not yet revealed. Along each wall stood rows of mechanical men, intact except for one oddity: their heads had been ritually removed and placed on the floor at their feet. This could mean only one thing -- I had discovered the tomb of a great Dwarven noble, maybe even a king! Burials of this type had been discovered before, most famously by Ransom’s expedition to Hammerfell, but no completely intact tomb had ever been found. Until now.

But if this was truly a royal burial, where was the tomb? I stepped forward gingerly, the rows of headless bodies standing silently as they had for eons, their disembodied eyes seeming to watch me as I passed. I had heard wild tales of the Curse of the Dwarves, but had always laughed it off as superstition. But now, breathing the same air as the mysterious builders of this city, which had lain undisturbed since the cataclysm that spelled their doom, I felt a twinge of fear. There was some power here, I felt, something malevolent that resented my presence. I stopped for a moment and listened. All was silent.

Except... it seemed I heard a faint hiss, regular as breathing. I fought down a sudden surge of panic. I was unarmed, not thinking of danger in my haste to explore past the blocked passage. Sweat dripped down my face as I scanned the gloom for any movement. The room was warm, I suddenly noticed, much warmer than the rest of the labyrinth thus far. My excitement returned. Could I have found a section of the city still connected to a functioning steam grid? Pipes ran along the walls, as in all sections of the city. I walked over and placed my hand on one. It was hot, almost too hot to touch! Now I saw that in places where the ancient piping had corroded, small jets of steam were escaping -- the sound I had heard. I laughed at my own credulity.

I now advanced quickly to the far end of the room, giving a cheerful salute to the ranks of mechanical soldiers who had appeared so menacing only moments before. I smiled with triumph as the light swept back the darkness of centuries to reveal the giant effigy of a Dwarven king standing on a raised dais, his metal hand clutching his rod of office. This was the prize indeed! I circled the dais slowly, admiring the craftsmanship of the ancient Dwarves. The golden king stood twenty feet tall under a freestanding domed cupola, his long upswept beard jutting forward proudly as his glittering metal eyes seemed to follow me. But my superstitious mood had passed, and I gazed benevolently on the old Dwarven king. My king, as I had already begun to think of him. I stepped onto the dais to get a better look at the sculpted armor. Suddenly the eyes of the figure opened and it raised a mailed fist to strike!

I leaped to one side as the golden arm came crashing down, striking sparks from the steps where I had stood a moment before. With a hiss of steam and the whir of gears, the giant figure stepped ponderously out from under its canopy and strode towards me with frightening speed, its eyes tracking me as I scrambled backwards. I dodged behind a pillar as the fist whistled down again. I had dropped my lantern in the confusion, and now I crept into the darkness outside the pool of light, hoping to slip between the headless mechanisms and thus escape back to the safety of the passageway. Where had the monster gone? You would think that a twenty-foot golden kind would be hard to miss, but he was nowhere to be seen. The guttering lamp only illuminated a small part of the room. He could be hiding anywhere in the gloom. I crawled faster. Without warning, the dim ranks of Dwarven soldiers in front of me went flying as the monstrous guardian loomed before me. He had cut off my escape! As I dodged backwards, blow after blow whistled down as the implacable machine followed me relentlessly, driving me into the far corner of the room. At last there was nowhere left for me to go. My back was to the wall. I glared up at my foe, determined to die on my feet. The huge fists lifted for one final blow.

The room blazed with sudden light. Bolts of purple energy crackled across the metal carapace of the Dwarven monster, and it halted, half-turning to meet this new threat. Master Arum had come! I was about to raise a cheer when the giant figure turned back to me, unharmed by the lightning bolt hurled by Master Arum, determined to destroy this first intruder. I shouted out “Steam! Steam!” as the giant raised his fist to crush me into the floor. There was a hiss and a gust of bitter cold and I looked up. The monster was now covered with a shell of ice, frozen in the very moment of dispatching me. Master Arum had understood. I leaned against the wall with relief.

The ice cracked above me. The giant golden king stood before me, the shell of ice falling away, his head swiveling towards me in triumph. Was there no stopping this Dwarven monstrosity?! But then the light faded from his eyes, and his arms dropped to his sides. The magical frost had worked, cooling its steam-driven energy.

As Master Arum and the diggers crowded around me, congratulating me on my narrow escape, my thoughts drifted. I imagined my return to the Imperial City, and I knew that this would be my greatest triumph yet. How could I possibly top this find? Perhaps it was time to move on. Recovering the fabled Eye of Argonia... now that would be a coup! I smiled to myself, reveling in the glory of the moment but already planning my next adventure.', 0);

-- AR-VI-010 — Skorm Snow-Strider’s Journal
INSERT INTO tomes (id, call_number, title, author, school, body, restricted) VALUES
  (163, 'AR-VI-010', 'Skorm Snow-Strider’s Journal', 'Skorm Snow-Strider', 'Journals & Logs',
   '13th of Sun’s Dusk 1E139

At the command of Lord Harald we have swept our company to the south edge of our territories in an attempt to drive the Snow Elves up north to the main host of his forces. The first few days met with heavy resistance, but as we approached the eastern edge of Lake Honnith we have seen little and less of them.

21st of Sun’s Dusk 1E139

We’ve begun to receive reports of attacks back around Lake Honnith and word has come from the front that we should pull back to be sure we are not leaving our rear exposed. If there is a stronghold of Elves here, we will surely root them out.

27th of Sun’s Dusk 1E139

It sounds impossible, but we appeared to have stumbled upon a massive hold out of the Dragon Cultists, who were believed to be wiped out during the Dragon War. The Elves must wait, as this is a threat we cannot ignore. If we are quick, we may be able to catch them unaware and avoid a lengthy siege.

21st of Evening Star 1E139

Third week of the siege. The men grow restless with the cold and all miss their families. If that blasted storm hadn’t caught us off guard and slowed our ascent we might have taken the Monastery, but as it stands we may be in for several more weeks of pounding on their walls. I’ve sent word to Harald to send one of the Voice masters to help bring down the wall.

4th of Morning Star 1E140

We’ve brought down their main gate thanks to the young Voice master, but the brash lad took an arrow in the neck in the process. It seems he will be joining the Eight in Sovngarde soon. The cultists have fallen back to the interior of the Monastery but soon enough we will breach those defenses. The sooner the better - it’s too blasted cold on this mountain.

5th of Morning Star 1E140

We entered the Monastery today only to find all inside dead. It appears they purposely caved in the stairway to the refectory and then took their own lives. Some appear to have slit their own wrists, others we found with empty vials. Most appear to be poisoned, but oddly there are not as many empty bottles as one would expect by the number of dead. We shall hold up here over night rather than face the cold, and explore the catacombs in the morning to see if we can find another passage to the upper areas.

6th of Morning Star 1E140

May the Eight protect us from Dragons and madmen. We lost half our remaining men today. We discovered a well in the catacombs, locked but with several buckets already filled, and in their excitement for a drink that didn’t risk frostbite on their tongue, two score drank before we could stop them. Gods only know how these cultists could use that horrible poison in their own water supply. We’ve lost more men to this catastrophe than we did taking the courtyard.

The well was locked from this side, and the key must be somewhere in the catacombs, but with the ghosts of these dead cultists and the men demoralized, it just isn’t worth the search. Let those gods-forsaken cultists drink their way to Oblivion and be done with it. The upper door in the courtyard has some sort of barrier over it and our mages believe that the sacrifice made here will sustain it for decades at the least.

We leave this accursed place tomorrow to regroup and push up north, but I will leave this journal, so that in an age or so when the poison has faded, someone may find a way in to be sure the cultists met their due fate.', 0);

-- AR-VI-011 — Twin Secrets
INSERT INTO tomes (id, call_number, title, author, school, body, restricted) VALUES
  (164, 'AR-VI-011', 'Twin Secrets', 'Brarilu Theran', 'Journals & Logs',
   'These secrets I lay down, knowing full well that none may ever take advantage of them. I am upon my death bed, and am loathe to see knowledge of any sort lost to the mists of time. Take these as the foolish reminiscences of an old man, or the insights of a master enchanter. I care not which.

It is well known that enchanting is limited where it once was not. The best enchanters of this age can imbue almost any spells into the metal and leather of armor and weapons. However, once enchanted, such an item will not enchant again. It is called the Law of Firsts. The first enchantment is the only one that takes.

In my life, I’ve traveled widely. I’ve seen Summerset Isle, communed with Psijiics, walked the shores of Akavir. I had hoped to see lost Atmora before I passed, that is not to be. I have even done the unthinkable. I have spoken to a dragon.

Dragons are said to be gone from the world. Yet I found one. Sheltered in the smoking ruins of Vvardenfell, I came upon it. My magic proved to be sufficient to defeat the beast. If that gives you cause to wonder, I will not deny that I was once a pyromancer of great skill.

Exhausted and near the end of my spells, I parlayed with the wyrm, offering it life if it would share it’s secrets. Haughty to the end, it agreed to one secret for one life. I asked for it’s name, but it told me it would rather die than surrender that. Instead if offered me something else. And that it how I learned how to defy the Law of Firsts.

The law itself is inviolate. However, the skillful enchanter can weave two enchantments simultaneously into an item. For men and elves, the limit is two. The dragon said that men and elves have two arms, two legs, two eyes and two ears. I asked why that mattered, and the beast just laughed.

The enchanter must weave one enchantment with the left hand while weaving the other with the right. The eyes must focus on one and only one enchantment, while the ears only pay attention to the other. When I asked about my legs, the beast laughed again.

I spent two years mastering the technique. Just last month I made a sword with both fire and fear enchantments. Now I am too weak to make another. I go to my death victorious, for I have done what no other enchanter in modern times has done.', 0);

-- AR-VI-012 — Venarus Vulpin’s Journal
INSERT INTO tomes (id, call_number, title, author, school, body, restricted) VALUES
  (165, 'AR-VI-012', 'Venarus Vulpin’s Journal', 'Venarus Vulpin', 'Journals & Logs',
   '~ 28th of Sun’s Dusk, 4E 200

I’ve found an interesting book of short stories on the pawnshop’s shelves today. I don’t think the owner will mind if I take it. I really should spend more time around the docks, these Altmer are too thin blooded for my taste.

Anyway, one of the tales in the book is an account of the “Bloodspring of Lengeir’s Feast,” a fabled source of power for vampires. It is a story I’ve read several renditions of before but this version suggests that it may be located in Skyrim, in a ruin buried by quaking of the earth during the 2nd Era.

Considering that my business here with Inquisitor Amolmaire is, shall we say, at an end, it might be a good time to leave Summerset for a worthwhile diversion for the next twenty to thirty years. Perhaps I shall investigate this fabled Bloodspring.

~ 2nd of Morning Star, 4E 201

I was able to obtain passage from Alinor to Solitude by way of ship. No mean feat with this Nord insurrection going on, I assure you. I ran across one of my own in the local tavern and feared at first that it might cause problems for me, but it turns out that she is well-positioned here in the city and has been happy to help if I keep a civil manner. We spoke much on my research into the Bloodspring and while she made sure to point out she thinks it a “soft headed pursuit” she did say that what she’s heard would point to The Rift.

~ 5th of First Seed, 4E 201

After months of searching I finally may have found a lead. While looking for a bit of dinner in the Vilemyr Inn, I overheard an old hermit by the name of Jokull, talking about strange red water he found bubbling out of the ground.

Once I dispose of this soldier, I’ll follow to see if I can find the location.

~ 13th of First Seed, 4E 201

I can’t believe I didn’t realize sooner.

Jokull has been taking buckets of rock and dirt out of his house all week. When I realized that he’s digging a basement I snuck in to check if he had uncovered the Bloodspring. He’s hit a cave system that must be where Bloodspring has sunken into over the years. It was hard to see in the dim light, even with my eyes, but I would swear the water I saw pooled on the ground was red.

Unfortunately he woke up while I was exploring the basement and he dropped his torch on a pelt as I killed him. More setbacks.

~ 4th of Rain’s Hand, 4E 201

The runnels I initially found had passed through too much rock and dirt but I’ve “befriended” some of the locals and we’ve managed to find the source of the Bloodspring. We’ve kept a low profile so as not to draw too much attention and thus far I’ve managed to keep them to only attacking hunters and other dregs, but we’ll need to set up a ready food source that won’t draw too much attention if we are to remain here.

The Bloodspring is not everything that I’d hoped it would be. Though it is blood and gives great strength it provides no sustenance. And the power it grants lasts only for a short while and carries a weakening of the body and mind with it. I’ve had to lock the door to the chamber to keep the others from becoming completely dependent upon it. When I’ve tested it on mortals, it is worse for them, for it carries only disease and addiction with no benefits at all.

Addiction.

I may have just found a solution for our food problem.', 0);

-- AR-VI-013 — Venarus Vulpin’s Research
INSERT INTO tomes (id, call_number, title, author, school, body, restricted) VALUES
  (166, 'AR-VI-013', 'Venarus Vulpin’s Research', 'Venarus Vulpin', 'Journals & Logs',
   '~ 19th of Second Seed, 4E 201

Thanks to the more sordid past of some of my underlings, we found a way to add the waters of the Bloodspring into the process for turning moonsugar to skooma. It is far more potent and highly addictive. We’ve turned the basement into a Den and sent out some of the locals with “samples” to lure people back, turning the disappointment of the spring into a ready supply of blood.

We’re calling it Redwater Skooma, in case any of the patrons happen to notice “water” in any of the corners.

I’ve found many ruined books in the chambers connected to the spring and will continue to study them for a way to drink the waters without the side effects. Mortals appear to become infected with all manner of disease, while Vampires gain power but only for a short while.

~ 9th of Mid Year, 4E 201

Many of the books I’ve found are but tattered shreds, ruined by the ages and moisture, but I’ve pieced together the origin of the Spring, if little else.

It used to be a spring sacred to Arkay in the 1st Era, headed by the priest, Lengeir. I’m glossing over much that isn’t of interest to my search, but it would seem that the woman he was in love with was bitten and turned into a vampire and subsequently turned him as well. They went on a rampage through the Spring and killed the other priests as they cowered in the pool, praying for Arkay’s protection.

“...and as we tore the spine... ...last priestess... ...took the viscera into the Bloodstone Chalice... ...waters ran red forever more...”

Perhaps this “Bloodstone Chalice” is the answer.

~ 18th of Sun’s Height, 4E 201

Weeks of research and still nothing to show for it. It would seem that the Bloodstone Chalice is most likely the key to harnessing the power of the Spring, but it is also clear that at some point it was removed from the ruins.

I’ve found an illustration of it which I have endeavored to sketch here, but nothing else regarding where it may have ended up.', 0);

-- AR-VI-014 — Wabbajack
INSERT INTO tomes (id, call_number, title, author, school, body, restricted) VALUES
  (167, 'AR-VI-014', 'Wabbajack', 'Anonymous', 'Journals & Logs',
   'Little boys shouldn’t summon up the forces of eternal darkness unless they have an adult supervising, I know, I know. But on that sunny night on the 5th of First Seed, I didn’t want an adult. I wanted Hermaeus Mora, the daedra of knowledge, learning, gums, and varnishes. You see, I was told by a beautiful, large breasted man who lived under the library in my home town that the 5th of First Seed was Hermaeus Mora’s night. And if I wanted the Oghma Infinium, the book of knowledge, I had to summon him. When you’re the new king of Solitude, every bit of knowledge helps.

Normally, you need a witches coven, or a mages guild, or at least matching pillow case and sheets to invoke a prince of Oblivion. The Man Under the Library showed me how to do it myself. He told me to wait until the storm was at its height before shaving the cat. I’ve forgotten the rest of the ceremony. It doesn’t matter.

Someone appeared who I thought was Hermaeus Mora. The only thing that made me somewhat suspicious was Hermaeus Mora, from what I read, was a big blobby multi-eyed clawed monstrosity, and this guy looked like a waistcoated banker. Also, he kept calling himself Sheogorath, not Hermaeus Mora. Still, I was so happy to have successfully summoned Hermaeus Mora, these inconsistencies did not bother me. He had me do some things that didn’t make any sense to me (beyond the mortal scope, breadth, and ken, I suppose), and then his servant happily gave me something he called the Wabbajack. Wabbajack. Wabbajack.

Wabbajack.

Wabbajack. Wabbajack. Wabbajack. Wabbajack. Wabbajack. Wabbajack.

Maybe the Wabbajack is the Book of Knowledge. Maybe I’m smarter because I know cats can be bats can be rats can be hats can be gnats can be thats can be thises. And that doors can be boars can be snores can be floors can be roars can be spores can be yours can be mine. I must be smart, for the interconnective system is very clear to me. Then why, or wherefore do people keep calling me mad?

Wabbajack. Wabbajack. Wabbajack.', 0);

-- AR-VI-015 — Watcher of Stones
INSERT INTO tomes (id, call_number, title, author, school, body, restricted) VALUES
  (168, 'AR-VI-015', 'Watcher of Stones', 'Gelyph Sig Thane of Bjorin', 'Journals & Logs',
   'Long have I waited at the Guardians. I must know: are the stories true? Surely you’ve heard them. Tales of the stones granting powers to Heroes of old, those special few being able to choose any stone to rewrite his fate. Of course you’ve heard them, that’s why you touch the stones as you pass by. You’ve heard they bring luck, or a sign from the gods. But you think little of the action. It has no true meaning for you. I see it in your eyes as you pass. You do not believe. But I have always believed. Always felt that I was one of the few whose fate was not sealed at birth by the stars overhead. One of the few who could use these stones, draw on the power of the gods to change my life, change my future. I have always felt it.

I have done much in my years. Fought battles, defended villages, quested and adventured throughout Skyrim. I have bested the Companions of Whiterun in combat, and performed deeds worthy of everlasting praise in song from the Bards College. No task was too small or great if it could bring me honor, glory, proof that I was worthy of the stones’ power.

And yet, nothing.

I have found many of these accursed stones in my travels, and none have responded to my touch. With each new feat I would return to the Guardians, wondering if the gods finally deemed me worthy. But now those days are gone. I am an old man, with no fight left in me. And so here I sit, watching the faces of those who pass by on their daily errands, their mundane travels from one city or town to another. Most of you do not even give the stones a passing glance. You have never heard their call, you will never feel drawn to them. Some days, I envy you that.

Long will I wait at the Guardians, for I must know. Are the stories true?', 0);

-- Cross-references, derived from the titles named in these bodies.
INSERT INTO citations (from_tome, cites_call_number) VALUES (154, 'AR-X-023');
INSERT INTO citations (from_tome, cites_call_number) VALUES (157, 'AR-IX-004');
INSERT INTO citations (from_tome, cites_call_number) VALUES (158, 'AR-IV-023');
INSERT INTO citations (from_tome, cites_call_number) VALUES (159, 'AR-II-005');
INSERT INTO citations (from_tome, cites_call_number) VALUES (161, 'AR-IV-033');
INSERT INTO citations (from_tome, cites_call_number) VALUES (163, 'AR-X-011');
