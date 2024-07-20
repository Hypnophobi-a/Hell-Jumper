local itemDictionary = {
    ["gold"] = {
        value = 1,
        animSpeed = .1,
        spriteSheet = love.graphics.newImage("sprites/gold.png")
    }
}

local chestTable = {
    ["chest0"] = {
        animSpeed = .1,
        spriteSheet = love.graphics.newImage("sprites/chest.png"),
        contents = {
            gold = 5,
            silver = 5
        }
    }
}

local getDictionary = function()
    return itemDictionary
end

local getChest = function()
    return chestTable
end

local load = function()
    print("Items loaded")
    anim8 = require("libraries/anim8")

    for k, v in pairs(itemDictionary) do -- Setup item animations
        itemDictionary[k].grid = anim8.newGrid(16, 16, itemDictionary[k].spriteSheet:getWidth(), itemDictionary[k].spriteSheet:getHeight())
        print("Setup animation grid for: "..k)
        itemDictionary[k].anim = anim8.newAnimation(itemDictionary[k].grid("1-5", 1), itemDictionary[k].animSpeed)
        print("Created animation for: "..k)
    end

    for k, v in pairs(chestTable) do -- Setup chest animations
        chestTable[k].grid = anim8.newGrid(32, 32, chestTable[k].spriteSheet:getWidth(), chestTable[k].spriteSheet:getHeight())
        print("Setup animation grids for: "..k)
        chestTable[k].anim1 = anim8.newAnimation(chestTable[k].grid("1-1", 3), chestTable[k].animSpeed)
        chestTable[k].anim2 = anim8.newAnimation(chestTable[k].grid("1-1", 3), chestTable[k].animSpeed)
        print("Created animation for: "..k)
    end
end

return { 
    load = load,
    spawnItem = spawnItem,
    getDictionary = getDictionary,
    getChest = getChest
}