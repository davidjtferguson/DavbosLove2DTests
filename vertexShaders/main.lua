function love.load(args)
    love.window.setMode(1000, 600, {fullscreen = false})

    -- load the shader
    local pixel = love.filesystem.read('pixel.glsl')

    vertex = love.filesystem.read('vertex.glsl')

    shader = love.graphics.newShader(pixel, vertex)

    PI = 3.14
end

 
function love.draw()

    -- normalised from 0 to PI... how do I normalise from -PI to PI?
    --time = -PI * (love.timer.getTime() % 1)

    -- get values from 0 to 1 alternating per second
    theta = (love.timer.getTime() % 1)

    -- normalise from 0 to 1 to -PI to PI
    -- newvalue= (max'-min')/(max-min)*(value-max)+max'
    time = (PI+PI)/(1-0)*(theta-1)+PI

    print(time)

    shader:send("time", time)
    love.graphics.setShader(shader)

    -- draw things
    love.graphics.rectangle( "fill", 500, 400, 100, 100 )

    love.graphics.setShader()
    -- draw more things
    
    love.graphics.rectangle( "fill", 100, 400, 100, 100 )
end