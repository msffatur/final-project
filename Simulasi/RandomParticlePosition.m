function x = RandomParticlePosition(c,UB)

r1 = rand(1,6);
%r2 = rand(1);
%r2 = 0.1;
%r = r1.^(10*r2);
x = c*r1.*UB;
%x = r1;

end