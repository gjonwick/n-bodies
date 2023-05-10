System = Class{}

function System:init(def)
    self.bodies = def.bodies
    self.camera = Camera()
    self.playerBody = def.bodies[1]
end


function System:update(dt)
    for k1, body1 in ipairs(self.bodies) do
        local sumForce = {x = 0, y = 0}
        for k2, body2 in ipairs(self.bodies) do
            if k1 ~= k2 then
                sumForce = addVectors(sumForce, body1:interact(body2))
            end
        end
        body1:setForce(sumForce)
    end


    local cameraOffsets = self.camera:getOffsets()
 
    if love.keyboard.isDown('s') and love.keyboard.isDown('d') then
        self.camera:updateOffsets(cameraOffsets.x + self.camera.speed * dt, cameraOffsets.y + self.camera.speed * dt)
    elseif love.keyboard.isDown('d') then
        self.camera:updateOffsets(cameraOffsets.x + self.camera.speed * dt, cameraOffsets.y)
    elseif love.keyboard.isDown('s') and love.keyboard.isDown('a') then
        self.camera:updateOffsets(cameraOffsets.x - self.camera.speed * dt, cameraOffsets.y + self.camera.speed * dt)
    elseif love.keyboard.isDown('s') then
        self.camera:updateOffsets(cameraOffsets.x, cameraOffsets.y + self.camera.speed * dt)
    elseif love.keyboard.isDown('a') then
        self.camera:updateOffsets(cameraOffsets.x - self.camera.speed * dt, cameraOffsets.y)
    elseif love.keyboard.isDown('w') and love.keyboard.isDown('d') then
        self.camera:updateOffsets(cameraOffsets.x + self.camera.speed * dt, cameraOffsets.y - self.camera.speed * dt)
    elseif love.keyboard.isDown('w') then
        self.camera:updateOffsets(cameraOffsets.x, cameraOffsets.y - self.camera.speed * dt)
    end

    -- if love.keyboard.isDown('d') then
    --     self.camera:updateOffsets(cameraOffsets.x + self.camera.speed * dt, cameraOffsets.y)
    -- end
    -- if love.keyboard.isDown('a') then
    --     self.camera:updateOffsets(cameraOffsets.x - self.camera.speed * dt, cameraOffsets.y)
    -- end
    
    --if love.keyboard.isDown('space') then
        -- add tween here
        self.camera:updateOffsets(self.playerBody.position.x, self.playerBody.position.y)
    --end

    for k, body in ipairs(self.bodies) do
        body:updateOffsets(self.camera.xOffset, self.camera.yOffset)
        body:update(dt)
    end


end


function System:render()
    for k, body in ipairs(self.bodies) do
        body:render()
    end
end

