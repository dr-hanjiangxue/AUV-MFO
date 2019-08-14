%%
%MFO�㷨λ�ó�ʼ��
function [path]=initialization(SearchAgents_no,PortGrid,HeightData,starty,starth,endy,endh)
%% ·���滮��ʼ��Ϣ
%SearchAgents_no        ��Ⱥ����
%LevelGrid     input    ���򻮷ָ���
%PortGrid      input    ���򻮷ָ���
%HeightData    input    ��ͼ�߶�
%starty starth input    ��ʼ��
%path          output   �滮·��
%% ��������
ycMax=2;   %�������䶯
hcMax=2;   %�������䶯
path=zeros(SearchAgents_no,42);
%% ѭ������·��
for ii=1:SearchAgents_no
    
    path(ii,1:2)=[starty,starth];  %��¼·��
    NowPoint=[starty,starth];      %��ǰ�����
    
    %% �������Ӧ��ֵ
    for abscissa=2:PortGrid-1       %abscissa������
        %�����������ݵ��Ӧ����Ӧ��ֵ
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
        
        
        %ѡ���¸���
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
        
        %·������
        path(ii,abscissa*2-1:abscissa*2)=[oldpoint(1),oldpoint(2)];    
        NowPoint=oldpoint;
        
    end
    path(ii,41:42)=[endy,endh];
end
