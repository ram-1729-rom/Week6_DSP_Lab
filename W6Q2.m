ecg_data = load('ECG_Data.txt');

Apass = 2;           
Astop = 40;        
Fs = 720;         
Fpass = 10;          
Fstop = 20;          

Wp = 2 * pi * (Fpass / Fs);
Ws = 2 * pi * (Fstop / Fs);

[N, Wn] = buttord(Wp, Ws, Apass, Astop);

[b, a] = butter(N, Wn, 'low');

filtered_ecg_data = filter(b, a, ecg_data);

t = (0:length(ecg_data) - 1) / Fs;

figure;
plot(t, ecg_data, 'b', 'LineWidth', 1.5, 'DisplayName', 'Original ECG');
hold on;
plot(t, filtered_ecg, 'r', 'LineWidth', 1.5, 'DisplayName', 'Filtered ECG');
grid on;
xlabel('Time (s)');
ylabel('Amplitude');
title('Original ECG vs. Filtered ECG');
legend;
