function X=fig3heat

load AMean
load SMean

cA=heatm3(AMean');
cS=heatm3(SMean');

subplot(2,1,1)
imagesc(cA);
xticks([1 5 9 13 17 21 25 29 33])
xticklabels({})
ylabel('Polarization (\alpha)')
yticks([0.5 25.5 50.5])
yticklabels({0,0.5,1})
colormap(flipud(gray))
axis xy

subplot(2,1,2)
imagesc(cS);
xticks([1 5 9 13 17 21 25 29 33])
xticklabels({'0','1','2','3','4','5','6','7','8'})
xlabel('\tau (anticipation time)')
ylabel('Scaled size (\sigma)')
yticks([0.5 25.5 50.5])
yticklabels({0,0.5,1})
axis xy
