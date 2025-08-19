-- Optmized module for parsing the experience structure into InstanceNode component props for rendering

local components = game.src.components

local instanceIconPack = require(game.src.modules.Icons.instances.StudioNew)

local ExperienceTree = {}
ExperienceTree.__index = ExperienceTree

function ExperienceTree:GetInstanceData(instance: Instance)
    local instanceData = self.cache[instance]
    if not instanceData then
        instanceData = self:CreateInstanceData(instance)
    end

    return instanceData
end

function ExperienceTree:CreateInstanceData(instance: Instance, position: number)
    local name = instance.Name
    local class = instance.ClassName
    local parent = instance.Parent
    local instanceData = {
        instance = instance,
        name = name,
        class = class,
        parent = parent and self:GetInstanceData(parent),

        constructor = self.constructor,
        props = {
            name = name,
            class = class,
            icon = instanceIconPack.icons[class],
            experienceTree = self,
            respectiveExperienceTreePos = position,
            instanceIconPack = instanceIconPack
        }
    }

    self.cache[instance] = instanceData

    return instanceData
end

function ExperienceTree:OpenInstanceDataNode(dataNode)
    print(dataNode)
    local insertPosition = dataNode.position + 1
    for i, v in dataNode.instance:GetChildren() do
        local vData = self:GetInstanceData(v)
        table.insert(self, insertPosition, vData)
    end
end

function ExperienceTree.new()
    local self = setmetatable({}, ExperienceTree)
    self.data = {}
    self.cache = {}
    self.constructor = require(components.InstanceNode)

    return self
end

return ExperienceTree
