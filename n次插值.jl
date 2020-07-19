using Plots
#导入数据
P = [ 341948.0  1092759  5491  49375   1340000   365   2500  78200   867023 14000 23700 70700 304500 138000 2602000 ]
V = [ 4.81   5.88    3.31 4.90  5.62    2.76 2.27 3.85  5.21   3.70  3.27  4.31  4.42   4.39   5.05 ]
N=length(P)
#
#
p1,p2 = extrema(P)
pp = p1 : 1000.0 : p2
vv = zero(pp)
#预计绘图使用自变量pp,因变量vv,
#
#
#n次插值函数
function get_La_interP_value(X,Y,x)
    #X指的是原始数据的自变量
    #Y指的是原始数据的因变量
    #x指的是预测图像的自变量
    #函数返回值位预测图象的因变量
    @assert length(X) == length(Y)
    y = 0.0
    N = length(X)
    #N指的是自变量向量的长度
    for i in 1 : N
        w = 1.0
        for j in 1:N
            if j != i
                w *= ( x - X[j] ) / ( X[i] - X[j] )#w是y的“系数”
            end
        end
        y += Y[i]*w
    end
    return y
end
#函数没问题
#
#
fit(x) = get_La_interP_value(P,V,x)
for i in 1:N
    vv[i] = fit(pp[i])
end
scatter(P,V)
plot!(pp,vv)
savefig("n次插值.png")
#
#
