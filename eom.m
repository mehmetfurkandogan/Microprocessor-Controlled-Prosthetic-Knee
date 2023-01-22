function dydt = eom(t,y)
    g = 9.8067;     % m/s^2
    m = 0.904;  % kg
    Lcm = 340*1e-3;  % m
    T = 0.88;      % s
    I = T^2/(4*pi^2) *m*g*Lcm;  % kg*m^2
    % I = 0.0110947;  % kg*m^2
    c = 0.0020;     % N*s
    k_knee = 1000;        % N*m
    % Coulomb friction
    k_c = 0.1419;    % N*m
    k_n = 8.8688e-04;  % m

    ax = knee_ax(t);        % m/s^2
    ay = knee_ay(t);        % m/s^2
    theta_thigh = thigh_theta(t);       % deg
    theta_thigh = 90 - theta_thigh;     % deg
    theta_thigh = theta_thigh*pi/180;   % rad

    cd("Position Functions\");
    knee_xr = knee_x(t)*1e-3;
    knee_yr = knee_y(t)*1e-3;
    cd("..");


    % Ground Reaction Forces
    knee = [knee_xr.' knee_yr.'];

    % From ankle to sole can be calculated as
    L_sole = 1.700 * 0.285;
    
    sole_s = L_sole * exp(1i*y(1));
    sole_x = imag(sole_s);
    sole_y = real(sole_s);
    sole_s = knee - [sole_x sole_y];
    clear sole_x;clear sole_y;
    
    % From sole to heel
    L_sole2heel = 45*1e-3;      % m
    
    heel_s = L_sole2heel * exp(1i*(y(1)+pi/2));
    heel_x = imag(heel_s);
    heel_y = real(heel_s);
    heel_s = sole_s - [heel_x heel_y];
    clear heel_x;clear heel_y;
    
    % From sole to toe
    L_sole2toe = 135*1e-3;      % m
    
    toe_s = L_sole2toe * exp(1i*(y(1)-pi/2));
    toe_x = imag(toe_s);
    toe_y = real(toe_s);
    toe_s = sole_s - [toe_x toe_y];
    clear toe_x;clear toe_y;

    ground_level = 30*1e-3;     % m

    heel_dist = ground_level - heel_s(2);

    toe_dist = ground_level - toe_s(2);

    heel_vx = y(2) * (knee(1,2) - heel_s(2));

    toe_vx = y(2) * (knee(1,2) - toe_s(2));


    grf = GRF(heel_dist,toe_dist,heel_vx,toe_vx);

    F_N_heel = grf(1);
    F_N_toe = grf(2);
    F_f_heel = grf(3);
    F_f_toe = grf(4);


    dydt = [y(2);
            - (c/I)*y(2) ...
            - (m*(g+ay)*Lcm/I) * sin(y(1)) ...
            - (m*ax*Lcm/I) * cos(y(1)) ...
            - (k_c/I)*sign(y(2))...
            - (k_n/I)*sign(y(2))*m*(g*cos(y(1))+ (y(2)^2)*Lcm)...
            - ((y(1)-theta_thigh)<0)*k_knee*(y(1)-theta_thigh)/I...
            + ((F_N_heel*(heel_s(1)- knee_xr))+F_N_toe*(toe_s(1)- knee_xr))/I...
            + ((F_f_heel*(knee_yr - heel_s(2)))+F_f_toe*(knee_yr - toe_s(2)))/I];

end