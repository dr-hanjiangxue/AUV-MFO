clc;
clear;
x1=[0.1 0.25 0.4 0.6 0.7 0.8 0.95 1.1 1.25 1.35 1.4 1.5 1.6 1.7 1.75 1.85 1.95 2.0 2.1 2.25];
y1=0.01*[56 54 58 57 58 64 68 69 75 73 73 76 77 75 74 73 72 74 74 72];
% z=polyfit(x1,y1,3)
x=0:0.01:2.5;
y=-0.0807*x.^3+0.2149*x.^2-0.0055*x+0.5413;
figure
plot(x1,y1,'o','MarkerEdgeColor','r',...
    'MarkerSize', 5,...
    'MarkerFaceColor', 'r');
hold on
plot(x,y,'b','LineWidth',2);
xlabel('AUV sailing speed m/s','fontsize',12)
ylabel('AUV work efficiency','fontsize',12)