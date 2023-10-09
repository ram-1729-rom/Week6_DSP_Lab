Apass = 2;         
filename = 'instru2.wav';
[y, Fs] = audioread(filename);

window_size = 1024;  
overlap = 512;       
nfft = 2048;         

spectrogram(y, hamming(window_size), overlap, nfft, Fs, 'yaxis');
title('Original Spectrogram');
xlabel('Time (s)');
ylabel('Frequency (Hz)');
colorbar;

% Design a digital Butterworth bandpass filter
f_passband = [20 1000];  
order = 6;                

[b, a] = butter(order, f_passband / (Fs/2), 'bandpass');

filtered_signal = filter(b, a, y);

output_filename = 'filtered_instru2.wav';
audiowrite(output_filename, filtered_signal, Fs);

figure;
spectrogram(filtered_signal, hamming(window_size), overlap, nfft, Fs, 'yaxis');
title('Filtered Spectrogram');
xlabel('Time (s)');
ylabel('Frequency (Hz)');
colorbar;

sound(filtered_signal, Fs);