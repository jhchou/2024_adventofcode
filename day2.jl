function check_safe(v)
    delta = diff(v)
    dir = sign.(delta)
    safe = all(e -> e == dir[1], dir) && all(1 .<= abs.(delta) .<= 3)
    return(safe)
end

filename = "data/day2.txt"
lines = readlines(filename)

part1 = 0
part2 = 0
for line in lines
    v = parse.(Int, split(line, " "))
    if check_safe(v)
        part1 += 1
        part2 += 1
    else
        # Brute force by removing every index in turn. Initially tried to be clever and finding
        # first failing index for conditions, but too many possibilities of needing to remove at index, or +1 / -1 index
        for idx in 1:length(v)
            if check_safe(deleteat!(copy(v), idx))
                part2 += 1
                break
            end
        end
    end    
end
part1 # Part 1: 686
part2 # Part 2: 717
