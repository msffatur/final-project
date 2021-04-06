function [a,v,s] = pick_reference(numref)

acc = 'percepatan';
spd = 'kecepatan';
dis = 'jarak';
format = '.mat';
a = append(acc,string(numref),format);
v = append(spd,string(numref),format);
s = append(dis,string(numref),format);

end