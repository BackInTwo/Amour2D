GeometryUtil = {}

function GeometryUtil.getRectangleCenter(position, off)

    local offset = 0

    if not off or string.lower(off) == "center" then
        offset = 0.5
    elseif string.lower(off) == "corner" then
        offset = 0
    else
        assert(false, "Offset should be either \"center\" or \"corner\"")
    end

    local deltaOffX = 0.5 - offset
    local deltaOffY = 0.5 - offset

    local x = position.x - (position.x * deltaOffX)
    local y = position.y - (position.y * deltaOffY)

    return { x = x, y = y }

end

function GeometryUtil.getRotRectangleCenter(position, rotation, size, offset)

    local center = GeometryUtil.getRectangleCenter(position, offset)
    local angle = rotation:get()

    local vec = { x = center.x - position.x + size.x / 2, y = center.y - position.y + size.y / 2 }

    local cosA = math.cos(angle)
    local sinA = math.sin(angle)

    local x  = vec.x * cosA - vec.y * sinA
    local y = vec.x * sinA + vec.y * cosA

    return { x = x + position.x, y = y + position.y }

end

function GeometryUtil.getRectanglePolygon(position, rotation, size, offset)

    local center = nil

    if string.lower(offset) == "center" then
        center = GeometryUtil.getRectangleCenter(position, offset)
    elseif string.lower(offset) == "corner" then
        center = GeometryUtil.getRotRectangleCenter(position, rotation, size, offset)
    else
        assert(false, "Offset should be either \"center\" or \"corner\"")
    end

    local angle = rotation:get()
    local width = size.x
    local height = size.y

    local cos = math.cos
    local sin = math.sin

    local polygon = {}

    local x = center.x - ((width / 2) * cos(angle)) - ((height / 2) * sin(angle))
    local y = center.y - ((width / 2) * sin(angle)) + ((height / 2) * cos(angle))
    table.insert(polygon, {x=x, y=y})

    x = center.x - ((width / 2) * cos(angle)) + ((height / 2) * sin(angle))
    y = center.y - ((width / 2) * sin(angle)) - ((height / 2) * cos(angle))
    table.insert(polygon, {x=x, y=y})

    x = center.x + ((width / 2) * cos(angle)) + ((height / 2) * sin(angle))
    y = center.y + ((width / 2) * sin(angle)) - ((height / 2) * cos(angle))
    table.insert(polygon, {x=x, y=y})

    x = center.x + ((width / 2) * cos(angle)) - ((height / 2) * sin(angle))
    y = center.y + ((width / 2) * sin(angle)) + ((height / 2) * cos(angle))
    table.insert(polygon, {x=x, y=y})

    return polygon

end

function GeometryUtil.toDrawablePolygon(poly)

    local drawablePoly = {}

    for k in pairs(poly) do
        if type(poly[k]) == "table" then
            table.insert(drawablePoly, poly[k].x)
            table.insert(drawablePoly, poly[k].y)
        end
    end

    return drawablePoly

end

return GeometryUtil
