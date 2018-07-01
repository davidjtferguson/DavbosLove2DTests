-- Include Simple Tiled Implementation into project
local sti = require "sti/sti"

function love.load()
    -- Load map file
    map = sti("testMap2.lua")

    
    -- Create new dynamic data layer called "Sprites" as the 8th layer
    local layer = map:addCustomLayer("Sprites", 8)

    -- Get enemy spawn object
    enemy={}
    for k, object in pairs(map.objects) do
        if object.name == "enemy" then
            enemy = object
            break
        end
    end

    -- Create enemy object
    sprite = love.graphics.newImage("graphics/enemy.png")

    --layer.enemy = {
    drawableEnemy = {
        sprite = sprite,
        x      = enemy.x,
        y      = enemy.y,
        ox     = sprite:getWidth() / 2,
        oy     = sprite:getHeight() / 2
    }
    
    -- Draw enemy in layer (supposedly, not appearing for me)
    layer.draw = function(self)
        -- love.graphics.draw(
        --     self.enemy.sprite,
        --     math.floor(self.enemy.x),
        --     math.floor(self.enemy.y),
        --     0,
        --     1,
        --     1,
        --     self.enemy.ox,
        --     self.enemy.oy
        -- )

        -- Temporarily draw a point at our location so we know
        -- that our sprite is offset properly
        love.graphics.setPointSize(5)
        love.graphics.points(math.floor(self.enemy.x), math.floor(self.enemy.y))
    end

    -- Remove unneeded object layer
    --map:removeLayer("Spawn Point")
end

function love.update(dt)
    -- Update world
    map:update(dt)
end

function love.draw()
    love.graphics.setColor( 1.0, 1.0, 1.0, 1.0 )

    -- Draw world
    map:draw()
    
    -- tutorial said do this in the layer but I'm a scrub
    love.graphics.draw(
        drawableEnemy.sprite,
        math.floor(drawableEnemy.x),
        math.floor(drawableEnemy.y),
        0,
        1,
        1,
        drawableEnemy.ox,
        drawableEnemy.oy
    )

    love.graphics.setColor( 0.2, 0.9, 0.3, 0.8 )
    love.graphics.print(enemy.x..".."..enemy.y, 50, 50)
end