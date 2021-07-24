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

    for indexBullets = #bullets, 1, -1 do
        bullets[indexBullets]:update(dt)

        -- Bala no limite da tela
        if bullets[indexBullets]:screenBoundary() then
            table.remove(bullets, indexBullets)
        else
            -- Colisão da bala com os robores 
            for indexRobots = #robots, 1, -1 do
                if collides(bullets[indexBullets], robots[indexRobots]) then
                    table.remove(robots, indexRobots)
                    table.remove(bullets, indexBullets)
                    break
                end
            end
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


function collides(entity1, entity2)
    if math.sqrt((entity1.x - entity2.x)^2 + (entity1.y - entity2.y)^2 ) 
    <= (entity1.radius + entity2.radius) then
        return true
    end
    return false
end