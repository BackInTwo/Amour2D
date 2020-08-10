GeometryUtil = {}

function GeometryUtil.getRectangleCenter(position, offset)

    local deltaOffX = 0.5 - offset.x
    local deltaOffY = 0.5 - offset.y

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

    local center = GeometryUtil.getRotRectangleCenter(position, rotation, size, offset)

    local angle = rotation:get()
    local width = size.x
    local height = size.y

    local cos = math.cos
    local sin = math.sin

    local polygon = {}

    local x = center.x - ((width / 2) * cos(angle)) - ((height / 2) * sin(angle))
    local y = center.y - ((width / 2) * sin(angle)) + ((height / 2) * cos(angle))
    table.insert(polygon, x)
    table.insert(polygon, y)

    x = center.x - ((width / 2) * cos(angle)) + ((height / 2) * sin(angle))
    y = center.y - ((width / 2) * sin(angle)) - ((height / 2) * cos(angle))
    table.insert(polygon, x)
    table.insert(polygon, y)

    x = center.x + ((width / 2) * cos(angle)) + ((height / 2) * sin(angle))
    y = center.y + ((width / 2) * sin(angle)) - ((height / 2) * cos(angle))
    table.insert(polygon, x)
    table.insert(polygon, y)

    x = center.x + ((width / 2) * cos(angle)) - ((height / 2) * sin(angle))
    y = center.y + ((width / 2) * sin(angle)) + ((height / 2) * cos(angle))
    table.insert(polygon, x)
    table.insert(polygon, y)

    return polygon

end

return GeometryUtil
