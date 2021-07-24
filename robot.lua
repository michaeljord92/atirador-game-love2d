local Sprite = require('sprite')
local Display = require('display')

---
---Criar um novo [robot].
---
---@param x number # Posicao no eixo x.
---@param y number # Posicao no eixo y.
---@param direction number # Direção do alvo.
---@param sprite love.Image # Imagem do [robot].
---@return table table # O [robot] novo.
return function (x, y, direction, sprite)
    local entity = {}
    entity.x = x or math.random(0, Display.width)
    entity.y = y or math.random(0, Display.height)
    entity.sprite = sprite or Sprite.robot
    entity.speed = 100
    entity.direction = direction or 0

    entity.targetEntityAngle = function (self, target)
        return math.atan2(
            (target.y or 0)-self.y,
            (target.x or 0)-self.x
        )
    end

    entity.update = function (self, dt, target)
        self.direction = self:targetEntityAngle(target)
        self.x = self.x + self.speed * math.cos(self.direction) * dt
        self.y = self.y + self.speed * math.sin(self.direction) * dt
    end

    entity.draw = function (self) 
        love.graphics.draw(
            self.sprite, 
            self.x, self.y, -- posição
            self.direction,  -- rotação
            nil, nil, -- escala
            self.sprite:getWidth()/2, -- centro no eixo x
            self.sprite:getHeight()/2 -- centro no eixo y
        )
    end

    return entity
end