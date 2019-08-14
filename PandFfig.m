clc;
clear;
x1=[0 1 2 8 15 20 26 34 40 50 59 67 80 88 100 110 120 132 144 158];
y1=[0 2 5 9 12 15 19 22 26 31 34 36 40 41 45 47 48 48 52 53];
x=0:1:160;
y=-0.0021*x.^2+0.6342*x+2.8372;
figure
plot(x1,y1,'o','MarkerEdgeColor','r',...
    'MarkerSize', 5,...
    'MarkerFaceColor', 'r');
hold on
plot(x,y,'b','LineWidth',2);
xlabel('Propeller output power P/W','fontsize',12)
ylabel('Propeller thrust F/N','fontsize',12')
