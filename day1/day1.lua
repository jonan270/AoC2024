function file_exists(file)
    local f = io.open(file, "rb")
    if f then f:close() end
    return f ~= nil
end

function lines_from(file)
    if not file_exists(file) then return {} end
    local lines = {}
    for line in io.lines(file) do
        lines[#lines + 1] = line -- number of entries + 1
    end
    return lines
end

local lines = lines_from("input.txt")
if next(lines) ~= nil then
    local lefts = {}
    local rights = {}
    for k,line in pairs(lines) do
        local char_first, char_second = string.match(line, "(%d+)%s*(%d+)")

        lefts[k] = tonumber(char_first)
        rights[k] = tonumber(char_second)
    end

    table.sort(lefts)
    table.sort(rights)

    -- Part 1
    local sum = 0
    for i=1,#lines do
        sum = sum + math.abs(lefts[i] - rights[i])
    end
    print("Part 1: " .. sum)

    -- Part 2
    local similarity_score = 0
    for _,left_value in pairs(lefts) do
        local multiplier = 0
        for _,right_value in pairs(rights) do
            if right_value == left_value then
                multiplier = multiplier + 1
            elseif right_value > left_value then
                break
            end
        end
        similarity_score = similarity_score + left_value * multiplier
    end
    print("Part 2: " .. similarity_score)
else
    print("Could not open file!!")
end
