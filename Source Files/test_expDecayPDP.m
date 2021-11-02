
% sampling rate and sampling period
samplingRate = fftSize * 15e-3;
delta_tau = 1/samplingRate;
sigma = 5 * delta_tau/10;

tau_max = 10 * tau_rms; % maximum delay excess
N = floor(tau_max/delta_tau) + 1; % number of channel taps

% normalization factor
xi = (1 - exp(-N * delta_tau /sigma ))/(1-exp(-delta_tau/sigma));

% average power of each taps
var_2 = exp(- (0: N-1) *delta_tau/sigma)/(xi);

