local Sprite = require('sprite')

BULLET_SPEED = 300

---
---Criar um novo [bullet].
---
---@param x number # Posicao no eixo x.
---@param y number # Posicao no eixo y.
---@param sprite love.Image # Imagem do [bullet].
---@return table table # O [bullet] novo.
return function (x, y, direction, sprite)
    local entity = {}
    entity.x = x + 30 * math.cos(direction+0.36)
    entity.y = y + 30 * math.sin(direction+0.36)
    entity.sprite = sprite or Sprite.bullet
    entity.speed = BULLET_SPEED
    entity.direction = direction

    entity.update = function (self, dt)
        self.x = self.x + self.speed * math.cos(self.direction) * dt
        self.y = self.y + self.speed * math.sin(self.direction) * dt
    end

    entity.draw = function (self) love.graphics.draw(
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