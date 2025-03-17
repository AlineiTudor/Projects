function [interval] = elim_gs(func,interv,eps)
d=interv(2)-interv(1);
a=interv(1);
b=interv(2);
while b-a>=eps
    d=0.610*d;
    x1=b-d;
    x2=a+d;
    if(func(x1)<=func(x2))
        b=x2;
    else
        a=x1;
    end
end
interval=[a b];
end

