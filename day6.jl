# file = "data/day6test.txt"
file = "data/day6.txt"

grid = reduce(vcat, (permutedims(collect(s)) for s in eachline(file))) # reduce allocations?
(r_max, c_max) = size(grid)

(r, c) = Tuple(findall(grid .== '^')[1]) # start is (first) location of '^'

directions = [ (-1, 0), (0, 1), (1, 0), (0, -1)] # ordered for R turns: up, right, down, left
dir = 1
visited = Set([(r, c)])
# visited2 = Set([(r, c, dir)]) # for part 2, if on previously visited coord in same direction, then in infinite loop -- need to track all dirs

while true
    # grid[r, c] = 'X' # to visualize path
    (r_new, c_new) = (r, c) .+ directions[dir]
    if (r_new < 1) || (r_new > r_max) || (c_new <1) || (c_new > c_max)
        break
    elseif grid[r_new, c_new] == '#'
        dir = dir == 4 ? 1 : dir + 1
    else
        (r, c) = (r_new, c_new)
        push!(visited, (r, c))
        push!(visited2, (r, c, dir))
    end
end

part1 = length(visited)

part1 # Part 1: 4663


# Display grid
# for row in 1:size(grid)[1]
#     # println( replace(join(grid[row,:]), '1'=>'#', '0'=>'.') )
#     println( join(grid[row,:]) )
# end
