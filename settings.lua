local composer = require( "composer" )
local mui = require( "materialui.mui" )
local save_file = require( "save_file" )
 
local scene = composer.newScene()

-- forward declare
local background, title_box, text_view_box, scroll_box, contact_box

-- mui helper functions

-- removes current scene and moves to title screen
local function goToTitle ()
    composer.removeScene( "settings", true )
    composer.gotoScene( "title", "slideDown", 300)
end

-- function to save text/full page view option
local function saveTextView ( e )
    mui.actionForCheckbox(e)
    local value_saved = "Text view"

    --either init or switch value
    local temp = save_file.loadTable("settings")
    if temp.textView then
        if temp.textView == "False" then
            temp.textView = "True"
        else
            temp.textView = "False"
            value_saved = "Hymn view"
        end
    else
        temp.textView = "True"
    end

    save_file.saveTable(temp, "settings")

    -- create a small toast to show that setting has been saved
    mui.newToast({
        name = "text_saved_toast",
        text = "You are now in " .. value_saved,
        radius = 20,
        width = mui.getScaleVal(300),
        height = mui.getScaleVal(50),
        font = native.systemFont,
        fontSize = mui.getScaleVal(24),
        fillColor = { 1, 1, 1, 1 },
        textColor = { 0, 0, 0, 1 },
        top = mui.getScaleVal(120),
        easingIn = 500,
        easingOut = 500,
        callBack = nil
    })
end

-- function to save scroll up/down left/right option
local function saveScrollType ( e )
    mui.actionForCheckbox(e)
    local value_saved = "scroll down"

    --either init or switch value
    local temp = save_file.loadTable("settings")
    if temp.scrollType then
        if temp.scrollType == "Right" then
            temp.scrollType = "Down"
        else
            temp.scrollType = "Right"
            value_saved = "scoll right"
        end
    else
        temp.scrollType = "Down"
    end

    save_file.saveTable(temp, "settings")

    -- create a small toast to show that setting has been saved
    mui.newToast({
        name = "scroll_saved_toast",
        text = "Now set to " .. value_saved,
        radius = 20,
        width = mui.getScaleVal(300),
        height = mui.getScaleVal(50),
        font = native.systemFont,
        fontSize = mui.getScaleVal(24),
        fillColor = { 1, 1, 1, 1 },
        textColor = { 0, 0, 0, 1 },
        top = mui.getScaleVal(120),
        easingIn = 500,
        easingOut = 500,
        callBack = nil
    })
end

--function to open links
-- has to be on a object with a .link attribute
local function openTextURL ( e )
    if (e.phase == "ended") then
        if (e.target.link ~= nil) then
            system.openURL( e.target.link )
        end
    end
    return true
end


