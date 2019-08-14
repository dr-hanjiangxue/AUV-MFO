function [Best_flame_score,Best_flame_pos,Convergence_curve]=MFO_searchpath(SearchAgents_no,Max_iteration,Moth_fitness,HeightData)

disp('MFO is optimizing your problem');

%Initialize the positions of moths
PortGrid=21;
starty=10;
starth=4; 
endy=8;
endh=5;
path=initialization(SearchAgents_no,PortGrid,HeightData,starty,starth,endy,endh);

Convergence_curve=zeros(1,Max_iteration);%收敛曲线

Iteration=1;

% Main loop
while Iteration<Max_iteration+1
    
    % Number of flames Eq. (3.14) in the paper
    Flame_no=round(SearchAgents_no-Iteration*((SearchAgents_no-1)/Max_iteration));
    
    for i=1:size(path,1)%取行数
        
        % Check if moths go out of the search spaceand bring it back
%         Flag4ub=Moth_pos(i,:)>ub;
%         Flag4lb=Moth_pos(i,:)<lb;
%         Moth_pos(i,:)=(Moth_pos(i,:).*(~(Flag4ub+Flag4lb)))+ub.*Flag4ub+lb.*Flag4lb;  
%         
        % Calculate the fitness of moths
        Moth_fitness(i,1)=Costfuction(path(i,:));  
        
    end
       
    if Iteration==1
        % Sort the first population of moths
        [fitness_sorted,I]=sort(Moth_fitness);
        sorted_population=path(I,:);
        
        % Update the flames
        best_flames=sorted_population;
        best_flame_fitness=fitness_sorted;
    else
        
        % Sort the moths
        double_population=[previous_population;best_flames];
        double_fitness=[previous_fitness;best_flame_fitness];
        
        [double_fitness_sorted I]=sort(double_fitness);
        double_sorted_population=double_population(I,:);
        
        N=SearchAgents_no;
        fitness_sorted=double_fitness_sorted(1:N);
        sorted_population=double_sorted_population(1:N,:);
        
        % Update the flames
        best_flames=sorted_population;
        best_flame_fitness=fitness_sorted;
    end
    
    % Update the position best flame obtained so far
    Best_flame_score=fitness_sorted(1);
    Best_flame_pos=sorted_population(1,:);
      
    previous_population=path;
    previous_fitness=Moth_fitness;
    
    % a linearly dicreases from -1 to -2 to calculate t in Eq. (3.12)
    a=-1+Iteration*((-1)/Max_iteration);
    
    for i=1:size(path,1)
