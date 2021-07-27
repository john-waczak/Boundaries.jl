struct Point{T<:Real}
    x::T
    y::T
end


# return true if vector ab is left of vector ac
function isleft(a::Point, b::Point, c::Point)
    v1 = Point((b.x-a.x), (b.y-a.y))
    v2 = Point((c.x-a.x), (c.y-a.y))

    v1crossv2_z = v1.x*v2.y - v1.y*v2.x
    # this is just a check for left handedness! If ab is left of ac then ab × ac has positive z component
    return (v1crossv2_z < 0)
end



function nextLeft(p_id::Int, points::Vector{Point{T}}) where T
    p = points[p_id]
    idxs = 1:length(points)
    idxs = idxs[1:end .!= p_id]
    next_idx = idxs[1]
    for i∈1:length(points)
        if i != p_id
            if !(isleft(p, points[next_idx], points[i]))
                next_idx = i
            end
        end
    end

    return next_idx
end
