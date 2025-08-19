local pkgs = game.src.pkgs
local Fusion = require(pkgs.Fusion)
local Children = Fusion.Children
local peek = Fusion.peek

local Theme = require(game.src.modules.Theme)

local Icons = game.src.modules.Icons
local Vanilla3UI = require(Icons.ui.Vanilla3UI)

return function(scope: Fusion.Scope, props: {
    name: string,
    icon: Vector2,
    isOpen: boolean?,
    isSelected: boolean?,
    experienceTree: {},
    respectiveExperienceTreePos: number,
    instanceIconPack: {}
})
    local isOpen = props.isOpen or scope:Value(false)
    local isHovered = scope:Value(false)
    local isSelected = scope:Value(props.isSelected or false)
    local experienceTree = props.experienceTree
    local respectiveExperienceTreePos = props.respectiveExperienceTreePos
    local instanceIconPack = props.instanceIconPack

    return scope:New "ImageButton" {
        Name = "InstanceNode",
        BackgroundColor3 =   Color3.fromHex("#55aaff"),
        BackgroundTransparency = scope:Computed(function(use)
            local t = if use(isSelected) then 0.5 else 1
            t -= if use(isHovered) then 0.25 else 0

            return t
        end),
        Size = UDim2.new(1, 0, 0, 18),

        [Fusion.OnEvent("MouseEnter")] = function()
            isHovered:set(true)
        end,
        [Fusion.OnEvent("MouseLeave")] = function()
            isHovered:set(false)
        end,

        [Children] = {
            scope:New "UIListLayout" {
                Name = "UIListLayout",
                FillDirection = Enum.FillDirection.Horizontal,
                SortOrder = Enum.SortOrder.LayoutOrder,
                VerticalAlignment = Enum.VerticalAlignment.Center,
            },

            scope:New "ImageButton" {
                Name = "Toggle",
                AutoButtonColor = false,
                BackgroundTransparency = 1,
                Size = UDim2.fromScale(1, 1),
                SizeConstraint = Enum.SizeConstraint.RelativeYY,

                [Fusion.OnEvent("Activated")] = function()
                    local newIsOpen = not peek(isOpen)
                    isOpen:set(newIsOpen)
                    if newIsOpen then
                        local respectiveDataNode = experienceTree.data[respectiveExperienceTreePos]
                        experienceTree:OpenInstanceDataNode(respectiveDataNode)
                    end
                end,

                [Children] = {
                    scope:New "ImageLabel" {
                        Name = "Icon",
                        Active = true,
                        AnchorPoint = Vector2.new(0.5, 0.5),
                        BackgroundTransparency = 1,
                        ImageRectSize = Vanilla3UI.size,
                        Image = Vanilla3UI.image,
                        ImageTransparency = 0.2,
                        ImageRectOffset = scope:Computed(function(use)
                            return Vanilla3UI.icons[if use(isOpen) then "ArrowDown" else "ArrowRight"]
                        end),
                        Position = UDim2.fromScale(0.5, 0.5),
                        Selectable = true,
                        Size = UDim2.new(1, -4, 1, -4),
                    },
                }
            },

            scope:New "ImageLabel" {
                Name = "ClassIcon",
                Active = true,
                AnchorPoint = Vector2.new(0.5, 0.5),
                BackgroundTransparency = 1,
                ImageRectSize = instanceIconPack.size,
                Image = instanceIconPack.image,
                ImageRectOffset = props.icon,
                Position = UDim2.fromScale(0.5, 0.5),
                Selectable = true,
                Size = UDim2.new(1, -4, 1, -4),
                SizeConstraint = Enum.SizeConstraint.RelativeYY,
            },

            scope:New "TextLabel" {
                Name = "NameLabel",
                BackgroundTransparency = 1,
                FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json"),
                Size = UDim2.fromScale(1, 1),
                Text = props.name,
                TextColor3 = Theme.Colors.text,
                TextSize = 10,
                TextWrapped = true,
                TextXAlignment = Enum.TextXAlignment.Left,

                [Children] = {
                    scope:New "UIPadding" {
                        Name = "UIPadding",
                        PaddingLeft = UDim.new(0, 4),
                    },
                }
            },

            scope:New "UIPadding" {
                Name = "UIPadding",
            },
        }
    }, isHovered
end
