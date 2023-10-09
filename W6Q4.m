Apass = 2;          
Astop = 40;         
Fs = 720;           
Fpass = 10;         
Fstop = 20;        

Wp = 2*pi*(Fpass/Fs);
Ws = 2*pi*(Fstop/Fs);

% Chebyshev Type 1 filter
[N_cheb, Wn_cheb] = cheb1ord(Wp, Ws, Apass, Astop);
[b_cheb, a_cheb] = cheby1(N_cheb, Apass, Wn_cheb, "low");
H_cheb = tf(b_cheb, a_cheb, 1/Fs);

% Butterworth filter
[N_butter, Wn_butter] = buttord(Wp, Ws, Apass, Astop);
[b_butter, a_butter] = butter(N_butter, Wn_butter, "low");
H_butter = tf(b_butter, a_butter, 1/Fs);

% (1) Order comparision
fprintf('Chebyshev Type 1 Filter Order: %d\n', N_cheb);
fprintf('Butterworth Filter Order: %d\n', N_butter);

% Frequency response for Chebyshev Type 1 filter
[H_c, f_c] = freqz(b_cheb, a_cheb, 1024, Fs);

% Frequency response for Butterworth filter
[H_b, f_b] = freqz(b_butter, a_butter, 1024, Fs);

% (2) Bode plots
figure;
semilogx(f_c, 20*log10(abs(H_c)), 'b', 'LineWidth', 2);
hold on;
semilogx(f_b, 20*log10(abs(H_b)), 'r', 'LineWidth', 2);

xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
title('Bode Plot Comparison: Chebyshev Type 1 vs. Butterworth');
legend('Chebyshev Type 1', 'Butterworth');
grid on;
hold off;

% (3) Impulse and Step responses comparision
t = (0:1/Fs:1);

impulse_response_cheb = impulse(H_cheb, t);
step_response_cheb = step(H_cheb, t);

impulse_response_butter = impulse(H_butter, t);
step_response_butter = step(H_butter, t);

figure;
subplot(2, 1, 1);
plot(t, impulse_response_cheb, 'b', 'LineWidth', 1.5, 'DisplayName', 'Impulse Response (Chebyshev)');
hold on;
plot(t, impulse_response_butter, 'r', 'LineWidth', 1.5, 'DisplayName', 'Impulse Response (Butterworth)');
grid on;
xlabel('Time (s)');
ylabel('Amplitude');
title('Impulse Response Comparison');
legend;

subplot(2, 1, 2);
plot(t, step_response_cheb, 'b', 'LineWidth', 1.5, 'DisplayName', 'Step Response (Chebyshev)');
hold on;
plot(t, step_response_butter, 'r', 'LineWidth', 1.5, 'DisplayName', 'Step Response (Butterworth)');
grid on;
xlabel('Time (s)');
ylabel('Amplitude');
title('Step Response Comparison');
legend;

