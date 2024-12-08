using DataStructures # DefaultDict

# file = "data/day8test.txt"
file = "data/day8.txt"
grid = reduce(vcat, (permutedims(collect(s)) for s in eachline(file))) # reduce allocations?
(max_row, max_col) = size(grid)

# Dict with key grid content --> coordinates
freq_lookup = DefaultDict{Char, Set{Tuple{Int64, Int64}}}(Set())
for p in findall(grid .!= '.') # CartesianIndex
    push!(freq_lookup[grid[p]], Tuple(p))
end

part1_antinodes =  Set{Tuple{Int64, Int64}}()
part2_antinodes =  Set{Tuple{Int64, Int64}}()
for (freq, values) in freq_lookup # list of all Chars in grid
    positions = collect(values) # all the tuple positions of 'freq'
    for p1 in positions, p2 in positions
        if p1 == p2 continue end
        Δpos  = p1 .- p2 # [Δrow, Δcol]

        # Part 1
        for (r, c) in [p1 .+ Δpos, p2 .- Δpos]
            if (1 <= r <= max_row) && (1 <= c <= max_col)
                push!(part1_antinodes, (r, c))
            end
        end

        # Part 2
        Δpos2 =  Δpos .÷ gcd([Δpos[1], Δpos[2]]) # exactly in line steps
        # How to utterly fail with "Don't Repeat Yourself"
        i = 0
        while true
            (r, c) = p1 .+ i.*Δpos2
            if (1 <= r <= max_row) && (1 <= c <= max_col)
                push!(part2_antinodes, (r, c))
                i += 1
            else
                break
            end
        end
        i = 1
        while true
            (r, c) = p1 .- i.*Δpos2
            if (1 <= r <= max_row) && (1 <= c <= max_col)
                push!(part2_antinodes, (r, c))
                i -= 1
            else
                break
            end
        end

    end
end

part1 = length(part1_antinodes)
part2 = length(part2_antinodes)

part1 # Part 1: 305
part2 # Part 2: 1150

### Display grid
# for row in 1:size(grid)[1]
#     # println( replace(join(grid[row,:]), '1'=>'#', '0'=>'.') )
#     println( join(grid[row,:]) )
# end
