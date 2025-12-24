function C=mean(A,B,s)

  t=1/2;

  switch s

    case 1 %media aritmetica
      C=(1-t)*A+t*B;

    case 2 %media geometrica
       % se il determinante è quasi zero non riesco a fare l'inverso di matrice
      if det(A) < 1e-12 || det(B) < 1e-12
          C=(A+B)/2;
      else
          C=A*(inv(A)*B)^t;
    end

    case 3 %Log-euclidea
    C=expm((logm(A)+logm(B))/2);

    case 4 %media armonica
      if det(A) < 1e-12 || det(B) < 1e-12
          C=(A+B)/2;
      else
          C=((1-t)*inv(A)+t*inv(B))^(-1);
    end

  case 5 %power mean con p=-2
  p=-2;
    C=((A^p+B^p)/2)^(1/p);
  case 6 %power mean con p=2
    p=2;
    C=((A^p+B^p)/2)^(1/p);
  case 7 %power mean con p=0.5
    p=1/2;
    C=((A^p+B^p)/2)^(1/p);
  case 8 %power mean con p=-0.5
    p=-1/2;
    C=((A^p+B^p)/2)^(1/p);


 end
