
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

# Part 1

part1 = 0

rules = Set() # will contain all the collected rules as the number paris in [lower, higher] vector
for line in lines
    # Assumption: all rules precede any update lines
    m = match(r"(\d+)\|(\d+)", line) # rule line
    if !isnothing(m)
        m2 = parse.(Int, m.captures)
        push!(rules, m2)
    elseif !isnothing(match(r"\d", line)) # update line
        update = parse.(Int, split(line, ","))
        result = in_order(update, rules)
        if !isnothing(result)
            part1 += result
        end
    end
end

part1 # Part 1: 6949
