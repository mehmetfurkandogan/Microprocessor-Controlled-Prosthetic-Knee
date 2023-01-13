function Ff = fourier_series_synthesis(a,t,not)
    % Reassembling the function using Fourier series coefficients
    k = -1*floor(not/2):not-floor(not/2)-1;
    Ff = zeros(1,size(t,1));
    for ti = 1:size(t,1)
        for ki = 1:not
            % Ff(ti) = Ff(ti) + a(ki)*exp(1j*k(ki)*2*pi*t(ti)); % Complex Form
            Ff(ti) = Ff(ti) + abs(a(ki))*cos(k(ki)*2*pi*t(ti) + angle(a(ki)));
        end
    end
end