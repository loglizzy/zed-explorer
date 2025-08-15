local components = game.src.components
local pkgs = game.src.pkgs
local Fusion = require(pkgs.Fusion)
local Explorer = require(components.Explorer)

return {
    fusion = Fusion,
    -- controls = {},
    story = function(props)
        local scope = Fusion:scoped()
        local explorer = Explorer(scope, {})
        explorer.Parent = props.target

        return function()
            scope:doCleanup()
        end
    end
}
