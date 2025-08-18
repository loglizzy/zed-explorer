-- Optmized module for parsing the experience structure into InstanceNode component props for rendering

local Root = require(script.Root)

local components = game.src.components
local InstanceNode = require(components.InstanceNode)

local pkgs = game.src.pkgs
local instanceIconPack = require(game.src.modules.Icons.instances.StudioNew)

local dataCache = {}
local function CreateInstanceData(instance: Instance)
    local class = instance.ClassName
    local instanceData = {
        constructor = InstanceNode,
        props = {
            name = instance.Name,
            class = class,
            icon = instanceIconPack.icons[class],
            instanceIconPack = instanceIconPack
        }
    }

    dataCache[instance] = instanceData

    return instanceData
end

local ExperienceTree = {}
function ExperienceTree.GetInstanceData(instance: Instance)
    local instanceData = dataCache[instance]
    if not instanceData then
        instanceData = CreateInstanceData(instance)
    end

    return instanceData
end



for i, v in Root[1].lookup do
    local rootInstance = game:FindFirstChild(v)
    if not rootInstance then continue end
    ExperienceTree[i] = CreateInstanceData(rootInstance)
end

return ExperienceTree
