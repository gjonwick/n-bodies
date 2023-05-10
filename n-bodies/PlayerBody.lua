PlayerBody = Class{__includes = Body}

function PlayerBody:handleInput()
    local appliedForce = {x = 0, y = 0}
    -- burst of anti-gravity when space or left mouse are pressed
    if love.keyboard.isDown('up') then
        appliedForce = {x = 0, y = -1000}
    elseif love.keyboard.isDown('down') then
        appliedForce = {x = 0, y = 1000}
    elseif love.keyboard.isDown('right') then
        appliedForce = {x = 1000, y = 0}
    elseif love.keyboard.isDown('left') then
        appliedForce = {x = -1000, y = 0}
    end
    self.force = addVectors(self.force, appliedForce)
end

function PlayerBody:update(dt)

    self:handleInput()

    self:updateState(dt)

end
