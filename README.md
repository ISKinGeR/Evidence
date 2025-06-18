## Original scripts

This original scripts

Mythic: https://github.com/Mythic-Framework/mythic-framework/tree/main/resources/%5Bmythic%5D/mythic-evidence

Sandbox: https://github.com/BadCodesGG/sandbox-fivem/tree/main/server/resources/%5Bsandbox%5D/sandbox-evidence

## What on it?
I just add a few changes and new type which is fingerprints

## How to use it?
It's work exactly like the dna but you will need to trigger it to leave a finger print

*How?*

Simple, go to the place you wanna trigger it, for example fleeca heist in (sandbox/mythic)-robbery script under the green_laptop Item RegisterUse as [This Image](https://prnt.sc/fxVu6laIHhF6)

as the following:
```lua
TriggerClientEvent('Evidence:Client:tryLeaveFingerprint', source, "RobeName which can be anything", 1)
``` 
the number must be 1,2 while 1 is he rob it successfully and 2 is failed to rob it

An examples: 

```lua
TriggerClientEvent('Evidence:Client:tryLeaveFingerprint', source, "FleecaRob", 1)
TriggerClientEvent('Evidence:Client:tryLeaveFingerprint', source, "LombankRobbery", 2)
TriggerEvent('Evidence:Client:tryLeaveFingerprint', "CarSteal", 1)
TriggerEvent('Evidence:Client:tryLeaveFingerprint', "StoreRob", 2)
```

## Still can't do it or need any help? 
Please enter [Mythic-Framework](https://discord.gg/crBq7e9J2d) discord server and we will help you!
