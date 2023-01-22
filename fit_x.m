function [x_f,p] = fit_x (x,t,not,file_name)
    % Fourier series fit for x coordinates
    % not is the number of terms
    %% Linear regression to obtain a periodic function
    p = polyfit(t,x,1);
    x_n = x - (p(1)*t+p(2));    % normalizing
    x_n = x_n(1:70);            % taking one period
    %% Fourier Series
    t_n = t(1:70);              % one period
    T = 0.987;                      %s
    a=fourier_series_analysis(x_n,t_n,T,not);
    t_ex = t;
    Ff = fourier_series_synthesis(a,t_ex,not);
    x_f = real(Ff) + (p(1)*t_ex.'+p(2));
    filename = strcat('Fits\',file_name,'.txt');
    fourier_series_function(a,not,filename);
    fileID = fopen(filename,'a');
    fprintf(fileID,'+%.3f*time+%.3f',p(1),p(2));
    fclose(fileID);
    % Matlab Function
    filename = strcat('Fits\',file_name,'.m');
    fileID = fopen(filename,'w');
    fprintf(fileID,'function x = ');
    fprintf(fileID,file_name);
    fprintf(fileID,'(time)\n\tx = ');
    fclose(fileID);
    fourier_series_function(a,not,filename);
    fileID = fopen(filename,'a');
    fprintf(fileID,'+%.3f*time+%.3f',p(1),p(2));
    fprintf(fileID,';\nend');
    fclose(fileID);
end