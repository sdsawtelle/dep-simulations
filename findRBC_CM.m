function RBC_CM = findRBC_CM(RBC_complex,Med_complex)

% In this script red blood cells are modeled as oblate spheroids with a
% single shell. The detailed mathematical model is found in the journal
% Electrophoresis in the 2008 article "Bovine red blood cell starvation..."
% by Gagnon, Gordon, Sengupta and Chang.


RBC_CM=(RBC_complex-Med_complex)/(RBC_complex+2*Med_complex);

end

