function love.load(args)
    image = love.graphics.newImage('point.png')
    shrekImage = love.graphics.newImage('shrek.jpeg')

    fadeTimer = 0
    fadeEffect = love.graphics.newShader [[
        extern number time;
        vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 pixel_coords)
        {
            return vec4((1.0+sin(time))/2.0, abs(cos(time)), abs(sin(time)), 1.0);
        }
    ]]
    
    love.window.setMode(1000, 600, {fullscreen = false})

    -- load the shader
    local source = love.filesystem.read('practiceBlur.glsl')
    blurEffect = love.graphics.newShader(source)

    source = love.filesystem.read('radialBlur.glsl')
    radialBlurEffect = love.graphics.newShader(source)
    -- print(radialBlurEffect:getWarnings())

    quad = love.graphics.newQuad(150,200,600,600,shrekImage:getWidth(),shrekImage:getHeight())

    canvas = love.graphics.newCanvas(500,500)
end

function love.update(dt)
    fadeTimer = fadeTimer + dt
    fadeEffect:send("time", fadeTimer)
    
    blurEffect:send("blurRadius", 3*math.pow(math.sin(love.timer.getTime()), 2))
    --blurEffect:send("blurRadius", 3)

    --draw two effects to the canvas
    canvas:renderTo(function()
        
        love.graphics.setShader(radialBlurEffect)
        love.graphics.draw(image,0,0)
    end)

end

function love.draw()
    -- boring white
    love.graphics.setShader()
    love.graphics.rectangle('fill', 10,10,780,285)
 
    -- LOOK AT THE PRETTY COLORS!
    love.graphics.setShader(fadeEffect)
    love.graphics.rectangle('fill', 10,305,780,285)

    love.graphics.setShader(radialBlurEffect)
    love.graphics.draw(image,5,5)

    --love.graphics.setShader(blurEffect)
    love.graphics.draw(shrekImage, 500,10,0,0.5,0.25)

    --love.graphics.setShader()
    --love.graphics.draw(shrekImage, quad, 500, 10)
    love.graphics.setShader(blurEffect)
    love.graphics.draw(canvas, 5, 330);
end
