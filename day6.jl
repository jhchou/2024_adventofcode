using DataStructures

function guard_path(grid)
    # - input grid, with guard starting location at '^'
    # - output either number locations visited before exiting, or Nothing if infinite loop
    (r_max, c_max) = size(grid)
    (r, c) = Tuple(findall(grid .== '^')[1]) # start is (first) location of '^'
    directions = [ (-1, 0), (0, 1), (1, 0), (0, -1)] # ordered for R turns: up, right, down, left
    dir = 1
    visited = DefaultDict{Tuple{Int64, Int64}, Set{Int64}}(Set()) # keys are (r,c) coordinates --> contains Set of directions
    push!(visited[(r, c)], dir)
    while true
        # grid[r, c] = 'X' # to visualize path
        (r_new, c_new) = (r, c) .+ directions[dir]
        if (r_new < 1) || (r_new > r_max) || (c_new <1) || (c_new > c_max)
            break
        elseif grid[r_new, c_new] == '#'
            dir = dir == 4 ? 1 : dir + 1
        else
            if haskey(visited, (r_new, c_new)) # can't just access value -- would create empty Set() at that key
                if dir in visited[(r_new, c_new)]
                    return nothing
                end
            end
            (r, c) = (r_new, c_new)
            push!(visited[(r, c)], dir)
        end
    end
    return length(visited)
end


# file = "data/day6test.txt"
file = "data/day6.txt"
grid = reduce(vcat, (permutedims(collect(s)) for s in eachline(file))) # reduce allocations?

# Part 1
part1 = guard_path(grid)

# Part 2

part2 = 0
(r_max, c_max) = size(grid)
for r_block in 1:r_max
    for c_block in 1:c_max
        if (grid[r_block, c_block] == '#') || (grid[r_block, c_block] == '^')
            continue
        end
        grid2 = copy(grid) # would probably be faster to NOT make copies and just alter original + restore
        grid2[r_block, c_block] = '#'
        if isnothing(guard_path(grid2))
            part2 += 1
        end
    end
end

part1 # Part 1: 4663
part2 # Part 2: 1530


# Display grid
# for row in 1:size(grid)[1]
#     # println( replace(join(grid[row,:]), '1'=>'#', '0'=>'.') )
#     println( join(grid[row,:]) )
# end
