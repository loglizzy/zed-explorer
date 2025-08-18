type ThemeColors = {
    background: Color3,
    inputBackground: Color3,
    text: Color3
}

local themes = script.themes
local Theme = {
    Colors = {} :: ThemeColors
}

local current
function Theme.Set(themeName: string)
    current = require(themes[themeName])
    Theme._update()
end

function Theme._update()
    for i, v in current.Colors do
        Theme.Colors[i] = v
    end
end

Theme.Set("Default")

return Theme
