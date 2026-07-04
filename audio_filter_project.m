clc;
clear;
close all;

x = [];
Fs = 0;

[x, Fs] = audioread('input_audio.wav');

if size(x, 2) == 2
    x = mean(x, 2);
end

x = x / max(abs(x));

N = length(x);
t = (0:N-1)' / Fs;

f_noise = 50;
A_noise50 = 0.15;
A_white = 0.02;

noise_50 = A_noise50 * sin(2*pi*f_noise*t);
noise_white = A_white * randn(N, 1);

x_noisy = x + noise_50 + noise_white;
x_noisy = x_noisy / max(abs(x_noisy));

wo = f_noise / (Fs/2);
bw = wo / 35;
[b_iir, a_iir] = iirnotch(wo, bw);

x_iir = filter(b_iir, a_iir, x_noisy);
x_iir = x_iir / max(abs(x_iir));

fir_order = 100;
fc = 3500;
b_fir = fir1(fir_order, fc/(Fs/2), 'low');

x_fir = filter(b_fir, 1, x_noisy);
x_fir = x_fir / max(abs(x_fir));

x_both = filter(b_iir, a_iir, x_noisy);
x_both = filter(b_fir, 1, x_both);
x_both = x_both / max(abs(x_both));

snr_noisy = 10 * log10(sum(x.^2) / sum((x_noisy - x).^2));
snr_iir = 10 * log10(sum(x.^2) / sum((x_iir - x).^2));
snr_fir = 10 * log10(sum(x.^2) / sum((x_fir - x).^2));
snr_both = 10 * log10(sum(x.^2) / sum((x_both - x).^2));

disp(['SNR noisy = ', num2str(snr_noisy), ' dB']);
disp(['SNR IIR   = ', num2str(snr_iir), ' dB']);
disp(['SNR FIR   = ', num2str(snr_fir), ' dB']);
disp(['SNR BOTH  = ', num2str(snr_both), ' dB']);

L = min(N, Fs*3);
time_plot = (0:L-1)/Fs;

figure;
subplot(4,1,1);
plot(time_plot, x(1:L));
title('Tin hieu goc');
xlabel('Thoi gian (s)');
ylabel('Bien do');
grid on;

subplot(4,1,2);
plot(time_plot, x_noisy(1:L));
title('Tin hieu bi nhieu');
xlabel('Thoi gian (s)');
ylabel('Bien do');
grid on;

subplot(4,1,3);
plot(time_plot, x_iir(1:L));
title('Tin hieu sau loc IIR notch');
xlabel('Thoi gian (s)');
ylabel('Bien do');
grid on;

subplot(4,1,4);
plot(time_plot, x_both(1:L));
title('Tin hieu sau loc IIR + FIR');
xlabel('Thoi gian (s)');
ylabel('Bien do');
grid on;

nfft = 2^nextpow2(N);

X = fft(x, nfft);
X_noisy = fft(x_noisy, nfft);
X_iir = fft(x_iir, nfft);
X_fir = fft(x_fir, nfft);
X_both = fft(x_both, nfft);

f = Fs*(0:nfft/2)/nfft;

mag_X = abs(X(1:nfft/2+1));
mag_noisy = abs(X_noisy(1:nfft/2+1));
mag_iir = abs(X_iir(1:nfft/2+1));
mag_fir = abs(X_fir(1:nfft/2+1));
mag_both = abs(X_both(1:nfft/2+1));

figure;
subplot(5,1,1);
plot(f, mag_X);
title('Pho tin hieu goc');
xlabel('Tan so (Hz)');
ylabel('|X(f)|');
grid on;
xlim([0 5000]);

subplot(5,1,2);
plot(f, mag_noisy);
title('Pho tin hieu bi nhieu');
xlabel('Tan so (Hz)');
ylabel('|X(f)|');
grid on;
xlim([0 5000]);

subplot(5,1,3);
plot(f, mag_iir);
title('Pho sau loc IIR notch');
xlabel('Tan so (Hz)');
ylabel('|X(f)|');
grid on;
xlim([0 5000]);

subplot(5,1,4);
plot(f, mag_fir);
title('Pho sau loc FIR low-pass');
xlabel('Tan so (Hz)');
ylabel('|X(f)|');
grid on;
xlim([0 5000]);

subplot(5,1,5);
plot(f, mag_both);
title('Pho sau loc IIR + FIR');
xlabel('Tan so (Hz)');
ylabel('|X(f)|');
grid on;
xlim([0 5000]);

figure;
freqz(b_iir, a_iir, 1024, Fs);
title('Dap ung tan so cua bo loc IIR notch');

figure;
freqz(b_fir, 1, 1024, Fs);
title('Dap ung tan so cua bo loc FIR low-pass');

audiowrite('audio_noisy.wav', x_noisy, Fs);
audiowrite('audio_iir.wav', x_iir, Fs);
audiowrite('audio_fir.wav', x_fir, Fs);
audiowrite('audio_both.wav', x_both, Fs);