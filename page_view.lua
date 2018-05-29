-----------------------------------------------------------------------------------------
--
-- page1.lua
--
-----------------------------------------------------------------------------------------

local PageClass = require( "page_class" )
local save_file = require( "save_file" )
local composer = require( "composer" )
local mui = require( "materialui.mui" )
local muiData = require( "materialui.mui-data" )

local scene = composer.newScene()

-- forward declarations and other locals
local background, current_page
-- in order to remove in page_transition create a a local old_page
local old_page = nil
--settings values
local scrollType = "right"
local textView = false

local screen_width = display.contentWidth
local screen_height = display.contentHeight
local next_screen_time = 200
local touch_enable = true

-- PageClass init
local num_hymns = 438
local hymn_table = nil
local current_hymn = 1

-- helpful functions

function page_transition_listener ( obj )
	touch_enable = true
	if old_page ~= nil then scene.view:remove( old_page ) end
	old_page = nil
end

function display_page(URL, move_direction)
	if touch_enable then
		touch_enable = false
		old_page = current_page

		current_page = display.newImageRect( scene.view, URL, display.contentWidth, display.contentHeight - mui.getScaleVal(70)/2 - 40 )	
		
		if scrollType == "right" then
			--start animation on old page
			if old_page ~= nil then
				if move_direction == "right" then
					old_page.anchorX = 0
					old_page.x, old_page.y = 0, 40
				elseif move_direction == "left" then
					old_page.anchorX = 0
					old_page.x, old_page.y = 0, 40
				else
					old_page.anchorX = 0
					old_page.x, current_page.y = 0, 40
				end
				if move_direction == "left" then
					transition.moveTo( old_page, { x = -screen_width, time=next_screen_time })
				elseif move_direction == "right" then
					transition.moveTo( old_page, { x = screen_width, time=next_screen_time })
				end
			end

			-- start animation on next page
			if current_page == nil then
				if URL == nil then
					native.showAlert( "Page not found", "Cant find URL requested. URL nil. Current hymn " .. current_hymn)
				else 
					native.showAlert( "Page not found", "Cant find URL requested." .. URL) 
				end
			else
				current_page.anchorY = 0
				if move_direction == "right" then
					current_page.anchorX = 1.0
					current_page.x, current_page.y = 0, 40
				elseif move_direction == "left" then
					current_page.anchorX = 0
					current_page.x, current_page.y = screen_width, 40
				else
					current_page.anchorX = 0
					current_page.x, current_page.y = 0, 40
					touch_enable = true
				end
			end
			if move_direction == "left" then
				transition.moveTo( current_page, { x = 0, time=next_screen_time, onComplete=page_transition_listener} )
			elseif move_direction == "right" then
				transition.moveTo( current_page, { x = screen_width, time=next_screen_time, onComplete=page_transition_listener} )
			end
		else
			--start animation on old page
			if old_page ~= nil then
				old_page.anchorX = 0
				if move_direction == "down" then
					old_page.anchorY = 0
					old_page.x, old_page.y = 0, 40
				elseif move_direction == "up" then
					old_page.anchorY = 0
					old_page.x, old_page.y = 0, 40
				else
					old_page.anchorY = 0
					old_page.x, current_page.y = 0, 40
				end
				if move_direction == "up" then
					transition.moveTo( old_page, { y = -screen_height, time=next_screen_time })
				elseif move_direction == "down" then
					transition.moveTo( old_page, { y = screen_height, time=next_screen_time })
				end
			end

			-- start animation on next page
			if current_page == nil then
				if URL == nil then
					native.showAlert( "Page not found", "Cant find URL requested. URL nil. Current hymn " .. current_hymn)
				else 
					native.showAlert( "Page not found", "Cant find URL requested." .. URL) 
				end
			else
				current_page.anchorX = 0
				current_page.anchorY = 0
				if move_direction == "up" then
					current_page.anchorY = 0
					current_page.x, current_page.y = 0, screen_height
				elseif move_direction == "down" then
					current_page.anchorY = 0
					current_page.x, current_page.y = 0, -screen_height
				else
					current_page.anchorY = 0
					current_page.x, current_page.y = 0, 40
					touch_enable = true
				end
			end
			if move_direction == "up" then
				transition.moveTo( current_page, { y = 40, time=next_screen_time, onComplete=page_transition_listener} )
			elseif move_direction == "down" then
				transition.moveTo( current_page, { y = 40, time=next_screen_time, onComplete=page_transition_listener} )
			end
		end
	end
end

-- Key Listener
-- Called when a key event has been received
local function onKeyEvent( event )
    -- If the "back" key was pressed on Android or Windows Phone, prevent it from backing out of the app
    -- add second event potential for testing on simulator due to simulator lacking back button functionality
    if ( event.keyName == "back" or ("b" == event.keyName and event.phase == "down" and system.getInfo("environment") == "simulator")) then
        local platformName = system.getInfo( "platformName" )
        if ( platformName == "Android" ) or ( platformName == "WinPhone" ) or (system.getInfo("environment") == "simulator") then
        	composer.gotoScene("title", "slideRight", 300)
            return true
        end
    end
 
    -- IMPORTANT! Return false to indicate that this app is NOT overriding the received key
    -- This lets the operating system execute its default handling of the key
    return false
end

-- Hymn Selection Box
local hymn_select_box
 
