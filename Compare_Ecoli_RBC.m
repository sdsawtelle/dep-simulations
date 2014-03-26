% This script compares the values of the CM factor and force pre-factor for
% different particles as a function of frequency and medium conductivity.
% This will generate a heatmap illustrating the ratio between the CM
% factors or forces for the two different particles. The CM ratio heatmap
% can be interpreted as follows - when the particles experience opposite
% forces due to different sign of the CM factor, the heat map is red, when
% the forces are aligned the heatmap is green. the intensity of these
% colors represents an increasing magnitude of the CM ratio. The Force
% ratio heatmap should be interpreted as follows: red indicates that
% log(abs(force ratio)) is positive such that the magnitude of the force
% ratio is larger than 1, while green represents the magnitude of the force
% ratio is less than 1. The intensity of these values indicates how small
% or large the log is. This The particular form for these prefactors comes
% from the wikipedia page on dielectrophoresis, the ecoli variant is for a
% field-aligned ellipsoid, the RBC are taken as spherical. The reamining
% factors in the force calculation are common between the two particles
% since they involve only the medium permittivity and the electric field
% profile.

clear;
savepath='C:\Users\Sonya\Dropbox\Research\Research\DEP Project\Matlab scripts\CM Simulations\CMsim Library\testing scripts\'

[Ecoli_params,RBC_params,Exosome_params,Bead_params]=defineParams()

emed=78.5;

% create vectors for the range of solution conductivities and frequencies
logsigstart=-2;
logsigstop=0.3;
sigmed=logspace(logsigstart,logsigstop,300);

logfstart=5;
logfstop=9;
f=logspace(logfstart,logfstop,300);



% find Re(CM) for E.Coli and RBC
for k=1:length(sigmed)
    
    for i=1:length(f)
        Med_complex=findMed_complex(sigmed(k),emed,f(i));

        RBC_complex=findRBC_complex(RBC_params{:},f(i));
        [Ecoli_complex,Ecoli_depolarization]=findEcoli_complex(Ecoli_params{:},f(i));

        RBC_CM(i)=findRBC_CM(RBC_complex,Med_complex);
        Ecoli_CM(i)=findEcoli_CM(Ecoli_complex,Ecoli_depolarization,Med_complex);
    end

    RBC_ReCM(k,:)=real(RBC_CM);
    Ecoli_ReCM(k,:)=real(Ecoli_CM);
    
end



CM_compare=Ecoli_ReCM./RBC_ReCM;

HM=HeatMap(CM_compare,'DisplayRange',2,'RowLabels',sigmed);
addTitle(HM,'Ratio of CM Magnitude and Sign')
addXLabel(HM,'frequency');
addYLabel(HM,'solution conductivity');
H1=plot(HM);
savename=strcat(savepath,'CMcompare_sign_mag');
saveas(H1, savename,'png');
saveas(H1, savename,'fig');


% use the CM factor and other geometrical parameters to calculate the
% force prefactor.

majoraxis_Ecoli=Ecoli_params{9};
minoraxis_Ecoli=Ecoli_params{12};
F_Ecoli=pi/3*minoraxis_Ecoli^2*majoraxis_Ecoli*Ecoli_ReCM;

radius_RBC=RBC_params{6};
F_RBC=2*pi*radius_RBC^3*RBC_ReCM;

F_compare=F_Ecoli./F_RBC;
F_logabs=log(abs(F_compare));

HM=HeatMap(F_logabs,'DisplayRange',1,'RowLabels',sigmed);
addTitle(HM,'Log-scaled Ratio of Abs(Force)')
addXLabel(HM,'frequency');
addYLabel(HM,'solution conductivity');
H2=plot(HM);
savename=strcat(savepath,'Fcompare_log_mag');
saveas(H2, savename,'png');
saveas(H2, savename,'fig');

