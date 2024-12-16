

module Geometry
using Makie
import Base.==
export Point2d, Point3d, Polygon, stringParse, isRectangular, area, distance

struct Point2d
    x::Real
    y::Real

    function Point2d(x::Real, y::Real)
        new(x,y)
    end
    function Point2d()
        new(0.0,0.0)
    end
    function Point2d(s::String)

        v = stringParse(s)
        new(v[1],v[2])

    end
end

"""

Point2d struct
Fields:
    x::Real
    y::Real
Constructors:
    Point2d(x::Real, y::Real)
    Point2d(s::String)
Examples:
    Point2d(1,2)
    Point2d("(1,2)")

"""

struct Polygon
    points::Vector{Point2d}

    function Polygon(points::Vector{Point2d})    #constructor from vector of 2d points
        length(points)>2||throw(ArgumentError("You must have at least 3 points"))
        new(points)
     end

    function Polygon(points::Vector{<:Real}) #constructor from vector of reals
        length(points)%2==0||throw(ArgumentError("You must provide an even number of values"))
        length(points)>5 ||throw(ArgumentError("Too few points"))

        new_points = Vector{Point2d}()
        for i in 1:2:length(points)-1
            push!(new_points, Point2d(points[i],points[i+1]))
        end
        new(new_points)

     end

function Polygon(x::Vararg{<:Real})  # Accepts a variable number of real numbers
    v = Real[]  # A vector to store the input values
    for i in x
        push!(v, i)
    end

    length(v) % 2 == 0 || throw(ArgumentError("You must provide an even number of values"))
    length(v) > 5 || throw(ArgumentError("Too few points"))

    nv = Vector{Point2d}()
    for i in 1:2:length(v)-1
        push!(nv, Point2d(float(v[i]), float(v[i+1])))  # Convert to float for consistency
    end
    new(nv)
end

"""
Polygon struct.
Fields:
    points::Vector{Point2d}
Constructors:
    Polygon(points::Vector{Point2d})
    Polygon(points::Vector{<:Real})
    Polygon(x::Vararg{<:Real})
Examples:
    Polygon([Point2d(1,2),Point2d(3,4),Point2d(5,6)])
    Polygon([1,2,3,4,5,6])
    Polygon(1,2,3,4,5,6)
"""

end
Makie.plottype(::Polygon) = Makie.Lines
function Makie.convert_arguments(S::Type{<:Lines}, poly::Polygon)
    xpts = [point.x for point in poly.points]
    ypts = [point.y for point in poly.points]
    push!(xpts, poly.points[1].x)
    push!(ypts, poly.points[1].y)
    Makie.convert_arguments(S, xpts, ypts)
  end


function stringParse(s::String)

    #Go through the string and ignore anything that isn't a decimal, a ',' or a '.'
    #Put it in an array, then cast to Float.
    #Also, this could be very easily adapted to the extra credit if it there wasn't requirement to use split.

    local v = Vector{String}(["",""])
    local j = 1
for i in 1:length(s)

    if s[i] >= '.' && s[i] <= '9' && s[i] != '/' # '.' = 46, '/' = 47, '0' = 48
        v[j] *= s[i]
    elseif s[i] == ','  #advances to second index. If the user decided to put in more than one comma, it will crash, but that's on them, I think throw catch is unnecessary here.
        j+=1

    end

end
    return [parse(Float64, v[1]), parse(Float64, v[2])]
end









struct Point3d
    x::Real
    y::Real
    z::Real
end



#=function ==(p1::Point2d, p2::Point2d)
    return (p1.x == p2.x) && (p1.y == p2.y)
end=#
function equals(p1::Point2d,p2::Point2d)
    (p1.x == p2.x) && (p1.y == p2.y)
end
# ==(p1::Point2d, p2::Point2d) = (p1.x == p2.x && p1.y == p2.y)

function equals(p1::Point3d, p2::Point3d)
    return p1.x == p2.x && p1.y == p2.y && p1.z == p2.z
end

function equals(p1::Polygon, p2::Polygon)
    return p1.points == p2.points
end












function distance(p1::Point2d, p2::Point2d)
    sqrt(abs(p2.x - p1.x)^2 + abs((p2.y - p1.y))^2)
end

function distance(p1::Point3d, p2::Point3d)
    sqrt((p1.y-p2.y)^2+(p1.x-p2.x)^2+(p1.z-p2.z)^2)
end
"""
Distance function.
    Takes 2 Point2d or Point3d objects and returns the distance between them

"""

function perimeter(p::Polygon) #find the perimeter for a polygon
    perimeter = 0
    for i in 1:length(p.points)-1    #go around and measure/add each side length

        #println(i, ": ", p.points[i], p.points[i+1], distance(p.points[i], p.points[i+1]))
        perimeter += distance(p.points[i], p.points[i+1])
    end
    perimeter += distance(p.points[length(p.points)], p.points[1]) #except the last one which is measured here
    perimeter
end

"""
Perimeter function.
Takes a polygon struct and returns the perimeter.

"""


function isRectangular(p::Polygon)
    if length(p.points) != 4
        return false
    else
        if isapprox(distance(p.points[1], p.points[3]), distance(p.points[2], p.points[4]))
            return true
        end
        return false
    end
end

"""
isRectangular function.
Takes a polygon struct and returrns a boolean representing whether or not the parameter is rectangular.

"""

function area(p::Polygon)
    area = 0
    for i in 1:length(p.points)-1
        area += p.points[i].x*p.points[i+1].y - p.points[i].y*p.points[i+1].x
    end
    area += p.points[length(p.points)].x * p.points[1].y - p.points[length(p.points)].y * p.points[1].x
    area = abs(area)/2

end
"""
Area function.
Takes polygon as parameter and returns the area of the polygon.

"""



"""
midpoint(p::Polyon)
calculates the midpoint of the polygon.
"""
midpoint(p::Polygon) = Point2D(mean(map(pt -> pt.x, p.pts)), mean(map(pt -> pt.y, p.pts)))



end