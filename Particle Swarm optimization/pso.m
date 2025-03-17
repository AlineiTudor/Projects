function [xmin,minval]=pso(func,search_space,n_particles,wmin,wmax,c1,c2,max_iter,eps)
    %search_space is a matrix Nx2 with N being the number of values for
    %each particle in X by 2 which are upper and lower bounds of search
    %space.
    %eps is an epsilon which describes the minimum required distance
    %between the last best fitness value and the current best fitness value. 
    %If the current best minus the last best fitness value objective function 
    %is less than eps the altgorithm stops.
   
    
    %The weight (inertia coeff) decreases liniarli from 0.9 to 0.2 with
    %each iteration
    dim=size(search_space);
    N=dim(1);
    %get the upper and lower bounds of search_space
    lb=search_space(:,1);
    ub=search_space(:,2);
    
    %------plot contour for a 2 variable fitness function------
    %do it inside the script
    
    %------initialization------
    r1=rand();
    r2=rand();
    w=wmax;%w decreases liniarly to w_min
    X=[];%matrix with particles
    V=[];%matrix with velocities
    X=zeros(n_particles,N);
    %init position
    for i=1:n_particles
        for j=1:N
            X(i,j)=lb(j)+rand*(ub(j)-lb(j));
        end
    end
%     plot(X(:,1),X(:,2),'k*')
%     return
    %init velocity
    V=0.1*X;%instead of 0.1 we could use another const
    %initialize best particle with best fitness value (x_global is vector)
    [best_val,index_best]=min(func(X));
    x_global=X(index_best,:);
    %initialize local best for each X (here we have a matrix)
    best_local=func(X);
    x_local=X;  
    
    %-----pso begins-----
    k=1;
    last_global_update=0;
    max_iter_glob_upd=50;
    %alter best_val to enter the pso algorithm
    best_val=best_val+3*eps;
    while k<=max_iter
        
        %Stopping criteria: a specified number of iterations have passed
        %since last global update was done
        last_global_update=last_global_update+1;
        if last_global_update==max_iter_glob_upd
            %to keep last particles on contour for 2 variable function
            if N==2
                p=plot(X(:,1),X(:,2),'k*');
            end
            break
        end
        
        %check if distance between all particles is 
        %higher than the treshold eps
%         test=0;
%         for i=1:n_particles           
%             if norm(x_local(i,:)-x_global)<=eps
%                 test=test+1;
%             end
%         end
%         if test==n_particles
%             %to keep last particles on contour for 2 variable function
%             if N==2
%                 p=plot(X(:,1),X(:,2),'k*');
%             end
%             break
%         end


        %update position
        X=X+V;
        %optional, reinitialize points which go outside the search space
        for i=1:n_particles
            for j=1:N
                if X(i,j)<lb(j) || X(i,j)>ub(j)
                    %randomly reinitialize particle
                    %X(i,j)=lb(j)+rand*(ub(j)-lb(j));
                    
                    %reinitialize particle with best particle
                    X(i,j)=x_global(j);
                end
            end
        end
        
        %compute fitness for each particle
        fit=func(X);
        %compute global best considering a minimization problem;
        [best_val2,index_min]=min(fit);
        if best_val2<best_val
            last_global_update=0;
            x_global=X(index_min,:);
            best_val=best_val2;
        end
        %compute the local best for each particle
        local_val=func(X);
        new_best_local=local_val<best_local;
        new_best_local_index=find(new_best_local);
        x_local(new_best_local_index,:)=X(new_best_local_index,:);
        best_local(new_best_local_index)=local_val(new_best_local_index);
        %update velocity
%         size(X)
%         size(V)
%         size(best_local)
%         size(x_global)
        V=w*V+c1*r1*(x_local-X)+c2*r2*(x_global-X);
        
        r1=rand();
        r2=rand();
        if w>=wmin
            w=wmax-k/300;
        end
        if N==2
            p=plot(X(:,1),X(:,2),'k*');
            pause(0.3);
            set(p,'visible','off')
            %hold off
        end
        k=k+1;
        
    end
    xmin=x_global;
    minval=best_val;
end

