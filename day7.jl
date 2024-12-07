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
            if result > target
                break
                # this is still not fast, because will still check all the other ops sequences that are initially identical
                # recursive procedure would be MUCH faster, because would not further explore down trees that failed earlier
            end
        end
        if result == target
            return target
        end
    end
    return 0
end

function test_file(file)
    part1 = part2 = 0
    lines = readlines(file)
    for line in lines
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
