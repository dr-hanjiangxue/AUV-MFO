function Moth_fitness=Costfuction(path)
%% �ú������ڼ��������Ӧ��ֵ
%path       input     ·��
%fitness    input     ·��
q1=0.5;%Ȩֵq1
q2=0.5;%Ȩֵq2
q3=0.4;%Ȩֵq3
C=0.7;%��ϵ��C
den=1;%ˮ�ܶ�
area=0.126;%AUV������
[n,m]=size(path);
for i=1:n
    Moth_fitness(i)=0;
    Moth_distance(i)=0;
    Moth_energycost(i)=0;
    for j=3:2:m
        %������Ӧֵ
        dis=sqrt(1+(path(i,j)-path(i,j-2))^2+(path(i,j+1)-path(i,j-1))^2);
        Moth_distance(i)=Moth_distance(i)+dis;
        %Ѳ���ܺ���Ӧֵ
        Vi=testone(i,path(i,j),path(i,j+1),path(i,j-2),path(i,j-1));%AUVѲ���ٶ�
        Moth_energycost(i)= Moth_energycost(i)+0.5*C*den*area*dis/(-0.0807*Vi...
        +0.2149-0.0055/Vi+0.5413/(Vi^2));
        %�����ܺ���Ӧֵ
        %fluent_cost(i)=fluent_cost(i)
        %����Ӧֵ
        Moth_fitness(i)=Moth_distance(i);%Moth_energycost(i);
    end
    
end