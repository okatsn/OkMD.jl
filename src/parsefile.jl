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


"""
`get_changelog(projectfile, logfile, nlevel; kwargs...)` get the target section of `logfile` that matches the version number in `projectfile`, where the version number is assumed to be in the header of `nlevel`.
"""
function get_changelog(projectfile, logfile, nlevel; kwargs...)
    d = TOML.parsefile(projectfile)
    verstr = d["version"]
    exprh = Regex(replace(verstr, "." => "\\."))
    read_section(logfile, nlevel, exprh; kwargs...)
end


"""
Expression that matches item bullet of asterisk.
"""
const expr_item = r"(\A\s*)\* "
const expr_sstr = s"\1- "

"""
`plain_string(md2::Markdown.MD)` convert item bullet of asterisk (`*`) into `-`.

# Example
```julia
using Markdown, OkMD
md2 = \"\"\"
Changelog
- v0.1.0
\"\"\"

open("changelog_for_test.md", "w") do io
    write(io, OkMD.plain_string(md2))
end
```
"""
function plain_string(md2::Markdown.MD)
    strv = split(string(md2), "\n")
    strv1 = replace.(strv, expr_item => expr_sstr)
    join(strv1, "\n")
end
