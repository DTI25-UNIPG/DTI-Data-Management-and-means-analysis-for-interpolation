function [N,count] = interpol_cell_tot_best(arr,inizio,fine)

  [~, I, J, ~] = size(arr);

  A_cell = cell(I, J);
  B_cell = cell(I, J);
  C_vera_cell = cell(I, J);
  C_interpol_cell = cell(4,I, J);
  Err = zeros(4, I, J);
  N = zeros(fine-inizio+1,4);
  count = zeros(1,4);

for k = inizio : fine
  for i = 1:I
    for j = 1:J
      % Estraiamo i vettori 6x1 per ogni pixel e li convertiamo in matrici 3x3
      A_cell{i,j} = unsvec(squeeze(arr(:, i, j, k-1)));
      B_cell{i,j} = unsvec(squeeze(arr(:, i, j, k+1)));
      C_vera_cell{i,j} = unsvec(squeeze(arr(:, i, j, k)));

      for type = 1:4
      C_interpol_cell{type,i,j} = mean(A_cell{i,j}, B_cell{i,j},type);
      %(A_cell{i,j} + B_cell{i,j}) / 2;
      Err(type,i,j)=norm(C_interpol_cell{type,i,j}-C_vera_cell{i,j})/norm(C_vera_cell{i,j});


    end
  end
   Err(isnan(Err) | isinf(Err)) = 0;
   for type = 1:4
    N(k-inizio+1,type)=norm(squeeze(Err(type,:,:)));
    end
end
best = min([N(k-inizio+1,1),N(k-inizio+1,2),N(k-inizio+1,3),N(k-inizio+1,4)]);
    if best == N(k-inizio+1,1)
      count(1)=count(1)+1;
    elseif best == N(k-inizio+1,2)
      count(2)=count(2)+1;
    elseif best == N(k-inizio+1,3)
      count(3)=count(3)+1;
    elseif best == N(k-inizio+1,4)
      count(4)=count(4)+1;

    end
end

