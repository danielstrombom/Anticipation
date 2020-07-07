function X=LabAnticipation

%Function used to generate figure 2. 

%PARAMETERS
t=15000; %t=number of time steps in each simulation
N=50; %N=number of particles
L=10; %L=size of square
T=100; %Number of runs for each c calue

%ATTRACTION VALUE VECTOR
c=0.02:0.02:2;
sc=size(c,2);

%WITH ANTICIPATION (tau=1)
tau=1;
waAMean=zeros(T,sc);
waSMean=zeros(T,sc);
waTTime=zeros(T,sc);

for k=1:T
for i=1:sc
    M=anticipation(N,L,tau,c(1,i),t);
    waAMean(k,i)=M(1,1);
    waSMean(k,i)=M(1,2);
    waTTime(k,i)=M(3,2);
    
    [1 k c(1,i) M(3,2)]
end
save waAMean waAMean
save waSMean waSMean
save waTTime waTTime
end

%WITHOUT ANTICIPATION (tau=0)
tau=0;
woaAMean=zeros(T,sc);
woaSMean=zeros(T,sc);
woaTTime=zeros(T,sc);

for k=1:T
for i=1:sc
    M=anticipation(N,L,tau,c(1,i),t);
    woaAMean(k,i)=M(1,1);
    woaSMean(k,i)=M(1,2);
    woaTTime(k,i)=M(3,2);
    
    [1 k c(1,i) M(3,2)]
end

save woaAMean woaAMean
save woaSMean woaSMean
save woaTTime woaTTime
end

fig2heat;
