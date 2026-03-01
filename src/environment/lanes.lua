local config = require "config.config"

-- for temporary visualization of lanes
local Lanes = {}
Lanes.__index = Lanes

function Lanes:new()
    local o = {}
    setmetatable(o, Lanes)
    o.laneHeight = Player.height
    o.lane1 = {
        x = 0,
        y = ScreenHeight/2 - Player.height/2 -  config.ChunkSize,
        width = ScreenWidth,
        height = o.laneHeight
    }
    o.lane2 = {
        x = 0,
        y = ScreenHeight/2 + Player.height/2 -  config.ChunkSize,
        width = ScreenWidth,
        height = o.laneHeight
    }
    o.sizesPrinted = false
    return o
end

function Lanes:drawLanes()
    love.graphics.setColor(config.LaneColor)

    love.graphics.rectangle("fill", self.lane1.x, self.lane1.y, self.lane1.width, self.lane1.height)
    love.graphics.rectangle("fill", self.lane2.x, self.lane2.y, self.lane2.width, self.lane2.height)
    love.graphics.setColor(0,0,0)
    love.graphics.rectangle("line", self.lane1.x, self.lane1.y, self.lane1.width, self.lane1.height)
    love.graphics.rectangle("line", self.lane2.x, self.lane2.y, self.lane2.width, self.lane2.height)
end




return Lanes
