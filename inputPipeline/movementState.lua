
movementState = {
    bindings = {
        -- button pressed/released require no dt
        toColours = function() state = gameStates.colourState end,

        -- button down requires dt
        moveUp = function() wordsPos.y=wordsPos.y-5 end,
        moveDown = function() wordsPos.y=wordsPos.y+5 end,
        moveLeft = function() wordsPos.x=wordsPos.x-5 end,
        moveRight = function() wordsPos.x=wordsPos.x+5 end,
    },
    keys = {},
    keysDown = {
        w = "moveUp",
        s = "moveDown",
        a = "moveLeft",
        d = "moveRight",
    },
    keysReleased = {
        c = "toColours",
    },
    buttons = {},
    buttonsDown = {
        y = "moveUp",
        a = "moveDown",
        x = "moveLeft",
        b = "moveRight",
    },
    buttonsReleased = {
        back = "toColours",
    },
    draw = function()
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.print(test, wordsPos.x, wordsPos.y)
    end
}

return movementState
