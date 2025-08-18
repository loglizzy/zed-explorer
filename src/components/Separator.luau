local pkgs = game.src.pkgs
local Fusion = require(pkgs.Fusion)

local Theme = require(game.src.modules.Theme)

return function(scope: Fusion.Scope, props: {
    mode: "horizontal" | "vertical"?
})
    local mode = props.mode or "horizontal"
    return scope:New "Frame" {
        Name = "Separator",
        BackgroundColor3 = Theme.Colors.separator,
        BorderColor3 = Color3.new(),
        BorderSizePixel = 0,
        LayoutOrder = 2,
        Size = mode == "horizontal" and UDim2.new(1, -4, 0, 1) or UDim2.new(0, 1, 1, -4),
    }
end
