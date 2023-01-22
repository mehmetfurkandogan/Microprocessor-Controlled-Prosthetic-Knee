function GRF = GRF(heel_dist, toe_dist, heel_vx, toe_vx )
    a = 1.5;
    b = 4.5;
    k_toe = 9.8067*93/0.0125;   % N/m
    k_heel = 9.8067*93/0.0075;  % N/m
    c = 10000; % çok

    if and(heel_dist < 0, toe_dist < 0) % no contact
        GRF = [0, 0, 0, 0];
     
    elseif or(heel_dist > 0, toe_dist > 0)  % at least 1 contact
        if (((toe_dist>0) && (heel_dist<0)) && (toe_dist/b > -heel_dist))...
        || ((toe_dist<0) && (heel_dist>0)) && (heel_dist/a > -toe_dist)...
        || ((heel_dist>0) && (toe_dist>0))  % boht contact
            fprintf("desparados")
            GRF = [k_heel*((b*heel_dist+toe_dist)/(b-(1/a))), k_toe*((a*toe_dist+heel_dist)/(a-(1/b))), ...
                heel_vx * c, toe_vx * c];

        elseif (heel_dist > 0)  % only heel contact
            GRF = [heel_dist*k_heel, 0 , heel_vx * c, 0];

        elseif (toe_dist > 0)   % only toe contact
            GRF = [0, toe_dist*k_toe, 0, toe_vx * c];

        end
    end
end