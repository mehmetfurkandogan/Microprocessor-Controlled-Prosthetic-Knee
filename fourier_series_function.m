function fourier_series_function(a,not,filename)
    fileID = fopen(filename,'w');
    % Reassembling the function using Fourier series coefficients
    k = -1*floor(not/2):not-floor(not/2)-1;
    for ki = 1:not
        % abs(a(ki))*cos(k(ki)*2*pi*t(ti) + angle(a(ki)))
        fprintf(fileID,'+%.3f*cos(%d*2*pi*time+%.3f)',abs(a(ki)),k(ki),angle(a(ki)));
    end
    fclose(fileID);
end