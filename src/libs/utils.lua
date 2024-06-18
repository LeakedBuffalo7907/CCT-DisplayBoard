local utils = {}

utils.hexToColor = function (hex)
    local hexToRGB = function(hex)
        return tonumber(hex:sub(1, 2), 16) / 255,
               tonumber(hex:sub(3, 4), 16) / 255,
               tonumber(hex:sub(5, 6), 16) / 255
    end

    local function closestColorIndex(rgb)
        local colors = { 0x0, 0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0x7, 0x8, 0x9, 0xa, 0xb, 0xc, 0xd, 0xe, 0xf }
        local minDistance = math.huge
        local closestIndex = 1

        for i, color in ipairs(colors) do
            local r, g, b = term.getPaletteColor(color)
            local distance = math.sqrt((r - rgb[1])^2 + (g - rgb[2])^2 + (b - rgb[3])^2)
            if distance < minDistance then
                minDistance = distance
                closestIndex = i
            end
        end

        return closestIndex - 1
    end

    local r, g, b = hexToRGB(hex)
    local colorIndex = closestColorIndex({r, g, b})

    return colorIndex
end

return utils