function [N1, N2, N3, N4, best] = test(N, x1, x2, y1, y2)

  if nargin<2
    x1=1;
    x2=128;
    y1=1;
    y2=128;
  end

  disp('Sono al primo');
  [A,B,CV,CI,Err1]=interpol_cell(N,1);
  Err1(isnan(Err1) | isinf(Err1)) = 0;

  disp('Sono al secondo');
  [A,B,CV,CI,Err2]=interpol_cell(N,2);
  Err2(isnan(Err2) | isinf(Err2)) = 0;

  disp('Sono al contorno');
  [A,B,CV,CI,Err3]=interpol_cell(N,3);
  Err3(isnan(Err3) | isinf(Err3)) = 0;

  disp('Sono al dolce');
  [A,B,CV,CI,Err4]=interpol_cell(N,4);
  Err4(isnan(Err4) | isinf(Err4)) = 0;

  N1=norm(Err1(x1:x2, y1:y2));
  N2=norm(Err2(x1:x2, y1:y2));
  N3=norm(Err3(x1:x2, y1:y2));
  N4=norm(Err4(x1:x2, y1:y2));

  best = min([N1, N2, N3, N4]);
