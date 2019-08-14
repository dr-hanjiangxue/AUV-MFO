%%
%MFO算法位置初始化
function [path]=initialization(SearchAgents_no,PortGrid,HeightData,starty,starth,endy,endh)
%% 路径规划初始信息
%SearchAgents_no        种群个数
%LevelGrid     input    横向划分格数
%PortGrid      input    纵向划分个数
%HeightData    input    地图高度
%starty starth input    开始点
%path          output   规划路径
%% 搜索参数
ycMax=2;   %横向最大变动
hcMax=2;   %纵向最大变动
path=zeros(SearchAgents_no,42);
%% 循环搜索路径
for ii=1:SearchAgents_no
    
    path(ii,1:2)=[starty,starth];  %记录路径
    NowPoint=[starty,starth];      %当前坐标点
    
    %% 计算点适应度值
    for abscissa=2:PortGrid-1       %abscissa横坐标
        %计算所有数据点对应的适应度值
        kk=1;
        for i=-ycMax:ycMax
            for j=-hcMax:hcMax
                NextPoint(kk,:)=[NowPoint(1)+i,NowPoint(2)+j];
                if (NextPoint(kk,1)<20)&&(NextPoint(kk,1)>0)&&(NextPoint(kk,2)<20)&&(NextPoint(kk,2)>0)
                    qfz(kk)=CacuQfz(NextPoint(kk,1),NextPoint(kk,2),NowPoint(1),NowPoint(2),endy,endh,abscissa,HeightData);
                    kk=kk+1;
                else
                    qfz(kk)=0;
                    kk=kk+1;
                end
            end
        end
        
        
        %选择下个点
        sumq=qfz./sum(qfz);
    
        pick=rand;
        while pick==0
            pick=rand;
        end
        
        for i=1:25
            pick=pick-sumq(i);
            if pick<=0
                index=i;
                break;
            end
        end
        
        oldpoint=NextPoint(index,:);
        
        %路径保存
        path(ii,abscissa*2-1:abscissa*2)=[oldpoint(1),oldpoint(2)];    
        NowPoint=oldpoint;
        
    end
    path(ii,41:42)=[endy,endh];
end
