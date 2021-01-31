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
{UseText("journal_description")}Notes ?

// BEGINNING OF ENTRY
+ [Entry 1]
->exampleJournalEntry->
<-navigation
++[Back]->journal_1
// END OF ENTRY

// BEGINNING OF ENTRY
+ {exampleJournalEntry>0}[Entry 2]
<-navigation
(Only appears conditionally! Wow). You can also write entries directly into the journal like this, but it makes things a bit messy. Just make sure to write them -under- the navigation back-arrow.
++[Back]->journal_1
// END OF ENTRY

// FINAL ENTRY <- this just auto-sends the journal back to the start just in case.
- ->journal_1
// END OF TAB 1

=journal_2
<-navigation
{UseText("journal_description")}Hints ?

// START OF ENTRY
+ [Entry 1]
<-navigation
Maybe have hints here? I dunno.
++[Back]->journal_2
// END OF ENTRY

// FINAL ENTRY
- ->journal_2
// END OF TAB 2

=journal_3
<-navigation
{UseText("journal_description")}Spells ?

// START OF ENTRY
+ [Spell 1?]
->anotherExample->
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

==anotherExample
Maybe your spell book could be filled in from the start? And have the hints like 'something soft, something hard, something wet' and so on? Up to you.
->->