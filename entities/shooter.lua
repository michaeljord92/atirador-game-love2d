local Sprite = require('sprite')
local World = require('world')
local Bullet = require('entities/bullet')
-- local bullets = require('entities').bullets



-- local function mouseEntityAngle(x, y)
--     return math.atan2(love.mouse.getY()-y, love.mouse.getX()-x )
-- end

---
---Criar um novo [shooter].
---
---@param x number # Posicao no eixo x.
---@param y number # Posicao no eixo y.
---@param sprite love.Image # Imagem do [shooter].
---@return table table # O [shooter] novo.
return function (x, y, bullets, sprite)
    local entity = {}
    entity.x = x or 30
    entity.y = y or 30
    entity.sprite = sprite or Sprite.shooter
    entity.speed = 160
    entity.rotation = 0
    entity.radius = 25
    entity.especial = false
    entity.especial_time = 0
    entity.bullets = bullets
    
    entity.shoot = function (self)
        local bullet = Bullet(self.x,self.y,self.rotation)
        table.insert(self.bullets,bullet)
    end

    entity.update = function (self, dt, upKey, downKey, leftKey, rightKey)
        
        -- especial 
        if self.especial then
            self.especial_time = self.especial_time - dt
            if self.especial_time <= 0 then
                self.especial = false
            end

            self.rotation = self.rotation + 10 * dt
            if (math.modf(self.rotation*11)%3) == 0 then
                self:shoot()                
            end
            
        -- normal
        else
            self.rotation = World.mouseEntityAngle(self)
        
            if love.keyboard.isDown(upKey or 'w') then
                self.y = self.y - self.speed * dt
            end
            if love.keyboard.isDown(downKey or 's') then
                self.y = self.y + self.speed * dt
            end
            if love.keyboard.isDown(leftKey or 'a') then
                self.x = self.x - self.speed * dt
            end
            if love.keyboard.isDown(rightKey or 'd') then
                self.x = self.x + self.speed * dt
            end
        end
    end

    entity.draw = function (self) 
        love.graphics.draw(
            self.sprite, 
            self.x, self.y, -- posição
            self.rotation,  -- rotação
            nil, nil, -- escala
            self.sprite:getWidth()/2, -- centro no eixo x
            self.sprite:getHeight()/2 -- centro no eixo y
        )
        -- love.graphics.circle('line', self.x, self.y, self.radius)

    end

    return entity
end