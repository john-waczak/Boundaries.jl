import("Point.jl")


function nextPoint(start_pt::Point, pts::Vector{Point})
    
end




function jarvis(pts::Vector{Point})
    hull = Vector{Point}()

    # sort by x value
    sort!(pts, by=(pt->pt.x))

    # start with left-most value. This will be ∈ cvx_hull no matter what
    push!(hull, pts[1])


    i = 1
    curr_pt = pts[2]

end
