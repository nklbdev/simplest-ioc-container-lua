SimplestIoCContainer = {}
SimplestIoCContainer.__index = SimplestIoCContainer

function SimplestIoCContainer.new()
    local self = setmetatable({}, SimplestIoCContainer)
    self.bindings = {}
    return self
end

function SimplestIoCContainer:resolve(key)
    local binding = self.bindings[key]

    if not binding then
        error(string.format("IoC: Cannot resolve key \"%s\"", tostring(key)))
    end

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
    if key == nil then
        error("IoC: Key is nil")
    end
    if self.bindings[key] then
        error(string.format("IoC: Key \"%s\" is already present", tostring(key)))
    end
    if resolvingFunction == nil then
        error("IoC: ResolvingFunction is nil")
    end
    assert(type(resolvingFunction) == "function", "IoC: ResolvingFunction is not a function")

    self.bindings[key] = {
        resolvingFunction = resolvingFunction,
        isSingleInstance = isSingleInstance or false
    }
end
