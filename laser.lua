Laser = {}

function Laser.reset()
    Laser.objects = {} -- Store all lasers
end

function Laser.spawn(x, y)
    local laser = {
        x = x,
        y = y,
        width = 5,
        height = 20,
        speed = 200,
        hit = false -- Initialize as false to allow collision checks
    }
    table.insert(Laser.objects, laser)
end

function Laser.update(dt)
    for i = #Laser.objects, 1, -1 do -- Iterate backward for safe removal
        local laser = Laser.objects[i]
        
        -- Move lasers downward
        laser.y = laser.y + laser.speed * dt

        -- Check for collision with rocket
        if not laser.hit and
           Rocket.x < laser.x + laser.width and
           Rocket.x + Rocket.size > laser.x and
           Rocket.y < laser.y + laser.height and
           Rocket.y + Rocket.size > laser.y then
            laser.hit = true
            Rocket.health = Rocket.health - 10 -- Deduct health once
            table.remove(Laser.objects, i) -- Remove immediately after hit
        end

        -- Remove lasers that go off-screen
        if laser.y > 600 then
            table.remove(Laser.objects, i)
        end
    end
end

function Laser.draw()
    for _, laser in ipairs(Laser.objects) do
        love.graphics.setColor(1, 0, 0) -- Red lasers
        love.graphics.rectangle("fill", laser.x, laser.y, laser.width, laser.height)
    end
end