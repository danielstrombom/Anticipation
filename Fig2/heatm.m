function P=heatm(M)

M=M(:,2:100);
T=size(M,1);
c=size(M,2);

P=zeros(50,c);


for i=1:T
    for j=1:c
        k=1;
        S=0;
        while S==0
            if M(i,j)<=k/50
                P(k,j)=P(k,j)+1;
                S=1;
            end
            k=k+1;
        end
    end
end
P=(1/100)*P;

%imagesc(P);
        