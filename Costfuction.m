function Moth_fitness=Costfuction(path)
%% 该函数用于计算个体适应度值
%path       input     路径
%fitness    input     路径
q1=0.5;%权值q1
q2=0.5;%权值q2
q3=0.4;%权值q3
C=0.7;%常系数C
den=1;%水密度
area=0.126;%AUV横截面积
[n,m]=size(path);
for i=1:n
    Moth_fitness(i)=0;
    Moth_distance(i)=0;
    Moth_energycost(i)=0;
    for j=3:2:m
        %距离适应值
        dis=sqrt(1+(path(i,j)-path(i,j-2))^2+(path(i,j+1)-path(i,j-1))^2);
        Moth_distance(i)=Moth_distance(i)+dis;
        %巡航能耗适应值
        Vi=testone(i,path(i,j),path(i,j+1),path(i,j-2),path(i,j-1));%AUV巡航速度
        Moth_energycost(i)= Moth_energycost(i)+0.5*C*den*area*dis/(-0.0807*Vi...
        +0.2149-0.0055/Vi+0.5413/(Vi^2));
        %海流能耗适应值
        %fluent_cost(i)=fluent_cost(i)
        %总适应值
        Moth_fitness(i)=Moth_distance(i);%Moth_energycost(i);
    end
    
end