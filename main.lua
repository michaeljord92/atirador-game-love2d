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
local Shooter = require('shooter')
local Robot = require('robot')
local Bullet = require('bullet')
local Hole = require('hole')


function love.load()
    math.randomseed(os.time())

    -- Display:fullscreen()
    love.window.setMode(Display.width, Display.height, {
        fullscreen = Display.isFullScreen,
        resizable = true
    })

    shooter = Shooter(Display.width/2, Display.height/2)
    
    bullets = {}

    timerLimit = 2 -- segundos
    timer = timerLimit
    robots = {}

    holes = {}
    table.insert(holes, Hole(40,40))
    table.insert(holes, Hole(Display.width - 40,40))
    table.insert(holes, Hole(40,Display.height - 40))
    table.insert(holes, Hole(Display.width - 40, Display.height - 40))
end

function love.update(dt)

    -- Criação automática de [robots]
    timer = timer - dt
    if timer <= 0 then
        local indexhole = math.random(1, #holes)
        local robot = Robot(holes[indexhole].x, holes[indexhole].y)
        table.insert(robots,robot)
        
        timerLimit = timerLimit * 0.93
        timer = math.random(timerLimit, timerLimit * 1.3)
        if timerLimit <= math.random(0,1) then
            timerLimit = timerLimit + math.random(0,1) + math.random(0,1)
        end
    end

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

    for index, hole in ipairs(holes) do
        hole:draw()
    end

    for _, bullet in ipairs(bullets) do
        bullet:draw()
    end

    for _, robot in ipairs(robots) do
        robot:draw()
    end
    
    shooter:draw()
    
    -- love.graphics.print('FPS: ' .. fps, 10, 12)
    -- love.graphics.print('Quantidade de balas: ' .. qtBullets, 10, 24)
    -- love.graphics.print('Quantidade de robores: ' .. qtRobots, 10, 38)
    -- love.graphics.print('Timer de robores: ' .. timer, 10, 50)
    -- love.graphics.print('timerLimit de robores: ' .. timerLimit, 10, 62)
end

function love.keypressed(key)
    -- Atira um [bullet]
    if  key == 'space' then
        local bullet = Bullet(shooter.x,shooter.y,shooter:mouseEntityAngle())
        table.insert(bullets,bullet)
    end

    -- Cria um novo [robot]
    if  key == 'return' then
        local indexhole = math.random(1,#holes)
        local robot = Robot(holes[indexhole].x, holes[indexhole].y)
        table.insert(robots,robot)
    end

    -- Sai do jogo
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