function scene:create( event )

    local sceneGroup = self.view
    
    mui.init()

    -- attributes of GUI
    local spacer = mui.getScaleVal(100)

    local nav_bar_by = mui.getScaleVal(80)

    local text_x = 10
    local text_size = mui.getScaleVal(30)
    local check_box_x = mui.getScaleVal(500)
    local check_width = mui.getScaleVal(50)

    local text_text_y = nav_bar_by + spacer + text_size
    local text_check_y = nav_bar_by + text_size + spacer + check_width/2

    local scroll_text_y = text_text_y + text_size + spacer
    local scroll_check_y = text_text_y + text_size + spacer + check_width/2

    local text_email_y = scroll_text_y + text_size + spacer
    local text_github_y = text_email_y + text_size + spacer
    local text_enjoy_y = text_github_y + text_size + spacer

    -- Text text/check box
    -- allows users to specify just text view or default full hymn page view
    local text_check_text = display.newText( sceneGroup, "Display Hymn's in text format:", 0, 0, native.systemFont, text_size )
    text_check_text:setFillColor( 1, 1, 1 )
    text_check_text.anchorX = 0
    text_check_text.x = text_x
    text_check_text.y = text_text_y
    text_check_text.align = "left"

    --get saved values
    local temp = save_file.loadTable("settings")

    if temp == nil then
        temp = {}
        temp.textView = "False"
        temp.scrollType = "Right"
        save_file.saveTable("settings")
    end

    local isChecked = false
    local check_image = "check_box_outline_blank"
    if temp.textView then
        if temp.textView == "True" then
            isChecked = true
            check_image = "check_box"
        end
    end

    mui.newCheckBox ({
        name = "text_check",
        text = check_image,
        isChecked = isChecked,
        width = check_width,
        height = check_width,
        x = check_box_x,
        y = text_check_y,
        font = mui.materialFont,
        textColor = { 1,1,1 },
        value = 500,
        callBack = saveTextView
        })

    -- Scroll text/check box
    -- allows users to specify type of scroll, either up/down or (defualt) left/right
    local scroll_type_text = display.newText( sceneGroup, "Scroll down (default right):", 0, 0, native.systemFont, text_size )
    scroll_type_text:setFillColor( 1, 1, 1 )
    scroll_type_text.anchorX = 0
    scroll_type_text.x = text_x
    scroll_type_text.y = scroll_text_y
    scroll_type_text.align = "left"

    --get saved values
    local temp = save_file.loadTable("settings")
    
    if temp == nil then
        temp = {}
        temp.textView = "False"
        temp.scrollType = "Right"
        save_file.saveTable("settings")
    end

    isChecked = false
    check_image = "check_box_outline_blank"
    if temp.scrollType then
        if temp.scrollType == "Down" then
            isChecked = true
            check_image = "check_box"
        end
    end

    mui.newCheckBox ({
        name = "scroll_check",
        text = check_image,
        isChecked = isChecked,
        height = check_width,
        x = check_box_x,
        y = scroll_check_y,
        font = mui.materialFont,
        textColor = { 1,1,1 },
        value = 500,
        callBack = saveScrollType
        })  

    -- contant info 
    -- Will include:
        -- submit feedback/comments/concerns/bugs to bocreations2017@outlook.com (as a mail link)
        -- follow project on github --> https://github.com/BOCreations/ChristadelphianHymnBook (as a link)
        -- Hope you enjoy!

    local text_options = {
        text = "Please submit feedback/comments/concerns/bugs to bocreations2017@outlook.com",
        x = display.contentCenterX,
        y = text_email_y,
        width = display.contentWidth,
        height = 0,
        fontSize = text_size,
        align = "center"
    }
    local text_email = display.newText( text_options )
    text_email:setFillColor( 1, 1, 1 )
    sceneGroup:insert(text_email)
    text_email.link = "mailto:bocreations2017@outlook.com?subject=Hi%20there&body=I%20just%20wanted%20to%20say%2C%20Hi!"

    text_email:addEventListener( "touch", openTextURL )

    text_options = {
        text = "Follow project on github --> https://github.com/BOCreations/ChristadelphianHymnBook",
        x = display.contentCenterX,
        y = text_github_y,
        width = display.contentWidth,
        height = 0,
        fontSize = text_size,
        align = "center"
    }
    local text_github = display.newText( text_options )
    text_github:setFillColor( 1, 1, 1 )
    sceneGroup:insert(text_github)
    text_github.link = "https://github.com/BOCreations/ChristadelphianHymnBook"

    text_github:addEventListener( "touch", openTextURL )

    text_options = {
        text = "Hope you enjoy!",
        x = display.contentCenterX,
        y = text_enjoy_y,
        width = display.contentWidth,
        height = 0,
        fontSize = text_size,
        align = "center"
    }
    local text_enjoy = display.newText( text_options )
    text_enjoy:setFillColor( 1, 1, 1 )
    sceneGroup:insert(text_enjoy)


    -- Nav bar
    -- set last so that it writes over all other objects
    -- Only contains a back button that goes back to the menu screen
    -- and a text object that contains the string "Settings"
    mui.newNavbar ({
        name = "settings_nav",
        height = nav_bar_by,
        left = 0,
        top = 0,
        fillColor = { .93,.93,.93 },
        activeText = { 0, 0, 0 },
        padding = mui.getScaleVal(10)
        })

    -- Back button
    mui.newRoundedRectButton ({
        name = "back_nav_button",
        text = "nothing",
        width = nav_bar_by,
        height = nav_bar_by,
        textColor = { 0,0,0,0 },
        radius = 10,
        callBack = goToTitle,
        image = {
            src = "images/back-icon-sheet.png",
            sheetIndex = 2,
            touchIndex = 1,
            touchFadeAnimation = true,
            touchFadeAnimationSpeedOut = 500,
            sheetOptions = {
                width = 101,
                height = 101,
                numFrames = 2
            }
        }
        })

    -- Text
    mui.newEmbossedText ({
        x = 0,
        y = 0,
        name = "settings_text",
        text = "Settings",
        align = "center",
        width = mui.getScaleVal(700),
        font = native.systemFont,
        fontSize = mui.getScaleVal(40),
        fillColor = { 0,0,0,1 }
        })

    mui.attachToNavBar ( "settings_nav", {
            widgetName = "back_nav_button",
            widgetType = "RectButton",
            align = "left"
        })

    mui.attachToNavBar ( "settings_nav", {
            widgetName = "settings_text",
            widgetType = "EmbossedText",
            align = "right"
        })
end
 
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
 
    elseif ( phase == "did" ) then
 
    end
end
 
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then

 
    elseif ( phase == "did" ) then
 
    end
end

function scene:destroy( event )
 
    local sceneGroup = self.view

    mui.destroy()
end
 
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene
