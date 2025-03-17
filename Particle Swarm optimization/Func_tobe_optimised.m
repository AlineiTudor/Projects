clear
clc
%multimodal Schwefel function for 2D
fit_func=@(X)(418.9829*2-sum((X.*sin(X))'));

%points=[(-300:15:300)',(-300:15:300)'];
points=[(-20:0.5:20)',(-20:0.5:20)'];
x=points(:,1);
y=points(:,2);
[x,y]=meshgrid(x,y);
func=@(x,y)(418.9829*2-x.*sin(x)-y.*sin(y));
%mesh(x,y,func(x,y),'facecolor','flat');
figure
surf(x,y,func(x,y));
colormap jet

points=[(-20:0.1:20)',(-20:0.1:20)'];
x=points(:,1);
y=points(:,2);
[x,y]=meshgrid(x,y);
figure
contour(x,y,func(x,y)),hold on

%%
%pso algorithm
search_space=[-18 18;-18 18];%we put the bounds inside the contour
n_particles=25;
wmin=0.2;
wmax=0.9;
c1=2;
c2=2;
max_iter=1000;
eps=0.1;
[xmin,minval]=pso(fit_func,search_space,n_particles,wmin,wmax,c1,c2,max_iter,eps);
xmin
minval

