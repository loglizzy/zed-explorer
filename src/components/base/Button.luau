local pkgs = game.src.pkgs
local Fusion = require(pkgs.Fusion)
local Children = Fusion.Children

local Untitled = require(pkgs.Icons.ui.Untitled)

return function(scope: Fusion.Scope, props: {
    label: string?,
    icon: Vector2?,
    disabled: boolean?,
    background: boolean?
})
    local label = props.label
    local icon = props.icon or Untitled.icons["cursor-click"]
    local disabled = props.disabled or false
    local background = props.background or false

    return scope:New "ImageButton" {
        Name = "Controls",
        AutomaticSize = Enum.AutomaticSize.X,
        BackgroundColor3 = Color3.fromRGB(66, 66, 66),
        BackgroundTransparency = if background then if disabled then 0.5 else 0 else 1,
        Active = not disabled,
        Size = UDim2.new(0, 0, 0, 20),

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
                TextColor3 = Color3.new(1, 1, 1),
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
