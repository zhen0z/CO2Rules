# export jutulVWell

# struct jutulVWell{D, T}
#     irate::T
#     name::Vector{Symbol}
#     loc::Vector
#     startz
#     endz
# end

# jutulVWell(irate::T, loc::NTuple{D, T}; startz=nothing, endz=nothing) where {D, T} = jutulVWell(irate, [loc]; startz=startz, endz=endz)
# jutulVWell(irate::T, loc::Vector{NTuple{D, T}}; startz=nothing, endz=nothing) where {D, T}= jutulVWell{D+1, T}(irate, vcat(:Injector, [:Producer for i = 1:length(loc)]), loc, startz, endz)

# display(f::jutulVWell{D, T}) where {D, T} =
#     println("$(D)D jutulVWell structure with $(length(f.loc)) injection/production wells and rate $(f.irate) m^3/s")

# ==(A::jutulVWell{D, T}, B::jutulVWell{D, T}) where {D,T} = (A.irate == B.irate && A.name == B.name && A.loc == B.loc)


# multiple wells
struct jutulVWell{D, T}
    irate::T
    name::Vector{Symbol}
    loc::Vector{NTuple{D, T}}
    startz
    endz
end

# Constructor for a single well
jutulVWell(irate::T, loc::NTuple{D, T}; startz=nothing, endz=nothing) where {D, T} = 
    jutulVWell(irate, [:Injector], [loc], startz, endz)

# Constructor for multiple wells
jutulVWell(irate::T, locs::Vector{NTuple{D, T}}; startz=nothing, endz=nothing) where {D, T} = 
    jutulVWell{D+1, T}(irate, vcat(:Injector for _ in 1:length(locs)), locs, startz, endz)

display(f::jutulVWell{D, T}) where {D, T} =
    println("$(D)D jutulVWell structure with $(length(f.loc)) wells and rate $(f.irate) m^3/s")

==(A::jutulVWell{D, T}, B::jutulVWell{D, T}) where {D,T} = 
    (A.irate == B.irate && A.name == B.name && A.loc == B.loc)
