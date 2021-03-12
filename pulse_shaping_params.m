clear all
clc


noise_power = 1e-11;
%PULSE GENERATOR
pulse_gen_noise_clock = 1./50000;
pulse_gen_period = 100*1e-6; % Tpprd

sampling_rate = 1e-7; % Tclkn

hpf_diff_constant = 50e-6; % Taud

%LP FILTER
ma_length = 4;
lp_coeff = ones(1,ma_length)./ma_length;

%TRAPEZOID FILTER A
a_filter_slope_length = 5;
a_filter_gap_length = 1;
a_filter_slope_pos = 1/a_filter_slope_length;
a_filter_slope_neg = -1/a_filter_slope_length;
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
nakhostin_10_1_L = 16;
nakhostin_10_1_MA_order = 4;

%Nakhostin 10.3
nakhostin_10_3_gain = sampling_rate/2/hpf_diff_constant;
nakhostin_10_3_L = 8;
nakhostin_10_3_N = 16;
nakhostin_10_3_fir_coeff = [0,ones(1,nakhostin_10_3_L-1)];
