//Some default functions for the InkWriter

VAR debug = true
VAR sayStarted = false

VAR checkItem = -1

LIST characters = Sadie, George, Ashley, Peter, Egroeg

LIST items = tool_knife, tool_scissors, tool_scissors_rust, tool_flashlight, tool_flashlight_off, tool_bottle, tool_box, tool_bells, tool_can, tool_honey, cons_bottle, cons_can, cons_gum, cons_sandwich, cons_mushroom, cons_sugar, cons_tea, ing_doll, ing_scarf, ing_ribbon, ing_candle, ing_tape, ing_lavender, ing_box, ing_pearl, ing_pipe, ing_photo, fuel_wood, fuel_battery, fuel_twigs, george_final

EXTERNAL CheckHasItem(x,y)
EXTERNAL ConsumeItem(x,y)

==function Consume(item, amount)==
{CheckItem(item, amount)>=amount:
{ConsumeItem(ConvertToString(item), amount)}
- else:
[Cannot consume item - not enough in Player inventory!]
}
==function CheckItem(item, amount)==
// Helper function
{CheckHasItem(ConvertToString(item), "checkItem")}
~return checkItem

===function ConsumeItem(itemName, amount)===
(Attempted consumption of {amount} {itemName})

===function CheckHasItem(itemName, returnVar)===
~checkItem = 2

===function UseButton(buttonName)===
<>{not debug:
\[useButton.{buttonName}]
}
===function UseText(textName)===
<>{not debug:
\[useText.{textName}]
}

===function ConvertToString(targetItem)===
// Add more items to this list as needed
~temp returnVar = ""
{targetItem:
- tool_knife:
~returnVar = "tool-knife"
- tool_scissors:
~returnVar = "tool-scissors"
- tool_scissors_rust:
~returnVar = "tool-scissors_rust"
- tool_flashlight:
~returnVar = "tool-flashlight"
- tool_flashlight_off:
~returnVar = "tool-flashlight_off"
- tool_bottle:
~returnVar = "tool-bottle"
- tool_box:
~returnVar = "tool-box"
- tool_bells:
~returnVar = "tool-bells"
- tool_can:
~returnVar = "tool-can"
- tool_honey:
~returnVar = "tool-honey"
- cons_bottle:
~returnVar = "cons-bottle"
- cons_can:
~returnVar = "cons-can"
- cons_gum:
~returnVar = "cons-gum"
- cons_sandwich:
~returnVar = "cons-sandwich"
- cons_mushroom:
~returnVar = "cons-mushroom"
- cons_sugar:
~returnVar = "cons-sugar"
- cons_tea:
~returnVar = "cons-tea"
- ing_doll:
~returnVar = "ing-doll"
- ing_scarf:
~returnVar = "ing-scarf"
- ing_ribbon:
~returnVar = "ing-ribbon"
- ing_candle:
~returnVar = "ing-candle"
- ing_tape:
~returnVar = "ing-tape"
- ing_lavender:
~returnVar = "ing-lavender"
- ing_box:
~returnVar = "ing-box"
- ing_pearl:
~returnVar = "ing-pearl"
- ing_pipe:
~returnVar = "ing-pipe"
- ing_photo:
~returnVar = "ing-photo"
- fuel_wood:
~returnVar = "fuel-wood"
- fuel_battery:
~returnVar = "fuel-battery"
- fuel_twigs:
~returnVar = "fuel-twigs"
- george_final:
~returnVar = "ulti-soul-george"
}
// and return
~return returnVar

===function ReqS(currentAmount, requiredAmount, customString)===
// used to enable/disable options [{Req(stuffYouNeed, 10, "Stuffs")}!]
{currentAmount>=requiredAmount:<color=green>|<color=red>}
<>{not debug:
\[{currentAmount}/{requiredAmount}\ {customString}]</color>
- else:
({currentAmount}/{requiredAmount} {customString})</color>
}

// convenience function that assumes min 0 and max 1000 on any value
===function alter(ref value, change)===

// if you need to alter values of things outside of checks, use this instead of directly changing them
// use (variable, change (can be negative), minimum (0) maximum (1000...or more).
{alterValue(value, change, -10000, 10000, value)}

