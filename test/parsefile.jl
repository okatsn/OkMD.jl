@testset "parsefile.jl" begin
    md1 = md"""
    # Changelog

    ## v0.1.0
    - Not any function available yet.
    - CIs worked successfully.

    ## v0.1.1
    - Function `targetsection` and `targetrange` for retrieve the section from an `Markdown.MD` object.
    - Functions for checking the level of `Markdown.Header` (e.g., `islevel`).


    ## v0.2.0
    - Further tests in `islevelleq`, `islevel`
    - New function `stripheaderstring` that strip strings recursively from `text` and `code` field of `Markdown.___` objects.
    """

    open("changelog_for_test.md", "w") do io
        write(io, string(md1))
    end

    ## Test default behavior
    @test try OkMD.read_section("changelog_for_test.md", 2, r"v\d+.\d+.\d+"); catch e; isa(e, ArgumentError) end

    # Test retrieving the first target
    md2 = OkMD.read_section("changelog_for_test.md", 2, r"v\d+.\d+.\d+"; which_one = last)

    ### Test if the header is correct
    @test isa(md2.content[1], Markdown.Header{2})
    @test only(md2.content[1].text) == "v0.2.0"
    @test OkMD.stripheaderstring(md2.content[1]) == "v0.2.0"

    ### Test if the header is disabled
    md2 = OkMD.read_section("changelog_for_test.md", 2, r"v\d+.\d+.\d+"; which_one = last, with_header = false)

    ### Test if the first content is a List object
    theonlylist = first(md2.content)
    @test isa(theonlylist, Markdown.List)
    @test length(theonlylist.items) == 2
    ### Test the first item in the list
    theonlyparagraph = only(theonlylist.items[1]) # of the first item
    @test theonlyparagraph.content[1] == "Further tests in "




    # Test retrieving the first target
    md2 = OkMD.read_section("changelog_for_test.md", 2, r"v\d+.\d+.\d+"; which_one = first)

    ### Test if the header is correct
    @test isa(md2.content[1], Markdown.Header{2})
    @test only(md2.content[1].text) == "v0.1.0"
    @test OkMD.stripheaderstring(md2.content[1]) == "v0.1.0"

    ### Test if the header is disabled
    md2 = OkMD.read_section("changelog_for_test.md", 2, r"v\d+.\d+.\d+"; which_one = first, with_header = false)

    ### Test if the first content is a List object
    theonlylist = first(md2.content)
    @test isa(theonlylist, Markdown.List)
    @test length(theonlylist.items) == 2
    ### Test the first item in the list
    theonlyparagraph = only(theonlylist.items[1]) # of the first item
    @test theonlyparagraph.content[1] == "Not any function available yet."


    rm("changelog_for_test.md")
end
