function [A_cell, B_cell, C_vera_cell,C_interpol_cell,Err] = interpol_cell(k,type,arr)

  [~, I, J, ~] = size(arr);

  A_cell = cell(I, J);
  B_cell = cell(I, J);
  C_vera_cell = cell(I, J);
  C_interpol_cell = cell(I, J);

  for i = 1:I
    for j = 1:J
      % Estraiamo i vettori 6x1 per ogni pixel e li convertiamo in matrici 3x3
      A_cell{i,j} = unsvec(squeeze(arr(:, i, j, k-1)));
      B_cell{i,j} = unsvec(squeeze(arr(:, i, j, k+1)));
      C_vera_cell{i,j} = unsvec(squeeze(arr(:, i, j, k)));
      C_interpol_cell{i,j} = mean(A_cell{i,j}, B_cell{i,j},type);
      %(A_cell{i,j} + B_cell{i,j}) / 2;
      Err(i,j)=norm(C_interpol_cell{i,j}-C_vera_cell{i,j})/norm(C_vera_cell{i,j});
    end
  end
end
