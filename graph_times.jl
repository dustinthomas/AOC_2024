using GLMakie
using CSV, DataFrames

py_df = CSV.read("times_py.csv", DataFrame)
julia_df = CSV.read("times_julia.csv", DataFrame)

julia_times = julia_df.sec
py_times = py_df.sec

scatter(julia_times)
scatter!(py_times)