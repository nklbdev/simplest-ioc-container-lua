SimplestIoCContainer = {}
SimplestIoCContainer.__index = SimplestIoCContainer

function SimplestIoCContainer.new()
    local self = setmetatable({}, SimplestIoCContainer)
    self.bindings = {}
    return self
end

function SimplestIoCContainer:resolve(key)
    local binding = self.bindings[key]
    assert(binding ~= nil, string.format("IoC: Cannot resolve key \"%s\"", tostring(key)))

    if binding.isSingleInstance then
        if binding.lastResolvedInstance then
            return binding.lastResolvedInstance
        else
            binding.lastResolvedInstance = binding.resolvingFunction(self)
            return binding.lastResolvedInstance
        end
    else
        return binding.resolvingFunction(self)
    end
end

function SimplestIoCContainer:bind(key, resolvingFunction, isSingleInstance)
    assert(key ~= nil, "IoC: Key is nil")
    assert(self.bindings[key] == nil, string.format("IoC: Key \"%s\" is already present", tostring(key)))
    assert(resolvingFunction ~= nil, "IoC: ResolvingFunction is nil")
    assert(type(resolvingFunction) == "function", "IoC: ResolvingFunction is not a function")

    self.bindings[key] = {
        resolvingFunction = resolvingFunction,
        isSingleInstance = isSingleInstance or false
    }
end
