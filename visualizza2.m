function D=visualizza2(j)

  load data
   for h=1:6 %Elemento del vettore direzione
    for i=1:128 %Scorre la prima dimensione della matrice
      for k=1:45 %Scorre la seconda dimensione della matrice
        D(46-k,i)=arr(h,i,j,k); %Creo una matrice estrapolando solo le 2 dimensioni centrali del 4-tensore
      end
    end
    sum(sum(D<0)) %Sommo gli elementi di D (sia delle righe che delle colonne) che sono minori di zero
    %subplot(1,6,h);
    imagesc(D)
    axis image;%Disegno la fetta corrispondente)
    pause;
  end
