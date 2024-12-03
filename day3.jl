input = read("data/day3.txt", String);

# Generate vector of valid instructions: mul(#,#), do(), and don't()
# - initially made wrong assumption that do() / don't() would occur in valid pairs
# - but, multiple sequential do() or don't() can occur
# - so, need to treat them as toggles

instructions = [m.match for m in eachmatch(r"mul\(\d+,\d+\)|do\(\)|don't\(\)", input)]

part1 = 0
part2 = 0
active = true

for instruction in instructions
    if instruction == "do()"
        active = true
    elseif instruction == "don't()"
        active = false
    else
        m = match(r"mul\((\d+),(\d+)\)", instruction)
        product = parse(Int, m.captures[1]) * parse(Int, m.captures[2])
        part1 += product
        if active
            part2 = part2 += product
        end
    end
end

part1 # Part 1: 162813399
part2 # Part 2: 53783319
