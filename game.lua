Game = {}

function Game.load()
    -- Initialize game state
    Game.reset()
end

function Game.reset()
    Rocket.reset()
    Ground.reset()
    Camera.reset()
    Currency.reset()

    Game.gameOver = false
    Game.gameStarted = false
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

    if math.random() < 0.02 then -- 10% chance to spawn a new currency object each frame
        Currency.spawn()
    end
    -- Game over if rocket falls below the fixed screen height (600)
    if Rocket.y > 600 + Camera.y then
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

    -- Reset transformations to draw in screen space
    Camera.resetTransform()

     -- Draw the counter in the top-right corner
     local screenWidth = love.graphics.getWidth()
     local text = tostring(Currency.counter)
     local textWidth = love.graphics.getFont():getWidth(text) -- Get the width of the text
     local margin = 10 -- Margin from the edge of the screen
 
     love.graphics.setColor(253,220,92) -- Set text color to white
     love.graphics.print(text, screenWidth - textWidth - margin, margin)
 
     -- Draw UI (e.g., "Press Space to Start" and "Game Over")
     UI.draw()
end

function Game.keypressed(key)
    if key == 'r' and Game.gameOver then
        Game.reset()
    end
end