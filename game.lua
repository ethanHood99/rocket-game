Game = {}

function Game.load()
    -- Initialize game state
    Game.reset()
end

function Game.reset()
    Rocket.reset()
    Ground.reset()
    Camera.reset()

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

    Ground.draw()
    Rocket.draw()
    UI.draw()

    Camera.resetTransform()
end

function Game.keypressed(key)
    if key == 'r' and Game.gameOver then
        Game.reset()
    end
end