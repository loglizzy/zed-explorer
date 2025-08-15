local pkgs = game.src.pkgs
local Fusion = require(pkgs.Fusion)
local Children = Fusion.Children

local components = game.src.components
local Button = require(components.base.Button)
local TextBox = require(components.base.TextBox)
local Separator = require(components.base.Separator)
local VirtualScrollingFrame = require(components.VirtualScrollingFrame)
local InstanceNode = require(components.InstanceNode)

local Untitled = require(pkgs.Icons.ui.Untitled)
local instanceIconPack = require(pkgs.Icons.instances.StudioNew)

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

local data = {}
local function GetInstanceData(instance: Instance)
    local instanceData = dataCache[instance]
    if not instanceData then
        instanceData = CreateInstanceData(instance)
    end

    return instanceData
end

local listedRootInstances = {
    "Workspace",
    "SoundService",
    "Chat",
    "Players",
    "ReplicatedFirst",
    "MaterialService",
    "TextChatService",
    "StarterPlayer",
    "StarterPack",
    "StarterGui",
    "CoreGui",
    "LocalizationService",
    "VRService",
    "PublishService",
    "ReplicatedStorage",
    "ServerScriptService",
    "ServerStorage",
    "PathfindingService",
    "PluginGuiService",
    "HapticService",
    "Lighting",
    "Teams",
    "TestService",
    "VoiceChatService",
    "TextBoxService",
    "UGCValidationService"
}
for i, v in listedRootInstances do
    local rootInstance = game:FindFirstChild(v)
    if not rootInstance then continue end
    data[i] = CreateInstanceData(rootInstance)
end

return function(scope: Fusion.Scope, props: {})
    local searchBox = TextBox(scope, {})
    searchBox.LayoutOrder = 0

    return scope:New "Frame" {
        Name = "Explorer",
        BackgroundColor3 = Color3.fromRGB(39, 39, 39),
        BorderColor3 = Color3.fromRGB(34, 34, 34),
        BorderSizePixel = 0,
        Position = UDim2.fromScale(1, 0),
        AnchorPoint = Vector2.new(1, 0),
        Size = UDim2.new(0.0644915, 200, 1, 0),

        [Children] = {
            scope:New "UIListLayout" {
                Name = "UIListLayout",
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                SortOrder = Enum.SortOrder.LayoutOrder,
            },

            scope:New "UIPadding" {
                Name = "UIPadding",
            },

            scope:New("Frame") {
                Size = UDim2.new(1, 0, 0, 20),
                BackgroundTransparency = 1,
                [Children] = {
                    scope:New("UIListLayout") {
                        SortOrder = Enum.SortOrder.LayoutOrder,
                        FillDirection = Enum.FillDirection.Horizontal,
                        HorizontalAlignment = Enum.HorizontalAlignment.Left,
                        HorizontalFlex = Enum.UIFlexAlignment.Fill,
                        Padding = UDim.new(0, 2)
                    },

                    scope:New("UIPadding") {
                        PaddingLeft = UDim.new(0, 2),
                        PaddingRight = UDim.new(0, 2),
                    },

                    searchBox,
                    Button(scope, {
                        icon = Untitled.icons["cursor-click"]
                    })
                },
            },
            Separator(scope, {}),
            VirtualScrollingFrame(scope, {
                data = data,
                childSizeY = 18
            })
        }
    }
end
