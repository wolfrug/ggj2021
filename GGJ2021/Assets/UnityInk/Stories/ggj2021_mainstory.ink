INCLUDE ggj2021_functions.ink
INCLUDE ggj2021_journal.ink

// Default main story object - always have a stitch named ==start
{debug:
->OpenJournalInt
}
==start
->DONE
This is the start of the story.

->Say("This is a dialogue", "MyCharacter")->

+ [Open the journal] ->OpenJournalInt->

- And that's all for now.

+ [Close writer.] ->DONE

==inspectTank
Looks like a tank to me.
->DONE

==inspectTest
Testing inspection!
->DONE

==talkTest

You meet a dapper dude! Do we have the item he needs?
{CheckItem(Testitem1, 1)>0:
Yes we do, a total of {print_num(CheckItem(Testitem1, 1))} in stock! Let's eat some.
++ [Eat one.]->eatOne
- else:
We do not, sadly.
}
- + [Let's just do the talk-test]->talk

=eatOne
{Consume(Testitem1, 1)}
Ate one? Now we have...{print_num(CheckItem(Testitem1, 1))} left! Nice.
->DONE

=talk
->Say("Hey dude", George)->
->Say("I'm just testing if this works", George)->
->Say("Hey back", Player)->
->Say("Looks like it works!", George)->
{EndSay()}
You say goodbye.
->DONE