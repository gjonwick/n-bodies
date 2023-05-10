Camera = Class{}

function Camera:init()
    self.xOffset = 0
    self.yOffset = 0
    self.speed = 500
end

function Camera:updateOffsets(x, y)
    self.xOffset = x
    self.yOffset = y
end

function Camera:moveLeft(dt)
    self.xOffset = self.xOffset - self.speed * dt
end

function Camera:moveRight(dt)
    self.xOffset = self.xOffset + self.speed * dt
end

function Camera:moveUp(dt)
    self.yOffset = self.yOffset - self.speed * dt
end

function Camera:moveDown(dt)
    self.yOffset = self.yOffset + self.speed * dt
end
-- getters and setters

function Camera:getOffsets()
    return {x = self.xOffset, y = self.yOffset}
end
