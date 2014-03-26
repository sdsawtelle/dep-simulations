function Ecoli_CM = findEcoli_CM(Ecoli_complex,Ecoli_depolarization,Med_complex)

%{
	A description of the mathematical model used here can be found in the 2011 Lab on a Chip
	paper "Continuous dielectrophoretic bacterial..." by Park,Zhang,Wang and Yang.
	The non-spherical shape results in the CM factor being calculated based on the average
	value along each principle axis. In addition, the expression for each CM is slightly
	different from the standard expression, involving a 'depolarization factor. 
%}

for i=1:3
K(i)=1/3*(Ecoli_complex(i)-Med_complex)/(Med_complex+Ecoli_depolarization(1,i)*(Ecoli_complex(i)-Med_complex));
end

Ecoli_CM=1/3*(K(1)+K(2)+K(3));

end

