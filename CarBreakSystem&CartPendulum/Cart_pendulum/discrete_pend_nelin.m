function [x,y] = discrete_pend_nelin(uk,x0,Ts)
x=[];
x=[x,x0];
for k=1:length(uk)-1
    x=[x,x(:,k)+Ts*cont_pend_nelin(uk(k,:),x(:,k))];
end
y=[x(1,:);x(3,:)];
end

