% This script investigates how sensitive the crossover and CM curves are to
% size and morphology. This is helpful in knowing what behavior to expect
% from heterogeneous populations.

clear;
savepath='C:\Users\Sonya\Dropbox\Research\Research\DEP Project\Matlab scripts\CM Simulations\CM simulations package\testing scripts\'

[Ecoli_params,RBC_params,Exosome_params,Bead_params]=defineParams();

sigmed=0.1;
emed=78.5;

logfstart=3;
logfstop=9;
f=logspace(logfstart,logfstop,300);

% isotropic scaling of size
scale=[0.5 1 2 10];

% anisotropic stretching of morphology
stretch=[0.5 5 10 20];


% calculate CM for isotropic scalings 
for k=1:length(scale)
    defineParams();
    Ecoli_params_temp=cell2mat(Ecoli_params)*scale(k);
    for j=7:15
        Ecoli_params(j)={Ecoli_params_temp(j)};
    end
    for i=1:length(f)
        Med_complex=findMed_complex(sigmed,emed,f(i));
        [Ecoli_complex,Ecoli_depolarization]=findEcoli_complex(Ecoli_params{:},f(i));
        Ecoli_CM(i)=findEcoli_CM(Ecoli_complex,Ecoli_depolarization,Med_complex);
    end
    
    Ecoli_scale(:,k)=real(Ecoli_CM);
end

H1=figure;
lw=length(scale)*3+1;
cmap=hsv(length(scale));
leg=cell(1,length(scale));

for k=1:length(scale)
h=semilogx(f,Ecoli_scale(:,k),'color',cmap(k,:));
if k==1
    hold on
end
lw=lw-3;
set(h,'linewidth',lw);
leg(k)=cellstr(strcat('scaled by',{' '},num2str(scale(k))));
end

axis([10^(logfstart),10^(logfstop),-0.5,0.75]);
ylabel('CM factor','FontSize',16);
xlabel('f (Hz)','FontSize',16);
title('Isotropic Scaling of Ecoli','FontSize',18);
hleg=legend(leg);
set(hleg,'FontSize',12);
set(gca,'fontsize',16)

savename=strcat(savepath,'CM_IsotropicScale');
saveas(H1, savename,'png');
saveas(H1, savename,'fig');
hold off;


% calculate CM for anisotropic stretching 
for k=1:length(stretch)
    defineParams();
    oldlength=cell2mat(Ecoli_params(7));
    newlength=oldlength*stretch(k);
    add=newlength-oldlength;
    
    Ecoli_params(7)={newlength};
    Ecoli_params(8)={cell2mat(Ecoli_params(8))+add};
    Ecoli_params(9)={cell2mat(Ecoli_params(9))+add};
   
    for i=1:length(f)
        Med_complex=findMed_complex(sigmed,emed,f(i));
        [Ecoli_complex,Ecoli_depolarization]=findEcoli_complex(Ecoli_params{:},f(i));
        Ecoli_CM(i)=findEcoli_CM(Ecoli_complex,Ecoli_depolarization,Med_complex);
    end
    
    Ecoli_stretch(:,k)=real(Ecoli_CM);
end

% pretty picture
H2=figure;
lw=length(stretch)*3+1;
cmap=hsv(length(stretch));
leg=cell(1,length(stretch));

for k=1:length(stretch)
h=semilogx(f,Ecoli_stretch(:,k),'color',cmap(k,:));
if k==1
    hold on
end
lw=lw-3;
% set(h,'linewidth',lw);
leg(k)=cellstr(strcat('stretched by',{' '},num2str(stretch(k))));
end

xlim([10^(logfstart),10^(logfstop)]);
ylabel('CM factor','FontSize',16);
xlabel('f (Hz)','FontSize',16);
title(cellstr(strcat('Anisotropic Stretching in',{' '}, num2str(sigmed),' S/m')),'FontSize',18);
hleg=legend(leg);
set(hleg,'FontSize',12);
set(gca,'fontsize',16);

hold off;

savename=strcat(savepath,'CM_AnistropicStretch');
saveas(H2, savename,'png');
saveas(H2, savename,'fig');