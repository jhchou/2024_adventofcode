function test_recursive(target, elements, running, i, operator; is_part2 = false)
    if operator == '+'
        running += elements[i+1]
    elseif operator == '*'
        running *= elements[i+1]
    else # operator == '|'; should probably do this with math and not strings
        running = parse(Int, string(running) * string(elements[i+1]))
    end

    if running > target
        return false
    elseif i+1 == length(elements) # have just acted on the last element i+1
        return running == target
    elseif !is_part2
        return  (test_recursive(target, elements, running, i+1, '+'; is_part2)) ||
                (test_recursive(target, elements, running, i+1, '*'; is_part2))
    else # for part 2
        return  (test_recursive(target, elements, running, i+1, '+'; is_part2)) ||
                (test_recursive(target, elements, running, i+1, '*'; is_part2)) ||
                (test_recursive(target, elements, running, i+1, '|'; is_part2))
    end
end

function test_file(file)
    part1 = part2 = 0
    lines = readlines(file)
    for line in lines
        m = match(r"(.*): (.*)", line)
        target = parse(Int, m.captures[1])
        elements = parse.(Int, split(m.captures[2], " "))
        # Initial recursion call will '+' a running total of 0 to the first element to start the process
        part1 += test_recursive(target, elements, 0, 0, '+'; is_part2 = false) ? target : 0
        part2 += test_recursive(target, elements, 0, 0, '+'; is_part2 = true) ? target : 0

    end
    return (part1, part2)
end

(part1, part2) = test_file("data/day7.txt")
part1 # Part 1: 14711933466277
part2 # Part 2: 286580387663654
