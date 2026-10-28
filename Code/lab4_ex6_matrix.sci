
clc;
clear;

// ========================================
// Lab 4 - Exercise 6
// Linear Convolution - Matrix Method
// ========================================

// Output directories
folder = get_absolute_file_path("lab4_ex6_matrix.sci");
root = folder + "../";

consoleDir = root + "Console/";
imageDir = root + "Images/";

if ~isdir(consoleDir) then
    mkdir(consoleDir);
end

if ~isdir(imageDir) then
    mkdir(imageDir);
end

consoleFile = consoleDir + "lab4_ex6_matrix_console.txt";
figureFile = imageDir + "lab4_ex6_matrix.png";
energyFile = imageDir + "lab4_ex6_energy.png";

if isfile(consoleFile) then
    mdelete(consoleFile);
end

diary(consoleFile);

// ========================================
// 1. Original signals
// ========================================

x = [1 2 -3 2 1];
h = [1 0 -1];

Nx = length(x);
Nh = length(h);
Ny = Nx + Nh - 1;

nx = 0:(Nx-1);
nh = 0:(Nh-1);
ny = 0:(Ny-1);

// ========================================
// 2. Build convolution matrix
// ========================================

H = zeros(Ny, Nx);

for r = 1:Ny
    for c = 1:Nx

        j = r - c + 1;

        if (j >= 1) & (j <= Nh) then
            H(r,c) = h(j);
        end

    end
end

// Matrix multiplication
yColumn = H * x';
y = yColumn';

// ========================================
// 3. Calculate energy
// ========================================

energyX = x.^2;
energyY = y.^2;

Ex = sum(energyX);
Ey = sum(energyY);

// ========================================
// 4. Console output
// ========================================

mprintf("=== LAB 4 - EXERCISE 6 ===\n");
mprintf("Method: Matrix Method\n\n");

disp("x(n) =");
disp(x);

disp("h(n) =");
disp(h);

disp("Convolution matrix H =");
disp(H);

disp("y(n) = H*x =");
disp(y);

mprintf("Energy of x(n): %.0f\n", Ex);
mprintf("Energy of y(n): %.0f\n", Ey);

// ========================================
// 5. Figure - Matrix Method
// ========================================

scf(7);
clf();

subplot(3,1,1);
plot2d3(nx, x, style=2);
title("Input Signal x(n)");
xlabel("Sample index n");
ylabel("Amplitude");
xgrid();

a = gca();
a.data_bounds = [-1 -4; 5 4];

subplot(3,1,2);
plot2d3(nh, h, style=2);
title("Impulse Response h(n)");
xlabel("Sample index n");
ylabel("Amplitude");
xgrid();

a = gca();
a.data_bounds = [-1 -2; 3 2];

subplot(3,1,3);
plot2d3(ny, y, style=2);
title("Linear Convolution - Matrix Method");
xlabel("Sample index n");
ylabel("Amplitude");
xgrid();

a = gca();
a.data_bounds = [-1 -5; 7 5];

xs2png(gcf(), figureFile);

// ========================================
// 6. Figure - Signal Energy
// ========================================

scf(8);
clf();

subplot(2,2,1);
plot2d3(nx, x, style=2);
title("Input Signal x(n)");
xlabel("Sample index n");
ylabel("Amplitude");
xgrid();

subplot(2,2,2);
plot2d3(ny, y, style=2);
title("Output Signal y(n)");
xlabel("Sample index n");
ylabel("Amplitude");
xgrid();

subplot(2,2,3);
plot2d3(nx, energyX, style=2);
title("Energy per Sample - x(n)");
xlabel("Sample index n");
ylabel("|x(n)|^2");
xgrid();

subplot(2,2,4);
plot2d3(ny, energyY, style=2);
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
