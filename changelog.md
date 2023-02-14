# Changelog

## v0.1.0
- Not any function available yet.
- CIs worked successfully.

## v0.1.1
- Function `targetsection` and `targetrange` for retrieve the section from an `Markdown.MD` object.
- Functions for checking the level of `Markdown.Header` (e.g., `islevel`).

## v0.2.2
### Features
New features 
- `get_changelog` gets the target changelog for the current version number.
- `read_section` reads a target section from a `.md` file.
- `plain_string` convert an `Markdown.MD` to a plain string.

Subfunctions
- `stripheaderstring` strip strings recursively from `text` and `code` field of `Markdown.___` objects.
- `myflat` flattens any nested vector.
- `getheaderstr` gets the vector of plain strings of the markdown object.
- `headlevel` returns the level of an header

Upgrade
- `targetrange`, `targetsection` with option `which_one` for handling multiple targets.

### Tests
- `@testset "parsefile.jl"`
- `@testset "collect.jl: targetrange"`
