local config = require "config.config"

local UserStatsPanel = {}
UserStatsPanel.__index = UserStatsPanel

function UserStatsPanel:new()
    local o = {}
    setmetatable(o, UserStatsPanel)
    o.panel = love.graphics.newImage("assets/ui/ui.png")
    o.PixelPurl = love.graphics.newFont("assets/fonts/PixelPurl.ttf", 18)
    o.StatsFont = love.graphics.newFont("assets/fonts/Born2bSportyFS.otf", 24)
    o.HealthFont = love.graphics.newFont("assets/fonts/Born2bSportyFS.otf", 42)
    o.HealthFont_mini = love.graphics.newFont("assets/fonts/Born2bSportyFS.otf", 18)
    o.x = 10
    o.y = 10
    o.scale = 2
    return o
end

function UserStatsPanel:healthInterface(panelW, panelH)
    local healthMarker = "x"
    love.graphics.setFont(self.HealthFont_mini)
    local markerOffset = self.HealthFont_mini:getWidth(healthMarker) + 2

    -- Draw "x" marker
    love.graphics.setColor(1, 1, 1)
    love.graphics.printf(
        healthMarker,
        self.x + panelW/4 - markerOffset, -- pos x, left side with padding
        self.y + (panelH / 2) - 2, -- pos y, vertically centered
        panelW / 2 - 10, -- text box max width
        "left"
    )

    -- Draw health number
    love.graphics.setFont(self.HealthFont)
    local fontH = self.HealthFont:getHeight()
    love.graphics.printf(
        tostring(Player.health),
        self.x + panelW/4, -- pos x, left side with padding
        self.y + (panelH - fontH) / 2, -- pos y, vertically centered
        panelW / 2 - 10, -- text box max width
        "left"
    )
end

function UserStatsPanel:scoreInterface(panelW, offset)
    love.graphics.setFont(self.StatsFont)
    local scoreText = string.format("%04d", GameScore.score)
    love.graphics.setColor(1, 1, 1)
    love.graphics.printf(
        scoreText,
        self.x + panelW/2 + offset, -- pos x
        self.y + 5, -- pos y
        panelW/2 - 10, -- text box max width
        "left"
    )
end

function UserStatsPanel:speedInterface(panelW, panelH, offset)
    love.graphics.setFont(self.StatsFont)
    local fontH = self.StatsFont:getHeight()
    -- TODO: Design wants two fonts but for that we need to calculate
    -- the font width of the first font and then use that as an offset to align the two text
    local speedText = math.floor(10 * config.SpeedMultiplier) .. "mph"
    love.graphics.setColor(1, 1, 1)
    love.graphics.printf(
        speedText,
        self.x + panelW/2 + offset, -- pos x
        self.y + panelH - fontH - 10, -- pos y
        panelW/2 - 10, -- text box max width
        "left"
    )
end

function UserStatsPanel:draw()
    -- Draw the panel background image
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(self.panel, self.x, self.y, 0, self.scale, self.scale)

    local panelW = self.panel:getWidth() * self.scale
    local panelH = self.panel:getHeight() * self.scale
    -- offset from the halfway point of the panel to dial in stat positions
    local offset = 45

    self:healthInterface(panelW, panelH)
    self:scoreInterface(panelW, offset)
    self:speedInterface(panelW, panelH, offset)

    love.graphics.setColor(1, 1, 1)
end

return UserStatsPanel
