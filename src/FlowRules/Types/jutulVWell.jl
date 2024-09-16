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
export jutulVWell

struct jutulVWell{D, T}
    irate::T
    name::Vector{Symbol}
    loc::Vector
    startz
    endz
end

# Constructor for multiple wells with possible empty producer list
jutulVWell(irate::T, injector_locs::Vector{NTuple{D, T}}, producer_locs::Vector{NTuple{D, T}}=Vector{NTuple{D, T}}(); startz=nothing, endz=nothing) where {D, T} =
    let
        # Define names: injectors followed by producers
        injector_names = [:Injector for _ in 1:length(injector_locs)]
        producer_names = [:Producer for _ in 1:length(producer_locs)]
        names = vcat(injector_names, producer_names)
        
        # Combine injector and producer locations
        loc = vcat(injector_locs, producer_locs)
        
        # Create the jutulVWell instance
        jutulVWell{D+1, T}(irate, names, loc, startz, endz)
    end

# Display function for jutulVWell
display(f::jutulVWell{D, T}) where {D, T} =
    println("$(D)D jutulVWell structure with $(length(f.loc)) wells and rate $(f.irate) m^3/s")

# Equality check for jutulVWell
==(A::jutulVWell{D, T}, B::jutulVWell{D, T}) where {D,T} = 
    (A.irate == B.irate && A.name == B.name && A.loc == B.loc)
