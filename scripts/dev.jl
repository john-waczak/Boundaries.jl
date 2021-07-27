using Boundaries
using Plots
using Random


# struct Point{T<:Real}
#     x::T
#     y::T
# end


# # return true if vector ab is left of vector ac
# function isleft(a::Point, b::Point, c::Point)
#     v1 = Point((b.x-a.x), (b.y-a.y))
#     v2 = Point((c.x-a.x), (c.y-a.y))

#     v1crossv2_z = v1.x*v2.y - v1.y*v2.x
#     # this is just a check for left handedness! If ab is left of ac then ab × ac has positive z component
#     return (v1crossv2_z < 0)
# end


# turn these into tests
isleft(Point(0,0), Point(1,0), Point(0,1)) # true
isleft(Point(0,0), Point(0,1), Point(1,0)) # false



# function nextLeft(p_id::Int, points::Vector{Point{T}}) where T
#     p = points[p_id]
#     idxs = 1:length(points)
#     idxs = idxs[1:end .!= p_id]
#     next_idx = idxs[1]
#     for i∈1:length(points)
#         if i != p_id
#             if !(isleft(p, points[next_idx], points[i]))
#                 next_idx = i
#             end
#         end
#     end

#     return next_idx
# end




# function jarvis(pts::Vector{Point{T}}) where T
#     hull_idxs = Int[]

#     # first element is left-most point
#     sort!(pts, by=(p->p.x))
#     push!(hull_idxs, 1)


#     # figure out the second element
#     next_id = nextLeft(hull_idxs[1], pts)
#     i = 2
#     while(next_id != hull_idxs[1])
#         push!(hull_idxs, next_id)
#         next_id = nextLeft(hull_idxs[i], pts)
#         i += 1
#     end

#     return hull_idxs
# end





Random.seed!(42) # for reproducability
N = 100
xs = rand(N)
ys = rand(N)
points = [Point(xs[i], ys[i]) for i∈1:N]


hull_idxs = jarvis(points)
hull = points[hull_idxs]

interior_idxs = [i for i ∈ 1:length(points) if ! (i ∈ hull_idxs)]
interior_points = points[interior_idxs]

plot([p.x for p ∈ points], [p.y for p ∈ points], seriestype=:scatter, color=:blue, ms=4, grid=false, axes=false, ticks=false, label="")
plot!([p.x for p ∈ interior_points], [p.y for p ∈ interior_points], seriestype=:scatter, color=:red, ms=5, grid=false, axes=false, ticks=false, label="")
# plot!([p.x for p ∈ hull], [p.y for p ∈ hull], seriestype=:scatter, color=:green, ms=10, label="")
plot!(vcat([p.x for p ∈ hull], hull[1].x ), vcat([p.y for p ∈ hull], hull[1].y), linewidth=7, color=:green, label="")




