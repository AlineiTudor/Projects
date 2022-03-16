clear
load('proj_fit_08.mat');
MSE=[];
%crestem numarul de exponentiale cu fiecare iteratie prin acest for
%cu cat pasul este mai mare, cu atat intervalul pe care se face aproximarea
%este mai mare si deci numarul de exponentiale considerat este mai mic.
for pas=31:-2:2
tic
k=1;

%pentru fiecare sectiune cuprinsa intre X1(i)-X1(i+pas) si X2(j)-X2(j+pas)
%cautam sa calculam valorile c si b ce aproximeaza prin exponentiale acele sectiuni
%considerate
for i=1:pas:length(id.X{1})
    for j=1:pas:length(id.X{2})
        %verificam daca nu cumva am depasit lungimea datelor de intrare
          if (i+pas<=length(id.X{1}) & j+pas<=length(id.X{2}))
              %coeficientii c ai exponentialei i-am considerat ca fiind
              %mediile capetelor intervalelor de pe axele X1 si X2. c(i,1)
              %si c(i,2) sunt la mijlocul acestor intervale.
            c(k,1)=mean([id.X{1}(i),id.X{1}(i+pas)]);
            c(k,2)=mean([id.X{2}(j),id.X{2}(j+pas)]);
            %coeficientii b sunt latimile pe axele X1 si X2 ale exponentialelor 
            %ce aproximeaza iesirea Y
            b(k,1)=abs(id.X{1}(i)-id.X{1}(i+pas));
            b(k,2)=abs(id.X{2}(j)-id.X{2}(j+pas));
            k=k+1;
          end
    end
end

%identificare
%calculam valorile regresorilor pentru fiecare pereche X1(i),X2(j).
k=1;
nr=length(b(:,1));
for i=1:length(id.X{1})
    for j=1:length(id.X{2})
        for n=1:nr
            S(k,n)=exp(-(id.X{1}(i)-c(n,1))^2/b(n,1)^2)*exp(-(id.X{2}(j)-c(n,2))^2/b(n,2)^2);
        end
        k=k+1;
    end
end

T=S\id.Y(:);
y_aprox=S*T;
y_aprox=reshape(y_aprox,length(id.X{1}),length(id.X{2}));

mesh(id.X{1},id.X{2},y_aprox),title('Identificare'),xlabel('X1'),ylabel('X2'),zlabel('Y');

%validare
k=1;
for i=1:length(val.X{1})
    for j=1:length(val.X{2})
        for n=1:nr
            S2(k,n)=exp(-(val.X{1}(i)-c(n,1))^2/b(n,1)^2)*exp(-(val.X{2}(j)-c(n,2))^2/b(n,2)^2);
        end
        k=k+1;
    end
end
y_aprox_val=S2*T;
y_aprox_val=reshape(y_aprox_val,length(val.X{1}),length(val.X{2}));
MSE=[MSE,mean( mean( (y_aprox_val-val.Y).^2) )];

end
pas=31:-2:2;
dim=size(val.Y);
figure(2)
%Pentru a afla cate RBF-uri calculam cate functii radiale avem de-a lungul
%axei X1, cate functii de baza radiale avem de-a lungul lui X2,
%preluam partea intreaga a celor doua impartiri si inmultim 
%cele doua rezultate obtinute.  
plot(floor((dim(1)./pas)).*floor((dim(2)./pas)),MSE),xlabel('Numar de functii gaussiene bidimensionale'),ylabel('MSE'),title('MSE in functie de numarul de exponentiale');
figure(1)
mesh(val.X{1},val.X{2},val.Y),xlabel('x'),ylabel('y'),zlabel('z'),hold on,
mesh(val.X{1},val.X{2},y_aprox_val),title('Validare'),xlabel('X1'),ylabel('X2'),zlabel('Y');


