local pkgs = game.src.pkgs
local Fusion = require(pkgs.Fusion)
local Children = Fusion.Children

return function(scope: Fusion.Scope, props: {
    childSizeY: number,
    scrollOffset: Fusion.Value<number?>,
    data: {
        {
            constructor: (scope: Fusion.Scope, props: {}) -> Fusion.Child,
            props: {any}
        }
    }
})
    local childSizeY = props.childSizeY
    local data = props.data or {}
    local scrollOffset = props.scrollOffset or scope:Value(1)
    local holderSizeY = scope:Value(0)
    local childrenInView = {}

    local listFrame
    listFrame = scope:New("Frame") {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        [Children] = scope:Computed(function(use)
            table.clear(childrenInView)
            local scrollOffsetValue = use(scrollOffset)
            local scrollOffsetPixels = scrollOffsetValue * childSizeY
            local scrollOffsetFloor = math.floor(scrollOffsetValue)
            local scrollOffsetPixelsFloor = scrollOffsetFloor * childSizeY

            local difference = scrollOffsetPixelsFloor - scrollOffsetPixels
            local maxFitting = math.floor(use(holderSizeY) / childSizeY)
            local dataIterGoal = math.min(scrollOffsetFloor + maxFitting, #use(data))
            local posYIncrement = 0
            for i = scrollOffsetFloor, dataIterGoal do
                local childData = data[i]
                local child = childData.constructor(scope, childData.props)
                child.Position = UDim2.new(0, 0, 0, posYIncrement + difference)
                posYIncrement += childSizeY

                table.insert(childrenInView, child)
            end

            return childrenInView
        end)
    }

    listFrame:GetPropertyChangedSignal("Parent"):Connect(function()
        holderSizeY:set(listFrame.AbsoluteSize.Y)
    end)

    return listFrame
end
