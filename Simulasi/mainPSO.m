clear, clc, close all;

%% System Setup

% Number of Passenger
P = 88;
[A,B,C,D] = SystemModel(P);
G = ss(A,B,C,D);

% Model of Profile Reference
modref = 6; 
[acc,spd,dis] = init_reference(modref);
[acc_ref,spd_ref,dis_ref] = add_reference(acc,spd,dis,20);

% Controller Reference
[ZN,CC] = HeuristicMethod(G);
Ts = 0.1;

%% Particle Swarm Optimization Options

Swarm.Options.Particles = 100;
Swarm.Options.MaximumIteration = 150;
Swarm.Options.Varibles = 6;
Swarm.Options.Boundary.Constant = 1.5e+04;
%Swarm.Options.Boundary.UpperBound = ones(1,6);
Swarm.Options.Boundary.UpperBound = [1 1 1 0 0 0];
%Swarm.Options.Boundary.UpperBound = [CC(1) CC(2) CC(3) CC(1)/8.125 CC(2)/8.125 CC(3)/8.125];
Swarm.Options.Boundary.LowerBound = zeros(1,6);
Swarm.Options.SelfAdjustmentConstant = 1.49;
Swarm.Options.SocialAdjustmentConstant = 1.49;
Swarm.Options.InertiaWeight = 0.2;
Swarm.Options.StopCriterion = 30;

%% Initialization

fprintf("==========>=========>==========>===========> Initialization Start <==========<==========<==========<==========\n")

SWARM = Swarm.Options.Particles;
NVAR = Swarm.Options.Varibles;
UB = Swarm.Options.Boundary.UpperBound;
LB = Swarm.Options.Boundary.LowerBound;

for i = 1:SWARM
%    if i == 1
%        Swarm.Particle(i).Position = [82000 2600 150 8800 1 1600];
%    else
%        Swarm.Particle(i).Position = RandomParticlePosition(Swarm.Options.Boundary.Constant,UB);
%    end
    Swarm.Particle(i).Position = RandomParticlePosition(Swarm.Options.Boundary.Constant,UB);
    Swarm.Particle(i).BestPosition = Swarm.Particle(i).Position;
    Swarm.Particle(i).Velocity = zeros(1,6);
    for j = 1:NVAR
        x(j) = Swarm.Particle(i).Position(1,j);
    end
    [s.FitVal,s.sITSE,s.pITSE,s.sRMSE,s.pRMSE,s.FinSpd,s.FinPos] = ObjectiveFunction(x);
    Swarm.Particle(i).FitnessValue = s.FitVal;
    Swarm.Particle(i).BestFitnessValue = Swarm.Particle(i).FitnessValue;
    Swarm.Particle(i).Results = [s.sITSE s.pITSE s.sRMSE s.pRMSE s.FinSpd s.FinPos];
    fprintf("Iter: Init,\tAgent: %f,\tFitness Value: %f\n",i,Swarm.Particle(i).FitnessValue)
end

Swarm.Global.BestFitnessValue = inf;
for i = 1:SWARM
    if Swarm.Global.BestFitnessValue > Swarm.Particle(i).BestFitnessValue
        Swarm.Global.BestFitnessValue = Swarm.Particle(i).BestFitnessValue;
        Swarm.Global.BestPosition = Swarm.Particle(i).Position;
        Swarm.Global.BestAgent = i;
        Swarm.Global.Result.Speed.ITSE = Swarm.Particle(i).Results(1);
        Swarm.Global.Result.Speed.RMSE = Swarm.Particle(i).Results(3);
        Swarm.Global.Result.Speed.Final = Swarm.Particle(i).Results(5);
        Swarm.Global.Result.Position.RMSE = Swarm.Particle(i).Results(2);
        Swarm.Global.Result.Position.ITSE = Swarm.Particle(i).Results(4);
        Swarm.Global.Result.Position.Final = Swarm.Particle(i).Results(6);
    end
