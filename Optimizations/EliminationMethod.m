clear
clc

f=@(x)(x^2-3*x+1);
true_min=1.5
inter=[0 10];
prec=0.001;
[min_rand,n_iter_rand]=fminrand(f,inter,prec);
[min_dih,n_iter_dih]=fmindih(f,inter,prec);
%pentru exemplul ales, minimul este gasit in primul caz (x1 si x2 alese aleator)
%dupa 25 de iteratii, iar pentru cautarea dihotona este gasit dupa 14
%iteratii

f=@(x)(x^2+3*x+5);
true_min=-1.5
inter=[-10 0];
prec=0.001;
[min_rand,n_iter_rand]=fminrand(f,inter,prec);
[min_dih,n_iter_dih]=fmindih(f,inter,prec);
%pentru exemplul ales, minimul este gasit in primul caz (x1 si x2 alese aleator)
%dupa 37 de iteratii, iar pentru cautarea dihotona este gasit dupa 14
%iteratii

function [min,n_iter]=fminrand(func,interval,precision)
    a=interval(1);
    b=interval(2);
    e=precision;
    iter=0;
    while b-a>=e
        iter=iter+1;
        x1=a+(b-a)*rand(1,1);
        x2=b-(b-a)*rand(1,1);
        %x1 and x2 not too close to each other
        while abs(x1-x2)<1e-8
            x1=a+(b-a)*rand(1,1);
            x2=b-(b-a)*rand(1,1);
        end
        %check if x1<x2 else swap them
        if x2<x1
            aux=x1;
            x1=x2;
            x2=aux;
        end
        if func(x1)<func(x2)
            b=x2;
        else
            a=x1
        end
    end
    min=(a+b)/2;%return the middle of the interval smaller than the precision where min is found
    n_iter=iter;
end

function [min,n_iter]=fmindih(func,interval,precision)
    a=interval(1);
    b=interval(2);
    e=precision;
    iter=0;
    while b-a>=e
        iter=iter+1;
        x1=a+(b-a)*(0.5-precision);
        x2=b-(b-a)*(0.5-precision);
        if func(x1)<func(x2)
            b=x2;
        else
            a=x1
        end
    end
    min=(a+b)/2;%return the middle of the interval smaller than the precision where min is found
    n_iter=iter;
end