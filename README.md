# SimplestIoCContainerLua
Just simplest IoC container on Lua

usage:
```lua
local SimplestIocContainer = require("simplest_ioc_container")

local container = SimplestIocContainer.new()

container:bind("a", function(ctr)
    return { b = ctr:resolve("b"), c = ctr:resolve("c"), d = "asdfsdf"}
end, true)

container:bind("b", function(ctr)
    return "BBBBBB"
end, true)

container:bind("c", function(ctr)
    return "CCCCCCCC"
end, true)

local a = container:resolve("a")
print(a.b.." "..a.c.." "..a.d)
```
will print:
BBBBBB CCCCCCCC asdfsdf

or in object-oriented manner:

```lua
local SimplestIocContainer = require("simplest_ioc_container")
local Thor = require("thor")
local Mjolnir = require("mjolnir")

local container = SimplestIocContainer.new()

container:bind("God", function(ctr)
    return Thor.new(ctr:resolve("Hammer"))
end, true)

container:bind("Hammer", function(ctr)
    return Mjolnir.new()
end, true)

local god = container:resolve("God")
print(god.weapon.name)
```
