using LinearAlgebra
using BenchmarkTools

lines = readlines("xmas.txt")

function find_xmas(lines)

    char_matrix = permutedims(reduce(hcat, collect.(lines)))
    reverse_char_matrix = char_matrix[:, end:-1:1] 
    total = 0
    

    for line in lines
        forward_index = findall(r"XMAS", line)
        backward_index = findall(r"SAMX", line)
        total += length(forward_index) + length(backward_index)
    end

    rows, cols = size(char_matrix)

    for col in 1:cols
        string = join(char_matrix[:,col])
        forward_index = findall(r"XMAS", string)
        backward_index = findall(r"SAMX", string)
        total += length(forward_index) + length(backward_index)
    end

    rows, cols = size(reverse_char_matrix)
    
    for k in -(rows-1):(cols-1)
        str = diag(reverse_char_matrix, k) |> join
        forward_index = findall(r"XMAS", str)
        backward_index = findall(r"SAMX", str)
        total += length(forward_index) + length(backward_index)
    end

   rows, cols = size(char_matrix)
    
    for k in -(rows-1):(cols-1)
        str = diag(char_matrix,k) |> join
        forward_index = findall(r"XMAS", str)
        backward_index = findall(r"SAMX", str)
        total += length(forward_index) + length(backward_index)
    end
 
    return total 
end


function get_all_diagonals(M)
    rows, cols = size(M)
    
    for k in -(rows-1):(cols-1)
        str = diag(M,k) |> join
        println(str)
    end

end


function find_MAS_Xes(lines)

    char_matrix = permutedims(reduce(hcat, collect.(lines)))
    reverse_char_matrix = char_matrix[:, end:-1:1] 
    total = 0
    rows, cols = size(char_matrix)

    for diagIdx in -(rows-1):(cols-1)

        diag_str = diag(char_matrix, diagIdx) |> join
        forward_results_1 = findall(r"MAS", diag_str) 
        backward_results_1 = findall(r"SAM", diag_str)

        reverse_diag_str = diag(reverse_char_matrix, diagIdx) |> join
        forward_results_2 = findall(r"MAS", reverse_diag_str)
        backward_results_2 = findall(r"SAM", reverse_diag_str)

        diag_matches = intersect(forward_results_1, forward_results_2) |> length
        reverse_diag_matches = intersect(backward_results_1, backward_results_2) |> length
        
        total += diag_matches + reverse_diag_matches
    end

    return total
end

function antidiagonals(mat::AbstractMatrix)
    nrows, ncols = size(mat)
    n = nrows + ncols - 1
    [ [mat[i, k - i + 1] for i in max(1, k - ncols + 1):min(nrows, k)] for k in 1:n ]
end

test_lines = readlines("test_X_mas.txt")
char_matrix = permutedims(reduce(hcat, collect.(test_lines)))
cols,rows = size(char_matrix)
result = []

for diagIdx in -(rows-1):(cols-1)

    diag_str = diag(char_matrix, 0) |> join
    forward_results_1 = findall(r"MAS", diag_str) 
    backward_results_1 = findall(r"SAM", diag_str)

    if isempty(forward_results_1) == false
        push!(result, forward_results_1)
    end

    if isempty(backward_results_1) == false
        push!(result,backward_results_1)
    end

end



r