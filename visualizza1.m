function D=visualizza1(k)

load data %Mi restituisce un array con TUTTI i 3-tensori misurati (è un 4-tensore)

%for k=23:23 %Fetta (Non ha senso studiarsi tutte le fette a priori, chiedo in input il k che voglio analizzare)
  for h=1:6 %Elemento del vettore direzione
    for i=1:128 %Scorre la prima dimensione della matrice
      for j=1:128 %Scorre la seconda dimensione della matrice
        D(i,j)=arr(h,i,j,k); %Creo una matrice estrapolando solo le 2 dimensioni centrali del 4-tensore
      end
    end
    sum(sum(D<0)); %Sommo gli elementi di D (sia delle righe che delle colonne) che sono minori di zero
    subplot(2,3,h);
    imagesc(D);%Disegno la fetta corrispondente)
    %pbaspect([0.5 1 1]);
    %pause;
  end
%end