===function alterValue(ref value, newvalue, min, max, ref valueN) ===
~temp finalValue = value + newvalue
~temp change = newvalue
{finalValue > max:
{value !=max: 
    ~change = finalValue-max
- else:
    ~change = 0
}
    ~value = max
- else: 
    {finalValue < min:
    ~change = -value
    ~value = min
- else:
    ~value = value + newvalue
    }
}
~temp changePositive = change*-1
{change!=0:
#autoContinue
{change > 0:
        <i><color=yellow>Gained {print_num(change)} {print_var(valueN, change, false)}.</color></i>
    -else:
        <i><color=yellow>Lost {print_num(changePositive)} {print_var(valueN, change, false)}.</color></i>
}
}

// prints a var, capital, non capital, plural or singular
==function print_var(ref varN, amount, capital)==
{amount<0:
// Make amount always positive, in case it's a negative amount.
~amount = amount * -1
}
{varN:
-"AnyString":
{amount==1:
    {capital:
    ~return "Anystring"
    - else:
    ~return "anystring"
    }
- else:
    {capital:
    ~return "Anystrings"
    - else:
    ~return "anystrings"
    }
}
}

===function StartSay()===
#startSay
~sayStarted = true
<i></i>

===function EndSay()===
#endSay #changeportrait
~sayStarted = false
<b></b>

==Say(text, character)==
// ->Say("Text", character)->
{not sayStarted: {StartSay()}}
#changeportrait

{character:
- Sadie:
#spawn.portrait.sadie
- George:
#spawn.portrait.george
- Ashley:
#spawn.portrait.ashley
- Peter:
#spawn.portrait.peter
- Egroeg:
#spawn.portrait.Egroeg
}
{UseText("CharacterName")}{character}#autoContinue

{text}
//{EndSay()}
->->

// prints a number as pretty text
=== function print_num(x) ===
// print_num(45) -> forty-five
{ 
    - x >= 1000:
        {print_num(x / 1000)} thousand { x mod 1000 > 0:{print_num(x mod 1000)}}
    - x >= 100:
        {print_num(x / 100)} hundred { x mod 100 > 0:and {print_num(x mod 100)}}
    - x == 0:
        zero
    - else:
        { x >= 20:
            { x / 10:
                - 2: twenty
                - 3: thirty
                - 4: forty
                - 5: fifty
                - 6: sixty
                - 7: seventy
                - 8: eighty
                - 9: ninety
            }
            { x mod 10 > 0:<>-<>}
        }
        { x < 10 || x > 20:
            { x mod 10:
                - 1: one
                - 2: two
                - 3: three
                - 4: four        
                - 5: five
                - 6: six
                - 7: seven
                - 8: eight
                - 9: nine
            }
        - else:     
            { x:
                - 10: ten
                - 11: eleven       
                - 12: twelve
                - 13: thirteen
                - 14: fourteen
                - 15: fifteen
                - 16: sixteen      
                - 17: seventeen
                - 18: eighteen
                - 19: nineteen
            }
        }
}
// prints a number as pretty text but with a capital first letter
=== function print_Num(x) ===
// print_num(45) -> forty-five
{ 
    - x >= 1000:
        {print_num(x / 1000)} thousand { x mod 1000 > 0:{print_num(x mod 1000)}}
    - x >= 100:
        {print_num(x / 100)} hundred { x mod 100 > 0:and {print_num(x mod 100)}}
    - x == 0:
        zero
    - else:
        { x >= 20:
            { x / 10:
                - 2: Twenty
                - 3: Thirty
                - 4: Forty
                - 5: Fifty
                - 6: Sixty
                - 7: Seventy
                - 8: Eighty
                - 9: Ninety
            }
            { x mod 10 > 0:<>-<>}
        }
        { x < 10 || x > 20:
            { x mod 10:
                - 1: One
                - 2: Two
                - 3: Three
                - 4: Four        
                - 5: Five
                - 6: Six
                - 7: Seven
                - 8: Eight
                - 9: Nine
            }
        - else:     
            { x:
                - 10: Ten
                - 11: Eleven       
                - 12: Twelve
                - 13: Thirteen
                - 14: Fourteen
                - 15: Fifteen
                - 16: Sixteen      
                - 17: Seventeen
                - 18: Eighteen
                - 19: Nineteen
            }
        }
}