function X=LabAnticipationTau

%Function for generating figure 3.

%PARAMETERS
t=15000; %t=number of time steps in each simulation
N=100; %N=number of particles
L=10; %L=size of square
T=100; %Number of runs for each tau value


c=0.1;
tau=0:0.25:8;
st=size(tau,2);
AMean=zeros(st,T);
SMean=zeros(st,T);

for k=1:T
    for j=1:st
            M=anticipation(N,L,tau(1,j),c,t);
            AMean(j,k)=M(1,1);
            SMean(j,k)=M(1,2);
    end

    save AMean AMean
    save SMean SMean

end    

fig3heat




