--[[ mucking around with ideas from:
http://lua.space/gamedev/handling-input-in-lua
to get them in my head]]

function love.load()
    drawColours = {0.5, 0.5, 0.5, 1}
    
    test=""

    -- bind to functions
    bindings = {
        showRed = red,
        showGreen = green,
        showBlue = blue,
        showGrey = reset,
    }

    -- keyboard bindings
    keys = {
        r = "showRed",
        g = "showGreen",
        b = "showBlue",
        n = "showBlue",
    }

    keysReleased = {
        r = "showGrey",
        g = "showGrey",
        b = "showGrey",
        n = "showGrey",
    }

    -- controller bindings
    buttons = {
        b = "showRed",
        a = "showGreen",
        x = "showBlue",
    }

    buttonsReleased = {
        b = "showGrey",
        a = "showGrey",
        x = "showGrey",
    }
end

function love.update(dt)

end

function love.draw()
    -- i assume there's a nicer way to pass an appropriate obj to a function...
    love.graphics.setColor(
        drawColours[1],
        drawColours[2],
        drawColours[3],
        drawColours[4])

        love.graphics.rectangle('fill', 10,10,780,285)

        
        love.graphics.print(test, 10, 400)
end

-- PROCESS INPUTS

function inputHandler(input)
    local action = bindings[input]
    if action then
        return action()
    end
end

function love.keypressed(k)
    local binding = keys[k]

    test = k
    if binding then
        test = binding
    end

    return inputHandler(binding)
end

function love.keyreleased(k)
    local binding = keysReleased[k]
    return inputHandler(binding)
end

function love.gamepadpressed(gamepad, button)
    local binding = buttons[button]
    return inputHandler(binding)
end

function love.gamepadreleased(gamepad, button)
    local binding = buttonsReleased[button]
    return inputHandler(binding)
end

-- TEST FUNCTIONS

function red()
    drawColours = {1, 0, 0, 1}
end

function green()
    drawColours = {0, 1, 0, 1}
end

function blue()
    drawColours = {0, 0, 1, 1}
end

function reset()
    drawColours = {0.5, 0.5, 0.5, 1}
end