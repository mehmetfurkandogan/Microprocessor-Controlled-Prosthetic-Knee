function y_f = fit_y(y,t,not,filename)
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
    filename = strcat('Fits\',filename);
    fourier_series_function(a,not,filename);
end