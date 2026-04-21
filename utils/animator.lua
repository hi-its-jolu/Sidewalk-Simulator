local Animator = {}
Animator.__index = Animator

-- params:
--   spriteSheet   : love.graphics image
--   frameWidth    : width of a single frame in pixels (default 32)
--   frameHeight   : height of a single frame in pixels (default 64)
--   frameCount    : total frames (optional — inferred from sheet size / frame size)
--   frameDuration : seconds per frame (default 0.2)
function Animator:new(params)
    local o = {}
    setmetatable(o, Animator)

    local frameWidth  = params.frameWidth  or 32
    local frameHeight = params.frameHeight or 64
    
    local sheetW     = params.spriteSheet:getWidth()
    local sheetH     = params.spriteSheet:getHeight()

    -- TODO: If frames go into another row, of if different animations on a different row
    -- we would need to account for that.
    local frameCount = params.frameCount
                       or math.floor(sheetW / frameWidth) * math.floor(sheetH / frameHeight)

    o.spriteSheet = params.spriteSheet
    o.frameDuration = params.frameDuration or 0.2
    o.currentFrame = 0
    o.frameTimer = 0

    o.frames = {}
    for i = 0, frameCount - 1 do
        -- crop sheet into frames
        o.frames[i + 1] = love.graphics.newQuad(
            i * frameWidth, 0,
            frameWidth, frameHeight,
            sheetW, sheetH
        )
    end

    return o
end

-- TODO Animation switcher or individually animator objects per spritesheet?


function Animator:update(dt)
    self.frameTimer = self.frameTimer + dt
    if self.frameTimer >= self.frameDuration then
        self.frameTimer = self.frameTimer - self.frameDuration
        self.currentFrame = (self.currentFrame + 1) % #self.frames
    end
end

-- x, y, rotation, scaleX, scaleY all match love.graphics.draw params
function Animator:draw(x, y, rotation, scaleX, scaleY)
    love.graphics.draw(
        self.spriteSheet,
        self.frames[self.currentFrame + 1],
        x, y,
        rotation or 0,
        scaleX or 1,
        scaleY or 1
    )
end

return Animator
