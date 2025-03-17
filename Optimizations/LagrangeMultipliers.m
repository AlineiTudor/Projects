clear
clc

% syms x1 x2 l1 l2
% eq=[x1*x2+l1;x2+x1;x2+x1-4*l2;x1-l1+5*l2];
% sol=solve(eq,[x1 x2 l1 l2]);
% fn=fieldnames(sol);
% soln=[];
% for k=1:numel(fn)
%     soln=[soln,eval(sol.(fn{k}))];
% end

syms x1 x2
f=x1^2+x1*x2+2*x2^2+2*x2+3;
restrict=x1+x2-1;
func_var=[x1;x2];
[points,type,lambdas]=met_Lagrange(f,func_var,restrict);


syms x1 x2 real
f=x1^4+2*x1^2*x2+x1^2+4*x2^2+6*x2;
restr=x1^2+x2^2-1;
func_var=[x1;x2];
[points,type,lambdas]=met_Lagrange(f,func_var,restr);

syms x1 x2 real
f=x1^2*x2^2+113*x1*x2-1;
g=4*x1+3*x2-1;
func_var=[x1;x2];
[points,type,lambdas]=met_Lagrange(f,func_var,g);

function [points,type,lambdas]=met_Lagrange(func,func_var,restrict)
%func is a symbolic function

%func_var is a column vector with the necessary variables

%restrict is a column vector with restriction functions (by default equal
%to 0)

    type=[];%gives the type of extremum points
    n_var=length(func_var);

    %declaring enough lambda params for restrictions
    n_res=length(restrict);
    lam=[];
    for i=1:n_res
        lam=[lam;sym(strcat('l',num2str(i)),'real')];
    end
    
    %constructing Lagrange L function
    L=func+lam'*restrict;
    varL=[func_var;lam];
    
    %computing L jacobian
    dL=jacobian(L,varL);
    
    %computing the extremum points
    sol=solve(dL==0,varL);
    fn=fieldnames(sol);
    sol_num=[];
    for k=1:numel(fn)
        sol_num=[sol_num,eval(sol.(fn{k}))];
    end
    dim=size(sol_num);
    n_sol=dim(1);%number of solutions
    sol_num=sol_num';%each column contains a solution tuple
    
    %computing Hessian for L
    H_L=jacobian(dL,varL);
    
    %making [z*I 0;0 0] matrix
    syms z real
    Z=[z*eye(n_var),zeros(n_var,n_res);zeros(n_res,n_var),zeros(n_res)];
    
%     %preparing variable array to make the subs in H_L
%     var=[];
%     for i=1:length(varL)
%         var=[var;{varL(i)}];
%     end

    %for each solution, compute its type
    for i=1:n_sol
        current_sol=sol_num(:,i);
        %computing value of hessian for the current solution
        H_Ln=eval(subs(H_L,varL,current_sol));
        
        %computing solutions for det(H_L-[z*I 0;0 0])=0
        z_sol=eval(solve(det(H_Ln-Z),z));
        
        if sum(z_sol>0)==length(z_sol)
            type=[type;'Local minimum'];
        elseif sum(z_sol<0)==length(z_sol);
            type=[type;'Local maximum'];
        elseif sum(z_sol==0)~=0
            type=[type;'Undefined'];
        else
            type=[type;'Saddle'];
        end
    end
    points=sol_num(1:n_var,:);
    lambdas=sol_num(n_var+1:end,:);
end