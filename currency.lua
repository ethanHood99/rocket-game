Currency = {}

function Currency.reset()
    Currency.counter = 0 -- Total collected currency
    Currency.objects = {} -- Table to store individual currency objects
end

function Currency.spawn()
    -- Spawn a new currency object at a random position above the current camera view
    local currency = {
        x = math.random(0, 800), -- Random x position within the screen width
        y = Camera.y - math.random(100, 300), -- Random y position above the current camera view
        size = 20,
        collected = false -- Track if the currency has been collected
    }
    table.insert(Currency.objects, currency) -- Add the new currency object to the tableend
end

function Currency.update(dt)
    for i = #Currency.objects, 1, -1 do
        local currency = Currency.objects[i]

        -- Check for collision with the rocket
        if not currency.collected and
           Rocket.x < currency.x + currency.size and
           Rocket.x + Rocket.size > currency.x and
           Rocket.y < currency.y + currency.size and
           Rocket.y + Rocket.size > currency.y then
            -- Mark the currency as collected and increment the counter
            currency.collected = true
            Currency.counter = Currency.counter + 1
        end

        -- Remove collected currency objects from the table
        if currency.collected then
            table.remove(Currency.objects, i)
        end
    end
end

function Currency.draw()
    -- Draw all currency objects
    for _, currency in ipairs(Currency.objects) do
        if not currency.collected then
            love.graphics.setColor(178,122,1) -- Gold color
            love.graphics.rectangle("fill", currency.x, currency.y, currency.size, currency.size)
        end
    end
end