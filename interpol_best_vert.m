function [N,count] = interpol_best_vert(arr,inizio,fine,x1,x2,y1,y2)

  [~, I, ~, K] = size(arr);

  A_cell = cell(K,I);
  B_cell = cell(K,I);
  C_vera_cell = cell(K,I);
  C_interpol_cell = cell(4,K,I);
  Err = zeros(4, K, I);
  N = zeros(fine-inizio+1,4);
  count = zeros(1,4);

for j = inizio : fine
  for k = x1:x2
    for i = y1:y2
      % Estraiamo i vettori 6x1 per ogni pixel e li convertiamo in matrici 3x3
      A_cell{k-x1+1, i-y1+1} = unsvec(squeeze(arr(:, i, j-1, k)));
      B_cell{k-x1+1, i-y1+1} = unsvec(squeeze(arr(:, i, j+1, k)));
      C_vera_cell{k-x1+1,i-y1+1} = unsvec(squeeze(arr(:, i, j, k)));

      for type = 1:4
      C_interpol_cell{type,k-x1+1,i-y1+1} = mean(A_cell{k-x1+1,i-y1+1}, B_cell{k-x1+1,i-y1+1},type);
      %(A_cell{i,j} + B_cell{i,j}) / 2;
      Err(type,k-x1+1,i-y1+1)=norm(C_interpol_cell{type,k-x1+1, i-y1+1}-C_vera_cell{k-x1+1, i-y1+1})/norm(C_vera_cell{k-x1+1,i-y1+1});


    end
  end
   Err(isnan(Err) | isinf(Err)) = 0;
   for type = 1:4
    N(j-inizio+1,type)=norm(squeeze(Err(type,:,:)));
    end
end
best = min([N(j-inizio+1,1),N(j-inizio+1,2),N(j-inizio+1,3),N(j-inizio+1,4)]);
    if best == N(j-inizio+1,1)
      count(1)=count(1)+1;
    elseif best == N(j-inizio+1,2)
      count(2)=count(2)+1;
    elseif best == N(j-inizio+1,3)
      count(3)=count(3)+1;
    elseif best == N(j-inizio+1,4)
      count(4)=count(4)+1;

    end
end
