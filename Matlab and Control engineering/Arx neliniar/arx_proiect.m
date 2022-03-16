function [y_id_predictie,y_val_predictie,y_id_sim,y_val_sim] = arx_proiect(id,val,na,nb,nk,m)
%Am realizat o functie care calculeaza predictia si simularea prin metoda
%ARX neliniar atat pentru datele de identificare cat si pentru cele de
%validare.
%Functia are ca parametri de intrare datele de identificare, validare,
%numarul de zerouri na, numarul de poli nb, intarzierea nk si gradul
%aproximatorului polinomial m.
y_id_sim=[];%vecorul pentru simularea identificarii
y_val_sim=[];%vector pentru simularea datelor de validare
y_id_predictie=[];%vector pentru predictia identificarii
y_val_predictie=[];%vectorul pentru predictia datelor de validare
N=length(id.U);
a=[];
b=[];

puteri=0:m;%construim un vectori cu puteri de la 0 la m: [0 1 2....m]
x=cell(1,na+nb);%construim un cell array (o matrice cu matrici) de dimensiune 1x(na+nb).
%Avem na+nb astfel de matrici, deoarece cu ajutorul functiei polnvar2() vom
%genera un produs cartezian (din care vom scoate liniile de exponenti a caror suma este mai mare decat gradul maxim m) 
%pentru na+nb seturi egale cu [0 1 2...m], care
%vor reprezenta puterile la care vom ridica fiecare dintre regresorii de
%baza [y(k-1),y(k-2),....,y(k-na),u(k-nk),u(k-nk-1),...,u(k-nk-nb+1)].
for k=1:na+nb
    x{k}=puteri;
end

puteri=polnvar2(x,m);%Liniile acestei matrice vor fi de forma [p1 p2 p3...p_(na+nb)], unde
%p1+p2+...+p_(na+nb)<=m;
%PREDICTIA DATELOR DE IDENTIFICARE
for k=1:N%k reprezinta indicele liniei din matricea de regresori pe care o construim.
    %Vom avea atatea linii cate esantioane vom avea in datele de
    %intrare/iesire.
    a=[];
    b=[];
    %Construim vectorul a ce va contine intrarile intarziate de forma
    %[y(k-1),y(k-2),....,y(k-na)]
    for i=1:na
        if(k-i<=0)%daca valoarea indexului k-i este mai mica sau egala decat 0,
            %vom considera ca iesirea sistemului este 0.
            a=[a,0];
        else
            a=[a,id.Y(k-i)];
        end
    end
    %La vectorul mai sus construit vom adauga intrarile intarziate ale
    %sistemului:[u(k-nk),u(k-nk-1),...,u(k-nk-nb+1)].Astfel vom obtine urmatorul vector cu 
    %iesiri si intrari intarziate: [y(k-1),y(k-2),....,y(k-na),u(k-nk),u(k-nk-1),...,u(k-nk-nb+1)].
    for i=0:nb-1
        if(k-i-nk<=0)%vom considera intrarile la momentul 0 si inainte de momentul 0 ca fiind egale cu 0.
            a=[a,0];
        else
            a=[a,id.U(k-i-nk)];
        end
    end
    
    b1=a.^puteri;%ridicam fiecare termen din vectorul a la puterea pi corespunzatoare din matricea de puteri
    %construita mai sus
    b=prod(b1');%inmultim elementele de pe fiecare linie din din matricea b1 si astfel obtinem regresorii x1^p1*x2^p2*...*xn^pn.
    %A fost nevoie de transpusa matricei b1, fiindca functia prod()
    %realizeaza produsul elementelor de pe aceeasi coloana de pe o matrice iar elementele noastre sunt plasate pe linii.
    S1(k,:)=b;%Adaugam vectorul b mai sus construit la linia curenta k din matricea de regresori S1
end
T=S1\id.Y(:);%Folosim operatorul "\" pentru a rezolva sistemul si a afla parametrii T ai modelului ARX.
y_id_predictie=S1*T;%Realizam predictia pentru datele de identificare.

%PREDICTIA DATELOR DE VALIDARE
%Reluam acelasi algoritm explicat mai sus pentru predictia identificarii, 
%doar ca de aceasta data vectorul de iesiri folosit va fi cel pentru datele de validare.
N2=length(val.U);
for k=1:N2
    a=[];
    b=[];
    for i=1:na
        if(k-i<=0)
            a=[a,0];
        else
            a=[a,val.Y(k-i)];
        end
    end
    for i=0:nb-1
        if(k-i-nk<=0)
            a=[a,0];
        else
            a=[a,val.U(k-i-nk)];
        end
    end
    
    b2=a.^puteri;
    b=prod(b2');
    S2(k,:)=b;
end

y_val_predictie=S2*T;%calculam predictia pentru datele de validare folosindu-ne de parametrii T calculati anterior
%prin procedeul de regresie.

%SIMULAREA DATELOR DE IDENTIFICARE
a=[];
b=[];
%Realizam simularea sistemului necunoscand valoarea iesirilor,
%determinandu-le pornind doar de la intrari, iar apoi folosindu-ne si de
%iesirile anterior determinate.
for k=1:length(id.U)
    a=[];
    b=[];
    %Asemenea predictiei, in vectorul a vom avea iesirile intarziate de
    %forma [y_sim(k-1),...,y_sim(k-na),u(k-nk),...,u(k-nb-nk+1)]. De observat
    %ca acum nu ne mai folosim de valoarea iesirii oferite in datele
    %initiale, ci de valorile determinate de noi la pasii anteriori.
     for i=1:na
        if(k-i<=0)
            %Consideram iesirile dinainte de momentul 0 si la momentul 0
            %egale cu 0, altfel alipim vectorului a[] valorile anterior simulate pentru iesire y_sim.
            a=[a,0];
        else
            a=[a,y_id_sim(k-i)];%alipim lui a iesirile simulate anterior: [y_sim(k-1),...,y_sim(k-na)].
        end
     end
     for i=0:nb-1
        if(k-i-nk<=0)
            a=[a,0];
        else
            a=[a,id.U(k-i-nk)];%Concatenam la vectorul de regresori de baza intrarile intarziate [u(k-nk),...,u(k-nb-nk+1)].
        end
     end
    
    b3=a.^puteri;%reluam pasul de creare a regresorilor explicat in partea de simulare.
    b=prod(b3');
    y_id_sim=[y_id_sim,b*T];%construim treptat vectorul de iesire simulat y_sim 
    %inmultind vectorul ce contine combinatiile de regresori de tip 
    %polinomiali x1^p1*...*xn^pn de grad p1+p2+...+pn<=m cu vectorul de
    %parametri T determinati in prima parte a functiei.
  
end 


%SIMULAREA DATELOR DE VALIDARE
%Pentru validare, aplicam acelasi algoritm explicat mai sus pentru partea
%de simulare a identificarii.
a=[];
b=[];

for k=1:length(val.u)
    a=[];
    b=[];
    for i=1:na
        if(k-i<=0)
            a=[a,0];
        else
            a=[a,y_val_sim(k-i)];
        end
    end
    for i=0:nb-1
        if(k-i-nk<=0)
            a=[a,0];
        else
            a=[a,val.U(k-i-nk)];
        end
    end
    
    b4=a.^puteri;
    b=prod(b4');
    y_val_sim=[y_val_sim,b*T];
end

end

