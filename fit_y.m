function y_f = fit_y(y,t,not,file_name)
    % Fourier series fit for y coordinates
    % not is the number of terms
    lf = 70;
    y = y(1:lf);            % taking one period
    t_n = t(1:lf);              % one period
    T = 0.987;                      %s
    a=fourier_series_analysis(y,t_n,T,not);
    t_ex = t;
    Ff = fourier_series_synthesis(a,t_ex,not);
    y_f = real(Ff);
    % Writing to a file
    filename = strcat('Fits\',file_name,'.txt');
    fourier_series_function(a,not,filename);
    % Matlab Function
    filename = strcat('Fits\',file_name,'.m');
    fileID = fopen(filename,'w');
    fprintf(fileID,'function y = ');
    fprintf(fileID,file_name);
    fprintf(fileID,'(time)\n\ty = ');
    fclose(fileID);
    fourier_series_function(a,not,filename);
    fileID = fopen(filename,'a');
    fprintf(fileID,';\nend');
    fclose(fileID);
end