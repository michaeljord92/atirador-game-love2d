WIDTH = 1024
HEIGHT = 576

local display = {}
display.title = "Aula 3 e 4 - Atirador"
display.icon = "assets/images/soldier1_gun.png"
display.resizable = true
display.width, display.height = WIDTH, HEIGHT
display.isFullScreen = false
display.fullscreen = function (self)
    _, _, self.flags = love.window.getMode()
    self.width, self.height = love.window.getDesktopDimensions(self.flags.display)
    self.isFullScreen = true
end

return display