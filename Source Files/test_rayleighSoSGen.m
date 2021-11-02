
clear all
close all

addpath('Functions')

fd=20;
fs=1000000;
nSamples = 100000;
nSines=40;
K = 3;


z = rayleighSoSGen(fs, fd,nSines,K,nSamples);

% waveform plot
plot((0:nSamples-1)/fs,real(z));
xlabel('time');
ylabel('real(z)');

% check average power
%mean(abs(z).^2)

% ACF & abs_z
nRels = 100;
acf = zeros(nSamples,1);
abs_z = zeros(1,K);
tau = (0:nSamples-1)'/fs;

for i = 1: nRels
    z = rayleighSoSGen(fs, fd,nSines,K,nSamples);
    [acfTmp, lags]= autocorr(real(z(:,1)),'NumLags',nSamples-1);
    acf =  acf + acfTmp;
    abs_z = abs_z + mean(abs(z).^2);
end

fprintf('The average power of samples: ');
abs_z = abs_z/nRels;
disp(abs_z);

acf_theo = zeros(nSamples,1);
for n = 1:nSines 
    
    alpha = 0.25*pi/nSines * 1/(K+2);
    f = fd * cos(0.5*pi/nSines *(n-0.5) + alpha);
    acf_theo =  acf_theo + cos(2*pi*f*tau);

end

figure;
plot(tau,acf/nRels);

hold on
plot(tau,acf_theo/nSines);

s = 2*pi*fd*(0:nSamples-1)/fs;
plot((0:nSamples-1)/fs,besselj(0,s),'--');

ylabel('ACF');
xlabel('$\tau$','interpreter','latex')
legend('SoS sim','SoS theo','REF')
grid on

% CCF between real and imaginary