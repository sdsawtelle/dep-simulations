%{
	A description of the mathematical model used here can be found in the 2011 Lab on a Chip
	paper "Continuous dielectrophoretic bacterial..." by Park,Zhang,Wang and Yang.
	The non-spherical shape results in the CM factor being calculated based on the average
	value along each principle axis. In addition, the expression for each CM is slightly
	different from the standard expression, involving a 'depolarization factor. Consequently 
	this function must return two things for _each_ axis, a complex permittivity(#) and a 
	depolarization factor (3-vector).
%}

function [Ecoli_complex,Ecoli_depolarization]=findEcoli_complex(sigcyt,sigmem,sigwall,ecyt,emem,ewall,a0,a1,a2,b0,b1,b2,c0,c1,c2,f)

	w=2*pi*f;
	e0=8.85*10^(-12);

	lambda1=(a1*b1*c1)/(a0*b0*c0);
	lambda2=(a2*b2*c2)/(a1*b1*c1);
	
	a=[a0,a1,a2];
	b=[b0,b1,b2];
	c=b;
	
	for i=1:3
		q(i)=a(i)/b(i);
		A(i,1)=q(i)/(q(i)^2-1)^(3/2)*log(q(i)+(q(i)^2-1)^(1/2))-1/(q(i)^2-1);
		A(i,2)=(1/2)*(1-A(i,1));
		A(i,3)=A(i,2);
	end
	
	Ecoli_depolarization=A;

	compcyt=complex(ecyt,-1/(w*e0)*sigcyt);
	compmem=complex(emem,-1/(w*e0)*sigmem);
	compwall=complex(ewall,-1/(w*e0)*sigwall);
	
	for j=1:3
		E2(j)=compmem*(compmem+A(3,j)*(compcyt-compmem)+lambda2*(compcyt-compmem)*(1-A(2,j)))/(compmem+A(3,j)*(compcyt-compmem)-lambda2*A(2,j)*(compcyt-compmem));
		E1(j)=compwall*(compwall+A(2,j)*(E2(j)-compwall)+lambda1*(E2(j)-compwall)*(1-A(1,j)))/(compwall+A(2,j)*(E2(j)-compwall)-lambda1*(E2(j)-compwall)*A(1,j));
	end

	Ecoli_complex=E1;
