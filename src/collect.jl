myflat(v) = [v]
"""
Flatten nested vectors to a vector of strings.
"""
myflat(v::Vector) = vcat(myflat.(v)...)


getheaderstr(obj::Markdown.Code) = obj.code
getheaderstr(obj::Union{Markdown.Bold, Markdown.Link, Markdown.Italic}) = getheaderstr(obj.text)
getheaderstr(obj::String) = obj
"""
Given a vector Any, `getheaderstr(v::Vector)` returns a (nested) strings of plain string, `code`, `text` field of `Markdown.___.text`.
"""
getheaderstr(v::Vector) = getheaderstr.(myflat(v))
getheaderstr(obj) = string(obj)

"""
`stripheaderstring(mdhd::Markdown.Header)` returns plain string concatenating the `text` or `code` field in `Markdown` container objects of format (i.e., `Markdown.Code`, `Markdown.Link`, `Markdown.Italic`, `Markdown.Bold`).

See also `OkMD.getheaderstr`, `OkMD.myflat`.
"""
stripheaderstring(mdhd::Markdown.Header) = join(myflat(getheaderstr.(mdhd.text)),"")

"""
Given a object `mdc`, `islevel(mdc, n)` returns true if `mdc` is the type of `Markdown.Header{n}`
"""
function islevel(mdc, n)
    return isa(mdc, Markdown.Header{n})
end

"""
Given a object `mdc`, `islevelleq(mdc, n)` returns true if `mdc` is the type of `Markdown.Header{x}` where `x ≤ n`. In brief, it recursively finds if it is a header of higher level (smaller `n`) until `n==0` (`false` is returned).
"""
function islevelleq(mdc, n)
    # do_next = true
    # while n > 0 && do_next
    #     do_next = !islevel(mdc, n)
    #     n = n - 1
    # end
    # isleq = !do_next
    # return isleq
    if n == 0
        return false
    elseif islevel(mdc, n)
        return true
    else
        islevelleq(mdc, n - 1)
    end
end

"""
`headlevel(::Markdown.Header{n})` returns `n`.
"""
headlevel(::Markdown.Header{n}) where n = n

"""
Given a `Vector`, `targetrange(mdcs::Vector, nlevel, exprh::Regex; which_one = only)` find the target `Markdown.Header{nlevel}` object whose content matches `exprh`, returning a range which starts from this header until (but not include) the next header `Markdown.Header{nlevelnext}` where `nlevelnext ≤ nlevel`.

By default, if there is no or more than one header of `nlevel` matching `exprh`, error will be raised by `which_one = only`. You can assign `which_one = last` for example to get the last matched section.

Also see `islevel`, `islevelleq` and `targetsection`.
"""
function targetrange(mdcs::Vector, nlevel, exprh::Regex; which_one = only)
    ismatchlevel = islevelleq.(mdcs, nlevel)
    lenlv = length(ismatchlevel) # length of md1::MD.content
    thatlv = ismatchlevel |> findall # the number in the whole range of mdcs that is `nlevel` Header.
    target_h_n = occursin.(exprh, stripheaderstring.(mdcs[thatlv])) |> id -> thatlv[id] |> which_one # the only number indexing to the matched header in the vector mdcs.

    # @assert length(target_h_n) != 1 "Zero or multiple matches."

    findfrom = target_h_n
    findafter = target_h_n < lenlv ? target_h_n + 1 : lenlv
    nextheader = findnext(ismatchlevel, findafter)
    if isnothing(nextheader)
        finduntil = lenlv
    else
        finduntil = nextheader - 1
    end
    return findfrom:finduntil
end

"""
Given a `Markdown.MD` object, `targetsection(md1::Markdown.MD, nlevel, exprh)` returns the section (which is a `Vector`) that starts with the `Markdown.Header{nlevel}` object whose content matches `exprh` and ends until the next header `Markdown.Header{nlevelnext}` where `nlevelnext ≤ nlevel`.

Also see `targetrange`.
"""
function targetsection(md1::Markdown.MD, nlevel, exprh; kwargs...)
    mdcs = md1.content
    tr = targetrange(mdcs, nlevel, exprh; kwargs...)
    return mdcs[tr]
end
