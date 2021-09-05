
%% Syntax
%% total_power = band_power(p,f,flow,fhigh)
%% Description
%%This functions inputs the frequency decomposition(f) and power spectral
%%density(p) from the output of the pwelch function to calculate total power
%%in any choosen EEG frequency band specified by f-low and f-high as the
%%band pass frequencies

function total_power = band_power(p,f,flow,fhigh)
    
    F = f(2)-f(1);
    ind = f<=fhigh & f>flow;
    total_power=sum(p(ind))*F;

end