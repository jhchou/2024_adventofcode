
# lines = readlines("data/day5test.txt")
lines = readlines("data/day5.txt")

function in_order(update, rules)
    # Given an update vector of numbers and the set of rules
    # - return Nothing if any rules broken
    # - otherwise, return the middle value of the update
    update_order = Dict() # dictionary of each value in update --> index of that value
    for (i, x) in enumerate(update)
        update_order[x] = i
    end
    for (lower, higher) in rules # test each rule
        if haskey(update_order, lower) && haskey(update_order, higher) # the rule values exist in the update...
            if update_order[lower] > update_order[higher] # ... and are in the wrong order, so fails
                return nothing
            end
        end
    end
    return update[length(update) ÷ 2 + 1] # passed all rule checks, return middle value
end

function custom_lt(x, y)
    # Define a custom "less than" function, then use sort(arr, lt = custom_lt)
    # - accessing `rules` as a global variable, which is a pretty bad idea
    for (lower, higher) in rules # test each rule
        if (x == lower) && (y == higher)
            return true
        end
    end
    return false
end

# Generate rules
rules = Set() # will contain all the collected rules as the number paris in [lower, higher] vector
for line in lines
    m = match(r"(\d+)\|(\d+)", line) # rule line
    if !isnothing(m)
        m2 = parse.(Int, m.captures)
        push!(rules, m2)
    end
end

# Test each update
part1 = 0
part2 = 0
for line in lines
    if !isnothing(match(r",", line)) # update line
        update = parse.(Int, split(line, ","))
        result = in_order(update, rules)
        if !isnothing(result)
            part1 += result
        else
            # making the assumption that the sort won't fail
            part2 += in_order(sort(update, lt = custom_lt), rules)
        end
    end
end

part1 # Part 1: 6949
part2 # Part 2: 4145
