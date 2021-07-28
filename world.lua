local Display = require('display')


local world = {}
world.state = "start"
world.point = 0

world.collides = function (entity1, entity2)
    if math.sqrt((entity1.x - entity2.x)^2 + (entity1.y - entity2.y)^2 ) 
    <= (entity1.radius + entity2.radius) then
        return true
    end
    return false
end

world.mouseEntityAngle = function (entity)
    return math.atan2(love.mouse.getY()-entity.y, love.mouse.getX()-entity.x )
end

world.drawGround = function ()
    love.graphics.reset()
    love.graphics.setColor(0.3, 0.3, 0.1, 0.45)
    love.graphics.rectangle('fill', 0, 0, Display.width, Display.height)
    love.graphics.reset()
end

return world