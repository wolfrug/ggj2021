INCLUDE ggj2021_functions.ink
INCLUDE ggj2021_journal.ink

==inspectContainer
Full of things I could use, I hope...
->DONE
==inspectGeorge
A lonely, wandering ghost. Ugh...
->DONE

// Default main story object - always have a stitch named ==start
{debug:
->firstGhost.talk
}
==start
->OpenJournalInt->
->DONE

==ghostTalk
{firstGhost.talk<1:
->firstGhost.talk
}
{firstGhost.talk2 < 1:
->firstGhost.talk2
}
{firstGhost.itemfound<1:
->firstGhost.talk3
}
->firstGhost.looking


===firstGhost

=talk
->Say("Er, hi there Mr–", Sadie)->
->Say("–George, my name is George...or at least it was, once.", George)->
->Say("Right, well can I help you with something, George? You look a little lost.", Sadie)->
->Say("Well now that you mention it, I am a bit turned around.!", George)->
->Say("I was looking for something - something important. But I can’t for the life of me remember where I left it.", George.)->
->Say("Well do you remember anything specific - like what it was, or what it looked like? Or are there any landmarks in the area where you lost it?", Sadie)->
->Say("Nope. There’s nothing I’m afraid. I can’t remember a thing. There’s just this nagging sense that something’s missing.", George)->
->Say("Of course not, that would have been too easy.", Sadie)->
->Say("Right… How about this? You and I will take a look around, and if you see something familiar you can point it out to me.", Sadie)->
->Say("With any luck we’ll find this thing of yours, and be able to go our separate ways in no time.", Sadie)->
->Say("Oh, thank you young witch, that’s very kind of you!", George)->
->Say("My motivations are entirely selfish, I assure you. And the name's Sadie.", Sadie)->
->Say("Now come along, I don’t have all day!.", Sadie)->
{EndSay()}
#deleteGhost1
The ghost tips his hat to you as you turn away. 
->DONE


=talk2 //when location reached

->Say("Is everything okay?", Sadie)->
->Say("Yes actually, I think I’ve remembered something!.", George)->
->Say("It’s this place, it looks familiar somehow.", George)->
->Say("Maybe this was your home?", Sadie)->
->Say("Maybe... But, somehow I don’t think so. It seems so small. My home was large, and full of light and colour. There were always people coming and going!", George)->
->Say("Look at you, remembering all sorts of things! That’s a good sign. ", Sadie)->
->Say("Yes, but it doesn’t explain why we’re here.", George)->
->Say("Maybe you lost your item nearby?", Sadie)->
->Say("Perhaps. Would you mind looking around for me and seeing what you find?.", George)->
->Say("Sure thing. But I’ll need to know what I’m looking for first. Have any more memories shaken loose?", Sadie)->
->Say("Now that you mention it, yes, they have! I remember it being small enough to fit into my hand. I think it was made of wood, and had something to do with fire? No, wait that’s not right.", George)->
->Say("Smoke! It was something to do with smoke, or maybe smoking. I’m sorry, I can’t remember anything more. Hopefully that helps.", George)->
->Say("It’ll have to do. I’ll take a look around.", Sadie)->
{EndSay()}
You say goodbye.. 
->DONE




=talk3 //when item found

I should check in with George again.

{CheckItem(ing_pipe, 1)>0:
Is this what you were looking for?->itemfound
- else:
You still haven’t found what you need. Maybe you should keep looking.
}
->DONE


=itemfound
->Say("Would you look at that, it’s my smoking pipe!", George)->
->Say("Where on earth did you find it?", George)->
->Say("Oh you know, over there behind some trash.", Sadie)->
->Say("It’s so wonderful to see it again. It was all I had left after...", George)->
->Say("After?.", Sadie)->
->Say("After everything went wrong.", George)->
->Say("I remember now. The big house, all the people coming and going, family in every room. I lost all of it.", George)->
->Say("I’m sorry to hear that.", Sadie)->
->Say("I ended up here in this... terrible place. And all I had left was this pipe, a memento of happier times. When I was a boy my Grandfather would sit and tell me stories while he smoked this pipe.", George)->
->Say("He left it to me when he died, and smoking it always reminded me of him - the sound of his voice lulling me to sleep, the smell of tobacco drifting through the air.", George)->
->Say("Sounds like a nice memory. My Grandmother, she...well, she used to tell me stories too.", Sadie)->
->Say("It sounds like you miss her.", George)->
->Say("I do sometimes. But I manage okay on my own. I don’t need anyone.", Sadie)->
->Say("We all need someone to talk to now and again.", George)->
->Say("Yeah, well. Some more than others I guess.", Sadie)->
->Say("So, now that you have your pipe back, do you feel like you are ready to move on?.", Sadie)->
->Say("Hmm, I don’t think so. There’s still something in the way, like static in the air. Everything is still so jumbled..", George)->
->Say("Maybe I can make a spell to help you along. Something specific to you, that’ll help to solidify your memories and help you move on.", Sadie)->
->Say("Oh, could you really!", George)->
->Say("Sure, it should be possible. I’ll use your Pipe as a tether, and maybe there are some hints in my journal that could give me ideas for the other ingredients.", Sadie)->
{EndSay()}
Guess it’s time for some spell crafting.
->DONE

=looking

{CheckItem(george_final, 1)>0:
You bring him the item, and his eyes light up. ->talkspellsuccess
- else:
I still don't have what I need. Hmm. Something representing memory...a photo perhaps?
}
->DONE

=talkspellsuccess //once the spell is complete, you say a few parting words, the ghost thanks you, and dissipates? Funny that our whole “gather a community and get to know your neighbours” game has devolved to just pure ghost banishment

//some sort of spell check?

->Say("That’s it, you’ve done it! I remember everything now.", George)->
->Say("It wasn’t my fault! The house, my family. There was a terrible fire! I was the only one left.", George)->
->Say("I thought...well, I thought they’d all left me because of some mistake I made. But it was just an accident.", George)->
->Say("And you were left all alone?", Sadie)->
->Say("Yes, but it’s alright now because I finally know where to find them. And that’s all thanks to you, Sadie..", George)->
->Say("Oh well, that’s alright. It wasn’t that much of an imposition. I’m just glad I could help, surprisingly", Sadie)->
->Say("You aren’t so bad, George. I hope you find what you’re looking for.", Sadie)->
->Say("You too, little witch..", George)->
->Say("And remember, no one deserves to be alone.", George)->
{EndSay()}
George tips his hat one last time in farewell.
#winGame
The End.
->DONE



=talkspellfailure

//failed spell check, Egroeg = the terrifying cow person

->Say("Hahahaha! Hello little witch.", Egroeg)->
->Say("George? Is that you? Oh no, what have I done...", Sadie)->
->Say("You’ve failed. You thought you could bring your lost ghost ack from the brink, but instead you’ve conjured me in his place.", Egroeg)->
->Say("What have you done with George?", Sadie)->
->Say("George is no more, the is only me, Egroeg the Unmaker.", Egroeg)->
->Say("You have no idea what you’ve done, little witch. But soon...soon you will understand! Bwhahaha!", Egroeg)->
{EndSay()}
Egroeg turns away. Clearly the conversation is over.

What have I done?
->DONE


