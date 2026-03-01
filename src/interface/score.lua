local Score = {}
Score.__index = Score

function Score:new()
    local o = {}
    setmetatable(o, Score)
    o.value = 0
    o.frameCount = 0
    return o
end

function Score:update()
    self.frameCount = self.frameCount + 1
    if self.frameCount % 10 == 0 then
        self.value = self.value + 1
    end
end

function Score:draw()
    love.graphics.setColor(0,0,0)
    love.graphics.print("Score: " .. tostring(self.value), 10, 10)
end

function Score:reset()
    self.value = 0
    self.frameCount = 0
end

return Score
