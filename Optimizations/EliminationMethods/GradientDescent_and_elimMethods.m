a=-4;b=0;
int=a:0.01:b;
f1=@(x)(x.^4-3*x.^2);


eps=1e-6;
interv_gs=elim_gs(f1,[a b],eps);
interv_fib=elim_fib(f1,[a b],eps);
figure
plot(int,f1(int)),hold on,
plot((interv_gs(1)+interv_gs(2))/2,f1((interv_gs(1)+interv_gs(2))/2),'r*');

f2=@(x)(x(1).*x(2)+x(1).^2*x(2).^2+5*x(1).^2+1)
d1=[1;1];
x0=[-2;2]
int_s1=[-40 40];
eps=1e-3;
f_s1=@(s)(f2(x0+s*d1));
interv_s1=elim_gs(f_s1,int_s1,eps);
pct_min=(interv_s1(1)+interv_s1(2))/2
int_plt=int_s1(1):0.1:int_s1(2);
figure
func_val=[]
for i=1:length(int_plt)
    func_val=[func_val,f2(x0+int_plt(i)*d1)];
end
figure
plot(int_plt,func_val),hold on
plot(pct_min,f2(x0+pct_min*d1),'r*');

