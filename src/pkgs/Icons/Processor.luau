return function(iconPackData: {
    icons: {[string]: Vector2},
    size: number | Vector2
})
    local icons = iconPackData.icons
    local list = {}
    for i, v in icons do
        table.insert(list, i)
    end

    table.sort(list)

    local columns = math.ceil(math.sqrt(#list))
    local size = iconPackData.size
    for i, v in list do
        i -= 1
        icons[v] = Vector2.new(
            math.floor((i%columns)*size),
            math.floor((i/columns))*size
        )
    end

    iconPackData.size = Vector2.new(size, size)
end
