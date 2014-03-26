% This function will plot CM factor curves as a function of frequency for
% all the conductivities listed in the sigmed vector below, for both RBCs
% and Ecoli (in separate plots).

clear;
savepath='C:\Users\Sonya\Dropbox\Research\Research\DEP Project\Matlab scripts\CM Simulations\CM simulations package\testing scripts\'

[Ecoli_params,RBC_params,Exosome_params,Bead_params]=defineParams();

sigmed=[0.0001 0.0005 0.001 0.005 0.01 0.05 0.1];
emed=78.5;

% creates a log-scale vector of frequencies over the range of interest
logfstart=4;
logfstop=9;
f=logspace(logfstart,logfstop,300);

% find the real part of the CM factor at different frequency and
% conductivity and store in the matrix RBC and Ecoli
for k=1:length(sigmed)
    
    for i=1:length(f)
        Med_complex=findMed_complex(sigmed(k),emed,f(i));

        Bead_complex=findBead_complex(Bead_params{:},f(i));
        [Ecoli_complex,Ecoli_depolarization]=findEcoli_complex(Ecoli_params{:},f(i));

        Bead_CM(i)=findBead_CM(Bead_complex,Med_complex);
        Ecoli_CM(i)=findEcoli_CM(Ecoli_complex,Ecoli_depolarization,Med_complex);
    end

    RBC(:,k)=real(Bead_CM);
    Ecoli(:,k)=real(Ecoli_CM);
    
end


% make pretty pictures

cmap=hsv(length(sigmed));
H1=figure(1);
for k=1:length(sigmed)
h=semilogx(f,Ecoli(:,k),'color',cmap(k,:));
if k==1
    hold on
end
leg(k)=cellstr(strcat(num2str(sigmed(k)),' S/m'));
end

axis([10^(logfstart),10^(logfstop),-0.5,2]);
ylabel('CM factor','FontSize',16);
xlabel('f (Hz)','FontSize',16);
titlestr=strcat('E. coli DEP in different conductivities');
title(titlestr,'FontSize',18);
hleg=legend(leg);
set(hleg,'FontSize',12);
set(gca,'fontsize',16)

savename=strcat(savepath,'CMcurves_Ecoli');
saveas(H1, savename,'png');
saveas(H1, savename,'fig');

H2=figure(2);
for k=1:length(sigmed)
h=semilogx(f,RBC(:,k),'color',cmap(k,:));
if k==1
    hold on
end
leg(k)=cellstr(strcat(num2str(sigmed(k)),' S/m'));
end

axis([10^(logfstart),10^(logfstop),-0.5,1]);
ylabel('CM factor','FontSize',16);
xlabel('f (Hz)','FontSize',16);
titlestr=strcat('RBC DEP in different conductivities')
title(titlestr,'FontSize',18);
hleg=legend(leg);
set(hleg,'FontSize',12);
set(gca,'fontsize',16)

savename=strcat(savepath,'CMcurves_RBC');
saveas(H2, savename,'png');
saveas(H2, savename,'fig');
