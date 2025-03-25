-- Ethan Hood
-- 3/25/2025
-- The ground file

Ground = {}

function Ground.reset()
    Ground.height = 100
    Ground.alpha = 1
end

function Ground.update(dt)
    Ground.alpha = math.max(0, 1 - (-Camera.y) / 1000)
end

function Ground.draw()
    love.graphics.setColor(0.1, 0.3, 0.1, Ground.alpha)
    love.graphics.rectangle("fill", 0, 600 - Ground.height, 800, Ground.height)
end