import Base;
Base.:&(a::Vector, b::Vector) = a .* b
Base.:|(a::Vector, b::Vector) = (a .+ b) - (a .* b)
Base.:~(a::Vector) = 1 .- a

N = 1000000 # количество ячеек
B = 4 # разрядность ячеек

# набор функций по умолчанию пустой
x = zeros(Float64, N, B)
y = copy(x)

# набор функций по умолчанию пустой
f = Array{Function}(undef, N)

# for i in 1:N
#     # просто какая-то функция
#     f[i] = (x) -> x[1,:] & x[3,:] | ~x[1,:] & x[2,:]
# end

# формулы зависимости
f[2] = () -> x[1, :] & x[3, :] | ~x[1, :] & x[2, :]
f[3] = () -> x[1, :] & x[2, :] | ~x[1, :] & x[3, :]

function st(x, y, f)
    for i = 1:N
        if isassigned(f, i)
            y[i, :] = f[i]()
        else
            y[i, :] = x[i, :]
        end
    end
    y, x
end

# первоначальное состояние
x[1, :] = [1, 0, 0, 0]
x[2, :] = [1, 0, 0, 0]

for i = 1:100
    global x, y
    x, y = st(x, y, f)
    # println(x)
end

# println(x)
