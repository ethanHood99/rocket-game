function love.load()
    love.window.setTitle("Rocket Game")
    love.window.setMode(800, 600)

    -- Load modules
    require("game")
    require("rocket")
    require("ground")
    require("camera")
    require("ui")
    require("currency")

    Game.load()
end

function love.update(dt)
    Game.update(dt)
end

function love.draw()
    Game.draw()
end

function love.keypressed(key)
    Game.keypressed(key)
end