clear 
clc
syms x y real
func=x^2+3*y+2*x*y^4;
% dfdx=jacobian(func,[x y]);
% H=jacobian(dfdx,[x y]);
x0=[1 2];
e_x=1e-3;
e_func=1e-8;
[x_extr,extr_type,n_iter]=newton_met(x0,e_x,e_func,func,[x y]');

dfdx=jacobian(func,[x y]);
H=jacobian(dfdx,[x y]);
det(eval(subs(H,[x y],x0)))

x=-1:0.01:1;
y=-1:0.01:1;
% x=-1000:2000;
% y=-1000:2000;
f=@(x,y)(x.^2+3.*y+2.*x.*y.^4);
[x y]=meshgrid(x,y);
figure
mesh(x,y,f(x,y)),xlabel('x'),ylabel('y'),zlabel('z');
figure
contour(x,y,f(x,y)),hold on, plot(x_extr(1),x_extr(2),'rx');

function [x,extremum_type,n_iter]=newton_met(x0,e_x,e_func,func,variables)
%adaptara metodei newton pentru cazul cand det(H)->0 si pastram
%valoarea anterioara a Hessianului

%x0->starting point
%e_x->diferenta acceptata intre x_k+1 si x_k intre doua iteratii
%e_func->diferenta acceptata intre f(x_k+1) si f(x_k) intre doua iteratii
%func->simbolic function
%simbolic variables of function func as array of simbols
x=[];
for i=1:length(variables)
    x=[x,variables(i)];
end
a=variables;
dfdx=jacobian(func,variables);
H=jacobian(dfdx,variables);
H_eval=subs(H,x,x0);
H_eval=eval(H_eval);
%daca valoarea determinantului este foarte mica
if abs(det(H_eval))<1e-7
    warning("Initial condition for H is close to an extremum."+newline+"Continuing iterations with first Hessian computed.");
end
dfdx_value=eval(subs(dfdx,x,x0));
dfdx_value=dfdx_value';
dfdx_norm=norm(dfdx_value);
x_prev=x0';
H_prev=H_eval;
n_iter=0;
while 1
    x=[];
    for i=1:length(variables)
        x=[x,{variables(i)}];
    end
    
    n_iter=n_iter+1;
    
    x_c=x_prev-H_eval^-1*dfdx_value;
    
    if abs(det(eval(subs(H,x,x_c'))))>=1e-7
        H_eval=eval(subs(H,x,x_c'));
    end
    
    dfdx_value=eval(subs(dfdx,x,x_c'));
    dfdx_value=dfdx_value';
    dfdx_norm=norm(dfdx_norm);
    
    if norm(x_c-x_prev)<=e_x || dfdx_norm<e_func || i>10000
        H_eig=eig(eval(subs(H,x,x_c')));
        if sum(H_eig>0)==length(H_eig)
            type='Local minimum';
        elseif sum(H_eig<0)==length(H_eig)
            type='Local maximum';
        elseif sum(H_eig<0)+sum(H_eig>0)==length(H_eig)
            type='Saddle point';
        else
            type='Unknown';
        end
        break;
    end
    
    x_prev=x_c;
    
end
extremum_type=type;
x=x_c;
end