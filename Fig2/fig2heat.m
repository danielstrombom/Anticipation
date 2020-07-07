function X=fig2heat

load waAMean
load waSMean
load woaAMean
load woaSMean

cA=heatm(waAMean);
cS=heatm(waSMean);
ScA=heatm(woaAMean);
ScS=heatm(woaSMean);

subplot(2,2,1)
imagesc(ScA);
colormap(flipud(gray))
xticks([9 19 29 39 49 59 69 79 89 99])
xticklabels({})
%xticklabels({0.2,0.4,0.6,0.8,1,1.2,1.4,1.6,1.8,2})
%xlabel('c (relative strength of local attraction)')
ylabel('Polarization (\alpha)')
title('Without anticipation (\tau=0)')
yticks([0.5 25.5 50.5])
yticklabels({0,0.5,1})
axis xy

subplot(2,2,2)
imagesc(cA);
xticks([9 19 29 39 49 59 69 79 89 99])
%xticklabels({0.2,0.4,0.6,0.8,1,1.2,1.4,1.6,1.8,2})
xticklabels({})
%xlabel('c (relative strength of local attraction)')
%ylabel('Polarization (\alpha)')
title('With anticipation (\tau=1)')
yticks([0.5 25.5 50.5])
yticklabels({})
%yticklabels({0,0.5,1})
axis xy

subplot(2,2,3)
imagesc(ScS);
xticks([9 19 29 39 49 59 69 79 89 99])
xticklabels({0.2,0.4,0.6,0.8,1,1.2,1.4,1.6,1.8,2})
xlabel('c (relative strength of local attraction)')
ylabel('Scaled size (\sigma)')
yticks([0.5 25.5 50.5])
yticklabels({0,0.5,1})
axis xy

subplot(2,2,4)
imagesc(cS);
xticks([9 19 29 39 49 59 69 79 89 99])
xticklabels({0.2,0.4,0.6,0.8,1,1.2,1.4,1.6,1.8,2})
xlabel('c (relative strength of local attraction)')
%ylabel('Scaled size (\sigma)')
yticks([0.5 25.5 50.5])
yticklabels({})
%yticklabels({0,0.5,1})
axis xy
