local pkgs = game.src.pkgs
local Fusion = require(pkgs.Fusion)
local Children = Fusion.Children

local components = game.src.components
local Button = require(components.Button)
local TextBox = require(components.TextBox)
local Separator = require(components.Separator)
local VirtualScrollingFrame = require(components.VirtualScrollingFrame)

local Theme = require(game.src.modules.Theme)
local Untitled = require(game.src.modules.Icons.ui.Untitled)
local ExperienceTree = require(game.src.modules.ExperienceTree)

return function(scope: Fusion.Scope, props: {})
    local searchBox = TextBox(scope, {
        icon = Untitled.icons["search-sm"]
    })
    searchBox.LayoutOrder = 0

    return scope:New "Frame" {
        Name = "Explorer",
        BackgroundColor3 = Theme.Colors.background,
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
                PaddingTop = UDim.new(0, 2),
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
                        Padding = UDim.new(0, 1)
                    },

                    scope:New("UIPadding") {
                        PaddingLeft = UDim.new(0, 2),
                        PaddingRight = UDim.new(0, 2),
                    },

                    searchBox,
                    Button(scope, {
                        icon = Untitled.icons["dots-horizontal"],
                        noBackground = true
                    })
                },
            },
            Separator(scope, {}),
            VirtualScrollingFrame(scope, {
                data = ExperienceTree,
                childSizeY = 18
            })
        }
    }
end
