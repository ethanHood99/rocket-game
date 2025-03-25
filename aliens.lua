-- Ethan Hood
-- 3/25/2025
-- file that controls the alien 

Aliens = {}

function Aliens.reset()
    Aliens.objects = {}
    Aliens.spawnTimer = 0
    Aliens.spawnInterval = 3
end

function Aliens.spawn()
    -- Spawn a new alien object at a random positon above the current camera
    local aliens = {
        x = math.random(0, 800 - 50),
        y = Camera.y - math.random(100, 300),
        width = 50,
        height = 30,
        speed = math.random(50, 150),
        direction = 1,
        shootTimer = 0,
        shootInterval = math.random(1, 3),
        hit = false
    }
    table.insert(Aliens.objects, aliens)
end

function Aliens.update(dt) 
    -- Update existing aliens
    for i, alien in ipairs(Aliens.objects) do
        -- Side to side movement
        alien.x = alien.x + alien.speed * alien.direction * dt

        if Utils.checkCollision(alien) then
                alien.hit = true
                Rocket.health = Rocket.health - 100
                table.remove(Aliens.objects, i)
            end

        -- Reverse direction at screen edges
        if alien.x <= 0 or alien.x >= 800 - alien.width then
            alien.direction = alien.direction * -1
        end

        -- Shoot lasers downward
        alien.shootTimer = alien.shootTimer + dt
        if alien.shootTimer >= alien.shootInterval then
            Laser.spawn(alien.x + alien.width / 2, alien.y + alien.height)
            alien.shootTimer = 0
        end

        -- Remove aliens that go off-screen (optional)
        Utils.remove(alien, Aliens)
    end
end

function Aliens.draw()
    for _, alien in ipairs(Aliens.objects) do
        love.graphics.setColor(0, 1, 0)
        love.graphics.rectangle("fill", alien.x, alien.y, alien.width, alien.height)
    end
end