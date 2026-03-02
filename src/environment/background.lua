local config = require "config.config"
local helper = require "utils.helper"

local Background = {}
Background.__index = Background

function Background:new(lanes)
    local o = {}
    setmetatable(o, Background)
    o.assets = {
        love.graphics.newImage("assets/environment/bg-01.png"),
        love.graphics.newImage("assets/environment/bg-02.png"),
    }
    o.assetStack = o.assets -- array of usable assets, refilled when runs out
    o.lanes = lanes
    o.maxSceneSize = 5
    o.scene = o:buildScene()
    return o
end

function Background:update(dt)
    
end

function Background:draw()

    for i, asset in ipairs(self.scene) do
        love.graphics.setColor(config.BackgroundColor)
        love.graphics.draw(
        asset,
        (i-1) * asset:getWidth() * 2, -- X
        0, -- Y
        0, -- rotation
        2, -- scaleX
        2) -- scaleY
    end

    love.graphics.draw(self.scene[1], 0, 0, 0, 2, 2)
end

function Background:buildScene()
    local randomIndex = math.random(1, #self.assetStack)
    local asset = self.assetStack[randomIndex]

    if self.scene == nil then
        self.scene = {}
    end

    if #self.scene < self.maxSceneSize then
        for _ = #self.scene + 1, self.maxSceneSize do
            randomIndex = math.random(1, #self.assetStack)
            asset = self.assetStack[randomIndex]

            table.insert(self.scene, asset)

        end
    end

    return self.scene
end


function Background:calculateSize()
    local topLane = self.lanes.lane1
    local backgroundX = 0
    local backgroundY = topLane.y
    local backgroundWidth = topLane.width
    local backgroundHeight = backgroundY

    if config.DebugToggle  then
        print("Background X: " .. backgroundX .. " Y: " .. backgroundY .. " Width: " .. backgroundWidth .. " Height: " .. backgroundHeight)
    end

    return backgroundX,  backgroundY, backgroundWidth, backgroundHeight
end

return Background
