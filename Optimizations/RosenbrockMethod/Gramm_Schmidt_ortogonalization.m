function [directions_new] = Gramm_Schmidt_ortogonalization(directions,distances)
%Gram_Schmidt_ortogonalization for Rosenbrock optimization algorithm
    n=length(directions);
    for i=1:n
        a(:,i)=sum( directions(:,i:end).*distances(i:end),2 );
    end
    %computing new orthogonal normed directions
    b=[a(:,1)];
    directions_new=b(:,1)/norm(b(:,1));
    for i=2:n
        val=zeros(n,1);
        for j=1:i-1
            val=val+a(:,i)'*b(:,j)/norm(b(:,j))^2*b(:,j);
        end
        b(:,i)=a(:,i)-val;
        directions_new=[directions_new,b(:,i)/norm(b(:,i))];
    end
end



