local Display = require('display')
local Fonts = require('fonts')

local menu = {}

menu.pause = {
    text = "PaUsAdO",
    text2 = "Pressione SPACE para continuar\n ou ESC para sair",
    draw = function ()
        -- love.graphics.line(Display.width/2, 0, Display.width/2, Display.height)
        -- love.graphics.line(0, Display.height/2, Display.width, Display.height/2)

        love.graphics.reset()
        love.graphics.setColor(0, 0, 0, 0.7)
        love.graphics.rectangle('fill', 0, 0, Display.width, Display.height)

        love.graphics.reset()
        love.graphics.setColor(1, 20 / 255, 1)
        love.graphics.setFont(Fonts.blox2)
        love.graphics.printf(menu.pause.text, 0, Display.height/2 - Fonts.blox2:getHeight()/2, Display.width, 'center')
        love.graphics.reset()

        love.graphics.setFont(Fonts.badrobot)
        love.graphics.setColor(1, 100 / 255, 1)
        love.graphics.printf(menu.pause.text2, 0, Display.height/2 + Fonts.blox2:getHeight(), Display.width, 'center')
        love.graphics.reset()
    end
}

menu.start = {
    text = "SHOOTER",
    text2 = "Pressione SPACE para jogar",
    draw = function ()
        -- love.graphics.line(Display.width/2, 0, Display.width/2, Display.height)
        -- love.graphics.line(0, Display.height/2, Display.width, Display.height/2)

        love.graphics.reset()
        love.graphics.setColor(1, 1, 0.7, 0.3)
        love.graphics.rectangle('fill', 0, 0, Display.width, Display.height)

        love.graphics.reset()
        love.graphics.setColor(1, 1, 1)
        love.graphics.setFont(Fonts.robot)
        love.graphics.printf(menu.start.text, 0, Display.height/2 - Fonts.blox2:getHeight(), Display.width, 'center')
        love.graphics.reset()

        love.graphics.setFont(Fonts.badrobot)
        love.graphics.setColor(1, 100 / 255, 1)
        love.graphics.printf(menu.start.text2, 0, Display.height/2 + Fonts.blox2:getHeight(), Display.width, 'center')
        love.graphics.reset()
    end
}

menu.failed = {
    text = "failed",
    text2 = "Pressione SPACE para jogar novamente",
    draw = function ()
        -- love.graphics.line(Display.width/2, 0, Display.width/2, Display.height)
        -- love.graphics.line(0, Display.height/2, Display.width, Display.height/2)

        love.graphics.reset()
        love.graphics.setColor(1, 0.5, 0.7, 0.3)
        love.graphics.rectangle('fill', 0, 0, Display.width, Display.height)

        love.graphics.reset()
        love.graphics.setColor(1, 1, 1)
        love.graphics.setFont(Fonts.dura)
        love.graphics.printf(menu.failed.text, 0, Display.height/2 - Fonts.blox2:getHeight(), Display.width, 'center')
        love.graphics.reset()

        love.graphics.setFont(Fonts.badrobot)
        love.graphics.setColor(1, 100 / 255, 1)
        love.graphics.printf(menu.failed.text2, 0, Display.height/2 + Fonts.blox2:getHeight(), Display.width, 'center')
        love.graphics.reset()
    end
}

menu.scoreboard = {
    text = "Score",
    draw = function ()
        love.graphics.reset()
        love.graphics.setColor(1, 20 / 255, 1)
        love.graphics.setFont(Fonts.blox2)
        love.graphics.printf(menu.pause.text, 0, Display.height/2- 25, Display.width, 'center')
        love.graphics.reset()
    end
}

return menu