function [power,delay] = expDecayPDP(sampRate,rmsDelay)
%-------------------------------------------------------------------------
% This function provide a deponential decay power-delay profile 
% INPUT:
%       samprate: samping rate Hz/s
%       rmsDelay: rms channel delay in second
% OUTPUT:
%       power: in watt
%       delay: in second
% [ref] Issues of the Simulation of Wireless Channels with Exponential-Decay Power-Delay Profles
% Link:https://ieeexplore.ieee.org/stamp/stamp.jsp?tp=&arnumber=1651488
% Dr Juquan Mao 
% eamil: juquan.justin.mao@gmail.com
% -------------------------------------------------------------------------


% sampling period
sampPeriod = 1/sampRate;

% number of channel taps 
%with maximum delay excess equal to 10 times of rms delay
N = floor(10 * rmsDelay/sampPeriod) + 1; % number of channel taps

% Formula from the reference
delay = (0:N-1)*sampPeriod; 
power = (1 - exp(- sampPeriod /rmsDelay )) *...
                    exp(- (0: N-1) *sampPeriod/rmsDelay);
                                
end

%--------------------------------------------------------------------------
% Test script:
% [avgPowVec,delayVec] = expDecayPDP(1,2);
% assert(abs(sum(avgPowVec) -1) < 1e-3)
% stem(delayVec,avgPowVec,'linewidth', 2)
%--------------------------------------------------------------------------

