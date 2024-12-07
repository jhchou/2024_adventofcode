using IterTools

function concat(x)
    return parse(Int, string(x[1]) * string(x[2]))
end

function testline(target, elements, ops)
    for ops in Iterators.product(fill( ops, length(elements) - 1)...)
        # generate iterator across all possible operations between elements
        result = elements[1]
        for i in 1:(length(elements) - 1)
            result = ops[i]([result, elements[i+1]])
        end
        if result == target
            return(target)
        end
    end
    return 0
end

function testinput(file)
    part1 = 0
    part2 = 0
    lines = readlines(file)
    for line in lines
        m = match(r"(.*): (.*)", line)
        if isnothing(m) continue end
        target = parse(Int, m.captures[1])
        elements = parse.(Int, split(m.captures[2], " "))
        part1 += testline(target, elements, [sum, prod])
        part2 += testline(target, elements, [sum, prod, concat])
    end
    return (part1, part2)
end

# file = "data/day7test.txt"
file = "data/day7.txt"

(part1, part2) = testinput(file)

part1 # Part 1: 14711933466277
part2 # Part 2: 