end

fprintf("\n==========>=========>==========>===========> Initialization Results <==========<==========<==========<==========\n")
fprintf("gbest \t= %f\t\t\tAgent: %f\n", Swarm.Global.BestFitnessValue,Swarm.Global.BestAgent)
fprintf("Kp_spd \t= %f \tKi_spd = %f \tKd_spd = %f \n",Swarm.Global.BestPosition(1),Swarm.Global.BestPosition(2),Swarm.Global.BestPosition(3))
fprintf("Kp_pos \t= %f \tKi_pos = %f \tKd_pos = %f \n",Swarm.Global.BestPosition(4),Swarm.Global.BestPosition(5),Swarm.Global.BestPosition(6))
fprintf("\n==========>=========>==========>===========> Performance <==========<==========<==========<==========\n")
fprintf("Speed ITSE \t\t= %f \tSpeed RMSE \t\t= %f \t\tFinal Speed \t= %f m/s\n",Swarm.Global.Result.Speed.ITSE,Swarm.Global.Result.Speed.RMSE,Swarm.Global.Result.Speed.Final)
fprintf("Position ITSE \t= %f \tPosition RMSE \t= %f \tFinal Position \t= %f m\n",Swarm.Global.Result.Position.ITSE,Swarm.Global.Result.Position.RMSE,Swarm.Global.Result.Position.Final)

%% Simulation

W = Swarm.Options.InertiaWeight;
SEA = Swarm.Options.SelfAdjustmentConstant;
SOA = Swarm.Options.SocialAdjustmentConstant;
ITER = 1;
FitnessTotal = 0;
i = 0;

