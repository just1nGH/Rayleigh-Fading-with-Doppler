function z = rayleighSoSGen(fs,fd,nSines,K,nSamples)
% Generate K mutually uncorrelated Rayleigh fading waveforms of nSamples
% using sum of sinusoilds (SoS)
% fd - Doppler frequency  
% fs - Sampling frequency
% nSines - Number of sinusoids
% K - K mutually uncorrelated Rayleigh fading waveforms
% nSamples - number of samples
% Source paper:M. Patzold, et.al "Two new sum-of-sinusoids-based methods 
% for the efficient generation of multiple uncorrelated rayleigh fading waveforms," 
% Author: Dr. Juquan Mao
% Email: juquan.justin.mao@gmail.com
% 2021 Nov
%----------------------------------------------------------------------

    t = (0: nSamples-1)'/fs;
    z=zeros(length(t),K);

    for k = 1: K
        
        x=zeros(length(t),1);
        y=zeros(length(t),1);

        for n=1:nSines
            %uniform distributed phase
            theta=rand*2*pi;
            % discrete doppler shift
            alpha = 0.25*pi/nSines * k/(K+2);
            f = fd * cos(0.5*pi/nSines *(n-0.5) + alpha);
            
            % real part
            x = x + cos(2*pi*f*t+theta);
            
            %uniform distributed phase
            theta=rand*2*pi;
            % discrete doppler shift
            f =fd * cos(0.5*pi/nSines *(n-0.5) - alpha); 
            
            %imagenary part
            y = y + cos(2*pi*f*t+theta);

        end
        
        % unitary real and imaginary parts, average power of z is 2
        z(:,k) = sqrt(2/nSines)*(x + 1i*y);
    end


end

