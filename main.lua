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
local Keypressed = require('keypressed')
local Entities = require('entities')
local States = require('states')
local World = require('world')




function love.load()
    math.randomseed(os.time())

    -- Display:fullscreen()
    love.window.setMode(Display.width, Display.height, {
        fullscreen = Display.isFullScreen,
        resizable = true
    })

    Entities.robots.timerLimit = 2
    Entities.robots.timer = Entities.robots.timerLimit
end

function love.update(dt)

    if States[World.state] then
        States[World.state].update(dt) 
    end

    fps = love.timer.getFPS()
    qtBullets = #Entities.bullets.entities
    qtRobots = #Entities.robots.entities
end

function love.draw()

    if States[World.state] then
        States[World.state].draw() 
    end
    
    -- love.graphics.print('FPS: ' .. fps, 10, 12)
    -- love.graphics.print('Quantidade de balas: ' .. qtBullets, 10, 24)
    -- love.graphics.print('Quantidade de robores: ' .. qtRobots, 10, 38)
    -- love.graphics.print('Timer de robores: ' .. timer, 10, 50)
    -- love.graphics.print('timerLimit de robores: ' .. timerLimit, 10, 62)
end

function love.keypressed(key)
    if Keypressed[key] then
        Keypressed[key]()
    end
end

function love.mousepressed(x, y, button, istouch)
    print(button)
    if button == 1 then
        if World.state == "play" then
            Entities.shooter:shoot(Entities.bullets.entities)
        end
    end
 end