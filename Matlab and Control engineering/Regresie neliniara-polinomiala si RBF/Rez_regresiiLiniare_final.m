clear
load('proj_fit_08.mat')
MSE=[]
for i=1:40%apelul functiei pentru aproximatoare polinomiale pana la gradul 40
[theta,y_aprox_id,y_aprox_val]=regresie(id,val,i);
MSE=[MSE, mean(mean((y_aprox_val-val.Y).^2))];%stocarea erorii medii patratice 
end
plot(1:40,MSE);
[eroare_min,m_min]=min(MSE)
[theta,y_aprox_id,y_aprox_val]=regresie(id,val,m_min);
figure(1)
mesh(id.X{1},id.X{2},id.Y),hold on;
mesh(id.X{1},id.X{2},y_aprox_id),title('Identificare'),xlabel('X1'),ylabel('X2'),zlabel('Y');

figure(2)
mesh(val.X{1},val.X{2},val.Y),hold on;
mesh(val.X{1},val.X{2},y_aprox_val),title('Validare'),xlabel('X1'),ylabel('X2'),zlabel('Y');

[theta,y_aprox_id,y_aprox_val]=regresie(id,val,20);%fenomenul de supraantrenare
figure(3)
mesh(id.X{1},id.X{2},id.Y),hold on;
mesh(id.X{1},id.X{2},y_aprox_id),title('Identificare'),xlabel('X1'),ylabel('X2'),zlabel('Y');

figure(4)
mesh(val.X{1},val.X{2},val.Y),hold on;
mesh(val.X{1},val.X{2},y_aprox_val),title('Validare'),xlabel('X1'),ylabel('X2'),zlabel('Y');