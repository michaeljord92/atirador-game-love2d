WIDTH = 1024
HEIGHT = 576

local display = {}
display.width, display.height = WIDTH, HEIGHT
display.isFullScreen = false
display.fullscreen = function (self)
    _, _, display.flags = love.window.getMode()
    display.width, display.height = love.window.getDesktopDimensions(display.flags.display)
    self.isFullScreen = true
end

return display