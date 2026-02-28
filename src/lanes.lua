-- for temporary visualization of lanes
local Lanes = {}
Lanes.__index = Lanes

function Lanes:new()
    local o = {}
    setmetatable(o, Lanes)

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
    local laneHeight = Player.height / 2  + 15 -- 15 is just a buffer to make it look nicer
    love.graphics.setColor(0.5, 0.5, 0.5)
    
    love.graphics.rectangle("line", self.lane1.x, self.lane1.y, ScreenWidth, laneHeight + 15)
    love.graphics.rectangle("line", self.lane2.x, self.lane2.y, ScreenWidth, laneHeight + 15)
end


return Lanes
