function [theta,y_aprox_id,y_aprox_val] = regresie(data,val,m)
tic

%in matricea regresorilor vom avea toate perechile de forma
%X{1}^p1*X{2}^p2, cu p1+p2<=m
p1=m;%p1 va fi puterea la care il vom calcula pe X{1}
p2=0;%p2 este puterea la care il vom ridica pe X{2}
S=zeros(length(data.X{1})*length(data.X{2}),(m+1)*(m+2)/2);%alocam spatiu petru matricea "regresorilor"

%k va reprezenta indicele coloanei matricei S=Sigma de regresori, coloana
%maxima fiind (m+1)*(m+2)/2
for k=1:(m+1)*(m+2)/2
    ct=1;%contorul ct va itera pe liniile matricei S pana la N1*N2, N1=lungimea lui X{1}, iar N2=lungimea lui X{2}
    
    %iteram prin cele doua matrice pentru a obtine toate combinatiile
    %(X{1}(i),X{2}(j)).
    %Aceste doua for-uri vor calcula practic cate o coloana din matricea S
    %corespunzatoare regresorului X{1}^p1*X{2}^p2, cu p1+p2<=m
    for i=1:length(data.X{1})
        for j=1:length(data.X{2})
            b=data.X{1}(i)^p1.*data.X{2}(j)^p2;
            S(ct,k)=b;
            ct=ct+1;
        end
    end
    %Aici redeterminam forma regresorului, pe care il calculam dupa
    %obtinerea fiecarei coloane.
    %p1 va merge de la m la 0, si va fi decrementat dupa obtinerea fiecarei
    %coloane, in timp ce p2 va fi incrementat cu cate o unitate atunci cand
    %s-au obtinut toate combinatiile X{1}^p1*X{2}^p2, cu p2 fixat. 
    %Astfel, regresorii determinati vor fi in urmatoarea ordine in matricea
    %simbolica Sigma:
    %S=[x1^m, x1^(m-1),..., x1, 1, x1^(m-1)*x2, x1^(m-2)*x2,..., x1^2*x2,
    %   x1*x2, x2,......,x1*x2^(m-1), x2^(m-1), x2^m].
    p1=p1-1;
    if p1==-1
        p2=p2+1;
        p1=m-p2;
    end
end
%folosim operatorul \ pentru a rezolva sistemul de ecuatii supradeterminat
%cu necunoscutele theta(i), cu i de la 1 la (m+1)(m+2)/2, cu specificatia
%ca matricea patratica Y ce contine datele de iesire trebuie sa fie
%transformata intr-o matrice coloana: Y->Y(:).
theta=S\data.Y(:);
y_aprox_id=S*theta;%reconstruim matricea ce ne aproximeaza iesirea Y folosind regresorii
                %deja calculati si matricea S de parametri, obtinuta mai sus
y_aprox_id=reshape(y_aprox_id,length(data.X{1}),length(data.X{2}));%redimensionam matricea
%ce aproximeaza iesirea Y, transformand-o dintr-o matrice coloana intr-o matrice patratica
%pentru a putea sa o reprezentam grafic sub forma urmatoare: fiecarei
%intrari de tipul (X{1}(i),X{2}(j)) ii corespunde o iesire y_aprox(i,j)

%algoritmul de mai jos foloseste matricea de parametri theta pentru a
%aproxima setul de date de validare, nefiind diferit cu ceva fata de partea
%descrisa mai sus.
    p1=m;
    p2=0;
    S=zeros(length(val.X{1})*length(val.X{2}),(m+1)*(m+2)/2);
    for k=1:(m+1)*(m+2)/2
        ct=1;
        for i=1:length(val.X{1})
            for j=1:length(val.X{2})
            b=val.X{1}(i)^p1.*val.X{2}(j)^p2;
            S(ct,k)=b;
            ct=ct+1;
            end
        end
        p1=p1-1;
        if p1==-1
            p2=p2+1;
            p1=m-p2;
        end
    end
       y_aprox_val=S*theta;
       y_aprox_val=reshape(y_aprox_val,length(val.X{1}),length(val.X{2})); 
toc


