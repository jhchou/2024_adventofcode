using IterTools # for product()

function test_line(target, elements, operations)
    for ops in product(fill( operations, length(elements) - 1)...)
        # generate iterator across all possible operations between elements
        result = elements[1]
        for i in 1:(length(elements) - 1)
            if ops[i] == '+'
                result +=  elements[i+1]
            elseif ops[i] == '*'
                result *=  elements[i+1]
            elseif ops[i] == '|'
                result = parse(Int, string(result) * string(elements[i+1]))
            else
                println("ERROR")
            end
        end
        if result == target
            return target
        elseif result > target
            return 0
        end
    end
    return 0
end

function test_file(file)
    part1 = part2 = 0
    for line in readlines(file)
        m = match(r"(.*): (.*)", line)
        target = parse(Int, m.captures[1])
        elements = parse.(Int, split(m.captures[2], " "))
        part1 += test_line(target, elements, ['+', '*'])
        part2 += test_line(target, elements, ['+', '*', '|'])
    end
    return (part1, part2)
end

# file = "data/day7test.txt"
file = "data/day7.txt"

(part1, part2) = test_file(file)
part1 # Part 1: 14711933466277
part2 # Part 2: 286580387663654
