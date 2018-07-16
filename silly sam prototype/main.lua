function love.load()

    love.window.setMode(1000, 600, {fullscreen = false})
    love.graphics.setBackgroundColor(0.41, 0.53, 0.97)

    love.physics.setMeter(100)
    world = love.physics.newWorld(0, 10*100, true)
  
    world:setCallbacks(beginContact, endContact, preSolve, postSolve)

    solids = {}

    solids.ground = {}
    solids.ground.body = love.physics.newBody(world, 1000/2, 600-50/2)
    solids.ground.shape = love.physics.newRectangleShape(0, 0, 800, 50)
    solids.ground.fixture = love.physics.newFixture(solids.ground.body, solids.ground.shape);
    solids.ground.fixture:setFriction(0.9)

    solids.leftWall = {}
    solids.leftWall.body = love.physics.newBody(world, 1000/2, 600-500/2)
    solids.leftWall.shape = love.physics.newRectangleShape(-425, 0, 50, 500)
    solids.leftWall.fixture = love.physics.newFixture(solids.leftWall.body, solids.leftWall.shape);

    solids.rightWall = {}
    solids.rightWall.body = love.physics.newBody(world, 1000/2, 600-500/2)
    solids.rightWall.shape = love.physics.newRectangleShape(400, 0, 50, 500)
    solids.rightWall.fixture = love.physics.newFixture(solids.rightWall.body, solids.rightWall.shape);

    local spawn = {
        x=1000/2,
        y=600/2,
    }

    sam = {}

    -- chest
    sam.chest = {}
    sam.chest.body = love.physics.newBody(world, spawn.x, spawn.y, "dynamic")
    sam.chest.shape = love.physics.newRectangleShape(0, 0, 50, 50)
    sam.chest.fixture = love.physics.newFixture(sam.chest.body, sam.chest.shape);
    sam.chest.fixture:setFriction(0.5)

    sam.chest.onGround = false

    -- left leg
    sam.leftLeg = {}
    sam.leftLeg.body = love.physics.newBody(world, spawn.x-25, spawn.y+45, "dynamic")
    sam.leftLeg.shape = love.physics.newRectangleShape(0, 0, 20, 40)
    sam.leftLeg.fixture = love.physics.newFixture(sam.leftLeg.body, sam.leftLeg.shape, 3);
    sam.leftLeg.fixture:setFriction(0.5)

    -- join to chest
    sam.leftLeg.joint = love.physics.newWeldJoint(sam.chest.body, sam.leftLeg.body,
        spawn.x-20, spawn.y+25, true)

    sam.leftLeg.onGround = false
    
    -- right leg
    sam.rightLeg = {}
    sam.rightLeg.body = love.physics.newBody(world, spawn.x+25, spawn.y+45, "dynamic")
    sam.rightLeg.shape = love.physics.newRectangleShape(0, 0, 20, 40)
    sam.rightLeg.fixture = love.physics.newFixture(sam.rightLeg.body, sam.rightLeg.shape, 3);
    sam.rightLeg.fixture:setFriction(0.5)

    sam.rightLeg.joint = love.physics.newWeldJoint(sam.chest.body, sam.rightLeg.body,
        spawn.x+20, spawn.y+25, true)

    sam.rightLeg.onGround = false
    
    sam.parts = {
        sam.chest,
        sam.leftLeg,
        sam.rightLeg,
    }
end

function love.update(dt)
    world:update(dt)
end

function love.keypressed(key, scancode, isrepeat)
    if key == "f" and sam.leftLeg.onGround then
        -- need some rotation maths to send force up up leg, not straight up
        sam.rightLeg.body:applyForce(0, -5500)
    end

    if key == "j" and sam.rightLeg.onGround then
        -- need some rotation maths to send force up up leg, not straight up
        sam.leftLeg.body:applyForce(0, -5500)
    end
end

function beginContact(body1, body2, contact)
    -- check the contact created is actually touching
    if not contact:isTouching() then
        return
    end

    -- need to be a lot smarter here - suppose to check the arguments being passed in
    for i in pairs(sam.parts) do
        sam.parts[i].onGround = sam.parts[i].body:isTouching(solids.ground.body)
    end
end

function endContact(body1, body2, contact)
    for i in pairs(sam.parts) do
        sam.parts[i].onGround = sam.parts[i].body:isTouching(solids.ground.body)
    end
end

-- what are these??
function preSolve(body1, body2, contact)

end

function postSolve(body1, body2, contact)

end

function love.draw()
    love.graphics.setColor(0.28, 0.63, 0.05)

    for i in pairs(solids) do
        love.graphics.polygon("fill", solids[i].body:getWorldPoints(solids[i].shape:getPoints()))
    end

    love.graphics.setColor(0.20, 0.20, 0.20)

    for i in pairs(sam.parts) do
        love.graphics.polygon("fill", sam.parts[i].body:getWorldPoints(sam.parts[i].shape:getPoints()))
    end

    if sam.leftLeg.onGround then
        love.graphics.print("true", 0, 0)
    else
        love.graphics.print("false", 0, 0)
    end
end