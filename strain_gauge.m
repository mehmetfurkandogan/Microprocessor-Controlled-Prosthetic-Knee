function [max_strain,min_SF,strain1,strain2] = strain_gauge(F,M,L)
    
    M_a = F(1,:).*L;
    M_sg = M_a.' + M;

    % PIPE
    R_i = 30e-3;    % m
    R_o = 34e-3;    % m
    b = 8e-3;       % m
    h = 2.1e-3;     % m
    A_sg = b*h;  % m^2
    A_tube = pi * (R_o^2 - R_i^2);
    A_total = A_sg + A_tube;

    sigma_a = F(2,:).'./A_total; % Pa

    % Moment of Area
    I_c = pi * (R_o^4 - R_i^4)/4;
    I_r = 2*b*h^3/12 + 2*b*h*(12.5e-3)^2;
    I = I_c + I_r;

    c = (13.1e-3);
    sigma_b = M_sg .* c / I;
    sigma_sg_1 = sigma_a + sigma_b;
    sigma_sg_2 = sigma_a - sigma_b;

    E = 72e9;       % Pa
    strain1 = sigma_sg_1 ./ E;   % m/m
    strain2 = sigma_sg_2 ./ E;   % m/m

    %% STRENGHT ANALYSIS
    sigma_b = M_sg .* R_o / I;
    sigma_sg_1 = sigma_a + sigma_b;
    sigma_sg_2 = sigma_a - sigma_b;

    cf = 135/56.7;
    sigma_sg_1 = sigma_sg_1.*cf;    % Pa
    sigma_sg_2 = sigma_sg_2.*cf;    % Pa
    % fprintf('Max stress = %.3f MPa\n',1e-6*max([max(sigma_sg_1),max(sigma_sg_2)]));
    strain1 = strain1.*cf;   % m/m
    strain2 = strain2.*cf;   % m/m
    max_strain = max([max(abs(strain1)),max(abs(strain2))]);

    YS = 505e6;     % Pa

    SF1 = YS ./ abs(sigma_sg_1);
    SF2 = YS ./ abs(sigma_sg_2);

    scf = 7.1 / 20.862 ; % Stress Concentration Factor

    SF1 = SF1 * scf;
    SF2 = SF2 * scf;
    
    min_SF = min([min(SF1),min(SF2)]);

end