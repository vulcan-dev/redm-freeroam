function split(inputString, delimiter)
    local result = {}
    local pattern = "(.-)" .. delimiter .. "()"
    local lastPosition = 1

    for value, position in inputString:gmatch(pattern) do
        table.insert(result, value)
        lastPosition = position
    end

    table.insert(result, inputString:sub(lastPosition))
    return result
end