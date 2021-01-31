VAR isJournalOpen = false
VAR journal_last_open_tab = ->Journal.journal_1

==OpenJournalExt==
// This is called externally, and ends with a ->DONE
// We close it if it is already open
{not isJournalOpen:
#openJournal
~isJournalOpen = true
<i></i>
->Journal->
#closeJournal
~isJournalOpen = false
<i></i>
->DONE
- else:
#closeJournal
~isJournalOpen = false
<i></i>
->DONE
}


==OpenJournalInt==
// This is called internally, and ends with a tunnel
#openJournal
~isJournalOpen = true
<i></i>
->Journal->
#closeJournal
~isJournalOpen = false
<i></i>
->->

==CloseJournal(continue)
#closeJournal
~isJournalOpen = false
<i></i>
{continue:
->->
- else:
->DONE
}

==Journal
// OPENING THE JOURNAL TO LAST SAVED SPOT
->journal_last_open_tab

=journal_1
<-navigation
{UseText("journal_description")}Notes

PROPERTY OF SADIE
PRIVATE!!!
DO NOT READ >:-(

// BEGINNING OF ENTRY
+ [Entry 1]
->journalentry0->
<-navigation
++[Back]->journal_1
// END OF ENTRY

// BEGINNING OF ENTRY
+ {firstGhost.talk>0}[Entry 2]
<-navigation
//(Only appears conditionally! Wow). You can also write entries directly into the journal like this, but it makes things a bit messy. Just make sure to write them -under- the navigation back-arrow.
++[Back]->journal_1
// END OF ENTRY

//is this right? ahhhhh

+ {firstGhost.talk2>0}[Entry 3]
->journalentry2->
<-navigation
++[Back]->journal_1
// END OF ENTRY

+ {firstGhost.talk3>0}[Entry 4]
->journalentry3->
<-navigation
++[Back]->journal_1
// END OF ENTRY

+ {firstGhost.talkspellsuccess>0}[Entry 5]
->journalentry4success->
<-navigation
++[Back]->journal_1
// END OF ENTRY

+ {firstGhost.talkspellfailure>0}[Entry 4]
->journalentry4failure->
<-navigation
++[Back]->journal_1
// END OF ENTRY

// FINAL ENTRY <- this just auto-sends the journal back to the start just in case.
- ->journal_1
// END OF TAB 1




=journal_2
<-navigation
{UseText("journal_description")}Hints

// START OF ENTRY
+ [Entry 1]
->hint0->
<-navigation
//Maybe have hints here? I dunno. 
++[Back]->journal_2
// END OF ENTRY

//I dunno either. Is any of this right?

// BEGINNING OF ENTRY
+ {firstGhost.talk>0}[Entry 2]
->hint1->
<-navigation
++[Back]->journal_2
// END OF ENTRY

+ {firstGhost.talk2>0}[Entry 3]
->hint2->
<-navigation
++[Back]->journal_2
// END OF ENTRY

+ {firstGhost.talk3>0}[Entry 4]
->hint3->
<-navigation
++[Back]->journal_2
// END OF ENTRY

+ {firstGhost.talkspellsuccess>0} {firstGhost.talkspellfailure>0} [Entry 5]
->hint4->
<-navigation
++[Back]->journal_2
// END OF ENTRY


// FINAL ENTRY
- ->journal_2
// END OF TAB 2



=journal_3
<-navigation
{UseText("journal_description")}Spells

// START OF ENTRY
+ [Spells]
->spells->
<-navigation
++[Back]->journal_3
// END OF ENTRY

// FINAL ENTRY
- ->journal_3
// END OF TAB 3



=navigation
+ [{UseButton("journal_1")}Notes]
~journal_last_open_tab = ->Journal.journal_1
->journal_1
+ [{UseButton("journal_2")}Hints]
~journal_last_open_tab = ->Journal.journal_2
->journal_2
+ [{UseButton("journal_3")}Spells]
~journal_last_open_tab = ->Journal.journal_3
->journal_3
+ [{UseButton("journal_quit")}X]
->closeJournal

=closeJournal
{UseText("journal_description")} <br>
->->


==exampleJournalEntry

This is the journal entry text, completely normal. It is what would appear after you click the button on the appropriate tab (button on right) - the text would be on the left. As a journal entry, we probably just want this to appear and take up all the space, so all you have to do is end it with a tunnel.
->->

==spells
HOW TO KEEP ICKY GHOSTS OFF YOU:

Make a stink-spell: combine something stinky with something that smells good (bind together tightly - tape?). Banishes ghosts back to wherever they came from.

Forget-me-spell: create an emptiness out of empty things. Cans, bottles, boxes. Cast to make the ghosts forget you...for a while.
->->


===journalentry0
There was a terrible storm last night, the biggest storm I've seen in years. 

It reminded me of the stories Grandmother used to tell about the end of the world, and the storms that swept across the planet, bringing chaos and magic into the world. 

I can still smell the lingering scent of ozone and magic in the air. It feels like something is about to happen. Or maybe my nerves are just on edge. 

I should probably take a look around, bbut first I should clean up the yard and gather some fuel for a fire. A good fire spell should be just the trick for dispelling any residual magic in the air.
->->



===journalentry1
You’d think the end of the world would have removed the pressures of social interaction, but no such luck. A stray ghost was drawn to my fire this morning, and he wants my help finding some missing item. Only problem is he can’t remember what it is, or where he left it… People really are the worst.

If I don’t help him he’ll just keep following me around, making sad faces and sucking all the warmth out of the place. Better to get it over and done with - like ripping off a band aid. 

I’ll take him for a walk around the neighbourhood and see if anything jogs his memory.
->->


===journalentry2
Looks like we aren’t alone out here. There are spirits all over the place, and not all of them are friendly. Luckily I know how to handle myself. Still I should craft some protection spells, just in case.

Meanwhile, the saga of ‘George the ghost’ continues. We’ve ended up in this dodgy old trailer park. The way he’s dressed I assumed he was from the nicer part of town. Just goes to show, you can’t judge a ghost by his perfectly waxed mustache...

I should look around and see if I can find this item of his. He said it’s small, and wooden, and has something to do with smoke, or smoking. 

Honestly, why do ghosts always have to be so insufferably vague?
->->


===journalentry3
Well we did it! We found the missing pipe. Only problem is, George is still stuck here. Which means that I’m still stuck here...with George. Truly a Witch’s work is never done.

To help George on I’m going to have to make a specific spell to gather up the essence of his spirit and help him move on from this place (and me). Spell crafting always involves a little bit of guesswork.

George’s identity seems to be firmly rooted in his memories of the past - stories by the fire, his grandfather, and the smell of burning tobacco. There might be a spell in there somewhere.

I’ll need George’s pipe, plus something that buns, and some sort of generic item for triggering memory?? 

Hopefully I get this right. There’s only a man’s soul at stake, no big deal. But those who don’t dare, don’t succeed! Or some nonsense to that effect.
->->


==journalentry4success
On my own again! At last!

...Guess I should go home, tend the fire, finish cleaning up? Things feel weirdly empty. I guess George is the first person I’ve really talked to since Grandmother died. Guess I’m not as much of a misanthrope as I like to think. Though I’ll deny it to my grave, just you try me!

But yeah, this whole thing has got me thinking. Maybe it would be nice to have someone to talk to on occasion. I can’t be the only living person out here, can I? 

I know after the Apocalypse things got rough, but humans are like cockroaches, we can survive just about anything.

Something to think about at least. But until then, I guess I should go home.

->->


==journalentry4failure
Well, I’m on my own again, sort of? Except now there’s some sort of terrifying bovine demon running around, and George - poor, George, is gone.

I must have used the wrong spell. Some key ingredient must have countered the other elements. But there’s nothing I can do about it now...

I should go home and regroup. Something tells me I’ll have to keep an eye out for that demon from now on.

This isn’t over.
->->





==hint0
To do list: I should gather some fuel and start a fire to dispell any bad energies left over from the storm.
->->

==hint1
Hint 1: Need to help this ghost find a missing object so he can shuffle off this mortal plane, should probably look around nearby.
->->

==hint2
Hint 2: Look for a small wooden item that has something to do with smoke, or smoking.
->->

==hint3
Hint 3: Spell crafting is an intuitive art. To help George move on I will need to craft a spell using the following ingredients: George’s pipe, something that burns, and an item to represent memory.
->->

==hint4
Hint 4: I should make my way back home to get some rest.
->->



==spellfire //example

Foolproof Fire Spell (good for wanton arson, and making campfires)

Fetch some wood, take it to a neary fireplace, and set it alight.

Honestly, what did you expect?
->->



