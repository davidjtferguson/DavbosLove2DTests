local function myStencilFunction()
    -- Draw four overlapping circles as a stencil.
    love.graphics.circle("fill", 200, 250, 100)
    love.graphics.circle("fill", 300, 250, 100)
    love.graphics.circle("fill", 250, 200, 100)
    love.graphics.circle("fill", 250, 300, 100)
	
    image = love.graphics.newImage('point.png')
 end
 
 function love.load(args)
    canvas = love.graphics.newCanvas()
 end
 
 function love.draw()
    
	-- testing out canvas with stencil
    love.graphics.setCanvas( {canvas, stencil=true} )
		love.graphics.setColor( 1, 1, 1, 1 )

		love.graphics.clear(0.2, 0.2, 0.5, 1)
	 
		-- Each pixel touched by each circle will have its stencil value incremented by 1.
		-- The stencil values for pixels where the circles overlap will be at least 2.
		love.graphics.stencil(myStencilFunction, "increment")
	  
		-- Only allow drawing in areas which have stencil values that are less than 2.
		love.graphics.setStencilTest("equal", 2)
	  
		-- Draw a big rectangle.
		love.graphics.rectangle("fill", 0, 0, 500, 500)
	  
		love.graphics.setStencilTest("equal", 3)

		love.graphics.setColor( 0.9, 0.1, 0.1, 0.8 )
		
		love.graphics.rectangle("fill", 0, 0, 500, 500)
		
		love.graphics.setStencilTest("equal", 4)

		love.graphics.setColor( 0.1, 0.9, 0.1, 0.8 )
		
		love.graphics.rectangle("fill", 0, 0, 500, 500)
		
		love.graphics.setStencilTest()

		love.graphics.setColor( 1, 1, 1, 1 )
	love.graphics.setCanvas()
	
	
	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.draw(canvas)

	-- draw something not stenciled (and also check out the shear function
    love.graphics.translate(500, 100)

    local t = love.timer.getTime()
    love.graphics.shear(math.cos(t), math.cos(t * 1.3))
    --love.graphics.rectangle('fill', 0, 0, 100, 50)
    love.graphics.draw(image,0,0)
 end