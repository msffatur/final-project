function Input = format_modifier(time,data)

MatIn = zeros(length(time),2);

for i = 1:length(time)
    MatIn(i,1) = time(i);
    MatIn(i,2) = data(i);
end

Input = MatIn;

end