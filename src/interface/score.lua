local Config = require "config.config"

local Score = {}
Score.__index = Score

local SCORE_INTERVAL = 0.1 -- seconds between score increments

function Score:new()
    local o = {}
    setmetatable(o, Score)
    o.score = 0
    o.timeAccumulator = 0
    o.font = love.graphics.newFont(25)
    o.speedLevel = 0
    return o
end

function Score:update(dt)
    self.timeAccumulator = self.timeAccumulator + math.min(dt, 0.5)
    while self.timeAccumulator >= SCORE_INTERVAL do
        self.timeAccumulator = self.timeAccumulator - SCORE_INTERVAL
        
        if Player.health > 0 then
            self.score = self.score + 1    
            self:increaseSpeed()
        end
    end
end

function Score:increaseSpeed()
    local speedIncrease = Config.SpeedIncreasePerLevel or 0.05
    local pointsPerSpeedLevel = Config.PointsPerSpeedLevel or 50
    local newSpeedLevel = math.floor(self.score / pointsPerSpeedLevel)
    
    if newSpeedLevel > self.speedLevel then
        local maxSpeed = Config.MaxSpeedMultiplier or 3
        Config.SpeedMultiplier = math.min(Config.SpeedMultiplier + (speedIncrease * (newSpeedLevel - self.speedLevel)), maxSpeed)
        self.speedLevel = newSpeedLevel
    end
end

function Score:reset()
    self.score = 0
    self.timeAccumulator = 0
end

return Score
