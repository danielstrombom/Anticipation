function CMAL=nh2DL(i,P,R,L,b)
%Neighbourhood function. Finds the neghbours of particle i and calculates 
%the direction from particle i to the local center of mass CM and the average 
%heading AL of the neighbours. Checks 9 cases because of the periodic boundary conditions.

ba=b/2; %Half of the blind angle
N=size(P,1); %Number of neighbours
NE=zeros(N,2); %To store index of neighbour and indicate over which boundary (if any) it was registered.
AG=zeros(N,3); %To store the coordinates and directional angle of the neighbours.
count=0; %Start counting neighbours.
v=[-cos(P(i,3)),-sin(P(i,3))]; %opposite to particle i:s direction of travel

for j=1:N %For all particles
    if j~=i %not itself
        if (P(i,1)-P(j,1))^2+(P(i,2)-P(j,2))^2<R^2 %If non-self particle j within interaction radius of focal particle i (over no boundary)
            u=[P(j,1)-P(i,1),P(j,2)-P(i,2)]; %Set up vector from particle i to particle j
            theta=acos((v(1)*u(1)+v(2)*u(2))/(sqrt(u(1)^2+u(2)^2))); %Angle between opposite i-direction and direction from i toward j.
            if abs(theta)>ba %If particle j not in i:s blind angle add as neighbour
                count=count+1; %Increase neighbour count
                NE(count,:)=[j,1]; %Store index j of neighbour
                AG(count,:)=[P(j,1),P(j,2),P(j,3)]; %Store coordinates and heading of neighbour
            end
        elseif (P(i,1)-(P(j,1)-L))^2+(P(i,2)-P(j,2))^2<R^2 
            u=[(P(j,1)-L)-P(i,1),P(j,2)-P(i,2)];
            theta=acos((v(1)*u(1)+v(2)*u(2))/(sqrt(u(1)^2+u(2)^2))); 
            if abs(theta)>ba 
                count=count+1;
                NE(count,:)=[j,2];
                AG(count,:)=[P(j,1)-L,P(j,2),P(j,3)];
            end
        elseif (P(i,1)-(P(j,1)-L))^2+(P(i,2)-(P(j,2)-L))^2<R^2
            u=[(P(j,1)-L)-P(i,1),(P(j,2)-L)-P(i,2)];
            theta=acos((v(1)*u(1)+v(2)*u(2))/(sqrt(u(1)^2+u(2)^2))); 
            if abs(theta)>ba 
                count=count+1;
                NE(count,:)=[j,3];
                AG(count,:)=[P(j,1)-L,P(j,2)-L,P(j,3)];
            end
        elseif (P(i,1)-P(j,1))^2+(P(i,2)-(P(j,2)-L))^2<R^2
            u=[P(j,1)-P(i,1),(P(j,2)-L)-P(i,2)];
            theta=acos((v(1)*u(1)+v(2)*u(2))/(sqrt(u(1)^2+u(2)^2))); 
            if abs(theta)>ba 
                count=count+1;
                NE(count,:)=[j,4];
                AG(count,:)=[P(j,1),P(j,2)-L,P(j,3)];
            end
        elseif (P(i,1)-(P(j,1)+L))^2+(P(i,2)-P(j,2))^2<R^2
            u=[(P(j,1)+L)-P(i,1),P(j,2)-P(i,2)];
            theta=acos((v(1)*u(1)+v(2)*u(2))/(sqrt(u(1)^2+u(2)^2))); 
            if abs(theta)>ba 
                count=count+1;
                NE(count,:)=[j,5];
                AG(count,:)=[P(j,1)+L,P(j,2),P(j,3)];
            end
        elseif (P(i,1)-(P(j,1)+L))^2+(P(i,2)-(P(j,2)+L))^2<R^2
            u=[(P(j,1)+L)-P(i,1),(P(j,2)+L)-P(i,2)];
            theta=acos((v(1)*u(1)+v(2)*u(2))/(sqrt(u(1)^2+u(2)^2)));
            if abs(theta)>ba 
                count=count+1;
                NE(count,:)=[j,6];
                AG(count,:)=[P(j,1)+L,P(j,2)+L,P(j,3)];
            end
        elseif (P(i,1)-P(j,1))^2+(P(i,2)-(P(j,2)+L))^2<R^2
            u=[P(j,1)-P(i,1),(P(j,2)+L)-P(i,2)];
            theta=acos((v(1)*u(1)+v(2)*u(2))/(sqrt(u(1)^2+u(2)^2))); 
            if abs(theta)>ba
                count=count+1;
                NE(count,:)=[j,7];
                AG(count,:)=[P(j,1),P(j,2)+L,P(j,3)];
            end
        elseif (P(i,1)-(P(j,1)-L))^2+(P(i,2)-(P(j,2)+L))^2<R^2
            u=[(P(j,1)-L)-P(i,1),(P(j,2)+L)-P(i,2)];
            theta=acos((v(1)*u(1)+v(2)*u(2))/(sqrt(u(1)^2+u(2)^2))); 
            if abs(theta)>ba 
                count=count+1;
                NE(count,:)=[j,8];
                AG(count,:)=[P(j,1)-L,P(j,2)+L,P(j,3)];
            end
        elseif (P(i,1)-(P(j,1)+L))^2+(P(i,2)-(P(j,2)-L))^2<R^2
            u=[(P(j,1)+L)-P(i,1),(P(j,2)-L)-P(i,2)];
            theta=acos((v(1)*u(1)+v(2)*u(2))/(sqrt(u(1)^2+u(2)^2))); 
            if abs(theta)>ba 
                count=count+1;
                NE(count,:)=[j,9];
                AG(count,:)=[P(j,1)+L,P(j,2)-L,P(j,3)];
            end
        else
            NE=NE;
        end
    end
end

NE=NE(1:count,:);
AG=AG(1:count,:);

if size(AG,1)>0 %If have any neighbours
    
    K=atan2(sum(sin(AG(:,3))),sum(cos(AG(:,3)))); %Average angle of neighbors
    AL=[cos(K),sin(K)]; %Average direction of neighbors
    
    CMx=mean(AG(:,1)); %x-coordinate of local center of mass
    CMy=mean(AG(:,2)); %y-coordinate of local center of mass
    
    CM=[CMx-P(i,1),CMy-P(i,2)]; %Direction toward center of mass of the neighbors
    CM=(1/((CM(1,1)^2+CM(1,2)^2)^(1/2)))*CM; %Normalized direction toward the local center of mass
    
    CMAL=[CM;AL;size(AG,1),0]; %Output

else %If no neighbours
    
    CMAL=[0,0;0,0;0,0]; %Output

end



%TESTS

%Neighborhood
%hold on
%plot(P(:,1),P(:,2),'.'); %All particles 
%plot(P(i,1),P(i,2),'rv'); %Particle i
%for k=1:size(NE,1)
 %   plot(P(NE(k),1),P(NE(k),2),'o'); %Neighbors of i marked with ring
 %   plot([P(NE(k),1),P(NE(k),1)+cos(P(NE(k),3))],[P(NE(k),2),P(NE(k),2)+sin(P(NE(k),3))],'k-'); %Direction of travel of neighbors
%end

%Center of mass (point)
%plot(mod(CMx+L,L),mod(CMy+L,L),'*'); %plotting center of mass

%Direction from individual i toward center of mass.
%plot(CM(1,1),CM(1,2),'x');

%Mean direction of neighbors
%plot(AL(1,1),AL(1,2),'+');
