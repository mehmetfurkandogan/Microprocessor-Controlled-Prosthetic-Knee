function dydt = eom(t,y)
    g = 9.8067;     % m/s^2
    m = 0.580;  % kg
    Lcm = 100*1e-3;  % m
    T = 0.925;      % s
    I = T^2/(4*pi^2) *m*g*Lcm;
    % I = 0.0110947;  % kg*m^2
    c = 0.0181;     % N*s/m

    dydt = [y(2); (-c/I)*y(2) - (m*g*Lcm/I) * sin(y(1))];
end