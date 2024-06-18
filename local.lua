-- Define the message to scroll
local message = "Hello"
local displayWidth, displayHeight = term.getSize() -- Get the width of the screen
local sleepTime = 0.3 -- Time delay between scroll steps

-- Function to scroll the text
local function scrollText(text)
    local finalText = text

    while #finalText < displayWidth do
        finalText = finalText .. " "
    end
    
    local textLength = #finalText

    while true do
        for i = 1, textLength do
            term.clear()
            term.setCursorPos(1, displayHeight / 2) -- Center the text vertically
            local displayText = finalText:sub(i, textLength) .. finalText:sub(1, i - 1)
            term.write(displayText:sub(1, displayWidth))
            sleep(sleepTime)
        end
    end
end

-- Clear the screen initially
term.clear()
term.setCursorPos(1, displayHeight / 2)

-- Start scrolling the text
scrollText(message)
