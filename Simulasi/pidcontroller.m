function x = pidcontroller(data1,data2,data3,data4,data5,P)

pidset.empty_passenger = data1.Swarm.Global.BestPosition;
pidset.quarter_passenger = data2.Swarm.Global.BestPosition;
pidset.half_passenger = data3.Swarm.Global.BestPosition;
pidset.three_quarter_passenger = data4.Swarm.Global.BestPosition;
pidset.full_passenger = data5.Swarm.Global.BestPosition;

if P == 0
    x = pidset.empty_passenger;
elseif P < 22
    x = ((pidset.quarter_passenger - pidset.empty_passenger)*(P/22)) + pidset.empty_passenger;
elseif P < 44
    x = ((pidset.half_passenger - pidset.quarter_passenger)*((P-22)/22)) + pidset.quarter_passenger;
elseif P < 66
    x = ((pidset.three_quarter_passenger - pidset.half_passenger)*((P-44)/22)) + pidset.half_passenger;
elseif P < 88
    x = ((pidset.full_passenger - pidset.three_quarter_passenger)*((P-66)/22)) + pidset.three_quarter_passenger;
else
    x = pidset.full_passenger;
end

end