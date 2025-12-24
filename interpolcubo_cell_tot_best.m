function [N,count] = interpolcubo_cell_tot_best(arr,inizio,fine, x1, x2, y1, y2)

  %[~, I, J, ~] = size(arr);

  A_cell = cell(x2-x1+1, y2-y1+1);
  B_cell = cell(x2-x1+1, y2-y1+1);
  C_vera_cell = cell(x2-x1+1, y2-y1+1);
  C_interpol_cell = cell(8,x2-x1+1, y2-y1+1);
  Err = zeros(8, x2-x1+1, y2-y1+1);
  %N = zeros(fine-inizio+1,4);
  count = zeros(1,8);

for k = inizio : fine
  for i = x1:x2
    for j = y1:y2
      % Estraiamo i vettori 6x1 per ogni pixel e li convertiamo in matrici 3x3
      A_cell{i-x1+1,j-y1+1} = unsvec(squeeze(arr(:, i, j, k-1)));
      B_cell{i-x1+1,j-y1+1} = unsvec(squeeze(arr(:, i, j, k+1)));
      C_vera_cell{i-x1+1,j-y1+1} = unsvec(squeeze(arr(:, i, j, k)));

      for type = 1:8
      C_interpol_cell{type,i-x1+1,j-y1+1} = mean(A_cell{i-x1+1,j-y1+1}, B_cell{i-x1+1,j-y1+1},type);
      %(A_cell{i,j} + B_cell{i,j}) / 2;
      Err(type,i-x1+1,j-y1+1)=norm(C_interpol_cell{type,i-x1+1,j-y1+1}-C_vera_cell{i-x1+1,j-y1+1})/norm(C_vera_cell{i-x1+1,j-y1+1});


    end
  end
   Err(isnan(Err) | isinf(Err)) = 0;
   for type = 1:8
    N(k-inizio+1,type)=norm(squeeze(Err(type,:,:)));
    end
end
best = min([N(k-inizio+1,1),N(k-inizio+1,2),N(k-inizio+1,3),N(k-inizio+1,4),N(k-inizio+1,5),N(k-inizio+1,6),N(k-inizio+1,7),N(k-inizio+1,8)]);
    if best == N(k-inizio+1,1)
      count(1)=count(1)+1;
    elseif best == N(k-inizio+1,2)
      count(2)=count(2)+1;
    elseif best == N(k-inizio+1,3)
      count(3)=count(3)+1;
    elseif best == N(k-inizio+1,4)
      count(4)=count(4)+1;
    elseif best == N(k-inizio+1,5)
      count(5)=count(5)+1;
    elseif best == N(k-inizio+1,6)
      count(6)=count(6)+1;
    elseif best == N(k-inizio+1,7)
      count(7)=count(7)+1;
    elseif best == N(k-inizio+1,8)
      count(8)=count(8)+1;

    end
end
