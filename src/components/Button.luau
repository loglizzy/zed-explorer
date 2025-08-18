local pkgs = game.src.pkgs
local Fusion = require(pkgs.Fusion)
local Children = Fusion.Children
local OnEvent = Fusion.OnEvent

local Theme = require(game.src.modules.Theme)
local Untitled = require(game.src.modules.Icons.ui.Untitled)

local style = TweenInfo.new(0.1, Enum.EasingStyle.Linear)
return function(scope: Fusion.Scope, props: {
    label: string?,
    icon: Vector2?,
    disabled: boolean?,
    noBackground: boolean?
})
    local label = props.label
    local icon = props.icon or Untitled.icons["cursor-click"]
    local disabled = props.disabled or false
    local noBackground = props.noBackground or false

    local isHovered = scope:Value(false)

    return scope:New "ImageButton" {
        Name = "Controls",
        AutomaticSize = Enum.AutomaticSize.X,
        BackgroundColor3 = Theme.Colors.inputBackground,
        BackgroundTransparency = scope:Tween(
            scope:Computed(function(use)
                local t = if noBackground then 1 else 0.5
                t -= if use(isHovered) then 1 else 0

                return t
            end),
            style
        ),
        Active = not disabled,
        Selectable = true,
        Size = UDim2.new(0, 0, 0, 18),

        [OnEvent("MouseEnter")] = function()
            isHovered:set(true)
        end,

        [OnEvent("MouseLeave")] = function()
            isHovered:set(false)
        end,

        [OnEvent("MouseButton1Click")] = function()

        end,

        [Children] = {
            scope:New "UIPadding" {
                Name = "UIPadding",
                PaddingLeft = UDim.new(0, 4),
                PaddingRight = UDim.new(0, 4),
            },

            scope:New "UIFlexItem" {},

            scope:New "UICorner" {
                Name = "UICorner",
                CornerRadius = UDim.new(0, 4),
            },

            scope:New "ImageLabel" {
                Name = "Icon",
                BackgroundTransparency = 1,
                Image = Untitled.image,
                ImageRectSize = Untitled.size,
                ImageRectOffset = icon,
                Visible = if icon then true else false,
                Size = UDim2.new(1, -8, 1, -8),
                SizeConstraint = Enum.SizeConstraint.RelativeYY,
            },

            scope:New "TextLabel" {
                Name = label,
                AutomaticSize = Enum.AutomaticSize.X,
                BackgroundTransparency = 1,
                FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json"),
                Size = UDim2.fromScale(0, 1),
                Text = "Controls",
                TextColor3 = Theme.Colors.text,
                TextSize = 10,
                Visible = if label then true else false
            },

            scope:New "UIListLayout" {
                Name = "UIListLayout",
                FillDirection = Enum.FillDirection.Horizontal,
                HorizontalAlignment = Enum.HorizontalAlignment.Right,
                Padding = UDim.new(0, 4),
                SortOrder = Enum.SortOrder.LayoutOrder,
                VerticalAlignment = Enum.VerticalAlignment.Center,
            },
        }
    }
end
