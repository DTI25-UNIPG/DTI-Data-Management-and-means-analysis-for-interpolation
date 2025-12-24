function [N,count] = interpol_best_sag(arr,inizio,fine,x1,x2,y1,y2)

  [~, ~, J, K] = size(arr);

  A_cell = cell(K,J);
  B_cell = cell(K,J);
  C_vera_cell = cell(K,J);
  C_interpol_cell = cell(4,K,J);
  Err = zeros(4, K, J);
  N = zeros(fine-inizio+1,4);
  count = zeros(1,4);

for i = inizio : fine
  for k = x1:x2
    for j = y1:y2
      % Estraiamo i vettori 6x1 per ogni pixel e li convertiamo in matrici 3x3
      A_cell{k-x1+1, j-y1+1} = unsvec(squeeze(arr(:, i-1, j, k)));
      B_cell{k-x1+1, j-y1+1} = unsvec(squeeze(arr(:, i+1, j, k)));
      C_vera_cell{k-x1+1,j-y1+1} = unsvec(squeeze(arr(:, i, j, k)));

      for type = 1:4
      C_interpol_cell{type,k-x1+1,j-y1+1} = mean(A_cell{k-x1+1,j-y1+1}, B_cell{k-x1+1,j-y1+1},type);
      %(A_cell{i,j} + B_cell{i,j}) / 2;
      Err(type,k-x1+1,j-y1+1)=norm(C_interpol_cell{type,k-x1+1, j-y1+1}-C_vera_cell{k-x1+1, j-y1+1})/norm(C_vera_cell{k-x1+1,j-y1+1});


    end
  end
   Err(isnan(Err) | isinf(Err)) = 0;
   for type = 1:4
    N(i-inizio+1,type)=norm(squeeze(Err(type,:,:)));
    end
end
best = min([N(i-inizio+1,1),N(i-inizio+1,2),N(i-inizio+1,3),N(i-inizio+1,4)]);
    if best == N(i-inizio+1,1)
      count(1)=count(1)+1;
    elseif best == N(i-inizio+1,2)
      count(2)=count(2)+1;
    elseif best == N(i-inizio+1,3)
      count(3)=count(3)+1;
    elseif best == N(i-inizio+1,4)
      count(4)=count(4)+1;

    end
end
