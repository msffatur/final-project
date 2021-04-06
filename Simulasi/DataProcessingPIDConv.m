clear, close all, clc;

%% System Setup

fprintf('==========>=========>==========>===========> System Setup <==========<==========<==========<==========\n')

% Profile Reference
modref = 6; 
[acc,spd,dis] = init_reference(modref);
[acc_ref,spd_ref,dis_ref] = add_reference(acc,spd,dis,20);
dt = 0.1;
Ts = 5e-03;
Tsim = 80;
N = (Tsim/Ts) + 1;

% PID Controller
PID.Controller(1).Parameter = [108.3927 60.9886 0 70.6302 8.9194 109.5674]; %% 0 Passenger
PID.Controller(2).Parameter = [112.8084 63.5248 0 73.5445 9.2913 114.0363]; %% 22 Passenger
PID.Controller(3).Parameter = [117.2411 66.0751 0 76.4727 9.6654 118.523]; %% 44 Passenger
PID.Controller(4).Parameter = [121.691 68.6398 0 79.4221 10.0428 123.0332]; %% 66 Passenger
PID.Controller(5).Parameter = [126.1583 71.2191 0 82.3735 10.4201 127.5500]; %% 88 Passenger

%% Simulation

for i = 1:5
    
    fprintf('\n==========>=========>==========> Simulation for %f Passenger <==========<==========<==========\n',(i-0.5)*22)
    
    % System Model
    %P = (i-0.5)*22;
    P = 44*(0.85 + (0.05*i));
    [A,B,C,D] = SystemModel(P);

    % PID Controller
    for j = 1:6
        %a = PID.Controller(i).Parameter(j);
        %b = PID.Controller(i+1).Parameter(j);
        %rangeX = [a b];
        %x(j) = mean(rangeX);
        x(j) = PID.Controller(3).Parameter(j);
    end
    
    % Running Simulation
    output = sim('simPIDConv');
    
    % Simulation Output
    Result(i).Speed.Data = output.speed.data;
    Result(i).Speed.RMSE = output.spd_rmse.data(length(output.spd_rmse.data));
    Result(i).Speed.Final = output.speed.data(length(output.speed.data));
    Result(i).Speed.Min = min(output.speed.data);
    Result(i).Speed.Max = max(output.speed.data);

    Result(i).Position.Data = output.position.data;
    Result(i).Position.RMSE = output.pos_rmse.data(length(output.pos_rmse.data));
    Result(i).Position.FinalError = output.position.data(length(output.position.data)) - 325;
    
    Result(i).Acceleration.Data = output.acceleration.data;
    Result(i).Acceleration.Min = min(output.acceleration.data);
    Result(i).Acceleration.Max = max(output.acceleration.data);
    
    Result(i).ControlInput.Data = output.controlinput.data;
    Result(i).ControlInput.Min = min(output.controlinput.data);
    Result(i).ControlInput.Max = max(output.controlinput.data);
    
    time = linspace(0,Tsim,N);
    for j = 1:N
        vref(j) = spd_ref(j,2);
        sref(j) = dis_ref(j,2);
        uppertolerance(j) = 325.1;
        lowertolerance(j) = 324.9;
    end
    [a,b,c,d,e,f] = PickName(i);

    fprintf('Data collected\n')
    
    % Speed Profile
    figure('Name','Profil Kecepatan','Color','white')
    plot(time,Result(i).Speed.Data),
    hold on;
    plot(time,vref),
    hold off;
    xlabel('Waktu (s)');
    ylabel('Kecepatan (m/s)');
    grid on;
    title(a);
    legend('PID auto-tuning','Reference');
    axis([0 90 -0.5 5]);
    fprintf('Speed profile was ploted\n')
    
    % Final Speed Profile
    figure('Name','Profil Kecepatan Akhir','Color','white')
    plot(time,Result(i).Speed.Data),
    hold on;
    plot(time,vref),
    hold off;
    xlabel('Waktu (s)');
    ylabel('Kecepatan (m/s)');
    grid on;
    title(b);
    legend('PID auto-tuning','Reference');
    axis([79 90 -0.25 0.25]);
    fprintf('Final speed profile was ploted\n')
    
    % Distance Profile
    figure('Name','Profil Jarak','Color','white')
    plot(time,Result(i).Position.Data),
    hold on;
    plot(time,sref),
    hold off;
    xlabel('Waktu (s)');
    ylabel('Jarak (m)');
    grid on;
    title(c);
    legend('PID auto-tuning','Reference');
    axis([0 90 -25 350]);
    fprintf('Distance profile was ploted\n')
    
    % Final Distance Profile
    figure('Name','Profil Jarak Akhir','Color','white')
    plot(time,Result(i).Position.Data),
    hold on;
    plot(time,sref),
    hold off;
    hold on;
    plot(time,uppertolerance,'g--'),
    hold off;
    hold on;
    plot(time,lowertolerance,'g--'),
    hold off;
    xlabel('Waktu (s)');
    ylabel('Jarak (m)');
    grid on;
    title(d);
    legend('PID auto-tuning','Reference','Tolerance Limit');
    axis([78 90 324.5 325.75]);
    fprintf('Final distance profile was ploted\n')
    
    % Control Input Profile
    figure('Name','Profil Masukan Kontrol','Color','white')
    plot(time,Result(i).ControlInput.Data),
    xlabel('Waktu (s)');
    ylabel('Masukan Kontrol (kN)');
    grid on;
    title(e);
    axis([0 90 -80 120]);
    fprintf('Control input profile was ploted\n')
    
    % Acceleration Profile
    figure('Name','Profil Percepatan','Color','white')
    plot(time,Result(i).Acceleration.Data),
    xlabel('Waktu (s)');
    ylabel('Percepatan (m/s^2)');
    grid on;
    title(f);
    axis([0 90 -1.1 1.1]);
    fprintf('Acceleration profile was ploted\n')
    
    fprintf('=====>=====> Results <=====<=====\n')
    fprintf('Final Speed \t\t\t= \t%f\n',Result(i).Speed.Final)
    fprintf('Final Distance Error \t= \t%f\n',Result(i).Position.FinalError)
    fprintf('Speed RMSE \t\t\t\t= \t%f\n',Result(i).Speed.RMSE)
    fprintf('Distance RMSE \t\t\t= \t%f\n',Result(i).Position.RMSE)
    fprintf('--------------------------------------\nBoundary \t\tMin \t\tMax\n--------------------------------------\n')
    fprintf('Speed \t\t\t%f \t%f\n',Result(i).Speed.Min,Result(i).Speed.Max)
    fprintf('Acceleration \t%f \t%f\n',Result(i).Acceleration.Min,Result(i).Acceleration.Max)
    fprintf('Control Input \t%f \t%f\n',Result(i).ControlInput.Min,Result(i).ControlInput.Max)
        
end

fprintf('==========>=========>==========>===========> Simulation Finished <==========<==========<==========<==========\n\n')
