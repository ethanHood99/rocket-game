function love.load()
    love.window.setTitle("Rocket Game")
    love.window.setMode(800, 600)

    resetGame()
end

function resetGame()
    rocket = {
        x = 400,
        y = 550,
        size = 50,
        speed = 200,
        velocityY = 0,
        gravity = 500,
        jumpForce = -300
    }

    cameraY = 0
    gameOver = false
    gameStarted = false
    groundHeight = 100
end

function love.update(dt)
    if gameOver then return end -- Stop updating when game over

    -- Start the game when space is first pressed
    if not gameStarted and love.keyboard.isDown("space") then
        gameStarted = true
        rocket.velocityY = rocket.jumpForce
    end

    if not gameStarted then return end

    -- Apply Gravity
    rocket.velocityY = rocket.velocityY + rocket.gravity * dt

    -- Move up when holding spacebar
    if love.keyboard.isDown("space") then
        rocket.velocityY = rocket.jumpForce
    end

    -- Move left and right with boundaries
    if love.keyboard.isDown("left") then
        rocket.x = rocket.x - rocket.speed * dt
    elseif love.keyboard.isDown("right") then
        rocket.x = rocket.x + rocket.speed * dt
    end

    -- Keep rocket within screen bounds
    rocket.x = math.max(0, math.min(800 - rocket.size, rocket.x))

    -- Update rocket position
    rocket.y = rocket.y + rocket.velocityY * dt

    -- Adjust the camera so the screen follows the rocket upwards
    if rocket.y < 300 + cameraY then
        cameraY = rocket.y - 300
    end

    -- Game over if rocket falls below the screen
    if rocket.y > 600 + cameraY then
        gameOver = true
    end
end

function love.draw()
    if gameOver then
        -- Show Game Over Screen
        love.graphics.setColor(1, 0, 0)
        love.graphics.printf("Game Over! Press R to Restart", 0, 250, 800, "center")
        return
    end

    love.graphics.translate(0, -cameraY) -- Moves the screen up based on cameraY

    -- Background color transition from sky blue to space black
    -- Transition starts from the top of the screen and progresses downward
    local transitionStartY = 0 -- Start transition at the top of the screen
    local transitionEndY = 3000 -- End transition after 3000 pixels
    local transitionFactor = math.min((-cameraY - transitionStartY) / transitionEndY, 1)
    transitionFactor = math.max(0, transitionFactor)

    -- Interpolate from sky blue to black
    local r = (135/255) * (1 - transitionFactor)
    local g = (206/255) * (1 - transitionFactor)
    local b = (235/255) * (1 - transitionFactor)

    -- Draw the background with the interpolated color
    love.graphics.setColor(r, g, b)
    love.graphics.rectangle("fill", 0, cameraY, 800, 600)

    -- Draw ground with gradual transition 
      -- Draw ground with gradual transition 
    local groundTransitionFactor = math.min((-cameraY) / 1000, 1) -- Transition over 1000 pixels
    groundTransitionFactor = math.max(0, groundTransitionFactor)
    local groundAlpha = 1 - groundTransitionFactor -- Fade out the ground as the rocket rises

    love.graphics.setColor(0.1, 0.3, 0.1, groundAlpha) 
    love.graphics.rectangle("fill", 0, 600, 800, groundHeight) 
    
    -- Draw rocket
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("fill", rocket.x, rocket.y, rocket.size, rocket.size)

    -- Display "Press Space to Start" before the game begins
    if not gameStarted then
        love.graphics.setColor(1, 1, 1)
        love.graphics.printf("Press Space to Start", 0, 250, 800, "center")
    end
end

function love.keypressed(key)
    if key == 'r' and gameOver then
        resetGame()
    elseif key == 'space' and not gameStarted then
        gameStarted = true
        rocket.velocityY = rocket.jumpForce
    end
end