%          for j=1:size(path,2)
%             if i<=Flame_no % Update the position of the moth with respect to its corresponsing flame
%                 
%                 % D in Eq. (3.13)
%                 distance_to_flame=abs(sorted_population(i,j)-path(i,j));
%                 b=1;
%                 t=(a-1)*rand+1;
%                 
%                 % Eq. (3.12)
%                 path(i,j)=distance_to_flame*exp(b.*t).*cos(t.*2*pi)+sorted_population(i,j);
%             end
%             
%             if i>Flame_no % Upaate the position of the moth with respct to one flame
%                 
%                 % Eq. (3.13)
%                 distance_to_flame=abs(sorted_population(i,j)-path(i,j));
%                 b=1;
%                 t=(a-1)*rand+1;
%                 
%                 % Eq. (3.12)
%                 path(i,j)=distance_to_flame*exp(b.*t).*cos(t.*2*pi)+sorted_population(Flame_no,j);
%             end
%             
%         end
     
        for j=3:2:size(path,2)
          S = 1;
          if i<=Flame_no % Update the position of the moth with respect to its corresponsing flame                
               
             while S==1
                distance_to_flamey=abs(sorted_population(i,j)-path(i,j));
                distance_to_flameh=abs(sorted_population(i,j+1)-path(i,j+1));
                b=1;
                t=(a-1)*rand+1;
                path(i,j)=distance_to_flamey * exp(b.*t).* cos(t.*2*pi) + sorted_population(i,j);
                path(i,j+1)=distance_to_flameh * exp(b.*t).* cos(t.*2*pi) + sorted_population(i,j+1);
                m1=floor(path(i,j));
                m2=ceil(path(i,j));
                m3=(j+1)/2;
                if m1>=1 && m2>=1 && m1<=21 && m2 <=21
                    if (HeightData(m1,m3)<=((path(i,j+1)*200)+20)) && (HeightData(m2,m3)<=((path(i,j+1)*200)+20))
                      S=0;
                    end
                end
             end
          end
            
          if i>Flame_no % Upaate the position of the moth with respct to one flame
            
              while S==1
                distance_to_flamey=abs(sorted_population(i,j)-path(i,j));
                distance_to_flameh=abs(sorted_population(i,j+1)-path(i,j+1));
                b=1;
                t=(a-1)*rand+1;
                path(i,j)=distance_to_flamey * exp(b.*t).* cos(t.*2*pi) + sorted_population(Flame_no,j);
                path(i,j+1)=distance_to_flameh * exp(b.*t).* cos(t.*2*pi) + sorted_population(Flame_no,j+1);
                m1=floor(path(i,j));
                m2=ceil(path(i,j));
                m3=(j+1)/2;
                if m1>=1 && m2>=1 && m1<=21 && m2 <=21
                    if (HeightData(m1,m3)<=((path(i,j+1)*200)+20)) && (HeightData(m2,m3)<=((path(i,j+1)*200)+20))
                      S=0;
                    end
                end
              end  
          end
        
%         for j=1:(size(path,2)/2)
%             [~,index]=max(HeightData);
%             p = index(j);
%             if i<=Flame_no % Update the position of the moth with respect to its corresponsing flame
%                 
%                   while (p>=1 && p<=21 && path(i,j*2)*200 < HeightData(p,j))
%                     distance_to_flame1=abs(sorted_population(i,j*2-1)-path(i,j*2-1));
%                     distance_to_flame2=abs(sorted_population(i,j*2)-path(i,j*2));
%                     b=1;
%                     t=(a-1)*rand+1;
% 
%                     path(i,j*2-1)=distance_to_flame1*exp(b.*t).*cos(t.*2*pi)+sorted_population(i,j*2-1);
%                     path(i,j*2)=distance_to_flame2*exp(b.*t).*cos(t.*2*pi)+sorted_population(i,j*2);
%                     p=round(path(i,j*2-1));
%                     p=round(path(i,j*2-1));
                    
%                     if (p>=1 && p<=21 && path(i,j*2)*200 > HeightData(p,j))
%                        break;
%                     end
%                   end
%              end    
%             
%             if i>Flame_no % Upaate the position of the moth with respct to one flame
%              
%                     while (p>=1 && p<=21 && path(i,j*2)*200 < HeightData(p,j))
%                     distance_to_flame1=abs(sorted_population(i,j*2-1)-path(i,j*2-1));
%                     distance_to_flame2=abs(sorted_population(i,j*2)-path(i,j*2));
%                     b=1;
%                     t=(a-1)*rand+1;
% 
%                     % Eq. (3.12)
%                     path(i,j*2-1)=distance_to_flame1*exp(b.*t).*cos(t.*2*pi)+sorted_population(Flame_no,j*2-1);
%                     path(i,j*2)=distance_to_flame2*exp(b.*t).*cos(t.*2*pi)+sorted_population(Flame_no,j*2);
%                     p=round(path(i,j*2-1));
% %                     p=round(path(i,j*2-1));
                
        end
     end
     
        
    
    Convergence_curve(Iteration)=Best_flame_score;
    
    % Display the iteration and best optimum obtained so far
    if mod(Iteration,50)==0
        display(['At iteration ', num2str(Iteration), ' the best fitness is ', num2str(Best_flame_score)]);
    end
    Iteration=Iteration+1; 
end    
    