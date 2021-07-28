local Display = require('display')
local Fonts = require('fonts')
local Sprite = require('sprite')
local World = require('world')



local menu = {}

menu.pause = {
    text = "PaUsEd",
    text2 = "Pressione SPACE para continuar\n ou ESC para sair",
    draw = function (self)
        -- love.graphics.line(Display.width/2, 0, Display.width/2, Display.height)
        -- love.graphics.line(0, Display.height/2, Display.width, Display.height/2)

        love.graphics.reset()
        love.graphics.setColor(0, 0, 0, 0.7)
        love.graphics.rectangle('fill', 0, 0, Display.width, Display.height)

        love.graphics.reset()
        love.graphics.setColor(1, 20 / 255, 1)
        love.graphics.setFont(Fonts.blox2)
        love.graphics.printf(self.text, 0, Display.height/2 - Fonts.blox2:getHeight()/2, Display.width, 'center')
        love.graphics.reset()

        love.graphics.setFont(Fonts.badrobot)
        love.graphics.setColor(1, 100 / 255, 1)
        love.graphics.printf(self.text2, 0, Display.height/2 + Fonts.blox2:getHeight(), Display.width, 'center')
        love.graphics.reset()
    end
}

menu.start = {
    text = "SHOOTER",
    text2 = "Pressione SPACE para jogar",
    draw = function (self)
        -- love.graphics.line(Display.width/2, 0, Display.width/2, Display.height)
        -- love.graphics.line(0, Display.height/2, Display.width, Display.height/2)

        love.graphics.reset()
        love.graphics.setColor(1, 1, 0.7, 0.3)
        love.graphics.rectangle('fill', 0, 0, Display.width, Display.height)

        love.graphics.reset()
        love.graphics.setColor(1, 1, 1)
        love.graphics.setFont(Fonts.robot)
        love.graphics.printf(self.text, 0, Display.height/2 - Fonts.blox2:getHeight(), Display.width, 'center')
        love.graphics.reset()

        love.graphics.setFont(Fonts.badrobot)
        love.graphics.setColor(1, 100 / 255, 1)
        love.graphics.printf(self.text2, 0, Display.height/2 + Fonts.blox2:getHeight(), Display.width, 'center')
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
    title = "Score",
    
    board_sprite = Sprite.scoreboard,
    board_x = Display.width/2,
    board_y = 8,

    draw = function (self)
        -- board 
        love.graphics.reset()
        love.graphics.draw(
            self.board_sprite, 
            self.board_x, 
            self.board_y, -- posição
            0,  -- rotação
            nil, 
            1.5, -- escala
            self.board_sprite:getWidth()/2 -- centro no eixo x
            -- self.board_sprite:getHeight()/2 -- centro no eixo y
        )

        -- titulo
        love.graphics.setColor(1, 20 / 255, 1)
        love.graphics.setFont(Fonts.badrobot)
        love.graphics.printf(
            self.title, 
            self.board_x - self.board_sprite:getWidth()/2, 
            self.board_y + 2, 
            self.board_sprite:getWidth()-10, 
            'center')
        love.graphics.reset()

        -- icone do inimigo
        love.graphics.draw(
            Sprite.robot, 
            self.board_x - self.board_sprite:getWidth() * 0.5 + 15, 
            self.board_y + Sprite.robot:getHeight() * 0.5 * 2 + 4, 
            0,  -- rotação
            0.5, 
            0.5, -- escala
            Sprite.robot:getWidth()/2, -- centro no eixo x
            Sprite.robot:getHeight()/2 -- centro no eixo y
        )

        -- pontuação
        love.graphics.setColor(0, 0, 0)
        love.graphics.setFont(Fonts.badrobot)
        love.graphics.printf(
            World.point, 
            self.board_x - self.board_sprite:getWidth()/2 + 30, -- x
            self.board_y + love.graphics.getFont():getHeight() + 8, -- y
            self.board_sprite:getWidth() - 40, -- limit
            'right' -- align
        )
        love.graphics.reset()
    end
}

return menu