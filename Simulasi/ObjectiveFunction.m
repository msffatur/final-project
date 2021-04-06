function [FitnessValue,SpeedITSE,PositionITSE,SpeedRMSE,PositionRMSE,FinalSpeed,FinalPosition] = ObjectiveFunction(x)

output = sim('simPID');

% Speed ITSE and Position ITSE
SpeedITSE = output.spd_itse.data(length(output.spd_itse.data));
PositionITSE = output.pos_itse.data(length(output.pos_itse.data));
%c1 = SpeedITSE + PositionITSE;

% Speed RSME and Position RMSE
SpeedRMSE = output.spd_rmse.data(length(output.spd_rmse.data));
PositionRMSE = output.pos_rmse.data(length(output.pos_rmse.data));
c2 = SpeedRMSE + PositionRMSE;

% Final Speed and Final Position
FinalSpeed = output.speed.data(floor(length(output.speed.data)*0.8));
FinalPosition = output.position.data(floor(length(output.position.data)*0.8)) - 325;
if FinalSpeed > 0.005
    x1 = 1e+08;
else
    x1 = 0;
end
if FinalPosition < -0.01
    x2 = 1e+08;
else
    x2 = 0;
end
c3 = (x1*abs(FinalSpeed)) + (x2*abs(FinalPosition));

% Speed Minimum Boundary
SpeedMinimum = min(output.speed.data);
if SpeedMinimum < 0
    c4 = SpeedMinimum*(-1e+8);    
else
    c4 = 0;
end

% Position Maximum Boundary
PositionMaximum = max(output.position.data);
if PositionMaximum > 325
    c5 = (PositionMaximum-325)*(1e+8);    
else
    c5 = 0;
end

%FitnessValue = c1 + c2 + c3 + c4 + c5;
%FitnessValue = c1 + c2 + c3 + c5;
FitnessValue = c2 + c3 + c4 + c5;

end