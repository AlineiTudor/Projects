function [mat_puteri] = polnvar2(x,m)%Functie care genereaza toate puterile unui polinom de n variabile (n=numarul de cell-uri ale unui cell-array x)
%ce contine in fiecare x{i} puterile disponibile pentru a alcatui acel
%polinom de grad maxim m.
%In acest caz, vom folosi in fiecare cell x{i} acelasi vecor.
%Algoritmul se bazeaza pe realizarea produsului cartezian a celor n
%cell-uri (care sunt vectori linie) ale lui x, eliminand din acest produs
%cartezian elemente in momentul in care suma puterilor ajunge mai mare
%decat m;
dim=size(x);%retinem in dim dimensiunea cell-array-ului x. Ne intereseaza dim(2), care reprezinta na+nb.
n_linii=factorial(dim(2)+m)/factorial(dim(2))/factorial(m);%acesta este numarul de termeni ai unui polinom de grad m si n variabile.
mat_puteri=zeros(n_linii,dim(2));%alocam spatiul necesar matricii de puteri.
aux=mat_puteri;%Vom considera si o matrice auxiliara pentru a realiza produsul cartezian.
l2=1;%Cu ajutorul lui l2 vom sti lilia curenta pana la care am ajuns sa construim perechile de puteri.
for k=1:dim(2)
    l=1;%reactualizam contorul l cu care vom parcurge liniile matricei cu puteri construite pana la un moment dat.
    for n=1:l2%parcurgem matricea auxiliara aux de puteri pana la indicele ultimei linii construite la iteratia k-1.
        for j=1:length(x{k})%parcurgem vectorul x{i} element cu element
            if(sum([aux(n,1:k-1),x{k}(j)])<=m)%verificam daca prin concatenarea liniei n a matricei aux cu un element din vectorul x{k}
                %nu depasim conditia ca suma tuturor puterilor sa fie mai
                %mica sau egala decat m.
                mat_puteri(l,1:k)=[aux(n,1:k-1),x{k}(j)];%daca conditia e respectata alipim elementul vectorului x{k} la matricea de puteri 
                %aux(n,1:k-1) reprezinta faptul ca pana la iteratia curenta
                %k am construit k-1 perechi de puteri [p1,p2..p_(k-1)].
                l=l+1;%odata gasita o noua pereche trecem mai departe, pe urmatoarea linie in matricea pe care dorim sa o construim.
            end
        end
    end
     l2=l-1;%indicele liniei din matricea aux[][] pana la care este nevoie sa iteram este indicele ultimei linii construite in matricea mat_puteri[][].
    aux=mat_puteri;%cu noua matrice obtinuta mat_puteri[][], reactualizam matricea auxiliara.
end
 %Pe scurt matricea aux[][] ne permite sa reactualizam si sa suprascriem linii din
 %matricea de puteri mat_puteri[][] fara sa pierdem perechile construite anterior.   

end


