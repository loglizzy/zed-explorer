local pkgs = game.src.pkgs
local Fusion = require(pkgs.Fusion)

local components = game.src.components
local Explorer = require(components.Explorer)

local Theme = require(game.src.modules.Theme)

return {
    fusion = Fusion,
    controls = {
        Theme = "Dark"
    },
    story = function(props)
        Theme.Set(props.controls.Theme)

        local scope = Fusion:scoped()
        local explorer = Explorer(scope, {

        })
        explorer.Parent = props.target

        return function()
            scope:doCleanup()
        end
    end
}
