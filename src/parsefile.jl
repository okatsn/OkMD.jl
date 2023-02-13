"""
`read_section(fpath::String, nlevel::Int, exprh::Regex; with_header = true, kwargs...)` read Markdown file `fpath` of Header of `nlevel` matching `exprh`. It takes the same `kwargs` as `targetrange` and `targetsection`.
"""
function read_section(fpath::String, nlevel::Int, exprh::Regex; with_header = true, kwargs...)
    md1 = Markdown.parse_file(fpath)
    ts = targetsection(md1, nlevel, exprh; kwargs...)
    if !with_header
        ts = ts[2:end]
    end
    md0 = md""
    push!(md0.content, ts...)
    return md0
end
