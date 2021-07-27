function jarvis(pts::Vector{Point{T}}) where T
    hull_idxs = Int[]

    # first element is left-most point
    sort!(pts, by=(p->p.x))
    push!(hull_idxs, 1)


    # figure out the second element
    next_id = nextLeft(hull_idxs[1], pts)
    i = 2
    while(next_id != hull_idxs[1])
        push!(hull_idxs, next_id)
        next_id = nextLeft(hull_idxs[i], pts)
        i += 1
    end

    return hull_idxs
end


