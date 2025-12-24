function [A,B,Cvera,C] = interpol(k)

  if k<=1 || k>44
    printf("Errore");
    return;
  end

load data

for h=1:6
 % A=visualizza1(k-1); %Fetta precedente
 % B=visualizza1(k+1); %Fetta successiva

 % C=(A+B)/2; %Interpolazione matrici lineare

    %Calcolo errore
 % Cvera=visualizza1(k);

  A{h}=squeeze(arr(h,:,:,k-1)); %Squeeze estrae dal tensore la matrice con h e k-1 fissato e i,j che variano
  B{h}=squeeze(arr(h,:,:,k+1));
  C{h}=(A{h}+B{h})/2;

  Cvera{h}=squeeze(arr(h,:,:,k));



  %Confronto immagine
 % subplot(3,6,h);
 % imagesc(Cvera);
 % axis image;
 % title(['Dir', num2str(h)]);

  %subplot(3,6,h+6);
  %imagesc(C)
  %axis image;
  %title(['Dir', num2str(h), ' interpolata']);

  %E = abs(Cvera - C);
  %E2 = norm(
  %subplot(3,6,h+12);
  %imagesc(E);
  %title(['Errore Dir', num2str(h)]);
  %colormap(hot); % Le zone chiare sono quelle con più errore
end
