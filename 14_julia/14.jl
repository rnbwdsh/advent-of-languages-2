# dedicated to julia, my favorite girlfriend
function simulate(robots::Vector{Tuple{Complex{Int}, Complex{Int}}}, wrap::Complex{Int}, time::Int)
    area = zeros(Int, (imag(wrap), real(wrap)))
    for (p, v) in robots
        z = p + v * time
        z_imag = mod(imag(z), imag(wrap))
        z_real = mod(real(z), real(wrap))
        area[z_imag + 1, z_real + 1] += 1  # Julia uses 1-based indexing
    end
    return area
end

# Explicitly define the type of robots
robots = Vector{Tuple{Complex{Int}, Complex{Int}}}()
for line in readlines(joinpath(@__DIR__, "14.in"))
    m = match(r"p=(\d+),(\d+) v=(-?\d+),(-?\d+)", line)
    if m !== nothing
        px, py, vx, vy = parse.(Int, m.captures)
        push!(robots, (px + py*im, vx + vy*im))
    end
end

wrap_around = complex(length(robots) <= 30 ? 11 : 101, length(robots) <= 30 ? 7 : 103)

# level a
grid = simulate(robots, wrap_around, 100)
xm, ym = div(real(wrap_around), 2), div(imag(wrap_around), 2)
quadrants = [grid[1:ym, 1:xm], grid[1:ym, xm+2:end], grid[ym+2:end, 1:xm], grid[ym+2:end, xm+2:end]]
println(prod([sum(quad) for quad in quadrants]))

# level b
max_quadrant_sums = [maximum(sum(simulate(robots, wrap_around, i) .> 0, dims=1)) for i in 1:10_000]
println(argmax(max_quadrant_sums))
