function love.load()
    animation = newAnimation(love.graphics.newImage("oldHero.png"), 16, 18, 0.5)

    av={
        x=200, 
        y=200,
        xscale=4,
        yscale=4
    }
end

function newAnimation(image, width, height, duration)
    local animation = {}
    animation.spriteSheet = image;
    animation.quads = {};
    animation.spriteNum = 0;
 
    for y = 0, image:getHeight() - height, height do
        for x = 0, image:getWidth() - width, width do
            table.insert(animation.quads, love.graphics.newQuad(x, y, width, height, image:getDimensions()))
        end
    end
 
    -- 6 frame animation
    -- need height and width to offset origin when drawing to flip around centre
    animation.frameWidth=image:getWidth() / 6
    animation.frameHeight=image:getHeight()

    animation.duration = duration or 1
    animation.currentTime = 0
 
    return animation
end

function love.update(dt)
    -- 4 when static
    animation.spriteNum = 4

    -- loop when left or right

    if love.keyboard.isDown('a') or love.keyboard.isDown('d') then
        animation.currentTime = animation.currentTime + dt
        if animation.currentTime >= animation.duration then
            animation.currentTime = animation.currentTime - animation.duration
        end

        animation.spriteNum = math.floor(animation.currentTime / animation.duration * #animation.quads) + 1    
    end

    -- flip for left
    if love.keyboard.isDown('a') then
        av.xscale=-math.abs(av.xscale)
    elseif love.keyboard.isDown('d') then
        av.xscale=math.abs(av.xscale)
    end

    -- 5 for jump
    if love.keyboard.isDown('w') then
        animation.spriteNum=5
    end
end

function love.draw()
    love.graphics.draw(animation.spriteSheet, animation.quads[animation.spriteNum], av.x, av.y, 0, av.xscale, av.yscale, animation.frameWidth/2, animation.frameHeight/2)

    -- without origin offset
    love.graphics.draw(animation.spriteSheet, animation.quads[animation.spriteNum], av.x, av.y, 0, av.xscale, av.yscale)
end
