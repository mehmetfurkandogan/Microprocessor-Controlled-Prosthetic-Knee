function GRF = GRF(heel_dist, toe_dist, heel_vx, toe_vx )
    a = 1.5;
    b = 4.5;
    k_toe = 9.8067*93/0.0125;   % N/m
    k_heel = 9.8067*93/0.0075;  % N/m
    k_toe = k_toe*1;
    k_heel = k_heel*1;
    %c = 1000; % çok
    mu = 0;

    % fprintf('%.3f\t%.3f\t%.3f\t%.3f\t',heel_dist, toe_dist, heel_vx, toe_vx);
    
    if and(heel_dist < 0, toe_dist < 0) % no contact
        GRF = [0, 0, 0, 0];
         fprintf("1\t");
     
    elseif or(heel_dist > 0, toe_dist > 0)  % at least 1 contact

        if (((toe_dist>0) && (heel_dist<0)) && (toe_dist/b > -heel_dist))...
        || ((toe_dist<0) && (heel_dist>0)) && (heel_dist/a > -toe_dist)...
        || ((heel_dist>0) && (toe_dist>0))  % boht contact
            GRF = [k_heel*((b*heel_dist+toe_dist)/(b-(1/a))), k_toe*((a*toe_dist+heel_dist)/(a-(1/b))), ...
                k_heel*((b*heel_dist+toe_dist)/(b-(1/a))) * mu * sign(-heel_vx), k_toe*((a*toe_dist+heel_dist)/(a-(1/b))) * mu* sign(-toe_vx)];
                 fprintf("2\t");
        elseif (heel_dist > 0)  % only heel contact
            GRF = [heel_dist*k_heel, 0 , heel_dist*k_heel * mu* sign(-heel_vx), 0];
             fprintf("3\t");
        elseif (toe_dist > 0)   % only toe contact
            GRF = [0, toe_dist*k_toe, 0, toe_dist*k_toe * mu * sign(-toe_vx)];
             fprintf("4\t");

        end
    end
    fprintf('%.3f\t%.3f\t%.3f\t%.3f\n',GRF(1), GRF(2), GRF(3), GRF(4));
end