using Test
using Revise
includet("Geometry.jl")
using .Geometry


@testset "Point2D Tests" begin
    p1 = Geometry.Point2d(1.0,1.0)
    @test isa(p1, Geometry.Point2d)
end

# Point2D Tests
# The constructors are called the necessary number of times in the polygon tests.
@testset "Point2D Tests" begin
    p1 = Geometry.Point2d(1, 2)
    @test isa(p1, Geometry.Point2d)

    p2 = Geometry.Point2d(1.5, 2.5)
    @test isa(p2, Geometry.Point2d)

    p3 = Geometry.Point2d(1, 2.5)
    @test isa(p3, Geometry.Point2d)

    p4 = Geometry.Point2d("(1, 2)")
    @test Geometry.equals(p4, Geometry.Point2d(1, 2))

    p5 = Geometry.Point2d(" (1.5 , 2.5) ")
    @test  Geometry.equals(p5,  Geometry.Point2d(1.5, 2.5))

    p6 =  Geometry.Point2d(" (1 , 2.5) ")
    @test  Geometry.equals(p6,  Geometry.Point2d(1, 2.5))

    @test isapprox(Geometry.distance(Geometry.Point2d(0, 0),  Geometry.Point2d(3, 4)), 5.0)
end



# Point2D Tests
@testset "Point3D Tests" begin
    p1 =  Geometry.Point3d(1, 2, 3)
    @test isa(p1,  Geometry.Point3d)

    p1 =  Geometry.Point3d(3, 4, 5)
    @test isa(p1,  Geometry.Point3d)

    p2 =  Geometry.Point3d(1.5, 2.5, 3.5)
    @test isa(p2,  Geometry.Point3d)

    p2 =  Geometry.Point3d(4.5, 2.9, 6.6)
    @test isa(p2,  Geometry.Point3d)

    p3 =  Geometry.Point3d(1, 2.5, 2)
    @test isa(p3,  Geometry.Point3d)

    p3 =  Geometry.Point3d(1.5, 2, 2.5)
    @test isa(p3,  Geometry.Point3d)

end

# Equality Tests
@testset "Equality Tests" begin
    p1 =  Geometry.Point2d(1, 2)
    p2 =  Geometry.Point2d(1, 2)
    p3 =  Geometry.Point2d(3, 4)
    @test  Geometry.equals(p1,p2)
    @test !Geometry.equals(p1, p3)

    p4 =  Geometry.Point3d(1, 2, 3)
    p5 =  Geometry.Point3d(1, 2, 3)
    p6 =  Geometry.Point3d(3, 4, 5)
    @test  Geometry.equals(p4, p5)
    @test ! Geometry.equals(p4 , p6)
end

# Polygon Tests
@testset "Polygon Tests" begin
    points = [ Geometry.Point2d(0, 0),  Geometry.Point2d(1, 0),  Geometry.Point2d(0, 1)]

    triangle =  Geometry.Polygon(points)


    @test isa(triangle,  Geometry.Polygon)

    rectangle =  Geometry.Polygon([ Geometry.Point2d(0, 0),  Geometry.Point2d(2, 0),  Geometry.Point2d(2, 1),  Geometry.Point2d(0, 1)])
    @test isa(rectangle,  Geometry.Polygon)

    parallelogram =  Geometry.Polygon([0, 0, 2, 0, 3, 1, 1, 1])
    @test isa(parallelogram,  Geometry.Polygon)

    shape =  Geometry.Polygon(0, 0, 2, 0, 3, 1, 1, 1)
    @test isa(shape,  Geometry.Polygon)


    @test_throws ArgumentError  Geometry.Polygon([1, 2, 3])  # Odd number of arguments
    @test_throws ArgumentError  Geometry.Polygon([ Geometry.Point2d(0, 0),  Geometry.Point2d(1, 1)])  # Less than 3 points

    #functions

    @test isapprox( Geometry.perimeter(triangle), sqrt(2)+2)
    @test isapprox( Geometry.perimeter(rectangle), 6)
    @test isapprox( Geometry.perimeter(parallelogram), 2*sqrt(2)+4)

end

@testset "Midpoint caclulations" begin
    points = [ Geometry.Point2d(0, 0),  Geometry.Point2d(1, 0),  Geometry.Point2d(0, 1)]

    triangle =  Geometry.Polygon(points)
    rectangle =  Geometry.Polygon([ Geometry.Point2d(0, 0),  Geometry.Point2d(2, 0),  Geometry.Point2d(2, 1),  Geometry.Point2d(0, 1)])
    @test midpoint(triangle) == Point2D(1/3,1/3)
    @test midpoint(rectangle) == Point2D(0.5,1)
end


