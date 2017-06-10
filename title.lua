-----------------------------------------------------------------------------------------
--
-- title.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local widget = require( "widget" )

local scene = composer.newScene()

--------------------------------------------
-- Key Listener
-- Called when a key event has been received
local function onKeyEvent( event )
    -- If the "back" key was pressed on Android or Windows Phone, prevent it from backing out of the app
    -- add second event potential for testing on simulator due to simulator lacking back button functionality
    if ( event.keyName == "back" or ("b" == event.keyName and event.phase == "down" and system.getInfo("environment") == "simulator")) then
        local platformName = system.getInfo( "platformName" )
        if ( platformName == "Android" ) or ( platformName == "WinPhone" ) or (system.getInfo("environment") == "simulator") then
        	-- do nothing
            return true
        end
    end
 
    -- IMPORTANT! Return false to indicate that this app is NOT overriding the received key
    -- This lets the operating system execute its default handling of the key
    return false
end

-- forward declaration
local background

-- Touch listener function for background object
local function onBackgroundTouch( self, event )
	if event.phase == "ended" or event.phase == "cancelled" then
		-- go to page1.lua scene
		composer.gotoScene( "page_view", "slideLeft", 300 )
		
		return true	-- indicates successful touch
	end
end

-- Function to handle button events
local function settingsButton( event )
 
    if ( "ended" == event.phase ) then
        composer.gotoScene( "settings", "slideDown", 200 )
    end
end


function scene:create( event )
	local sceneGroup = self.view

	-- display a background image
	background = display.newImageRect( sceneGroup, "images/background.png", display.contentWidth, display.contentHeight )
	background.anchorX = 0
	background.anchorY = 0
	background.x, background.y = 0, 0

	--settings buttons
	local settings_button = widget.newButton(
	    {
	        width = 50,
	        height = 50,
	        defaultFile = "images/settings.png",
	        overFile = "images/settings.png",
	        onEvent = settingsButton
	    }
	)
	 
	-- set button to bottom right
	settings_button.x = display.contentWidth - 30
	settings_button.y = display.contentHeight - 30
	
	-- Add the key event listener
	Runtime:addEventListener( "key", onKeyEvent )
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		-- Called when the scene is now on screen
		-- 
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.
		
		background.touch = onBackgroundTouch
		background:addEventListener( "touch", background )
	end
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)

		-- remove event listener from background
		background:removeEventListener( "touch", background )
		
	elseif phase == "did" then
		-- Called when the scene is now off screen
	end	
end

function scene:destroy( event )
	local sceneGroup = self.view
	
	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene