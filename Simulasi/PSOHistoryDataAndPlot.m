clear, close all, clc;

data1 = load('SimulationProcess1000P0'); % 0 passenger
data2 = load('SimulationProcess1000P22'); % 22 passenger
data3 = load('SimulationProcess1000P44'); % 44 passenger
data4 = load('SimulationProcess1000P66'); % 66 passenger
data5 = load('SimulationProcess1000P88'); % 88 passenger

BestHistory1 = data1.Swarm.History.Best;
BestHistory2 = data2.Swarm.History.Best;
BestHistory3 = data3.Swarm.History.Best;
BestHistory4 = data4.Swarm.History.Best;
BestHistory5 = data5.Swarm.History.Best;

pid0 = data1.Swarm.Global.BestPosition;
pid22 = data2.Swarm.Global.BestPosition;
pid44 = data3.Swarm.Global.BestPosition;
pid66 = data4.Swarm.Global.BestPosition;
pid88 = data5.Swarm.Global.BestPosition;

x1 = linspace(1,length(BestHistory1),length(BestHistory1));
figure('Name','PSO Best Fitness Value History','Color','white')
plot(x1,BestHistory1),
xlabel('Iteration');
ylabel('Value');
grid on;
title('G_b_e_s_t 0 Passenger');
fprintf('PSO best fitness value was ploted\n')

x2 = linspace(1,length(BestHistory2),length(BestHistory2));
figure('Name','PSO Best Fitness Value History','Color','white')
plot(x2,BestHistory2),
xlabel('Iteration');
ylabel('Value');
grid on;
title('G_b_e_s_t 22 Passenger');
fprintf('PSO best fitness value was ploted\n')

x3 = linspace(1,length(BestHistory3),length(BestHistory3));
figure('Name','PSO Best Fitness Value History','Color','white')
plot(x3,BestHistory3),
xlabel('Iteration');
ylabel('Value');
grid on;
title('G_b_e_s_t 44 Passenger');
fprintf('PSO best fitness value was ploted\n')

x4 = linspace(1,length(BestHistory4),length(BestHistory4));
figure('Name','PSO Best Fitness Value History','Color','white')
plot(x4,BestHistory4),
xlabel('Iteration');
ylabel('Value');
grid on;
title('G_b_e_s_t 66 Passenger');
fprintf('PSO best fitness value was ploted\n')

x5 = linspace(1,length(BestHistory5),length(BestHistory5));
figure('Name','PSO Best Fitness Value History','Color','white')
plot(x5,BestHistory5),
xlabel('Iteration');
ylabel('Value');
grid on;
title('G_b_e_s_t 88 Passenger');
fprintf('PSO best fitness value was ploted\n')

fprintf('=====>=====>=====> History Results <=====<=====<=====\n')
fprintf('=====>=====> 0 Passenger <=====<=====\n')
fprintf('Gbest \t= %f\n',BestHistory1(length(BestHistory1)))
fprintf('Iteration Total: \t%f\n',length(BestHistory1))
fprintf("Kp_spd = %f \tKi_spd = %f \tKd_spd = %f \n",pid0(1),pid0(2),pid0(3))
fprintf("Kp_pos = %f \tKi_pos = %f \t\tKd_pos = %f \n",pid0(4),pid0(5),pid0(6))    
fprintf('=====>=====> 22 Passenger <=====<=====\n')
fprintf('Gbest \t= %f\n',BestHistory2(length(BestHistory2)))
fprintf('Iteration Total: \t%f\n',length(BestHistory2))
fprintf("Kp_spd = %f \tKi_spd = %f \tKd_spd = %f \n",pid22(1),pid22(2),pid22(3))
fprintf("Kp_pos = %f \tKi_pos = %f \t\tKd_pos = %f \n",pid22(4),pid22(5),pid22(6))    
fprintf('=====>=====> 44 Passenger <=====<=====\n')
fprintf('Gbest \t= %f\n',BestHistory3(length(BestHistory3)))
fprintf('Iteration Total: \t%f\n',length(BestHistory3))
fprintf("Kp_spd = %f \tKi_spd = %f \tKd_spd = %f \n",pid44(1),pid44(2),pid44(3))
fprintf("Kp_pos = %f \tKi_pos = %f \t\tKd_pos = %f \n",pid44(4),pid44(5),pid44(6))
fprintf('=====>=====> 66 Passenger <=====<=====\n')
fprintf('Gbest \t= %f\n',BestHistory4(length(BestHistory4)))
fprintf('Iteration Total: \t%f\n',length(BestHistory4))
fprintf("Kp_spd = %f \tKi_spd = %f \tKd_spd = %f \n",pid66(1),pid66(2),pid66(3))
fprintf("Kp_pos = %f \tKi_pos = %f \t\tKd_pos = %f \n",pid66(4),pid66(5),pid66(6))    
fprintf('=====>=====> 88 Passenger <=====<=====\n')
fprintf('Gbest \t= %f\n',BestHistory5(length(BestHistory5)))
fprintf('Iteration Total: \t%f\n',length(BestHistory5))
fprintf("Kp_spd = %f \tKi_spd = %f \tKd_spd = %f \n",pid88(1),pid88(2),pid88(3))
fprintf("Kp_pos = %f \tKi_pos = %f \t\tKd_pos = %f \n",pid88(4),pid88(5),pid88(6))
