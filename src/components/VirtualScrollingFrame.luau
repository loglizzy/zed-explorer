local pkgs = game.src.pkgs
local Fusion = require(pkgs.Fusion)
local Children = Fusion.Children
local OnEvent = Fusion.OnEvent
local peek = Fusion.peek

local components = game.src.components
local VirtualList = require(components.VirtualList)

local Theme = require(game.src.modules.Theme)

local style = TweenInfo.new(0.1)
local defaultScrollStep = 1
return function(scope: Fusion.Scope, props: {
    data: {},
    childSizeY: number,
    scrollStep: number?,
})
    local data = props.data
    local childSizeY = props.childSizeY
    local scrollStep = props.scrollStep or defaultScrollStep

    local isHoveringScrollBar = scope:Value(false)
    local scrollOffset = scope:Value(1)
    local scrollBarAbsSize = scope:Value(Vector2.zero)

    local scrollBar = scope:New "ImageButton" {
        Name = "Scroll",
        Active = false,
        BackgroundTransparency = 1,
        Selectable = false,
        Size = scope:Tween(
            scope:Computed(function(use)
                local dataSizeY = use(#data) * childSizeY
                dataSizeY /= use(scrollBarAbsSize).Y

                return if use(isHoveringScrollBar) then UDim2.new(0,8,1,0) else UDim2.new(0,6,1,0)
            end),
            style
        ),
        Visible = true,

        [Fusion.Out("AbsoluteSize")] = scrollBarAbsSize,

        [OnEvent("MouseEnter")] = function()
            isHoveringScrollBar:set(true)
        end,

        [OnEvent("MouseLeave")] = function()
            isHoveringScrollBar:set(false)
        end,

        [Children] = {
            scope:New "ImageButton" {
                Name = "Bar",
                Active = false,
                BackgroundColor3 = Theme.Colors.inputBackground,
                BackgroundTransparency = scope:Tween(
                    scope:Computed(function(use)
                        return if use(isHoveringScrollBar) then 0 else 0.5
                    end),
                    style
                ),
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
    }

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

        [OnEvent("MouseWheelForward")] = function()
            scrollOffset:set(
                math.clamp(
                    peek(scrollOffset) - scrollStep,
                    1,
                    math.max(0, #data)
                )
            )
        end,

        [OnEvent("MouseWheelBackward")] = function()
            scrollOffset:set(
                math.clamp(
                    peek(scrollOffset) + scrollStep,
                    0,
                    math.max(1, #data)
                )
            )
        end,

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
                        scrollOffset = scrollOffset,
                        data = data
                    })
                }
            },

            scope:New "UIPadding" {
                Name = "UIPadding",
                PaddingRight = UDim.new(0, 2),
                PaddingTop = UDim.new(0, 2),
            },

            scrollBar,

            scope:New "UIListLayout" {
                Name = "UIListLayout",
                FillDirection = Enum.FillDirection.Horizontal,
                HorizontalFlex = Enum.UIFlexAlignment.Fill,
                SortOrder = Enum.SortOrder.LayoutOrder,
            },
        }
    }
end
