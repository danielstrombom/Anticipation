function M = anticipation(N,L,tau,c,t)

%2D LAM without anticipation if tau=0 or with anticipation if tau>0

rng('shuffle') %generate new random initial configuration each time

%PARAMETERS
%c = relative tendency to head for the center of mass of the neighbors
%tau = anticipation time (anticipation distance is tau*delta)
%N = number of particles
%L = side length of square
%t = number of time steps.
R=4; %interaction radius
delta=0.5; %displacement per time step


% MATRICES FOR COLLECTING IN-SIMULATION MEASUREMENTS
A=zeros(1,50); %for collecting alignment values
AX=zeros(1,50);
AY=zeros(1,50);
AZ=zeros(1,50);
SA=zeros(1,50); %for collecting size values
SAX=zeros(1,50);
SAY=zeros(1,50);
SAZ=zeros(1,50);


%INITIALIZE PARTICLE POSTIONS, HEADINGS and PREDICTED POSITIONS 
P=zeros(N,3); % Create initial population
G=zeros(N,3); % Predictions
for i=1:N % Initiate each of the N individuals.
    P(i,1)=rand*L; % Initiates x-coordinate.
    P(i,2)=rand*L; % Initiates y-coordinate.
    P(i,3)=rand*2*pi-pi; % Initiates angle [-pi,pi].
    G(i,1)=mod(P(i,1)+delta*cos(P(i,3)),L);
    G(i,2)=mod(P(i,2)+delta*sin(P(i,3)),L);
    G(i,3)=P(i,3);
end


%INITIALIZE HELP VARIABLES
 k=1; %Timestep
 S=0; 
 SS=0;
 SSS=0;
 LL=0;


while k<=t && S<50 && SS<50 && SSS<50 && LL<50% While number of time steps k<T & no particular group type detected.          

%             %----Plotting------------------------------------------------
%             plot(P(:,1),P(:,2),'k.','markersize',10);
%             hold on
%             for r=1:N
%                 plot([P(r,1),P(r,1)+0.2*cos(P(r,3))],[P(r,2),P(r,2)+0.2*sin(P(r,3))],'r-');
%             end
%             hold off
%             axis([0 L 0 L]);
%             xlabel('X position')
%             ylabel('Y position')
%             axis manual
%             U(k)=getframe; %makes a movie fram from the plot
%             %-------------------------------------------------------------


   PP=zeros(N,3); %Initiate array for simultaneous update

   for i=1:N %Anticipated future position of each particle        
        G(i,1)=mod(P(i,1)+tau*delta*cos(P(i,3)),L);
        G(i,2)=mod(P(i,2)+tau*delta*sin(P(i,3)),L);
        G(i,3)=P(i,3);
   end

   for i=1:N %Update each particle

        %Do not use prediction for particle i itself
        G(i,1)=P(i,1);
        G(i,2)=P(i,2);

        %FIND NEIGHBOURS AND CALCULATE C (if tau=0) or aC if (tau>0)
        %nh2DL calculates for each particle i
        %1. its neighborhood (i.e. finds the particles in its neighborhood.) 
        %2. the direction from it toward the local center of mass of its (anticipated) neighborhood (C)

        CMAL=nh2DL(i,G,R,L,0); 

        C=CMAL(1,:); % Direction toward the LCM
        n=CMAL(3,1); % Number of non-self neighbors

        D=[cos(P(i,3)),sin(P(i,3))]; %Previous heading

        if n==0 %If no neighbours no local interactions

            Dir=D; 

        else %if at least one neighbour local interactions C (or aC)

            Dir=c*C+D;

        end


        NormDir=(1/(Dir(1,1)^2+Dir(1,2)^2)^0.5)*Dir; %Normalized new direction

        PP(i,3)=atan2(NormDir(1,2),NormDir(1,1)); %New directional angle

        %Update position   
        PP(i,1)=mod(P(i,1)+delta*NormDir(1,1),L); %New x-coordinate
        PP(i,2)=mod(P(i,2)+delta*NormDir(1,2),L); %New y-coordinate

   end
   
   P(1:N,:)=PP(1:N,:); % Update all positions simultaneously
          
       
    %SCALED SIZE CALCULATION
    sa1=((max(P(:,1))-min(P(:,1)))*(max(P(:,2))-min(P(:,2))))/L^2; %works if shape does not cross any border
    %NEW sa MEASURE
    %1. translate in X
    PX=P(:,1)+(P(:,1)<L/2)*L; %translate points with x-coordinate less than L/2 by L (crosses border in x)
    saX=((max(PX)-min(PX))*(max(P(:,2))-min(P(:,2))))/L^2;
    PY=P(:,2)+(P(:,2)<L/2)*L; %translate points with y-coordinate less than L/2 by L (crosses border in y)
    saY=((max(P(:,1))-min(P(:,1)))*(max(PY)-min(PY)))/L^2;
    saXY=((max(PX)-min(PX))*(max(PY)-min(PY)))/L^2; %Translate both x and y-coordinates (crosses border in both x and y)
    sa=min([sa1,saX,saY,saXY]);
    
    %ALIGNMENT CALCULATION
    al=(1/N)*sqrt(sum(cos(P(:,3)))^2+sum(sin(P(:,3)))^2);

        % DETECT COHESIVE GROUP
        if sa<0.01 && k<t-50 %If sa<0.01 over 50 consecutive timesteps a cohesive group has certainly formed
            S=S+1;
            A(1,S)=al;
            SA(1,S)=sa;
        else
            S=0; 
            A=zeros(1,50);
            SA=zeros(1,50);
        end
        
        % DETECT ALIGNED GROUP
        if al>0.995 && k<t-50 %if al>0.995 over 50 consecutive timesteps we definitely have a dynamic group
            SS=SS+1;
            AX(1,SS)=al;
            SAX(1,SS)=sa;
        else
            SS=0; 
            AX=zeros(1,50);
            SAX=zeros(1,50);
        end
        
        % DETECT POLARIZED GROUP
        if al<0.02 && sa<0.25 && sa>0.01 && k<t-50 %if al<0.001 over 50 consecutive timesteps we definitely have a polarized group
            SSS=SSS+1;
            AY(1,SSS)=al;
            SAY(1,SSS)=sa;
        else
            SSS=0; 
            AY=zeros(1,50);
            SAY=zeros(1,50);
        end
        
        % DETECT RUNNING OUT OF TIME
        if k>=t-50 && S<50 && SS<50
            LL=LL+1;
            AZ(1,LL)=al;
            SAZ(1,LL)=sa;
        end
    
    k=k+1;
    
    end   
    
    % DECIDE WHICH GROUP TYPE WAS FOUND OR IF RAN OUT OF TIME
    if S==50
        K=1;
        M=[median(A),median(SA);mean(A),mean(SA);K,k];
    elseif SS==50
        K=2;
        M=[median(AX),median(SAX);mean(AX),mean(SAX);K,k];
    elseif SSS==50
        K=3;
        M=[median(AY),median(SAY);mean(AY),mean(SAY);K,k];
    else
        K=4;
        M=[median(AZ),median(SAZ);mean(AZ),mean(SAZ);K,k];
    end
    