using Markdown
md1 = md"""
---
title: Brief report on decision tree training (0x15b03b01222fec37)
author: Tsung-Hsi, Wu
date: 2022-03-16
---

This report is the brief summary of executing `"myexperiment.jl"` in trial `"0x15b03b01222fec37"`, at the time 2022-03-16T17:05:40.047. For the resultant data, see files in `"RESULT_ExpeDeci_0x15b03b01222fec37"`.

## Description Hello `code` *it* aaa-bbb45 **BolD haha `mia`**
### Keynotes
- Preprocessing: Impute missing values with mean.
 - Irrelevant time features ("year", "day", "minute",...) are removed.
 - Size of the training time window is changed

### Hyperparameters
#### Resampling
- `TimeSeriesCV` is applied with 24 folds.

#### Partitioning
80.0% of data is applied for training and validation, and 20.0% of data is for testing.


#### Tree depths
20 ≤ max_depth ≤ 100

#### Data shift
The past **240-minutes** ($t_{-24,...,-1}$) data are applied for predicting the future **10-minutes** ($t_{+1}$) SWC.


### Features
For training:
- month: $t_{i=-24,-23,...,-1}$ (total 24)
- hour: $t_{i=-24,-23,...,-1}$ (total 24)
- precipitation: $t_{i=-24,-23,...,-1}$ (total 24)
- air temperature: $t_{i=-24,-23,...,-1}$ (total 24)
- Soil temperature 10cm: $t_{i=-24,-23,...,-1}$ (total 24)
- Soil temperature 30cm: $t_{i=-24,-23,...,-1}$ (total 24)

To Predict:
- `"Soil_water_content_10cm_t"`

## Result
### Performance－Tree Depth
![](tuned_max_depth.png)

### Predict Result
- Best maximum depth is 33.
![](predict_result.png)
"""


@testset "collect.jl: islevelleq, islevel" begin
    @test OkMD.islevel(md1.content[4], 2)
    @test OkMD.islevelleq(md1.content[4], 3)
    @test OkMD.islevelleq(md1.content[4], 4)
    @test OkMD.islevelleq(md1.content[4], 5)
    @test !OkMD.islevelleq(md1.content[4], 1)

    @test OkMD.islevel(md1.content[16], 3)
    @test OkMD.islevelleq(md1.content[16], 3)
    @test OkMD.islevelleq(md1.content[16], 4)
    @test OkMD.islevelleq(md1.content[16], 5)
    @test !OkMD.islevelleq(md1.content[16], 2)
    @test !OkMD.islevelleq(md1.content[16], 1)
end

@testset "collect.jl: targetrange" begin
    @test isequal(OkMD.targetrange(md1.content, 2, r"Descrip"), 4:20)
    @test isequal(OkMD.targetrange(md1.content, 3, r"Keynot"), 5:6)
    @test isequal(OkMD.targetrange(md1.content, 3, r"Featu"), 16:20)
    @test isequal(OkMD.targetrange(md1.content, 2, r"Result"), 21:length(md1.content))
end

# TODO:
# 1. test islevelleq, islevel with Markdown.Header{2} object e.g., Markdown.Header{2}(Any["Description Hello ", Markdown.Code("", "code"), " ", Markdown.Italic(Any["it"]), " aaa-bbb45 ", Markdown.Bold(Any["BolD haha ", Markdown.Code("", "mia")])])
#
# 2. test targetrange that md1.content[range[end] +1] is Header of same or larger level of header, or the end of the md1.content
#
# Consider add targetrange(md1::Markdown.MD) support.
#
# 3. Test mdobj2str
#
# 4. md1 = Markdown.parse_file("changelog.txt"), targetsection of the section that matches current version number of project.toml. If not matched, simply give warning. Also have a test on not matched case.
#
# 5.echo $(julia --project=@. -e 'string("hello\\nworld") |> print') >> temp.txt (Note the double backslash!) but >> to GITHUB_OUTPUT instead. See https://stackoverflow.com/questions/59191913/how-do-i-get-the-output-of-a-specific-step-in-github-actions
