input = read("data/day3.txt", String); # several lines; unclear what should happen between lines
# input = "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))"
# input = "xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))"

part1 = 0
matches = eachmatch(r"mul\((\d+),(\d+)\)", input)
for match in matches
    # match.match, match.captures[1], match.captures[2]
    part1 += parse(Int, match.captures[1]) * parse(Int, match.captures[2])
end
part1 # Part 1: 162813399


input = "do()" * input * "don't()" # starts as active and needs to remain active to end
input2 = ""

pattern = r"do\(\)(.+?)don\'t\(\)" # .+? is for a NON-greedy match
matches = eachmatch(pattern, input)
for match in matches
    # match.match, match.captures[1], match.captures[2]
    println(match.captures[1])
    input2 *= match.captures[1]
    # part1 += parse(Int, match.captures[1]) * parse(Int, match.captures[2])
end

part2 = 0
matches = eachmatch(r"mul\((\d+),(\d+)\)", input2)
for match in matches
    # match.match, match.captures[1], match.captures[2]
    part2 += parse(Int, match.captures[1]) * parse(Int, match.captures[2])
end
part2 # Part 2: 45394036 is NOT correct; too low; possibly due to multi-line effects



part1 = 0
part2 = 0
lines = readlines("data/day3.txt");
# lines = ["xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))"]
for line in lines
    matches = eachmatch(r"mul\((\d+),(\d+)\)", line)
    for match in matches
        part1 += parse(Int, match.captures[1]) * parse(Int, match.captures[2])
    end

    input1 = "do()" * line * "don't()"
    input2 = ""
    matches = eachmatch(r"do\(\)(.+?)don\'t\(\)", input1) # .+? is for a NON-greedy match
    for match in matches
        input2 *= match.captures[1]
    end
    
    matches = eachmatch(r"mul\((\d+),(\d+)\)", input2)
    for match in matches
        part2 += parse(Int, match.captures[1]) * parse(Int, match.captures[2])
    end
end
part1 # Part 1: 162813399
part2 # Part 2: 
    # 45394036 too low; read input as single string with do() placed only at beginning
    # 58488142 too high; placed do() and don't() around every line
    # Perhaps activity persists ACROSS lines; slurp in entire file and REMOVE non-greedy between don't() and do()?

