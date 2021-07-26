local Sprite = require('sprite')
local Display = require('display')

---
---Criar um novo [hole].
---
---@param x number # Posicao no eixo x.
---@param y number # Posicao no eixo y.
---@param sprite love.Image # Imagem do [hole].
---@return table table # O [hole] novo.
return function (x, y, sprite)
    local entity = {}
    entity.x = x or math.random(0, Display.width)
    entity.y = y or math.random(0, Display.height)
    entity.sprite = sprite or Sprite.hole

    entity.draw = function (self) 
        love.graphics.draw(
            self.sprite, 
            self.x, self.y, -- posição
            0,  -- rotação
            nil, nil, -- escala
            self.sprite:getWidth()/2, -- centro no eixo x
            self.sprite:getHeight()/2 -- centro no eixo y
        )
    end

    return entity
end