while and(i < Swarm.Options.StopCriterion, ITER < (Swarm.Options.MaximumIteration + 1))
    fprintf("\n=========>==========>===========> Iteration : %f, Stop Criterion : %f <==========<==========<==========\n",ITER,i)
    for j = 1:SWARM
        x1 = W*Swarm.Particle(j).Velocity;
        x2 = SEA*rand(1,NVAR).*(Swarm.Particle(j).BestPosition - Swarm.Particle(j).Position);
        x3 = SOA*rand(1,NVAR).*(Swarm.Global.BestPosition - Swarm.Particle(j).Position);
        Swarm.Particle(j).Velocity = x1 + x2 + x3;
        Swarm.Particle(j).Position = Swarm.Particle(j).Position + Swarm.Particle(j).Velocity;
        for k = 1:NVAR
            if Swarm.Particle(j).Position(k) > Swarm.Options.Boundary.Constant*UB(k)
                Swarm.Particle(j).Position(k) = Swarm.Options.Boundary.Constant*UB(k);
            end
            if Swarm.Particle(j).Position(k) < LB(k)
                Swarm.Particle(j).Position(k) = LB(k);
            end
        end
        for k = 1:NVAR
            x(k) = Swarm.Particle(j).Position(1,k);
        end
        [s.FitVal,s.sITSE,s.pITSE,s.sRMSE,s.pRMSE,s.FinSpd,s.FinPos] = ObjectiveFunction(x);
        Swarm.Particle(j).FitnessValue = s.FitVal;
        FitnessTotal = FitnessTotal + Swarm.Particle(j).FitnessValue;
        Swarm.Particle(j).Results = [s.sITSE s.pITSE s.sRMSE s.pRMSE s.FinSpd s.FinPos];
        if Swarm.Particle(j).FitnessValue < Swarm.Particle(j).BestFitnessValue
            Swarm.Particle(j).BestFitnessValue = Swarm.Particle(j).FitnessValue;
            Swarm.Particle(j).BestPosition = Swarm.Particle(j).Position;
        end
        if Swarm.Particle(j).BestFitnessValue < Swarm.Global.BestFitnessValue
            Swarm.Global.BestFitnessValue = Swarm.Particle(j).BestFitnessValue;
            Swarm.Global.BestPosition = Swarm.Particle(j).BestPosition;
            Swarm.Global.BestAgent = j;
            Swarm.Global.Result.Speed.ITSE = Swarm.Particle(j).Results(1);
            Swarm.Global.Result.Speed.RMSE = Swarm.Particle(j).Results(3);
            Swarm.Global.Result.Speed.Final = Swarm.Particle(j).Results(5);
            Swarm.Global.Result.Position.RMSE = Swarm.Particle(j).Results(4);
            Swarm.Global.Result.Position.ITSE = Swarm.Particle(j).Results(2);
            Swarm.Global.Result.Position.Final = Swarm.Particle(j).Results(6);
        end
        fprintf("Iter: %f,\tAgent: %f,\tFitness Value: %f\n",ITER,j,Swarm.Particle(j).FitnessValue)
    end
    fprintf("\nIteration Results:\tgbest = %f\tAgent: %f\n", Swarm.Global.BestFitnessValue,Swarm.Global.BestAgent)
    fprintf("Iteration Results:\tKp_spd = %f \tKi_spd = %f \tKd_spd = %f \n",Swarm.Global.BestPosition(1),Swarm.Global.BestPosition(2),Swarm.Global.BestPosition(3))
    fprintf("Iteration Results:\tKp_pos = %f \tKi_pos = %f \tKd_pos = %f \n",Swarm.Global.BestPosition(4),Swarm.Global.BestPosition(5),Swarm.Global.BestPosition(6))
    fprintf("Performance:\tSpeed ITSE \t\t= %f \tSpeed RMSE \t\t= %f \t\tFinal Speed \t= %f m/s\n",Swarm.Global.Result.Speed.ITSE,Swarm.Global.Result.Speed.RMSE,Swarm.Global.Result.Speed.Final)
    fprintf("Performance:\tPosition ITSE \t= %f \tPosition RMSE \t= %f \tFinal Position \t= %f m\n",Swarm.Global.Result.Position.ITSE,Swarm.Global.Result.Position.RMSE,Swarm.Global.Result.Position.Final)
    Swarm.History.Mean(ITER) = FitnessTotal/SWARM;
    FitnessTotal = 0;
    Swarm.History.Best(ITER) = Swarm.Global.BestFitnessValue;
    if ITER > 1
        if Swarm.History.Best(ITER) < Swarm.History.Best(ITER - 1)
            i = 0;
        else
            i = i + 1;
        end
    end
    SimulationResults
    ITER = ITER + 1;
end

%% Simulation Result

fprintf("\n==========>=========>==========>===========> Simulation Results <==========<==========<==========<==========\n")
fprintf("gbest = %f\t\t\tTotal Iteration: %f\n", Swarm.Global.BestFitnessValue,ITER)
fprintf("Kp_spd \t= %f \tKi_spd = %f \tKd_spd = %f \n",Swarm.Global.BestPosition(1),Swarm.Global.BestPosition(2),Swarm.Global.BestPosition(3))
fprintf("Kp_pos \t= %f \tKi_pos = %f \tKd_pos = %f \n",Swarm.Global.BestPosition(4),Swarm.Global.BestPosition(5),Swarm.Global.BestPosition(6))
fprintf("\n==========>=========>==========>===========> Performance <==========<==========<==========<==========\n")
fprintf("Speed ITSE \t\t= %f \tSpeed RMSE \t\t= %f \tFinal Speed \t= %f m/s\n",Swarm.Global.Result.Speed.ITSE,Swarm.Global.Result.Speed.RMSE,Swarm.Global.Result.Speed.Final)
fprintf("Position ITSE \t= %f \tPosition RMSE \t= %f \tFinal Position \t= %f m\n\n",Swarm.Global.Result.Position.ITSE,Swarm.Global.Result.Position.RMSE,Swarm.Global.Result.Position.Final)

for i = 1:NVAR
    x(i) = Swarm.Global.BestPosition(1,i);
end
sim('simPID');
save('SimulationProcess');
