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
                chest.state = 0
                chest.name = v.name
            end
        end
    end

    return walls
end

local spawnItem = function(x, y, item)
    local itemDict = items.getDictionary()

    if itemDict[item] then
        print(item)
    end
end

local openChest = function(chest_name)    
    local chests = items.getChest()

    if chests[chest_name] then
        for k, v in pairs(chests[chest_name].contents) do
            spawnItem(512, 512, "gold")
        end
    end
end

return { 
    load = load,
    openChest = openChest
}