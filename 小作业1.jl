using Plots
using LinearAlgebra
#包的调用
#P是人口（自变量），V是速度（因变量）
P = [ 341948 1092759 5491 49375 1340000 365  2500 78200 867023 14000 23700 70700 304500 138000 2602000 ]
V = [ 4.81   5.88    3.31 4.90  5.62    2.76 2.27 3.85  5.21   3.70  3.27  4.31  4.42   4.39   5.05 ]
#
logP=log.(P)
logV=log.(V)
#计算结果为：
#logP = [12.7424  13.9042  8.61087  10.8072  14.1082  5.8999  7.82405  11.267
#  13.6728  9.54681  10.0732  11.1662  12.6264  11.835  14.7718]
#logV = [ 1.5707  1.77156  1.19695  1.58924  1.72633  1.01523  0.81978  1.34807
#  1.65058  1.30833  1.18479  1.46094  1.48614  1.47933  1.61939]
#
#
#
scatter(logP,logV)
savefig("logP,logV散点图.png")
#绘制散点图
#
#最小二乘法计算函数
function LstSqrMthd(X,Y)
    z = fill(1.0,length(Y))
    a0 = (dot(z,Y)*dot(X,X)-dot(X,Y)*dot(z,X))/(dot(z,z)*dot(X,X)-dot(z,X)*dot(z,X))
    a1 = (dot(z,z)*dot(X,Y)-dot(z,Y)*dot(z,X))/(dot(z,z)*dot(X,X)-dot(z,X)*dot(z,X))
    return a0,a1
end
#
#
#
a0 = LstSqrMthd(logP,logV)[1]
a1 = LstSqrMthd(logP,logV)[2]
fit=x->a0 + a1*x
x = 6:0.1:14
plot!(x,fit.(x))
savefig("最小二乘拟合.png")
#拟合曲线
#验证发现符合
#
#
#
#
#
#对比拟合情况，
#P_是绘图的自变量
#V_是绘图的因变量
scatter(P,V)
savefig("PV散点图.png")
#V=exp(a0)*P.^a1
Fit = x -> exp(a0)*x^a1
P_ = 0:1e4:2.5e6
V_ = Fit.(P_)
plot!(P_,V_)
savefig("PV的拟合.png")
#对比完成
#
#
#
#
#开始检验表格数据
V_check = Fit.(P)
#计算结果
#V_check =
#[ 4.74821  5.30854  3.1934  3.94308  5.41352  2.46157  2.96104  4.12107
#5.1919  3.49366  3.67478  4.08137  4.69563  4.35204  5.76967]
#
#
#开始计算伯恩斯坦残差
BError = abs.(V_check-V)
#计算结果：BError =
#[0.0617881  0.571465  0.116598  0.956917  0.206482  0.29843  0.691044  0.271066
# 0.0181036  0.206341  0.404777  0.228635  0.275628  0.0379559  0.719666]
