local spawnItem = function(x, y, item)
    local itemDict = items.getDictionary()

    if itemDict[item] then
        print(item)
    else
        print(item.." doesn't exist! Cannot spawn this!")
    end
end

local openChest = function(chest_name)    
    local chests = items.getChest()

    if chests[chest_name] then
        for k, v in pairs(chests[chest_name].contents) do
            spawnItem(512, 512, k) -- add score v on gold pickup, but move to spawnitem and do that first
        end
    end
end

local load = function()
    sti = require("libraries/sti")
    gameMap = sti("maps/world.lua")
    
    items = require("utilities/items")
    items.load()

    if gameMap.layers["Walls"] then
        for k, v in pairs(gameMap.layers["Walls"].objects) do
            local wall = world:newRectangleCollider(v.x, v.y, v.width, v.height)
            wall:setType("static")
        end
    end

    if gameMap.layers["Chests"] then
        for k, v in pairs(gameMap.layers["Chests"].objects) do
            for a, b in pairs(v) do
                local chest = world:newRectangleCollider(v.x, v.y, 32, 32)
                chest:setType("static")
                chest:setCollisionClass("Chest")
                chest.state = 0 -- Set the chest state as unopened
                chest.name = v.name
            end
        end
    end
end

local draw = function()
    -- draw all the chests, depending on their state. use sprites from items.lua
end

return { 
    load = load,
    openChest = openChest
}