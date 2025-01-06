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
    local reports = {}
    local number_of_safe = 0

    for _,line in pairs(lines) do
        local levels = {}
        for match in line:gmatch("%d+") do
            levels[#levels + 1] = tonumber(match)
        end
        reports[#reports + 1] = levels
    end

    for n,report in pairs(reports) do
        local safe = true
        local decreasing = report[1] > report[2]

        for key,val in pairs(report) do
            if key > 1 then
                local difference = val - report[key - 1]
                local distance = math.abs(difference)

                if distance < 1 or distance > 3 then
                    safe = false
                elseif decreasing and difference > 0 then
                    safe = false
                elseif not decreasing and difference < 0 then
                    safe = false
                end

                if not safe then break end
            end
        end

        if safe then
            --print("Report " .. n .. " is safe")
            number_of_safe = number_of_safe + 1
        end
    end
    print("Number of safe reports: " .. number_of_safe)
else
    print("Could not open file!!")
end
