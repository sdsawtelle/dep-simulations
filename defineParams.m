function [Ecoli_params,RBC_params,Exosome_params,Bead_params]=defineParams()

% all values are given in SI units in this function. This script sets the
% geometric and material properties of the particles.


% 	EColi are modeled as 3-shelled prolate spheroids. For multi-shelled particles I will use the 
% 	convention that for a given dimension the outermost radius is a0, the next outermost is a1 etc.

    

    sigcyt = 0.19;
    sigmem = 5*10^(-8);
    sigwall = 0.68;
    ecyt = 61;
    emem = 10.8;
    ewall = 60;
    a2 = 1.37*10^(-6);
    b2 = 0.315*10^(-6);
    c2 = b2;
    a1 = 1.375*10^(-6);
    b1 = 0.32*10^(-6);
    c1 = b1;
    a0 = 1.395*10^(-6);
    b0 = 0.34*10^(-6);
    c0 = b0;

    Ecoli_params={sigcyt,sigmem,sigwall,ecyt,emem,ewall,a0,a1,a2,b0,b1,b2,c0,c1,c2};

    % RBCs are modeled as single-shelled oblate spheroids with radius r, height c, and
    % half length a, bound by a membrane of thickness d where ao+d=a1.

    sigcyt=0.31;
    sigmem=1*10^(-6);
    ecyt = 59;
    emem = 4.44;
    a1 = 2.5*10^(-6);
    a0 = 2.509*10^(-6);
    
    RBC_params={sigcyt,sigmem,ecyt,emem,a0,a1};

       
    
    %{ 
        For polystyrene beads the bulk conductivity is negligible compared to the surface conductivity.
        The surface conductivity depends on the functionalization, but also more generally on the 
        conductivity of the medium due to differences in bound charge layers (this dependence is usually
        ignored). Bead conductivity is given by sigbead=2*Ks/a
    %}

    Ks=1.2*10^(-9);
    ebead=2.55;
    a=10^(-6);

    Bead_params={Ks,ebead,a};



    %{ 
        Exosomes are modeled as single-shelled spherical particles with cytoplasmic and membrane 
        parameters taken as equal to those of RBCs
    %}

    sigcyt = 0.31;
    sigmem = 1*10^(-6);
    ecyt = 59;
    emem = 4.44;
    a1 = 3.3*10^(-6);
    a0 = 3.309*10^(-6);

    
    Exosome_params={sigcyt,sigmem,ecyt,emem,a0,a1};


end