# SimplestIoCContainer
Just simplest IoC container on Lua

usage:
```
require("simplestIoCContainer")

local container = SimplestIoCContainer.new()

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
