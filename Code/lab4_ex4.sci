clc;
clear;

// ========================================
// Lab 4 - Exercise 4
// Audio Processing in Scilab
// ========================================

// Get script directory
folder = get_absolute_file_path("lab4_ex4.sci");

root = folder + "../";
consoleDir = root + "Console/";
imageDir = root + "Images/";

// Create output directories
if ~isdir(consoleDir) then
    mkdir(consoleDir);
end

if ~isdir(imageDir) then
    mkdir(imageDir);
end

wavFile = folder + "lab4_ex4_audio.wav";
consoleFile = consoleDir + "lab4_ex4_console.txt";
figureFile = imageDir + "lab4_ex4_audio.png";

// Remove old Console file
if isfile(consoleFile) then
    mdelete(consoleFile);
end

diary(consoleFile);

// ========================================
// 1. Generate audio signal
// ========================================

Fs = 8000;
duration = 1;

n = 0:(Fs*duration - 1);
t = n / Fs;

f1 = 440;
f2 = 880;

x = 0.65*sin(2*%pi*f1*t) ...
  + 0.25*sin(2*%pi*f2*t);

// ========================================
// 2. Save and read WAV file
// ========================================

wavwrite(x, Fs, 16, wavFile);

[xRead, FsRead, bitsRead] = wavread(wavFile);

xRead = matrix(xRead, 1, -1);

N = length(xRead);
tRead = (0:(N-1)) / FsRead;

// ========================================
// 3. Frequency analysis using FFT
// ========================================

X = fft(xRead, -1);

half = floor(N/2) + 1;

freq = (0:(half-1)) * FsRead / N;
mag = 2 * abs(X(1:half)) / N;

// ========================================
// 4. Display Console results
// ========================================

mprintf("=== LAB 4 - EXERCISE 4 ===\n");

mprintf("Sampling rate: %d Hz\n", FsRead);
mprintf("Bit depth: %d bits\n", bitsRead);
mprintf("Number of samples: %d\n", N);
mprintf("Duration: %.3f seconds\n", N/FsRead);

mprintf("Expected tones: %d Hz and %d Hz\n", f1, f2);

mprintf("Peak amplitude: %.4f\n", max(abs(xRead)));

mprintf("Max WAV rounding error: %.6f\n", ...
    max(abs(xRead-x)));

mprintf("Saved WAV: %s\n", wavFile);

// ========================================
// 5. Plot audio waveform
// ========================================

scf(0);
clf();

subplot(2,1,1);

plot2d(tRead(1:320), xRead(1:320), style=2);

title("Audio Waveform (first 40 ms)");
xlabel("Time (s)");
ylabel("Amplitude");
xgrid();

// ========================================
// 6. Plot magnitude spectrum
// ========================================

subplot(2,1,2);

plot2d(freq, mag, style=2);

title("Audio Magnitude Spectrum");
xlabel("Frequency (Hz)");
ylabel("Magnitude");
xgrid();

a = gca();
a.data_bounds = [0 0; 1500 0.75];

// ========================================
// 7. Export image and Console
// ========================================

xs2png(gcf(), figureFile);

mprintf("Saved figure: %s\n", figureFile);

diary(0);

// Optional audio playback
// playsnd(wavFile);
