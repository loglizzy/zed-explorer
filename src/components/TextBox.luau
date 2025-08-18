local pkgs = game.src.pkgs
local Fusion = require(pkgs.Fusion)
local Children = Fusion.Children

local Theme = require(game.src.modules.Theme)
local Untitled = require(game.src.modules.Icons.ui.Untitled)

local style = TweenInfo.new(.1, Enum.EasingStyle.Linear)
return function(scope: Fusion.Scope, props: {
    clearOnFocus: boolean?,
    icon: Vector2?
})
    local clearOnFocus = props.clearOnFocus or true
    local icon = props.icon

    local isFocused = scope:Value(false)

    local uiStroke = scope:New "UIStroke" {
        Name = "UIStroke",
        Color = Color3.fromRGB(85, 170, 255),
        Enabled = false,
    }

    local realInputBox = scope:New "TextBox" {
        Name = "Real",
        Active = false,
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json"),
        LayoutOrder = 1,
        PlaceholderColor3 = Color3.fromRGB(161, 161, 161),
        PlaceholderText = "Search",
        Selectable = false,
        Size = UDim2.fromScale(1, 0),
        Text = "",
        TextColor3 = Color3.new(1, 1, 1),
        TextSize = 10,
        TextXAlignment = Enum.TextXAlignment.Left,

        [Fusion.OnEvent("Focused")] = function()
            uiStroke.Enabled = true
            isFocused:set(true)
        end,
        [Fusion.OnEvent("FocusLost")] = function()
            uiStroke.Enabled = false
            isFocused:set(false)
        end,
    }

    return scope:New "TextBox" {
        Name = "SearchBox",
        BackgroundTransparency = scope:Tween(
            scope:Computed(function(use)
                local t = if use(isFocused) then 0 else 0.25
                return t
            end),
            style
        ),
        BackgroundColor3 = Theme.Colors.inputBackground,
        ClearTextOnFocus = clearOnFocus,
        CursorPosition = -1,
        FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json"),
        LayoutOrder = 1,
        PlaceholderColor3 = Color3.fromRGB(161, 161, 161),
        Size = UDim2.new(1, 0, 0, 18),
        Text = "",
        TextColor3 = Theme.Colors.text,
        TextSize = 10,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 2,

        [Fusion.OnEvent("MouseEnter")] = function()

        end,

        [Fusion.OnEvent("MouseLeave")] = function()

        end,

        [Fusion.OnEvent("Focused")] = function()
            realInputBox:CaptureFocus()
            if clearOnFocus then
                realInputBox.Text = ""
            end
        end,

        [Children] = {
            scope:New "UICorner" {
                Name = "UICorner",
                CornerRadius = UDim.new(0, 4),
            },

            uiStroke,

            scope:New "UIPadding" {
                Name = "UIPadding",
                PaddingBottom = UDim.new(0, 1),
                PaddingLeft = UDim.new(0, 0),
                PaddingRight = UDim.new(0, 3),
                PaddingTop = UDim.new(0, 1),
            },

            scope:New "Frame" {
                Name = "Content",
                BackgroundTransparency = 1,
                Size = UDim2.fromScale(1, 1),

                [Children] = {
                    scope:New "UIListLayout" {
                        Name = "UIListLayout",
                        FillDirection = Enum.FillDirection.Horizontal,
                        Padding = UDim.new(0, 4),
                        SortOrder = Enum.SortOrder.LayoutOrder,
                        VerticalAlignment = Enum.VerticalAlignment.Center,
                        HorizontalFlex = Enum.UIFlexAlignment.Fill
                    },

                    realInputBox,

                    scope:New "ImageLabel" {
                        Name = "Icon",
                        AnchorPoint = Vector2.new(0, 0.5),
                        BackgroundTransparency = 1,
                        Image = Untitled.image,
                        ImageRectSize = Untitled.size,
                        ImageRectOffset = icon,
                        Visible = if icon then true else false,
                        ImageColor3 = Color3.fromRGB(161, 161, 161),
                        Position = UDim2.new(0, 4, 0.5, 0),
                        Size = UDim2.new(1, -6, 1, -6),
                        SizeConstraint = Enum.SizeConstraint.RelativeYY,
                        [Children] = scope:New("UIFlexItem") {}
                    },

                    scope:New "UIPadding" {
                        Name = "UIPadding",
                        PaddingLeft = UDim.new(0, 4),
                    },
                }
            },
        }
    }
end
