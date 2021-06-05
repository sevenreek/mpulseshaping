

primary_ma = 1;
noise_power = 1e-12;
%PULSE GENERATOR
pulse_gen_noise_clock = 50e-9;
pulse_gen_period = 1*1e-8; % Tpprd

sampling_rate = 1e-9; % Tclkn

hpf_diff_constant = 140e-9; % Taud

%LP FILTER
ma_length = 4;
lp_coeff = ones(1,ma_length)./ma_length;

%TRAPEZOID FILTER A
a_filter_slope_length = 6;
a_filter_gap_length = 12;
a_filter_divider = 12;
a_filter_slope_pos = 1/a_filter_divider;
a_filter_slope_neg = -1/a_filter_divider;
a_fir_coeff = [...
    a_filter_slope_pos  .* ones(1,a_filter_slope_length), ...
                         zeros(1,a_filter_gap_length), ...
    a_filter_slope_neg  .* ones(1,a_filter_slope_length)  ...
];

%TRAPEZOID FILTER B
b_const_stage_0 = exp(-sampling_rate/hpf_diff_constant);
rng('shuffle');


%Nakhostin 10.1
nakhostin_10_1_epos = exp(sampling_rate/2/hpf_diff_constant);
nakhostin_10_1_eneg = exp(-sampling_rate/2/hpf_diff_constant);
nakhostin_10_1_L = 30;
nakhostin_10_1_MA_order = 8;
nakhostin_10_1_v0 = 2^15;

%Nakhostin 10.3
nakhostin_10_3_gain = sampling_rate/2/hpf_diff_constant;
nakhostin_10_3_L = 48;
nakhostin_10_3_N = 16;
nakhostin_10_3_fir_coeff = [0,ones(1,nakhostin_10_3_L-1)];

%Nakhostin 10.10
nakhostin_10_10_k = 2;
nakhostin_10_10_l = 64;
nakhostin_10_10_tau = hpf_diff_constant;
nakhostin_10_10_M = 1/( exp(sampling_rate/nakhostin_10_10_tau) - 1 );

%smooth_derivative
smooth_derivative_len = 4;
smooth_derivative_coeff = [ones(1,smooth_derivative_len), -ones(1,smooth_derivative_len)];

%smooth_derivative 2
smooth_derivative_2_len = 0;
if(smooth_derivative_2_len == 0)
    smooth_derivative_2_coeff = [1];
else
    smooth_derivative_2_coeff = [ones(1,smooth_derivative_2_len), -ones(1,smooth_derivative_2_len)];
end;


%pathak
pathak_tau = hpf_diff_constant;
pathak_K = 16;
pathak_L = 32;
pathak_M = 1/(exp(sampling_rate/hpf_diff_constant)-1);

filename = "out.txt";
fileID = fopen(filename,'r');
A = fscanf(fileID, "%d");
fclose(fileID);

mA = A(4096:2*4096-1).';

sampling_period = 1e-9;
time = [0:length(mA)-1]*sampling_period;

mA_ts = [time;mA]';
save data.mat -v7.3 mA


taus = [140];
hpd_gains = [1./(exp(1e-9./(taus.*1e-9))-1)];
