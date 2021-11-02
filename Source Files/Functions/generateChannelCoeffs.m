function chanCoeffs= generateChannelCoeffs(PDP,sampRate,maxDopplerShift,nSamples, nSines)
%--------------------------------------------------------------------------
% This function provids a channel coefficent based on given PDP and
% sampling rate.
% Juquan Mao @ 2021
%--------------------------------------------------------------------------
 [numTaps,~,tapAvgPows] = getChanInfo(PDP,sampRate);
 
 chanCoeffs = rayleighSoSGen(sampRate,maxDopplerShift,nSines,numTaps,nSamples);
 
 chanCoeffs =  bsxfun(@times,chanCoeffs, sqrt(tapAvgPows/2)');
    
    
end


