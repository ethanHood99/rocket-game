Asteroid = {}

function Asteroid.reset()
    Asteroid.objects = {} -- Table to store individual asteroid objects
end

function Asteroid.spawn()
    -- Spawn a new asteroid object at a random position above the current camera position
    local asteroids = {
        x = math.random(0, 800),
        y = Camera.y - math.random(100, 300),
        size = 20,
        hit = false
    }
    table.insert(Asteroid.objects, asteroids)
end

function Asteroid.update(dt)
    for i = #Asteroid.objects, 1, -1 do
        local asteroid = Asteroid.objects[i]

        -- Check for collision with rocket
        if not asteroid.hit and
            Rocket.x < asteroid.x + asteroid.size and
            Rocket.x + Rocket.size > asteroid.x and
            Rocket.y < asteroid.y + asteroid.size and
            Rocket.y + Rocket.size > asteroid.y then
                asteroid.hit = true
            end

        -- Remove hit asteroid objects from the table
        if asteroid.hit then
            Rocket.health = Rocket.health - 10
            table.remove(Asteroid.objects, i)
        end
    end
end

function Asteroid.draw()
    -- Draw all asteroid objects
    for _, asteroid in ipairs(Asteroid.objects) do 
        if not asteroid.hit then
            love.graphics.setColor(0, 0, 0)
            love.graphics.rectangle("fill", asteroid.x, asteroid.y, asteroid.size, asteroid.size)
        end
    end
end