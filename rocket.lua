-- Ethan Hood
-- 3/25/2025
-- File that handles the rocket object

Rocket = {}

function Rocket.reset()
    Rocket.x = 400
    Rocket.y = 550
    Rocket.size = 50
    Rocket.speed = 200
    Rocket.velocityY = 0
    Rocket.gravity = 500
    Rocket.jumpForce = -300
    Rocket.health = 100
end

function Rocket.update(dt)
    -- Apply gravity
    Rocket.velocityY = Rocket.velocityY + Rocket.gravity * dt

    -- Move upward while spacebar is held
    if love.keyboard.isDown("space") then
        Rocket.velocityY = Rocket.jumpForce
    end

    -- Move left and right
    if love.keyboard.isDown("left") then
        Rocket.x = Rocket.x - Rocket.speed * dt
    elseif love.keyboard.isDown("right") then
        Rocket.x = Rocket.x + Rocket.speed * dt
    end

    -- Keep rocket within screen bounds
    Rocket.x = math.max(0, math.min(800 - Rocket.size, Rocket.x))

    -- Update rocket position
    Rocket.y = Rocket.y + Rocket.velocityY * dt
end

function Rocket.jump()
    Rocket.velocityY = Rocket.jumpForce
end

function Rocket.draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("fill", Rocket.x, Rocket.y, Rocket.size, Rocket.size)
end