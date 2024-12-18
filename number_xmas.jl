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
        str = diag(reverse_char_matrix,k) |> join
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

number_xamas_found = find_xmas(lines)

@benchmark find_xmas(lines)