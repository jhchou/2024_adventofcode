# Day 1, tools used

# - readlines()
# - DataFrames and CSV
# - sort!() -- mutating sort
# - .|> -- element-wise piping
# - (count(==(val), col2)) -- count number element in array
# - parse(Int, x) -- parse string as a number; can set base (e.g., 10) for integers
# - m = match(r"(\d+)\s+(\d+)", line); m2 = parse.(Int, m.captures) -- extract RegExp capture fields

lines = readlines("data/day1.txt")

# Part 1 with DataFrames (base Julia code at bottom)
# Sum up the total distances between ordered values of 2 columns, separated by 3 spaces

using DataFrames, CSV
df = CSV.read("data/day1.txt", DataFrame; header=false, delim="   ");
col1 = sort!(df[!, :Column1])
col2 = sort!(df[!, :Column2])
part1 = col1 .- col2 .|> abs |> sum

part1 # Part 1: 2756096

# Part 2
# Add up each number in the left list after multiplying it by the number of times that
# number appears in the right list.

part2 = 0
for val in col1
    part2 += val * (count(==(val), col2))
end
part2 # Part 2: 23117829


# Part 1 with base Julia
#
# col1 = Int[] # == Array{Int, 1}(), for a 1-dimensional Int array?
# col2 = Int[]
# for line in lines
#     m = match(r"(\d+)\s+(\d+)", line)
#     m2 = parse.(Int, m.captures)
#     push!(col1, m2[1]) # Or better to pre-initialize to arrays of known length and assign?
#     push!(col2, m2[2])
# end
# sort!(col1) # mutating sort
# sort!(col2)
# part1 = 0
# for (y1, y2) in zip(col1, col2)
#     part1 += abs(y2 - y1)
# end
# part1 # Part 1: 2756096
