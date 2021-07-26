using Plots
using Random
#----- develop jarvis algorithm


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
    return (v1crossv2_z > 0)
end

isleft(Point(0,0), Point(1,0), Point(0,1)) # true
isleft(Point(0,0), Point(0,1), Point(1,0)) # false


# Random.seed!(42) # for reproducability
N = 20
xs = rand(N)
ys = rand(N)
points = [Point(xs[i], ys[i]) for i∈1:N]

# sort points by x value
function jarvis(pts::Vector{Point{T}}) where T
    points = pts # this will be the interior points
    hull = Vector{Point}()

    sort!(points, by=(p->p.x))

    leftMost = points[1]
    currentVertex = leftMost

    push!(hull, currentVertex)

    nextVertex = points[2]
    index = 3

    am_I_done = false
    while am_I_done == false
        checking = points[index] # the point we are checking against nextVertex

        if isleft(currentVertex, checking, nextVertex)
            nextVertex = checking
        end

        index += 1

        if index == length(points)
            if nextVertex == leftMost
                println("Done")
                am_I_done = true
            else
                push!(hull, nextVertex)
                currentVertex = nextVertex
                index = 1 # start back over
                nextVertex = leftMost
            end
        end
    end

    return hull
end


hull = jarvis(points)




plot([p.x for p ∈ points], [p.y for p ∈ points], seriestype=:scatter, color=:black, ms=7, grid=false, axes=false, ticks=false, label="")
plot!([p.x for p ∈ hull], [p.y for p ∈ hull], seriestype=:scatter, ms=10, color=:green)
plot!(vcat([p.x for p ∈ hull], hull[1].x ), vcat([p.y for p ∈ hull], hull[1].y), color=:green)




