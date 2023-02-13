module OkMD

# Write your package code here.
using Markdown
include("collect.jl")
export targetrange, targetsection

include("parsefile.jl")
end
