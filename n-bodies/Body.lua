Body = Class{}

function Body:init(def)

    self.position = def.position
    self.velocity = def.velocity
    self.force = def.force
    self.mass = def.mass
    self.dampingFactor = 1
    self.color = def.color or {255, 255, 255}
    self.size = def.size or 7
    self.positionHistory = {}
    self.historySize = 0
    self.xOffset = 0
    self.yOffset = 0
end

function Body:interact(body)
    local softCollisionFactor = 0.001
    local dist = addVectors(body.position, multiplyVector((-1), self.position))
    local normDist = norm(dist) + softCollisionFactor + self.size + body.size
    local inverseNormDist = 1 / normDist
    local inverseNormDistCubed = inverseNormDist * inverseNormDist * inverseNormDist
    local force = multiplyVector(NEWTON_G * self.mass * body.mass * inverseNormDistCubed, dist)
    return force
end

function Body:updateState(dt)
    local r, v, a
    r = self.position
    v = self.velocity
    a = multiplyVector(1/self.mass, self.force)
    v = addVectors(v, multiplyVector(dt, a))
    v = multiplyVector(self.dampingFactor, v)
    r = addVectors(r, multiplyVector(dt, v))

    self.position = r
    self.historySize = self.historySize + 1
    table.insert(self.positionHistory, r)
    if self.historySize > 1000 then
       table.remove(self.positionHistory, 1)
    end
    self.velocity = v
end

function Body:updateOffsets(x, y)
    self.xOffset = x
    self.yOffset = y
end


function Body:update(dt)
    self:updateState(dt)
end

function Body:render()
    love.graphics.setColor(self.color)
    love.graphics.circle("fill", self.position.x + VIRTUAL_WIDTH/2 - self.xOffset, self.position.y + VIRTUAL_HEIGHT/2 - self.yOffset, self.size)

    for key, pos in pairs(self.positionHistory) do
        if pos ~= nil then
            love.graphics.circle("fill", pos.x + VIRTUAL_WIDTH/2 - self.xOffset, pos.y + VIRTUAL_HEIGHT/2 - self.yOffset, 2)
            love.graphics.print(tostring(#self.positionHistory) .. 'history size = ' .. self.historySize, 20, 30)
        end
    end
        
    
    
end


-- Getters and setters

function Body:setForce(force)
    self.force = force
end

function Body:getForce()
    return self.force
end

function Body:setVelocity(velocity)
    self.velocity = velocity
end



