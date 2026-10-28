
clc;
clear;

// ========================================
// Lab 4 - Exercise 7
// Circular Convolution - Matrix Method
// ========================================

// Output directories
folder = get_absolute_file_path("lab4_ex7_matrix.sci");
root = folder + "../";

consoleDir = root + "Console/";
imageDir = root + "Images/";

if ~isdir(consoleDir) then
    mkdir(consoleDir);
end

if ~isdir(imageDir) then
    mkdir(imageDir);
end

consoleFile = consoleDir + "lab4_ex7_matrix_console.txt";
figureFile = imageDir + "lab4_ex7_matrix.png";
energyFile = imageDir + "lab4_ex7_energy.png";

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
// 2. Circular Convolution Matrix
// ========================================

H = zeros(N, N);

for r = 1:N
    for c = 1:N

        index = pmodulo(r-c, N) + 1;

        H(r,c) = h(index);

    end
end

// Matrix multiplication
yColumn = H * x';
y = yColumn';

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
mprintf("Method: Matrix Method\n\n");

disp("n =");
disp(n);

disp("x(n) =");
disp(x);

disp("h(n) =");
disp(h);

disp("Circular convolution matrix H =");
disp(H);

disp("y(n) = H*x =");
disp(y);

disp("Energy per sample - x(n) =");
disp(energyX);

disp("Energy per sample - y(n) =");
disp(energyY);

mprintf("Energy of x(n) per period: %.0f\n", Ex);
mprintf("Energy of y(n) per period: %.0f\n", Ey);

// ========================================
// 5. Figure - Matrix Method
// ========================================

scf(10);
clf();

subplot(3,1,1);
plot2d3(n, x, style=2);
title("Input Signal x(n)");
xlabel("Sample index n");
ylabel("Amplitude");
xgrid();

a = gca();
a.data_bounds = [-1 -4; 5 4];

subplot(3,1,2);
plot2d3(n, h, style=2);
title("Impulse Response h(n)");
xlabel("Sample index n");
ylabel("Amplitude");
xgrid();

a = gca();
a.data_bounds = [-1 -2; 5 2];

subplot(3,1,3);
plot2d3(n, y, style=2);
title("Circular Convolution - Matrix Method");
xlabel("Sample index n");
ylabel("Amplitude");
xgrid();

a = gca();
a.data_bounds = [-1 -5; 5 5];

xs2png(gcf(), figureFile);

// ========================================
// 6. Figure - Signal Energy
// ========================================

scf(11);
clf();

subplot(2,2,1);
plot2d3(n, x, style=2);
title("Input Signal x(n)");
xlabel("Sample index n");
ylabel("Amplitude");
xgrid();

subplot(2,2,2);
plot2d3(n, y, style=2);
title("Output Signal y(n)");
xlabel("Sample index n");
ylabel("Amplitude");
xgrid();

subplot(2,2,3);
plot2d3(n, energyX, style=2);
title("Energy per Sample - x(n)");
xlabel("Sample index n");
ylabel("|x(n)|^2");
xgrid();

subplot(2,2,4);
plot2d3(n, energyY, style=2);
title("Energy per Sample - y(n)");
xlabel("Sample index n");
ylabel("|y(n)|^2");
xgrid();

xs2png(gcf(), energyFile);

// ========================================
// 7. Save results
// ========================================

mprintf("Saved figure: %s\n", figureFile);
mprintf("Saved energy figure: %s\n", energyFile);

diary(0);
