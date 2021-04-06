function [ar,vr,sr] = init_reference(numref)

[a,v,s] = pick_reference(numref);
a_mod1 = load(a);
v_mod1 = load(v);
s_mod1 = load(s);
ar = format_modifier(a_mod1.ans.time,a_mod1.ans.data); % Acceleration Reference
vr = format_modifier(v_mod1.ans.time,v_mod1.ans.data); % Speed Reference
sr = format_modifier(s_mod1.ans.time,s_mod1.ans.data); % Distance Reference

end