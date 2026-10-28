
clc;
clear;

// ========================================
// Lab 4 - Exercise 7
// Circular Convolution - Folding and Shifting
// ========================================

// Output directories
folder = get_absolute_file_path("lab4_ex7_folding.sci");
root = folder + "../";

consoleDir = root + "Console/";
imageDir = root + "Images/";

if ~isdir(consoleDir) then
    mkdir(consoleDir);
end

if ~isdir(imageDir) then
    mkdir(imageDir);
end

consoleFile = consoleDir + "lab4_ex7_folding_console.txt";
figureFile = imageDir + "lab4_ex7_folding.png";

if isfile(consoleFile) then
    mdelete(consoleFile);
end

diary(consoleFile);

// ========================================
// 1. Original signals
// ========================================

x = [1 2 -3 2 1];
h = [1 0 -1 -1 1];

N = length(x);
n = 0:(N-1);

// ========================================
// 2. Circular Convolution
// Folding and Shifting
// ========================================

y = zeros(1, N);

// y[n] = sum h[k] * x[(n-k) mod N]
for i = 0:(N-1)

    sumValue = 0;

    for k = 0:(N-1)

        index = pmodulo(i-k, N) + 1;

        sumValue = sumValue + h(k+1)*x(index);

    end

    y(i+1) = sumValue;

end

// ========================================
// 3. Calculate energy per period
// ========================================

energyX = x.^2;
energyY = y.^2;

Ex = sum(energyX);
Ey = sum(energyY);

// ========================================
// 4. Console output
// ========================================

mprintf("=== LAB 4 - EXERCISE 7 ===\n");
mprintf("Method: Folding and Shifting\n\n");

disp("n =");
disp(n);

disp("x(n) =");
disp(x);

disp("h(n) =");
disp(h);

disp("y(n) =");
disp(y);

disp("Energy per sample - x(n) =");
disp(energyX);

disp("Energy per sample - y(n) =");
disp(energyY);

mprintf("Energy of x(n) per period: %.0f\n", Ex);
mprintf("Energy of y(n) per period: %.0f\n", Ey);

// ========================================
// 5. Plot signals
// ========================================

scf(9);
clf();

// Input signal
subplot(3,1,1);
plot2d3(n, x, style=2);
title("Input Signal x(n)");
xlabel("Sample index n");
ylabel("Amplitude");
xgrid();

a = gca();
a.data_bounds = [-1 -4; 5 4];

// Impulse response
subplot(3,1,2);
plot2d3(n, h, style=2);
title("Impulse Response h(n)");
xlabel("Sample index n");
ylabel("Amplitude");
xgrid();

a = gca();
a.data_bounds = [-1 -2; 5 2];

// Circular convolution output
subplot(3,1,3);
plot2d3(n, y, style=2);
title("Circular Convolution - Folding and Shifting");
xlabel("Sample index n");
ylabel("Amplitude");
xgrid();

a = gca();
a.data_bounds = [-1 -5; 5 5];

// ========================================
// 6. Save Figure
// ========================================

xs2png(gcf(), figureFile);

mprintf("Saved figure: %s\n", figureFile);

diary(0);
