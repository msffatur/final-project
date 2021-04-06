for N = 1:NVAR
    x(N) = Swarm.Global.BestPosition(N);
end
ObjectiveFunction(x);

x1 = linspace(1,ITER,ITER);
x2 = linspace(1,ITER,ITER);
y1 = Swarm.History.Mean;
y2 = Swarm.History.Best;

figure(1);
plot(x1,y1),
xlabel('Iteration');
ylabel('Fitness Mean');
title('Fitness Mean Curve');

figure(2);
plot(x2,y2),
xlabel('Iteration');
ylabel('Best Fitness');
title('Best Fitness Curve');
