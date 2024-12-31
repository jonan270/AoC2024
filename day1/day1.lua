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

    local sum = 0
    for i=1,#lines do
        sum = sum + math.abs(lefts[i] - rights[i])
    end
    print(sum)
end
