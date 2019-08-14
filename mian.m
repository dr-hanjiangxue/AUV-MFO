%%基于飞蛾扑火算法的三维路径规划方法
clc
clear
%% 数据初始化，载入海图信息
load  HeightData 
PortGrid=21;
starty=10;
starth=4; 
endy=8;
endh=5;
SearchAgents_no=100; % Number of search agents
Max_iteration=3000; % Maximum numbef of iterations
dim=3;  %问题维度
ub=[21 21 2000];  %变量上限
lb=[0 0 0];     %变量下限
Moth_fitness=Costfuction(path);%代价函数定义
[Best_flame_score,Best_flame_pos,Convergence_curve]=MFO_searchpath(SearchAgents_no,Max_iteration,Moth_fitness,HeightData);
% figure('Position',[284   214   660   290])
% %Draw search space
% subplot(1,2,1);
% func_plot(Function_name);
% title('Test function')
% xlabel('x_1');
% ylabel('x_2');
% zlabel([Function_name,'( x_1 , x_2 )'])
% grid off
% 
% %Draw objective space
% subplot(1,2,2);
% semilogy(cg_curve,'Color','b')
% title('Convergence curve')
% xlabel('Iteration');
% ylabel('Best flame (score) obtained so far');
% 
% axis tight
% grid off
% box on
% legend('MFO')
% 
% display(['The best solution obtained by MFO is : ', num2str(Best_pos)]);
% display(['The best optimal value of the objective funciton found by MFO is : ', num2str(Best_score)]);
for i=1:21
    a(i,1)=Best_flame_pos(i*2-1);
    a(i,2)=Best_flame_pos(i*2);
end
figure(1)
x=1:21;
y=1:21;
[x1,y1]=meshgrid(x,y);
mesh(x1,y1,HeightData)
axis([1,21,1,21,0,2000])
hold on
k=1:21;
plot3(k(1)',a(1,1)',a(1,2)'*200,'--o','LineWidth',2,...
                       'MarkerEdgeColor','k',...
                       'MarkerFaceColor','g',...
                       'MarkerSize',10)
plot3(k(21)',a(21,1)',a(21,2)'*200,'--o','LineWidth',2,...
                       'MarkerEdgeColor','k',...
                       'MarkerFaceColor','g',...
                       'MarkerSize',10)
                   text(k(1)',a(1,1)',a(1,2)'*200,'S');
text(k(21)',a(21,1)',a(21,2)'*200,'T');
xlabel('km','fontsize',12);
ylabel('km','fontsize',12);
zlabel('m','fontsize',12);
title('3D planning workspace','fontsize',12)
set(gcf, 'Renderer', 'ZBuffer')
hold on
plot3(k',a(:,1)',a(:,2)'*200,'--o')
hold on

%% 适应度变化
figure(2)
plot(Convergence_curve)
title('Optimal individual fitness trend')
xlabel('Number of iterations')
ylabel('Fitness value')

