var documenterSearchIndex = {"docs":
[{"location":"","page":"Home","title":"Home","text":"CurrentModule = OkMD","category":"page"},{"location":"#OkMD","page":"Home","title":"OkMD","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Documentation for OkMD.","category":"page"},{"location":"","page":"Home","title":"Home","text":"","category":"page"},{"location":"","page":"Home","title":"Home","text":"Modules = [OkMD]","category":"page"},{"location":"#OkMD.islevel-Tuple{Any, Any}","page":"Home","title":"OkMD.islevel","text":"Given a object mdc, islevel(mdc, n) returns true if mdc is the type of Markdown.Header{n}\n\n\n\n\n\n","category":"method"},{"location":"#OkMD.islevelleq-Tuple{Any, Any}","page":"Home","title":"OkMD.islevelleq","text":"Given a object mdc, islevelleq(mdc, n) returns true if mdc is the type of Markdown.Header{x} where x ≤ n. In brief, it recursively finds if it is a header of higher level (smaller n) until n==0 (false is returned).\n\n\n\n\n\n","category":"method"},{"location":"#OkMD.targetrange-Tuple{Vector, Any, Regex}","page":"Home","title":"OkMD.targetrange","text":"Given a Vector, targetrange(mdcs::Vector, nlevel, exprh::Regex) find the target Markdown.Header{nlevel} object whose content matches exprh, returning a range which starts from this header until (but not include) the next header Markdown.Header{nlevelnext} where nlevelnext ≤ nlevel.\n\nAlso see islevel, islevelleq and targetsection.\n\n\n\n\n\n","category":"method"},{"location":"#OkMD.targetsection-Tuple{Markdown.MD, Any, Any}","page":"Home","title":"OkMD.targetsection","text":"Given a Markdown.MD object, targetsection(md1::Markdown.MD, nlevel, exprh) returns the section (which is a Vector) that starts with the Markdown.Header{nlevel} object whose content matches exprh and ends until the next header Markdown.Header{nlevelnext} where nlevelnext ≤ nlevel.\n\nAlso see targetrange.\n\n\n\n\n\n","category":"method"}]
}