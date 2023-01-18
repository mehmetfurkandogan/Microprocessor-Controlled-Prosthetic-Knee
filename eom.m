function dydt = eom(t,y)
    g = 9.8067;     % m/s^2
    m = 0.580;  % kg
    Lcm = 100*1e-3;  % m
    T = 0.925;      % s
    I = T^2/(4*pi^2) *m*g*Lcm;
    % I = 0.0110947;  % kg*m^2
    c = 0.0181;     % N*s/m
    k = 1000;        % N*m
    time = t;
    ax = +0.454*cos(-7*2*pi*time+1.547)+0.065*cos(-6*2*pi*time+-2.042)+0.120*cos(-5*2*pi*time+2.845)+1.123*cos(-4*2*pi*time+-3.118)+1.499*cos(-3*2*pi*time+-0.645)+2.946*cos(-2*2*pi*time+-1.809)+2.618*cos(-1*2*pi*time+-0.990)+0.091*cos(0*2*pi*time+3.142)+2.618*cos(1*2*pi*time+0.990)+2.946*cos(2*2*pi*time+1.809)+1.499*cos(3*2*pi*time+0.645)+1.123*cos(4*2*pi*time+3.118)+0.120*cos(5*2*pi*time+-2.845)+0.065*cos(6*2*pi*time+2.042)+0.454*cos(7*2*pi*time+-1.547);
    ay = +0.445*cos(-7*2*pi*time+0.788)+0.232*cos(-6*2*pi*time+2.704)+0.369*cos(-5*2*pi*time+-0.518)+0.939*cos(-4*2*pi*time+1.535)+2.294*cos(-3*2*pi*time+0.708)+1.415*cos(-2*2*pi*time+-0.376)+0.344*cos(-1*2*pi*time+-0.560)+0.067*cos(0*2*pi*time+0.000)+0.344*cos(1*2*pi*time+0.560)+1.415*cos(2*2*pi*time+0.376)+2.294*cos(3*2*pi*time+-0.708)+0.939*cos(4*2*pi*time+-1.535)+0.369*cos(5*2*pi*time+0.518)+0.232*cos(6*2*pi*time+-2.704)+0.445*cos(7*2*pi*time+-0.788);
    theta_thigh = +0.054*cos(-7*2*pi*time+-2.190)+0.057*cos(-6*2*pi*time+1.729)+0.145*cos(-5*2*pi*time+-2.996)+0.115*cos(-4*2*pi*time+-0.063)+0.985*cos(-3*2*pi*time+2.836)+2.645*cos(-2*2*pi*time+1.940)+10.022*cos(-1*2*pi*time+2.095)+96.610*cos(0*2*pi*time+0.000)+10.022*cos(1*2*pi*time+-2.095)+2.645*cos(2*2*pi*time+-1.940)+0.985*cos(3*2*pi*time+-2.836)+0.115*cos(4*2*pi*time+0.063)+0.145*cos(5*2*pi*time+2.996)+0.057*cos(6*2*pi*time+-1.729)+0.054*cos(7*2*pi*time+2.190);
    theta_thigh = 90 - theta_thigh;
    theta_thigh = theta_thigh*pi/180;
    if (y(1)-theta_thigh)<0
        dydt = [y(2);
            (-c/I)*y(2) - (m*(g+ay)*Lcm/I) * sin(y(1)) - (m*ax*Lcm/I) * cos(y(1)) - k*(y(1)-theta_thigh)/I];
    else
        dydt = [y(2);
            (-c/I)*y(2) - (m*(g+ay)*Lcm/I) * sin(y(1)) - (m*ax*Lcm/I) * cos(y(1))];
    end
end