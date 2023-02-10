mdobj2str(mdc) = join(string.(mdc.text),"")

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
Given a `Vector`, `targetrange(mdcs::Vector, nlevel, exprh::Regex)` find the target `Markdown.Header{nlevel}` object whose content matches `exprh`, returning a range which starts from this header until (but not include) the next header `Markdown.Header{nlevelnext}` where `nlevelnext ≤ nlevel`.

Also see `islevel`, `islevelleq` and `targetsection`.
"""
function targetrange(mdcs::Vector, nlevel, exprh::Regex)
    ismatchlevel = islevelleq.(mdcs, nlevel)
    lenlv = length(ismatchlevel) # length of md1::MD.content
    thatlv = ismatchlevel |> findall
    target_h_n = occursin.(exprh, mdobj2str.(mdcs[thatlv])) |> id -> thatlv[id] |> only
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
function targetsection(md1::Markdown.MD, nlevel, exprh)
    mdcs = md1.content
    tr = targetrange(mdcs, nlevel, exprh)
    return mdcs[tr]
end
