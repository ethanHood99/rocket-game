-- Ethan Hood
-- 3/25/2025
-- File that controls the camera object

Camera = {}

function Camera.reset()
    Camera.y = 0
end

function Camera.update(dt)
    -- Adjust camera to follow the rocket upward only
    if Rocket.y < 300 + Camera.y then
        Camera.y = Rocket.y - 300
    end
end

function Camera.apply()
    love.graphics.translate(0, -Camera.y)
end

function Camera.resetTransform()
    love.graphics.origin()
end