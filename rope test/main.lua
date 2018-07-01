function love.load()

    love.window.setMode(1000, 600, {fullscreen = false})
    love.graphics.setBackgroundColor(0.41, 0.53, 0.97)

    love.physics.setMeter(100)
    world = love.physics.newWorld(0, 10*100, true)
  
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

    players = {}

    players.p1 = {}
    players.p1.body = love.physics.newBody(world, 1000/2-50, 600/2, "dynamic")
    players.p1.shape = love.physics.newRectangleShape(0, 0, 25, 25)
    players.p1.fixture = love.physics.newFixture(players.p1.body, players.p1.shape, 2);
    players.p1.fixture:setFriction(0.5)
    players.p1.onGround = false

    players.p2 = {}
    players.p2.body = love.physics.newBody(world, 1000/2+50, 600/2, "dynamic")
    players.p2.shape = love.physics.newRectangleShape(0, 0, 25, 25)
    players.p2.fixture = love.physics.newFixture(players.p2.body, players.p2.shape, 2);
    players.p2.fixture:setFriction(0.5)
    players.p2.onGround = false

    playersTouching = false

    -- useless. would need a chain of bodies and revolute joints to make a 'rope'
    -- rope = love.physics.newRopeJoint(players.p1.body, players.p2.body, 25/8, 25/8, 25/8, 25/8, 10, true)

    world:setCallbacks(beginContact, endContact, preSolve, postSolve)
end

function love.update(dt)
    world:update(dt)

    -- react to collisions with physics changes
    if playersTouching and (weldJoint == nil or weldJoint:isDestroyed()) then
    --if playersTouching and weldJoint == nil then
        weldJoint = love.physics.newWeldJoint(players.p1.body, players.p2.body,
            players.p1.body:getX(), players.p1.body:getY(), true)
    end

    if not playersTouching and weldJoint and not weldJoint:isDestroyed() then
        weldJoint:destroy()
    end

    --[[ had them unable to connect on the ground at first because I thought colliding and landing would be odd
    otherwise but more consistent design and more fun launching opportunities when connect on the ground
    if not players.p1.onGround and not players.p2.onGround
       and not weldJoint == nil and not weldJoint:isDestroyed() then
        --weldJoint:destroy()
    end
    ]]

    if love.keyboard.isDown("right") then
        x, y = players.p1.body:getLinearVelocity()

        if math.abs(x) < 300 then
            players.p1.body:applyForce(200, 0)
        end
    end
    if love.keyboard.isDown("left") then
        x, y = players.p1.body:getLinearVelocity()

        if math.abs(x) < 300 then
            players.p1.body:applyForce(-200, 0)
        end
    end

    if love.keyboard.isDown('d') then
        x, y = players.p2.body:getLinearVelocity()

        if math.abs(x) < 300 then
            players.p2.body:applyForce(200, 0)
        end
    end
    if love.keyboard.isDown('a') then
        x, y = players.p2.body:getLinearVelocity()

        if math.abs(x) < 300 then
            players.p2.body:applyForce(-200, 0)
        end
    end
end

function love.keypressed(key, scancode, isrepeat)
    if key == "up" then
        if weldJoint and not weldJoint:isDestroyed() then
            weldJoint:destroy()

            local x = players.p1.body:getX() - players.p2.body:getX()
            local y = players.p1.body:getY() - players.p2.body:getY()
            
            x=x*200
            y=y*200
    
            players.p1.body:applyForce(x, y)
            players.p2.body:applyForce(-x, -y)

            playersTouching = false
        end
        
        if players.p1.onGround then
            players.p1.body:applyForce(0, -2500)
        end
    end

    if key == 'w' then
        if weldJoint and not weldJoint:isDestroyed() then
            
            weldJoint:destroy()

            local x = players.p1.body:getX() - players.p2.body:getX()
            local y = players.p1.body:getY() - players.p2.body:getY()
            
            x=x*200
            y=y*200
    
            players.p1.body:applyForce(x, y)
            players.p2.body:applyForce(-x, -y)

            playersTouching = false
        end
    
        if players.p2.onGround then
            players.p2.body:applyForce(0, -2500)
        end
    end
end

function beginContact(body1, body2, contact)
    for i in pairs(players) do
        players[i].onGround = players[i].body:isTouching(solids.ground.body)
    end

    playersTouching = players.p1.body:isTouching(players.p2.body)
end

function endContact(body1, body2, contact)
    for i in pairs(players) do
        players[i].onGround = players[i].body:isTouching(solids.ground.body)
    end

    playersTouching = players.p1.body:isTouching(players.p2.body)
end

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

    for i in pairs(players) do
        love.graphics.polygon("fill", players[i].body:getWorldPoints(players[i].shape:getPoints()))
    end

    love.graphics.setColor(1.0, 1.0, 1.0, 1.0)

    if weldJoint then
        if weldJoint:isDestroyed() then
            love.graphics.print("true", 0, 0)
        else
            love.graphics.print("false", 0, 0)
        end
    end
end