local Entities = require('entities')
local Menu = require('menu')
local World = require('world')


local states = {

    -- Sai do jogo
    sair = function ()
        love.event.quit()
    end,

    -- Pausar o jogo
    pause = {
        update = function (dt)    
        end,
        draw = function ()
            World.drawGround()
            for key, _ in pairs(Entities) do
                if Entities[key].draw then
                    Entities[key]:draw()
                end
            end  
            Menu.pause.draw()
        end,
    },

    -- Rodando o jogo
    play = {
        update = function (dt)
            for key, _ in pairs(Entities) do
                if Entities[key].update then
                    Entities[key]:update(dt)
                end
            end  
        end,
        draw = function ()
            World.drawGround()
            for key, _ in pairs(Entities) do
                if Entities[key].draw then
                    Entities[key]:draw()
                end
            end  
        end,
    },

    -- Pausar o jogo
    start = {
        update = function (dt)    
        end,
        draw = function ()
            Menu.start.draw()
        end,
    },

    -- Game Over
    failed = {
        update = function (dt)    
        end,
        draw = function ()
            Menu.failed.draw()
        end,
    },

}

return states