local function textListener( event )
 
    if ( event.phase == "began" ) then
        -- User begins editing "defaultBox"
 
    elseif ( event.phase == "ended" or event.phase == "submitted" ) then
        -- Output resulting text from "defaultBox"
        event.target.text = ""
 
    elseif ( event.phase == "editing" ) then
    	if tonumber(event.target.text) ~= nil then
			local hymn_num = tonumber(event.target.text)
			if(hymn_num == 212) then
				URL = "images/hymn212.png"

				current_hymn = 212
				display_page(URL, "none")
			else 
				if (hymn_num > 0) and (hymn_num <= num_hymns) then
	        		URL = hymn_table[hymn_num]:first()
	        		current_hymn = hymn_num

					display_page(URL, "none")
				end
			end
		end
    end
end

-- function to show next animation
local function showNext(direction)
	URL = hymn_table[current_hymn]:next()
	
	-- need to get the first page of the next hymn
	if URL == nil then
		-- to check if we are already at last hymn
		local old_hymn = current_hymn

		if current_hymn < num_hymns then
			current_hymn = current_hymn + 1
		end

		-- if we are at the last hymn, stay at the last page
		if old_hymn == num_hymns then
			URL = hymn_table[current_hymn]:last()
		else 
			URL = hymn_table[current_hymn]:first()
		end
	end

	display_page(URL, direction)
end

local function showPrev(direction)
	local cont_show = true
	URL = hymn_table[current_hymn]:prev()
	
	-- need to get the last page of the prev hymn
	if URL == nil then
		-- to check if we are already at first hymn
		local old_hymn = current_hymn

		if current_hymn > 1 then
			current_hymn = current_hymn - 1
		end

		-- if we are at the first hymn, go to the title
		if old_hymn == 1 then
			cont_show = false
			--do nothing
		else 
			URL = hymn_table[current_hymn]:last()
		end
	end

	if cont_show then
		display_page(URL, direction)
	end
end

-- touch event listener for background object
local function onPageTap ( event )
	-- make sure that we arent tapping on the bar on the bottom
	if event.y > (display.contentHeight - mui.getScaleVal(70)) then return end
	-- lower key board if it is up to provide better user experience
	native.setKeyboardFocus( nil )
	if scrollType == "right" then
		if event.x > (screen_width / 2) then
			showNext("left")
		else 
			showPrev("right")
		end
	else 
		if event.y > (screen_height / 2) then
			showNext("up")
		else 
			showPrev("down")
		end
	end
end

function scene:create( event )
	composer.removeHidden( false )
	local sceneGroup = self.view

	-- Called when the scene's view does not exist.
	-- 
	-- INSERT code here to initialize the scene
	-- e.g. add display objects to 'sceneGroup', add touch listeners, etc.
	

	-- PageClass init
	hymn_table = PageClass.GetHymnTable( num_hymns )

	mui.init()
	
	-- create background image
	background = display.newImageRect( sceneGroup, "images/title_page.png", display.contentWidth, display.contentHeight )
	background.anchorX = 0
	background.anchorY = 0
	background.x, background.y = 0, 40
	background.height = display.contentHeight - mui.getScaleVal(70)/2 - 40

	background:addEventListener( "tap", onPageTap )

	-- Text Box

	hymn_select_box = native.newTextField( screen_width / 2, 20, screen_width, 40 )
	hymn_select_box:resizeFontToFitHeight( )
	hymn_select_box.inputType = "number"
	hymn_select_box.isEditable = true
	hymn_select_box:addEventListener( "userInput", textListener )
	sceneGroup:insert( hymn_select_box )
	-- Add the key event listener
	Runtime:addEventListener( "key", onKeyEvent )
end

function scene:show( event )
	composer.removeHidden( false )

	local sceneGroup = self.view
	local phase = event.phase

	if phase == "will" then
		--get saved values
		local temp = save_file.loadTable("settings")

		if temp == nil then
	        temp = {}
	        temp.textView = "False"
	        temp.scrollType = "Right"
	        save_file.saveTable("settings")
    	end
		--get/set/init textView
		if temp.textView then
			if temp.textView == "true" then
				textView = true
			else 
				textView = false
			end
		else 
			textView = false
			temp.textView = "false"
		end
		--get/set/init scrollType
		if temp.scrollType then
			if temp.scrollType == "Down" then
				scrollType = "down"
			else
				scrollType = "right"
			end
		else
			scrollType = "right"
			temp.scrollType = "Right"
		end

		save_file.saveTable(temp, "settings")


		if hymn_select_box == nil then
			hymn_select_box = native.newTextField( screen_width / 2, 20, screen_width, 40 )
			hymn_select_box:resizeFontToFitHeight( )
			hymn_select_box.inputType = "number"
			hymn_select_box.isEditable = true
			hymn_select_box:addEventListener( "userInput", textListener )
			sceneGroup:insert( hymn_select_box )
		end
	elseif phase == "did" then
		-- Called when the scene is now on screen
		-- 
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc

		
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
		hymn_select_box:removeSelf()
		hymn_select_box = nil

	elseif phase == "did" then
		-- Called when the scene is now off screen
		
	end		

	mui.destroy()
end

function scene:destroy( event )
	local sceneGroup = self.view
	mui.destroy()
	
	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
	background:removeEventListener( "tap", onPageTap )

	sceneGroup:remove(background)

	hymn_select_box:removeEventListener( "userInput", textListener )
	hymn_select_box:removeSelf()

end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene
