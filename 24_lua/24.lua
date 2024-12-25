local f = io.input('24.in')
local fc = f:read('*a')
f:close()

local part1, part2 = fc:match("^(.-)\n\n(.*)$")
local table = {}

for line in part1:gmatch("[^\n]+") do
    local a, b = line:match("(%w+):.(%w+)")
    local n = tonumber(b)
    table[a] = function() return n end
end

local operators = {
    AND = function(a, b) return a & b end,
    OR = function(a, b) return a | b end,
    XOR = function(a, b) return a ~ b end
}

local highestZ = 0
for line in part2:gmatch("[^\n]+") do
    local a, operator, b, target = line:match("(%w+).(%w+).(%w+)....(%w+)")
    if operator ~= nil then
        local op = operators[operator]
        table[target] = function() return op(table[a](), table[b]()) end
        if target:match("^z") then
            highestZ = math.max(highestZ, tonumber(target:match("%d+")))
        end
    end
end

function getVal(name)
    local combined = 0
    for i = 0, highestZ do
        local vn = string.format(name.."%02d", i)
        if table[vn] == nil then
            break
        end
        combined = combined + (table[vn]() << i)
    end
    return combined
end

-- print(getVal("x"))
-- print(getVal("y"))
-- print(getVal("x")+getVal("y"))
print(getVal("z"))

-- no way i'll do part b in lua