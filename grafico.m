function grafico(N)
figure(1)
%subplot(1,2,1)

%plot(N(:,1), 'bo')
%hold on
%plot(N(:,2), 'g+')
%plot(N(:,3), 'yh')
%plot(N(:,4), 'rv')
%legend("1")

[a,b]=sort(N(:,1));
subplot(1,2,1)
hold on
plot(N(b,1),'color',[1,0.5,0])
plot(N(b,2),'g')
plot(N(b,3),'b')
plot(N(b,4),'r')
plot(N(b,5),'k')
plot(N(b,6),'y')
plot(N(b,7),'c')
plot(N(b,8),'m')





[a,b]=sort(N(:,1));
for i = 1:8
  for j = 1:size(N,1)
    N2(j,i) = sum(N(1:j,i));
  endfor
endfor
subplot(1,2,2)
hold on
plot(N2(:,1),'color',[1,0.5,0])
plot(N2(:,2),'g')
plot(N2(:,3),'b')
plot(N2(:,4),'r')
plot(N2(:,5),'k')
plot(N2(:,6),'y')
plot(N2(:,7),'c')
plot(N2(:,8),'m')
