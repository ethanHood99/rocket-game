-- Ethan Hood
-- 3/25/2025
-- General Utilities to use throughout codebase

Utils = {}

function Utils.checkCollision(obj)
    -- Checks for collision with the rocket
    -- obj: The object in question that might collide with rocket
    -- return value: Whether or not the rocket has collided
    return not obj.hit and
           Rocket.x < obj.x + obj.width and
           Rocket.x + Rocket.size > obj.x and
           Rocket.y < obj.y + obj.height and
           Rocket.y + Rocket.size > obj.y
end

function Utils.remove(lilObj, bigObj)
    -- Checks for and object to go off screen, Garbage collection
    -- obj: The object in question that needs removal
    -- return value: Nil, it just removes the object from the table
    if lilObj.y > 600 then
        table.remove(bigObj.objects, i)
    end
end

function Utils.spawn(obj, rate)
    -- Spawns obj at a certain rate, note: obj must be spawnable
    -- obj: the spawnable object
    -- the rate at which the object will spawn
    if math.random() < rate then
        obj.spawn()
    end
end

return Utils