local load = function()
    print("test")
    anim8 = require("libraries/anim8")

    itemDictionary = {
        ["gold"] = {
            value = 1,
            spriteSheet = love.graphics.newImage("sprites/gold.png"),
            animSpeed = .1
        }
    }

    -- Setup item animations
    for k, v in pairs(itemDictionary) do
        itemDictionary[k].grid = anim8.newGrid(16, 16, itemDictionary[k].spriteSheet:getWidth(), itemDictionary[k].spriteSheet:getHeight())
        print("Setup animation grid for: "..k)
        itemDictionary[k].anim = anim8.newAnimation(itemDictionary[k].grid("1-5", 1), itemDictionary[k].animSpeed)
        print("Created animation for: "..k)
    end
end

local items = {

}

local spawnItem = function(x, y, item) -- If you want the amount of items to spawn to be fixed, set the minimum value to the desired number, and set maximum to nil.
    --[[
    local quantity = 0

    if min and not max then
        quantity = min
    else
        quantity = math.random(min, max)
    end
    --]]

    for k, v in pairs(itemDictionary) do
        if item == k then
            --print("Trying to spawn: "..k)
            -- add selected item to items table with coordinates for main.lua to spawn
            -- this should also include the other data in itemDictionary + grid/animations
            -- have function return table to use to spawn
        end
    end
end

return { 
    load = load,
    spawnItem = spawnItem
}