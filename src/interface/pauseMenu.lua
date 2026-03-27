local PauseMenu = {}
PauseMenu.__index = PauseMenu

function PauseMenu:new()
    local o = {}
    setmetatable(o, PauseMenu)
    o.paused = false
    return o
end

function PauseMenu:toggle()
    self.paused = not self.paused
end

function PauseMenu:draw()
    if not self.paused then return end

    local sw = love.graphics.getWidth()
    local sh = love.graphics.getHeight()

    -- Dim overlay
    love.graphics.setColor(0, 0, 0, 0.5)
    love.graphics.rectangle("fill", 0, 0, sw, sh)

    -- "PAUSED" text
    love.graphics.setColor(1, 1, 1)
    local font = love.graphics.getFont()
    local text = "PAUSED"
    local textW = font:getWidth(text)
    local textH = font:getHeight()
    love.graphics.print(text, sw / 2 - textW / 2, sh / 2 - textH / 2)
end

return PauseMenu
