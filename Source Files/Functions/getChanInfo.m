function [numTaps,tapDelays,tapAvgPows] = getChanInfo(PDP,sampRate)
%--------------------------------------------------------------------------
% This function provids a channel realization based on given PDP and
% sampling rate.
% Input:
%       PDP: power-delay profile. a struct with two fields: power(normalized),delay
%       sampRate: sampling rate
% Output:
%       numTaps: number of taps of the channel
%       tapDelays: delays in samples of each tap
%       tapAvgPows: channel variance for each tap 
% Juquan Mao @ 2021
%--------------------------------------------------------------------------

    delay = PDP.delay(:);
    power = PDP.power(:); % sum(power) == 1

    % Find sample ID based on PDP 
    sampPeriod = 1/sampRate;
    SampIdx = round(delay/sampPeriod) + 1; 

    %find unique samples ID 
    uniqueSampIdx = unique(SampIdx);

    % Number of taps only depends on the max sample index
    numTaps = max(SampIdx);
    tapAvgPows = zeros(numTaps,1);

    % Non-resolvable components within a sample period are combined into a single multi-path component. 
    % The averge power of one tap(sample) equals sum of all non-resolvable paths belongs to the tap
    for k =1:length(uniqueSampIdx)
        tapAvgPows(uniqueSampIdx(k)) = sum( power( SampIdx == uniqueSampIdx(k) ) );
    end
    
    % channle impulse response from one realization
    %cir = sqrt(cVar/2) .* (randn(1, numTaps) + 1i*randn(1, numTaps));
    
    tapDelays = (min(uniqueSampIdx)-1 :max(uniqueSampIdx)-1).' ;

end


