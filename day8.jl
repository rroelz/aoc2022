function readforest(file)
    input = readlines(file)
    mat_size = size(input)[1]
    forest = zeros(Int, mat_size, mat_size)
    i = 1
    for row in input
        rowvals = split(row, "")
        forest[i, :] = parse.(Int, rowvals)
        i+=1
    end
    return forest
end

function visline(treeline)
    visibletrees = zeros(Bool, size(treeline))
    largest = -1
    for n in eachindex(treeline)
        if treeline[n] > largest
            visibletrees[n] = true
            largest = treeline[n]
        end
    end
    return visibletrees
end

function seetree(trees)
    vismat = zeros(Bool, size(trees)[1], size(trees)[2], 4)

    vismat[:,:,1] = transpose(reduce(hcat, [visline(x) for x in eachrow(forest)]))
    vismat[:,:,2] = reduce(hcat, [visline(x) for x in eachcol(forest)])
    vismat[:,:,3] = transpose(reduce(hcat, reverse.([visline(reverse(x)) for x in eachrow(forest)])))
    vismat[:,:,4] = reduce(hcat, reverse.([visline(reverse(x)) for x in eachcol(forest)]))
end

function viewdistance(trees)
    treehouse = trees[1]
    i = 0
    if length(trees) == 1
        return i
    end
    for t in trees[2:end]
        i+=1
        if t >= treehouse
            return i
        end
    end
    return i
end


function scorescenes(forest)
    viewscore = zeros(Int, size(forest)[1], size(forest)[2])
    for Idx in CartesianIndices(forest)
        a = viewdistance(forest[Idx[1]:end, Idx[2]])
        b = viewdistance(reverse(forest[begin:Idx[1], Idx[2]]))
        c = viewdistance(forest[Idx[1], Idx[2]:end])
        d = viewdistance(reverse(forest[Idx[1], begin:Idx[2]]))
        viewscore[Idx] = a*b*c*d
    end
    return viewscore
end

forest = readforest("data/08-input.txt")

vismat = seetree(forest)
vistrees = mapslices(any, vismat, dims = 3)
sum(vistrees) 

scores = scorescenes(forest)
findmax(scores)