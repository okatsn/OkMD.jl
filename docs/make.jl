using OkMD
using Documenter

DocMeta.setdocmeta!(OkMD, :DocTestSetup, :(using OkMD); recursive=true)

makedocs(;
    modules=[OkMD],
    authors="okatsn <okatsn@gmail.com> and contributors",
    repo="https://github.com/okatsn/OkMD.jl/blob/{commit}{path}#{line}",
    sitename="OkMD.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://okatsn.github.io/OkMD.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/okatsn/OkMD.jl",
    devbranch="main",
)
