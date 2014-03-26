% This script plots of the crossover frequency shifts as the medium
% conductivity changes, and does this for several different sizes of beads.

clear;
savepath='C:\Users\Sonya\Dropbox\Research\Research\DEP Project\Matlab scripts\CM Simulations\CMsim Library\testing scripts\'

logsigstart=-4;
logsigstop=-1;
sigmed=logspace(logsigstart,logsigstop,300);

sizes=[5*10^-6 10^-6 5*10^-7];

cmap=hsv(length(sizes));
H1=figure(1);

for j=1:length(sizes)
    xovers=zeros(length(sigmed));
    
    for k=1:length(sigmed)
        xovers(k)=findBead_xover(sigmed(k),sizes(j));
    end

    loglog(sigmed(xovers>0),xovers(xovers>0),'color',cmap(j,:));
    
    if j==1
    hold on;
    end
    
    leg(j)=cellstr(strcat(num2str(sizes(j)),' m'));

end


ylabel('Crossover Frequency (Hz)','FontSize',16);
xlabel('Solution Conductivity (S/m)','FontSize',16);
titlestr=strcat('Crossover of Beads of Different Sizes');
title(titlestr,'FontSize',18);
hleg=legend(leg);
set(hleg,'FontSize',12);
set(gca,'fontsize',16)

savename=strcat(savepath,'Crossover_size');
saveas(H1, savename,'png');
saveas(H1, savename,'fig');