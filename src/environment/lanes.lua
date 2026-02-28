-- for temporary visualization of lanes
local Lanes = {}
Lanes.__index = Lanes

function Lanes:new()
    local o = {}
    setmetatable(o, Lanes)
    o.laneHeight = Player.height
    o.lane1 = {
        x = 0,
        y = ScreenHeight/2 - Player.height/2
    }
    o.lane2 = {
        x = 0,
        y = ScreenHeight/2 + Player.height/2
    }
    return o
end

function Lanes:drawLanes()
    love.graphics.setColor(0.5, 0.5, 0.5)
    
    love.graphics.rectangle("line", self.lane1.x, self.lane1.y, ScreenWidth, self.laneHeight)
    love.graphics.rectangle("line", self.lane2.x, self.lane2.y, ScreenWidth, self.laneHeight)
end


return Lanes
