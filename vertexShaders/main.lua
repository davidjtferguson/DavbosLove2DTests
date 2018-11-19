function love.load(args)
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