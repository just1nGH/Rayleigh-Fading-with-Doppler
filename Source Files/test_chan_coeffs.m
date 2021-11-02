
delay = [0 , 50 , 120 , 200 , 230 , 500 , 1600 , 2300 , 5000]*1e-9;
powdB = [-1 , -1 , -1 , 0 , 0 , 0 , -3 , -5 , -7];

PDP.delay = delay;
PDP.power = 10.^(powdB/10);
PDP.power = PDP.power./(sum(PDP.power));

nFFT = 256;
sampRate = nFFT*15e3;
maxDopplerShift = 500; % in Hz;
nSamples = 12*nFFT;
nSines=40;
[numTaps,tapDelays,tapAvgPows] = getChanInfo(PDP,sampRate);

avg = 0;
nRels =100;
for i = 1:nRels
    chanCoeffs= generateChannelCoeffs(PDP,sampRate,maxDopplerShift,nSamples,nSines);
    avg = avg+mean(abs(chanCoeffs).^2);
end
fprintf('average power comprision for each tap: \n');
[tapAvgPows,avg'/nRels]
