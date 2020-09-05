import Base
Base.:&(a::Vector, b::Vector) = a .* b
Base.:|(a::Vector, b::Vector) = (a .+ b) - (a .* b)
Base.:~(a::Vector) = 1 .- a
