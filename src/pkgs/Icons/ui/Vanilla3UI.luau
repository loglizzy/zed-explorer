local icons = {
    Add = Vector2.zero,
    AddNoBorder = Vector2.zero,
    Archive = Vector2.zero,
    ArrowDown = Vector2.zero,
    ArrowRight = Vector2.zero,
    Bold_Default = Vector2.zero,
    Bold_Selected = Vector2.zero,
    CloseWidget = Vector2.zero,
    Collapse = Vector2.zero,
    DropdownArrow = Vector2.zero,
    Expand = Vector2.zero,
    FavoritesTab_Default = Vector2.zero,
    FavoritesTab_Selected = Vector2.zero,
    HorizontalDoubleArrow = Vector2.zero,
    InventoryTab_Default = Vector2.zero,
    InventoryTab_Selected = Vector2.zero,
    Italic_Default = Vector2.zero,
    Italic_Selected = Vector2.zero,
    More = Vector2.zero,
    MyGame = Vector2.zero,
    New = Vector2.zero,
    Recent = Vector2.zero,
    ScrollbarDown = Vector2.zero,
    ScrollbarTriangle = Vector2.zero,
    ScrollbarUp = Vector2.zero,
    Strikethrough_Default = Vector2.zero,
    Strikethrough_Selected = Vector2.zero,
    Underline_Default = Vector2.zero,
    Underline_Selected = Vector2.zero,
}

local Vanilla3UI = {
    icons = icons,
    size = 32,
    image = "rbxassetid://104377173987486"
}

local Processor = require(script.Parent.Parent.Processor)
Processor(Vanilla3UI)

return Vanilla3UI
