# DTI-Data-Management-and-means-analysis-for-interpolation
---
## Team members

I membri del gruppo (in ordine alfabetico):

* Alfonso Esposito: [@alfonsoesposito548](https://github.com/alfonsoesposito548)
* Teresa Perioli: [@talybessa](https://github.com/talybessa)
* Melanie Provvedi: *In arrivo*
* Claudia Puliga: [@claudiapuliga](https://github.com/claudiapuliga)
* Benedetta Zibetti: [@benedettazibetti](https://github.com/benedettazibetti)
---

## Documentazione
Abbiamo realizzato un poster in formato A3 che riassume ciò che abbiamo analizzato nel nostro progetto:
* [**Scarica il Poster del Progetto (PDF)**](./docs/Poster_progetto.pdf)
---

## Abstract
Il progetto che abbiamo svolto verte sull'analisi di dati ottenuti tramite una risonanza magnetica a DTI (Diffusion Tensor Imaging) al cervello. 
Inizialemente abbiamo elaborato un codice per la visualizzazione del cervello lungo i tre piani anatomici: assiale, sagittale e coronale(verticale).
Successivamente ci siamo soffermati sullo sviluppo di codici per l'approssimazione e il miglioramento delle immagini. A tal fine abbiamo utilizzato diverse medie, la cui efficacia è stata verificata attraverso un'analisi quantitativa degli errori riscontrati.

*Nota sulla Riservatezza*: Seguendo le normative per la privacy, i dataset originali non sono inclusi nel repository. La documentazione e il codice presenti si riferiscono esclusivamente alla logica di elaborazione e agli algoritmi sviluppati.

## Analisi dettagliata delle funzioni

### 1. Funzioni di visualizzazione

Abbiamo elaborato tre funzioni di visualizzazione a seconda dell'asse considerato.
In ogni funzione, per prima cosa viene caricato il dataset. 
Esso contiene un 4-tensore denominato *arr* di dimensioni (6, 128, 128, 45) con la seguente struttura:
- Indice 1 ($h$): Vettore di direzione (6 componenti del segnale magnetico).
- Indice 2-3 ($i, j$): Dimensioni spaziali della fetta ($128 \times 128$ pixel).
- Indice 4 ($k$): Indice della fetta, cioè la profondità ($45$).

---

#### visualizza1

La prima funzione, *visualizza1*, permette di visualizzare l'immagine lungo l'asse orizzontale:

```matlab
function D=visualizza1(k)

load data %Mi restituisce un array con TUTTI i 3-tensori misurati (è un 4-tensore)

  for h=1:6 %Elemento del vettore direzione
    for i=1:128 %Scorre la prima dimensione della matrice
      for j=1:128 %Scorre la seconda dimensione della matrice
        D(i,j)=arr(h,i,j,k); %Creo una matrice estrapolando solo le 2 dimensioni centrali del 4-tensore
      end
    end
    sum(sum(D<0)); %Sommo gli elementi di D (sia delle righe che delle colonne) che sono minori di zero
    subplot(2,3,h);
    imagesc(D);%Disegno la fetta corrispondente)

    %pause;
  end
```
La funzione riceve in input l'indice $k$ della fetta desiderata. Per tale fetta, estrae le matrici relative alle 6 direzioni e le mostra in un'unica figura composta da 6 subplot ($2 \times 3$).

---

#### visualizza2.m

La seconda funzione, *visualizza2*, permette di visualizzare l'immagine lungo l'asse coronale(verticale):

```matlab
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
```
La funzione riceve in input l'indice $j$ della fetta desiderata. Per tale fetta, estrae le matrici relative alle 6 direzioni e mostra le rappresentazioni una per volta. Utilizzo l'indice *46-k* e non *k* per ottenere l'immagine nel verso "standard".

---

#### visualizza3.m

La terza funzione, *visualizza3*, permette di visualizzare l'immagine lungo l'asse sagittale:

```matlab
function D=visualizza3(i)

  load data
   for h=1:6 %Elemento del vettore direzione
    for j=1:128 %Scorre la prima dimensione della matrice
      for k=1:45 %Scorre la seconda dimensione della matrice
        D(46-k,j)=arr(h,i,j,k); %Creo una matrice estrapolando solo le 2 dimensioni centrali del 4-tensore
      end
    end
    sum(sum(D<0)) %Sommo gli elementi di D (sia delle righe che delle colonne) che sono minori di zero
    %subplot(1,6,h);
    imagesc(D)
    axis image;%Disegno la fetta corrispondente
    pause;
  end
```
La funzione riceve in input l'indice $i$ della fetta desiderata. Per tale fetta, estrae le matrici relative alle 6 direzioni e mostra le rappresentazioni una per volta. Utilizzo l'indice *46-k* e non *k* per ottenere l'immagine nel verso "standard".

In ogni funzione calcolo quanti sono i valori negativi nella matrice, che nel DTI possono simboleggiare rumore o interferenze nel segnale. Inoltre, lavorando direttamente sul dato, studiando quando i valori della matrice sono non negativi, posso ipotizzare l'ordine delle direzioni nel vettore h. 

**Osservazione**: Il codice può essere ottimizzato utilizzando, al posto dei cicli *for*, la funzione *squeeze* che permette di ottenere direttamente una matrice dal tensore.

---
