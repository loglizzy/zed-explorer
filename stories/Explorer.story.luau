local pkgs = game.src.pkgs
local Fusion = require(pkgs.Fusion)

local components = game.src.components
local Explorer = require(components.Explorer)
local UILabsUtils = require(game.src.pkgs.UILabsUtils)

local Theme = require(game.src.modules.Theme)

return {
    fusion = Fusion,
    controls = {
        Theme = UILabsUtils.Choose({
            "Default", "Dark", "Light"
        })
    },
    story = function(props)
        local scope = Fusion:scoped()
        local themeChoosed = "Dark"
        Theme.Set(themeChoosed)

        local explorer = Explorer(scope, {

        })
        explorer.Parent = props.target

        return function()
            scope:doCleanup()
        end
    end
}
