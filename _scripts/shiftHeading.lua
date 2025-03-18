local input_file = arg[1]
local shift = tonumber(arg[2]) or 1
local output_file = arg[3] or (input_file .. ".tmp")

local infile = io.open(input_file, "r")
if not infile then
    error("无法打开输入文件：" .. input_file)
end

local outfile = io.open(output_file, "w")

for line in infile:lines() do
    local hashes, title = line:match("^(#+)(%s.*)")
    if hashes then
        local current_level = #hashes
        local new_level = current_level + shift
        if new_level < 1 then new_level = 1 end
        outfile:write(string.rep("#", new_level) .. title .. "\n")
    else
        outfile:write(line .. "\n")
    end
end

infile:close()
outfile:close()