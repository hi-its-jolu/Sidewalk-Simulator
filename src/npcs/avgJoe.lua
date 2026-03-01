---@diagnostic disable: duplicate-set-field
local Config = require "config.config"
local Template = require "src.npcs.template"

local AvgJoe = setmetatable({}, {__index = Template})
AvgJoe.__index = AvgJoe

function AvgJoe:new(o)
    o = o or Template:new()
    setmetatable(o, AvgJoe)
    -- defaults
    o.name = o.name or "Average Joe"
    o.image = love.graphics.newImage("assets/npc/avgJoe-2x.png")
    return o
end


return AvgJoe