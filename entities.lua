local Display = require('display')
local Shooter = require('entities/shooter')
local Robot = require('entities/robot')
local Hole = require('entities/hole')
local World = require('world')


local entities = {}

entities.holes = {}
entities.holes.entities = {}
table.insert(entities.holes.entities, Hole(40,40))
table.insert(entities.holes.entities, Hole(Display.width - 40,40))
table.insert(entities.holes.entities, Hole(40,Display.height - 40))
table.insert(entities.holes.entities, Hole(Display.width - 40, Display.height - 40))

entities.holes.draw = function (self)
    for index, _ in ipairs(self.entities) do
        self.entities[index]:draw()
    end
end

entities.bullets = {}
entities.bullets.entities = {}
entities.bullets.draw = function (self)
    for index, _ in ipairs(self.entities) do
        self.entities[index]:draw()
    end 
end
entities.bullets.update = function (self,dt)
    for indexBullets = #self.entities, 1, -1 do
        self.entities[indexBullets]:update(dt)

        -- Bala no limite da tela
        if self.entities[indexBullets]:screenBoundary() then
            table.remove(self.entities, indexBullets)
        else
            -- Colisão da bala com os robores 
            for indexRobots = #entities.robots.entities, 1, -1 do
                if World.collides(self.entities[indexBullets], entities.robots.entities[indexRobots]) then
                    table.remove(entities.robots.entities, indexRobots)
                    table.remove(self.entities, indexBullets)
                    break
                end
            end
        end
    end
end

entities.robots = {}
entities.robots.entities = {}
entities.robots.timerLimit = 2 -- segundos
entities.robots.timer = 2

entities.robots.draw = function (self)
    for index, _ in ipairs(self.entities) do
        self.entities[index]:draw()
    end
end
entities.robots.update = function (self,dt)
    -- Criação automática de [robots]
    self.timer = self.timer - dt
    if self.timer <= 0 then
        local indexhole = math.random(1, #entities.holes.entities)
        local robot = Robot(entities.holes.entities[indexhole].x, entities.holes.entities[indexhole].y)
        table.insert(self.entities,robot)
        
        self.timerLimit = self.timerLimit * 0.93
        self.timer = math.random(self.timerLimit, self.timerLimit * 1.3)
        if self.timerLimit <= math.random(0,1) then
            self.timerLimit = self.timerLimit + math.random(0,1) + math.random(0,1)
        end
    end

    for i = #self.entities, 1, -1 do    
        self.entities[i]:update(dt, entities.shooter)
        if World.collides(self.entities[i],entities.shooter) then
            print("Game Over")
            World.state = "failed"
        end
    end
end

entities.shooter = Shooter(Display.width/2, Display.height/2)

return entities