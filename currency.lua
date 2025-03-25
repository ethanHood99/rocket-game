-- Ethan Hood
-- 3/25/2025
-- Currency file that makes the currency system work

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
        width = 20,
        height = 20,
        hit = false -- Track if the currency has been hit
    }
    table.insert(Currency.objects, currency) -- Add the new currency object to the tableend
end

function Currency.update(dt)
    for i = #Currency.objects, 1, -1 do
        local currency = Currency.objects[i]

        -- Check for collision with the rocket
        if Utils.checkCollision(currency) then
            -- Mark the currency as collected and increment the counter
            currency.hit = true
            Currency.counter = Currency.counter + 1
        end

        -- Remove collected currency objects from the table
        if currency.hit then
            table.remove(Currency.objects, i)
        end

        -- Remove currency that went off screen
        Utils.remove(currency, Currency)
    end
end

function Currency.draw()
    -- Draw all currency objects
    for _, currency in ipairs(Currency.objects) do
        if not currency.collected then
            love.graphics.setColor(178,122,1) -- Gold color
            love.graphics.rectangle("fill", currency.x, currency.y, currency.width, currency.height)
        end
    end
end