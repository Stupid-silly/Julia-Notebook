x =[3.0    3.1    3.2    3.3    3.4    3.5    3.6    3.7    3.8    3.9]
y =[20.08  22.30  24.53  27.12  29.96  33.11  36.60  40.45  44.70  49.40]
N=length(x)
#导入数据
#
#
x1,x2 = extrema(x)
xx = x1 : 0.01 : x2
yy = zero(xx)
#预计绘图使用自变量xx,因变量yy,
#
#
#
#
#
#
#目标是求解a, b, c, d向量
a = zeros(N)
b = zeros(N-1)
c = zeros(N)
d = zeros(N-1)
h = zeros(N-1)
#
for i in 1:N-1
    h[i] = x[i+1] - x[i]
end
a = y#为什么不能是a .= y？？？
#求a向量
#
#
A = zeros(N,N)
B = zeros(N)
#声明矩阵，将要求解方程
A[1,1] = 2*h[1]
A[1,2] = h[1]
A[N,N] =2*h[N-1]
A[N,N-1]=h[N-1]
B[1] = 3.0*(a[2]-a[1])/h[1]
B[N] = -3.0*(a[N]-a[N-1])/h[N-1]
#赋值
for i in 2:N-1
    A[i,i-1] = h[i-1]
    A[i,i] = 2.0*(h[i-1]-h[i])
    A[i,i+1] = h[i]
    B[i] = 3.0*(a[i+1]-a[i])/h[i] - 3.0*(a[i]-a[i-1])/h[i-1]
end
#
#以下开始求解
#c = A\B 代表解方程 A*c=B 中的向量c
c = A\B
#完毕，得到c向量
#
#
#继续解b, d
for i in 1:N-1
    b[i] = (a[i+1]-a[i])/h[i] - h[i]/3.0*(c[i+1]+2*c[i])
    d[i] = (c[i+1]-c[i])/3.0/h[i]
end
#求解完毕，解得每一段的系数组成的向量
#
#
#
#
#
#
#
#_x是未知点，a,b,c,d已经求解，x是自变量
function get_cubic_data(_x,a,b,c,d,x)
    r = a[1]
    for i in 1 : N-1
        if _x < x[i+1]
            r = a[i] + b[i]*(_x-x[i]) + c[i]*(_x-x[i])^2 + d[i]*(_x-x[i])^3
            return r
        end
    end
    return a[N]
end
#
#
#
#
#
#计算导数
f(_x) = get_cubic_data(_x,a,b,c,d,x)
der(fun,x)=(fun(x)-fun(x-0.01))/0.01
der(f,3.45)
der(exp,3.45)
#计算结果
#der(f,3.45)=50.860999999999024
#der(exp,3.45)=31.34341404384635
#
#
#
#计算积分
#b积分上限, a积分下限
function Intgr(fun,a,b)
    i=0
    for x in a:0.01:b-0.01
        i += f(x)*0.01
    end
    return i
end
#
#
Intgr(f,3.3,3.6)
Intgr(exp,3.3,3.6)
#计算结果
#Intgr(f,3.3,3.6)  =9.448404999999998
#Intgr(exp,3.3,3.6)=9.448404999999998
#
#
#
#
#
#
#
#
#
#
#
