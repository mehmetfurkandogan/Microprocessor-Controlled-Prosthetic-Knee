function a = fourier_series_analysis(F,t,T,not)
    % Calculating Fourier series coefficients
    omega_0 = 2*pi/T;
    k = -1*floor(not/2):not-floor(not/2)-1;
    a = zeros(1,not);
    for i = 1:not
        a(i) = (1/T) * trapz(t,F.*exp(-1j*k(i)*omega_0.*t));
    end
end