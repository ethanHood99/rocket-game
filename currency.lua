Currency = {
    frames = {},          -- Stores all animation frame images
    animationSpeed = 0.03, -- Seconds per frame
    loadedFrames = 0      -- Track how many frames we've loaded
}

function Currency.reset()
    Currency.counter = 0
    Currency.objects = {}
end

function Currency.load()
    -- Load frames in a staggered way to prevent freezing
    Currency.loadNextFrame()
end

function Currency.loadNextFrame()
    -- Load frames one by one to prevent stuttering
    if Currency.loadedFrames < 499 then
        Currency.loadedFrames = Currency.loadedFrames + 1
        local framePath = string.format("C:\\Users\\ethan\\Development\\Love2d-tests\\rocket-game\\Assets\\TBG 2D Game commission folder\\Assets\\CoinFrames\\1_%04d.png", Currency.loadedFrames)
        
        -- Use a placeholder if frame doesn't exist
        local success, image = pcall(love.graphics.newImage, framePath)
        if success then
            table.insert(Currency.frames, image)
        else
            -- Create a colored placeholder if frame is missing
            local placeholder = love.graphics.newCanvas(32, 32)
            love.graphics.setCanvas(placeholder)
            love.graphics.clear({178/255, 122/255, 1/255})
            love.graphics.setCanvas()
            table.insert(Currency.frames, placeholder)
        end
        
        -- Schedule next frame load
        if Currency.loadedFrames < 499 then
            love.timer.sleep(0.001) -- Tiny delay to prevent freezing
            Currency.loadNextFrame()
        end
    end
end

function Currency.spawn()
    local currency = {
        x = math.random(0, 800),
        y = Camera.y - math.random(100, 300),
        width = 32,
        height = 32,
        hit = false,
        currentFrame = math.random(1, #Currency.frames > 0 and #Currency.frames or 1),
        animationTimer = 0,
        scale = 0.8 + math.random() * 0.4,
    }
    table.insert(Currency.objects, currency)
end

function Currency.update(dt)
    -- Don't animate if frames aren't loaded yet
    if #Currency.frames == 0 then return end
    
    for i = #Currency.objects, 1, -1 do
        local currency = Currency.objects[i]
        
        -- Update animation only if we have frames
        currency.animationTimer = currency.animationTimer + dt
        if currency.animationTimer >= Currency.animationSpeed then
            currency.animationTimer = 0
            currency.currentFrame = (currency.currentFrame % #Currency.frames) + 1
        end

        -- Existing collision logic
        if Utils.checkCollision(currency) then
            currency.hit = true
            Currency.counter = Currency.counter + 1
        end

        if currency.hit then
            table.remove(Currency.objects, i)
        end

        Utils.remove(currency, Currency)
    end
end

function Currency.draw()
    for _, currency in ipairs(Currency.objects) do
        if not currency.hit and #Currency.frames > 0 then
            --love.graphics.setColor(1, 1, 1)
            love.graphics.draw(
                Currency.frames[currency.currentFrame],
                currency.x + currency.width/2, 
                currency.y + currency.height/2,
                currency.rotation,
                currency.scale,
                currency.scale,
                currency.width/2,
                currency.height/2
            )
        end
    end
end