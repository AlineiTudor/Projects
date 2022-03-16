clear
%Incarcam datele de identificare si de validare si le reprezentam grafic
%forma datelor de validare ne va indica posibilul ordin al sistemului
%asupra caruia trebuie sa aplicam metoda ARX (deoarece intrarea de validare a sistemului este o treapta si pentru acest
%semnal de intrare cunoastem formele raspunsului unui sistem).
load('iddata-08.mat');
figure(1)
subplot(2,2,1),plot(id.U),title('intrare de identificare');
subplot(2,2,2),plot(id.Y),title('iesire de identificare');
subplot(2,2,3),plot(val.U),title('intrare de validare');
subplot(2,2,4),plot(val.Y),title('iesire de validare');
%Dupa observarea formei datelor de validare am identificat ordinul
%sistemului ca fiind 1.
% na=1;%numarul de zerouri 
% nb=1;%numarul de poli
nk=1;%intarzierea
m_max=15;%gradul maxim pana la care am considerat aproximatorul
n=5;%ordinul maxim considerat pentru sistem
MSE_predictie_val=zeros(n,m_max);
MSE_simulare_val=zeros(n,m_max);
MSE_predictie_id=zeros(n,m_max);
MSE_simulare_id=zeros(n,m_max);
%Calculam erorile patratice pentru diferite combinatii ale ordinelor si
%gradelor.
for grad=1:n
    y_id_predictie=[];y_val_predictie=[];y_id_sim=[];y_val_sim=[];
    for m=1:m_max
        [y_id_predictie,y_val_predictie,y_id_sim,y_val_sim]=arx_proiect(id,val,grad,grad,nk,m);
        MSE_simulare_val(grad,m)=mean((val.Y-y_val_sim').^2);
        MSE_predictie_val(grad,m)=mean((val.Y-y_val_predictie).^2);
        MSE_predictie_id(grad,m)=mean((id.Y-y_id_predictie).^2);
        MSE_simulare_id(grad,m)=mean((id.Y-y_id_sim').^2);
    end
end

%%
%Apelarea functiei pentru ARX folosind datele care produc cele mai mici erori:
%na=nb=1, nk=1, m=13
clear
load('iddata-08.mat');

[y_id_predictie,y_val_predictie,y_id_sim,y_val_sim]=arx_proiect(id,val,1,1,1,13);
figure(2)
plot(id.Y),hold on,plot(y_id_sim),title('Simulare identificare');

figure(3)
plot(val.Y),hold on,plot(y_val_sim),title('Simulare validare');

figure(4)
plot(id.Y),hold on,plot(y_id_predictie),title('iesire identificare predictie'),hold off;

figure(5)
plot(val.Y),hold on,plot(y_val_predictie),title('predictie validare'),hold off;