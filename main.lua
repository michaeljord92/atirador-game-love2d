-- Programa: Aula 3 e 4 - O atirador
-- Autor: Michael Jordan S Chagas
-- Curso: Ciência da Computação - UFMT-CUA
-- Disclina: Design e Programação de Games (Opt)
-- Docente: Maxwell Silva Carmo
-- Data: 2021-07-23
--
-- Este programa simula um jogo de atirador contra robores.
-- Os comandos e controles do atirador são:
--   - mover para cima:     'w'
--   - mover para baixo:    's'
--   - mover para esquerda: 'a'
--   - mover para direita:  'd'
--   - atirar:              'espaço'
--   - especial:            ''
-------------------------------------------------------


local Display = require('display')
local Sprite = require('sprite')
local Shooter = require('shooter')
local Robot = require('robot')
local Bullet = require('bullet')


function love.load()
    math.randomseed(os.time())

    love.window.setMode(Display.width, Display.height, {
        -- fullscreen = true,
        resizable = true
    })

    shooter = Shooter(Display.width/2, Display.height/2)
    bullets = {}
    
end

function love.update(dt)
    shooter:update(dt)

    for i = #bullets, 1, -1 do
        bullets[i]:update(dt)

        if bullets[i].x <= 0 or bullets[i].x > Display.width or 
        bullets[i].y <= 0 or bullets[i].y > Display.height then
            table.remove(bullets, i)
        end
    end

    fps = love.timer.getFPS()
end

function love.draw()

    for _, bullet in ipairs(bullets) do
        bullet:draw()
    end
    
    shooter:draw()

    
    love.graphics.print('FPS: ' .. fps, 10, 12)
    love.graphics.print('Quantidade de balas: ' .. #bullets, 10, 24)

end



function love.keypressed(key)
    -- if state == 'start' and (key == 'return' or key == 'space') then
        
    --     state = 'play'
    -- end
    if  key == 'space' then
        local bullet = Bullet(shooter.x,shooter.y,shooter:mouseEntityAngle())
        table.insert(bullets,bullet)
        
    end

    if  key == 'escape' then
        love.event.quit()
    end

end
