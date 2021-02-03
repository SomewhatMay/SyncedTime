# SyncedTime

This is a **Module Script** That should be placed in **Replicated Storage**.
This only works in **ROBLOX** using **ROBLOX Lua functions** and cannot be run using regural Lua.

This module script will be accurate in ±30ms in time. 
*This accuracy will highly depend on the ping on the client to server*

This will also be very accurate on Client to Client Synchronization.
*Again, will vary depending on client(s) ping*

## How to setup

On a server script:
 * Require this module
 * Call `Init()`
```lua
local SyncedTime = require(game.ReplicatedStorage.SyncedTime)
SyncedTime:Init()
```
*`Init()` should only be called once on the server. Calling it multiple times might cause bugs.*

On Local Script:
 * Require this module
 * Call `Init()`
 * To get Synchronzied Time, call `GetTime()`
```lua
local SyncedTime = require(game.ReplicatedStorage.SyncedTime)
SyncedTime:Init() -- Does Yeild

print(SyncedTime:GetTime()) -- Prints Synchronized time
```
*`Init()` can be called multiple times on the client. 
Every time you call `Init()`, the client recalibrates the difference.
This can be good and bad.*

## API

#### `Init()`
```lua
SyncedTime:Init(bool useLocalAverage, int localCheckRate, bool resetGlobalAverage)
```
Calling `Init()` on the client multiple times will recalibrate the difference.

It is recommended to call `Init()` when the player will not have high ping.

It is highly recommended to run a game loaded check before running `Init()`

If you used `GetTime()` before, and called `Init()` again, you will get different SyncedTimes;
this is because the difference is updated when you call `Init()`.
If you are comparng time a lot, and want it to be really accurate, 
it is recommended to use `Init()` only once.

You should always call `Init()` once, and only once on the server.
`Init()` should be called on the server without any yeild or wait.

##### Parameters

```
Bool useLocalAverage [Optional]

Deafult: false
```
This is useful if you are trying to run `Init()` multiple times.

This states if it should find the average using the previous values it found from calling or not `Init()`

By deafult, it will use previous values from calling `Init()` (globalAverage)

```
int localCheckRate [Optional]

Deafult: 10
```
To compinsate with ping, we usually Invoke the server for the difference multiple times.
This value will determine how many times we're Invoking the server to get an average value.

This helps if your ping is high sometimes and low other times.

**Note: The higher the number is, 
the more accurate your value will be but the higher it is, 
the longer the yeild in `Init()` will be.**

```
bool resetGlobalAverage

deafult: false
```

This states if it should reset the globalAverage (to a nil table) after `Init()` has returned something.

If you are looking to use a different average table every time, set `useLocalAverage` to true instead.

#### `GetTime()`
```lua
SyncedTime:GetTime()
```
This can be called both in the Cleint and the Server.

If you are calling this on the server, it is recommended to use `tick()` instead; 
as it will return the same value.

If you are using Synced time on the client, then use call function.

If you are using time on the client that never needs to be synced or differentiated with the server, use `tick()` instead.

### How to run a game loaded check
```lua
repeat wait() until game:IsLoaded()
```
