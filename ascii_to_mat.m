filename = "out.txt";
fileID = fopen(filename,'r');
A = fscanf(fileID, "%d");
fclose(fileID);

mA = A(4096:2*4096-1).';

sampling_period = 1e-9;
time = [0:length(mA)-1]*sampling_period;

mA_ts = [time;mA]';
save data.mat -v7.3 mA
