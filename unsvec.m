function A=unsvec(v)
  A = zeros(3,3);

  A(1,1)=v(1);
  A(1:2,2)=v(2:3);
  A(1:3,3)=v(4:6);
  A(2,1)=v(2);
  A(3, 1:2)=v(4:5);
  end
