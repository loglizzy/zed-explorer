local pkgs = game.src.pkgs
local Fusion = require(pkgs.Fusion)
local Children = Fusion.Children

local components = game.src.components
local VirtualList = require(components.VirtualList)

return function(scope: Fusion.Scope, props: {
    data: {},
    childSizeY: number
})
    local data = props.data
    local childSizeY = props.childSizeY

    return scope:New "ScrollingFrame" {
        Name = "Tree",
        Active = true,
        BackgroundTransparency = 1,
        CanvasSize = UDim2.new(),
        LayoutOrder = 3,
        ScrollBarImageColor3 = Color3.new(),
        ScrollBarImageTransparency = 1,
        ScrollBarThickness = 0,
        Size = UDim2.fromScale(1, 1),

        [Children] = {
            scope:New "ScrollingFrame" {
                Name = "List",
                Active = true,
                BackgroundTransparency = 1,
                CanvasSize = UDim2.new(),
                ScrollBarImageColor3 = Color3.new(),
                ScrollBarImageTransparency = 1,
                ScrollBarThickness = 0,
                Size = UDim2.fromScale(1, 1),

                [Children] = {
                    VirtualList(scope, {
                        childSizeY = childSizeY,
                        data = data
                    })
                }
            },

            scope:New "UIPadding" {
                Name = "UIPadding",
                PaddingRight = UDim.new(0, 2),
                PaddingTop = UDim.new(0, 2),
            },

            scope:New "ImageButton" {
                Name = "Scroll",
                Active = false,
                BackgroundTransparency = 1,
                Selectable = false,
                Size = UDim2.new(0, 6, 1, 0),
                Visible = false,

                [Children] = {
                    scope:New "ImageButton" {
                        Name = "Bar",
                        Active = false,
                        BackgroundColor3 = Color3.new(1, 1, 1),
                        BackgroundTransparency = 0.925,
                        LayoutOrder = 1,
                        Selectable = false,
                        Size = UDim2.fromScale(1, 0.3),

                        [Children] = {
                            scope:New "UICorner" {
                                Name = "UICorner",
                            },
                        }
                    },

                    scope:New "UIFlexItem" {
                        Name = "UIFlexItem",
                    },

                    scope:New "UIPadding" {
                        Name = "UIPadding",
                        PaddingLeft = UDim.new(0, 1),
                        PaddingRight = UDim.new(0, 1),
                    },
                }
            },

            scope:New "UIListLayout" {
                Name = "UIListLayout",
                FillDirection = Enum.FillDirection.Horizontal,
                HorizontalFlex = Enum.UIFlexAlignment.Fill,
                SortOrder = Enum.SortOrder.LayoutOrder,
            },
        }
    }
end
