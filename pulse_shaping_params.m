clear all
clc


noise_power = 1e-9;
%PULSE GENERATOR
pulse_gen_noise_clock = 1./50000;
pulse_gen_period = 100*1e-6; % Tpprd

sampling_rate = 1e-9; % Tclkn

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

%Nakhostin 10.10
nakhostin_10_10_k = 4;
nakhostin_10_10_l = 8;
nakhostin_10_10_M = 1/( exp(sampling_rate/hpf_diff_constant) - 1 );

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


