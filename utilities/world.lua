local load = function()
    local walls = { }
    if gameMap.layers["Walls"] then
        for k, v in pairs(gameMap.layers["Walls"].objects) do
            local wall = world:newRectangleCollider(v.x, v.y, v.width, v.height)
            wall:setType("static")
        end
    end

    local chests = { }
    if gameMap.layers["Chest"] then
        for k, v in pairs(gameMap.layers["Chest"].objects) do
            local chest = world:newRectangleCollider(v.x, v.y, v.width, v.height)
            chest:setType("static")
            chest:setCollisionClass("Chest")
            chest.state = "unopened"
        end
    end

    return walls, chests
end

return { 
    load = load
}