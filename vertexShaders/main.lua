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
    local pixel = love.filesystem.read('pixel.glsl')

    vertex = love.filesystem.read('vertex.glsl')

    
    shader = love.graphics.newShader(pixel, vertex)
end

 
function love.draw()
    love.graphics.setShader(shader)

    -- draw things
    love.graphics.rectangle( "fill", 100, 100, 100, 100 )
    love.graphics.setShader()
    -- draw more things
    
    love.graphics.rectangle( "fill", 100, 100, 100, 100 )
end