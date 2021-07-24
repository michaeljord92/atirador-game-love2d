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
    robots = {}
    
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

    for i = #robots, 1, -1 do
        robots[i]:update(dt, shooter)
    end

    fps = love.timer.getFPS()
    qtBullets = #bullets
    qtRobots = #robots
end

function love.draw()

    for _, bullet in ipairs(bullets) do
        bullet:draw()
    end

    for _, robot in ipairs(robots) do
        robot:draw()
    end
    
    shooter:draw()
    
    love.graphics.print('FPS: ' .. fps, 10, 12)
    love.graphics.print('Quantidade de balas: ' .. qtBullets, 10, 24)
    love.graphics.print('Quantidade de robores: ' .. qtRobots, 10, 38)
end



function love.keypressed(key)
    if  key == 'space' then
        local bullet = Bullet(shooter.x,shooter.y,shooter:mouseEntityAngle())
        table.insert(bullets,bullet)
    end

    if  key == 'return' then
        local robot = Robot()
        table.insert(robots,robot)
    end

    if  key == 'escape' then
        love.event.quit()
    end

end
