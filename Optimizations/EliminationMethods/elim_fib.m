function [interval] = elim_fib(func,interv,eps)
d=interv(2)-interv(1);
a=interv(1);
b=interv(2);
F1=2;
F2=3;
while b-a>=eps
    d=b-a;
    d=F1/F2*d;
    x1=b-d;
    x2=a+d;
    if(func(x1)<=func(x2))
        b=x2;
    else
        a=x1;
    end
    aux=F2;
    F2=F1+F2;
    F1=aux;
end
interval=[a b];
end