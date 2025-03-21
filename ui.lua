UI = {}

function UI.reset()
    
end

function UI.update(dt)
    
end

function UI.draw()
    if not Game.gameStarted then
        love.graphics.setColor(1, 1, 1)
        love.graphics.printf("Press Space to Start", 0, 250, 800, "center")
    end

    if Game.gameOver then
        -- Reset the camera transformation to draw in screen space
        Camera.resetTransform()
        
        love.graphics.setColor(1, 0, 0)
        love.graphics.printf("Game Over! Press R to Restart", 0, 250, 800, "center")
    end
end