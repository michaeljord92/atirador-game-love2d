local Robot = require('entities/robot')
local Entities = require('entities')
local States = require('states')
local World = require('world')


local key_map = {
    -- Dar player no jogo ou atira
    space = function ()
        -- Dar player no jogo
        if World.state == "pause" or World.state == "start" then
            World.state = "play"
        
        -- Atira um [bullet]
        elseif World.state == "play" then
            Entities.shooter:shoot(Entities.bullets.entities)

        elseif World.state == "failed" then
            World.state = "start"
        end
    end,
    
    -- Cria um novo [robot]
    backspace = function ()
        if(World.state == "play")then
            local indexhole = math.random(1,#Entities.holes.entities)
            local robot = Robot(Entities.holes.entities[indexhole].x, Entities.holes.entities[indexhole].y)
            table.insert(Entities.robots.entities,robot)
        end
    end,

    -- Pausa ou sai do jogo
    escape = function ()
        -- Pausa o jogo 
        if World.state == "play" then
            World.state = "pause"
        
        -- Sai do jogo
        else
            States.sair()
        end
    end
}

return key_map