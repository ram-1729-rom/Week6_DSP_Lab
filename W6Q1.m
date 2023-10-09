Apass = 2;          
Astop = 40;           
Fs = 720;             
Fpass = 10;           
Fstop = 20;           

Wp = 2*pi*(Fpass/Fs);
Ws = 2*pi*(Fstop/Fs);

% Order of the filter
[N, Wn] = buttord(Wp, Ws, Apass, Astop);

% Butterworth low pass filter
[b, a] = butter(N, Wn, "low");

% (1) Transfer function 
H = tf(b, a, 1/Fs);

% (2) Pole-zero plot
figure;
pzmap(H);
title('Pole-Zero Plot');

% Assess system stability
poles = pole(H);

% Check if all poles are within the unit circle
isStable = all(abs(poles) < 1);

if isStable
    fprintf('The system is stable (all poles are inside the unit circle).\n');
else
    fprintf('The system is unstable (at least one pole is outside the unit circle).\n');
end

% (3) Bode plot
frequencies = linspace(0, Fs/2, 1000); 

[magnitude, phase] = bode(H, 2 * pi * frequencies); 

figure;
subplot(2, 1, 1);
semilogx(frequencies, 20*log10(squeeze(magnitude)));
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
title('Bode Plot (Magnitude)');

subplot(2, 1, 2);
semilogx(frequencies, squeeze(phase));
xlabel('Frequency (Hz)');
ylabel('Phase (degrees)');
title('Bode Plot (Phase)');

% Impulse and Step responses
t = (0:1/Fs:1);

impulse_response = impulse(H, t);

step_response = step(H, t);

figure;
plot(t, impulse_response, 'b', 'LineWidth', 1.5, 'DisplayName', 'Impulse Response');
hold on;
plot(t, step_response, 'r', 'LineWidth', 1.5, 'DisplayName', 'Step Response');
grid on;
xlabel('Time (s)');
ylabel('Amplitude');
title('Impulse Response and Step Response');
legend;


