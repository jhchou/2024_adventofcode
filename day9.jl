# Input: list of block lengths
# - odd are filled, even are empty
#
# Approach: maybe iterate by position, figure out what goes in it, and maintain running sum
# - by the end, all the internal unfilled space will be filled
# - after moves complete, exactly sum(drive[1:2:end]) spaces will be filled
# - (maybe quickly fill all empties up until last one, then manually fill in remaining?)
# - (push onto a stack? or no need, and just maintain running total)
# - cumsum() might be a way to index into lists of lengths?
#   - cumsum(drive) give ending breakpoints of each block; odd elements are previously filled
# - findfirst(), iseven(), isodd()
# - reverse()

# line = readline("data/day9test.txt") # 2333133121414131402; 19 characters, sum = 42
# line = readline("data/day9.txt") # 19,999 characters, sum = 95082

# drive = parse.(Int, split(line, ""))

function solve_part1(file)
    line = readline(file) 
    drive = parse.(Int, split(line, ""))

    breakpoint_ends = cumsum(drive) # give ending breakpoints of each block; odd elements are previously filled
    total_num_written_blocks = sum(drive[1:2:end]) 
    written_block_end_indices = cumsum(drive[1:2:end])

    function file_block_to_id(idx, drive; fwd=true)
        # using initial order of drives and skipping empty space, input index and return file id
        # if fwd=false, then count from back
        # drive[1:2:end] # the lengths of each block, whose id's will start at 0 up to length()-1
        # sum(drive[1:2:end] -- the total number of written blocks
        # cumsum(drive[1:2:end]) # the ending indices of each block, whose id's will start at 0 up to length()-1
        i = fwd ? idx : (total_num_written_blocks - idx + 1)
        return findfirst(i .<= written_block_end_indices) - 1
    end

    part1 = 0
    fwd_idx = back_idx = 0 # counting forward and backward from initial order of drives and skipping empty space
    for pos = 1:total_num_written_blocks # 1-based indexing; each of these will be filled by end
        block_idx = findfirst(pos .<= breakpoint_ends) # Determine which block pos is in
        if isodd(block_idx) # within an initially written block
            fwd_idx += 1
            part1 += (pos-1) * file_block_to_id(fwd_idx, drive; fwd=true)
        else
            back_idx += 1
            part1 += (pos-1) * file_block_to_id(back_idx, drive; fwd=false)
        end
    end
    
    return part1
end

part1 = solve_part1("data/day9.txt")

part1 # Part 1: 6463499258318

