# lines = readlines("data/day4test.txt")
lines = readlines("data/day4.txt")

# Read input as matrix of 1-character strings
input_v = Vector{String}[] # vector of vectors (rows)
for line in lines
    push!(input_v, split(line, ""))
end
input_m = permutedims(reduce(hcat, input_v)) # convert to matrix

(r_size, c_size) = size(input_m)
dirs = [(x, y) for x in [-1, 0, 1], y in [-1, 0, 1] if !(x == 0 && y == 0)] # product([-1, 0, 1], [-1, 0, 1]) except [0,0]

part1 = 0
for r in 1:r_size
    for c in 1:c_size
        for dir in dirs
            steps = [dir .* k for k in 0:3] # 4 steps from starting coordinates in given direction
            # Bounds check
            r_end = r + 3*dir[1]
            c_end = c + 3*dir[2]
            if (r_end < 1 || c_end < 1 || r_end > r_size || c_end > c_size)
                continue
            end
            word = reduce(*, [input_m[r + Δr, c + Δc] for (Δr, Δc) in steps])
            if word == "XMAS"
                part1 += 1
            end
        end
    end
end

part1 # Part 1: 2562


part2 = 0
for r in 2:r_size - 1
    for c in 2:c_size - 1
        word1 = reduce(*, [input_m[r + Δr, c + Δc] for (Δr, Δc) in [(-1, -1), (0, 0), (1, 1)]])
        word2 = reduce(*, [input_m[r + Δr, c + Δc] for (Δr, Δc) in [(-1, 1), (0, 0), (1, -1)]])
        if (word1 == "MAS" || word1 == "SAM") && (word2 == "MAS" || word2 == "SAM")
            part2 += 1
        end
    end
end

part2 # Part 2: 1902
