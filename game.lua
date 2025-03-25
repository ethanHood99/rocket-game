-- Ethan Hood
-- 3/25/2025
-- Main game file that uses all other assets

Game = {}

CURRENCY_RATE = 0.02
ASTEROID_RATE = 0.005
ALIENS_RATE = 0.0005

function Game.load()
    -- Initialize game state
    Game.reset()

    -- Create a larger font for the altitude meter
    Game.font = love.graphics.newFont(20)
end

function Game.reset()
    Rocket.reset()
    Ground.reset()
    Camera.reset()
    Currency.reset()
    Asteroid.reset()
    Aliens.reset()
    Laser.reset()

    Game.gameOver = false
    Game.gameStarted = false
    Game.altitude = 0 
end

function Game.update(dt)
    if Game.gameOver then return end

    -- Start the game when space is first pressed
    if not Game.gameStarted and love.keyboard.isDown("space") then
        Game.gameStarted = true
    end

    if not Game.gameStarted then return end

    Rocket.update(dt)
    Camera.update(dt)
    Currency.update(dt)
    Asteroid.update(dt)
    Aliens.update(dt)
    Laser.update(dt)

    Game.altitude = math.max(Game.altitude, -Camera.y)

    Utils.spawn(Currency, CURRENCY_RATE)
    Utils.spawn(Asteroid, ASTEROID_RATE)
    Utils.spawn(Aliens, ALIENS_RATE)

    -- Game over if rocket falls below the fixed screen height (600)
    if Rocket.y > 600 + Camera.y then
        Game.gameOver = true
    end

    if Rocket.health <= 0 then
        Game.gameOver = true
    end
end

function Game.draw()
    Camera.apply()

    -- Draw background
    love.graphics.setColor(0.53, 0.81, 0.92)
    love.graphics.rectangle("fill", 0, Camera.y, 800, 600)

    Currency.draw()
    Ground.draw()
    Rocket.draw()
    Asteroid.draw()
    Aliens.draw()
    Laser.draw()

    -- Reset transformations to draw in screen space
    Camera.resetTransform()

    -- Draw altitude meter in the top middle of the screen
    local altitudeText = "Altitude: " .. math.floor(Game.altitude) .. "M"
    love.graphics.setFont(Game.font)
    local textWidth = love.graphics.getFont():getWidth(altitudeText)
    local screenWidth = love.graphics.getWidth()
    local margin = 20

    love.graphics.setColor(1,1,1)
    love.graphics.print(altitudeText, (screenWidth - textWidth) / 2, margin)

     -- Draw the counter in the top-right corner
     local screenWidth = love.graphics.getWidth()
     local text = tostring(Currency.counter)
     local textWidth = love.graphics.getFont():getWidth(text) -- Get the width of the text
     local margin = 10 -- Margin from the edge of the screen
 
     love.graphics.setColor(253,220,92) -- Set text color to white
     love.graphics.print(text, screenWidth - textWidth - margin, margin)
    

     --Draw the Rocket health in the top left hand corner of the screen
    text = "Rocket Health: " .. math.floor(Rocket.health)
    margin = 20

    love.graphics.setColor(253, 220, 92)
    love.graphics.print(text, margin, margin)
     -- Draw UI (e.g., "Press Space to Start" and "Game Over")
     UI.draw()
end

function Game.keypressed(key)
    if key == 'r' and Game.gameOver then
        Game.reset()
    end
end