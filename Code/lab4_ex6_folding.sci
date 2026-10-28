
clc;
clear;

// ========================================
// Lab 4 - Exercise 6
// Linear Convolution - Folding and Shifting
// ========================================

// Output directories
folder = get_absolute_file_path("lab4_ex6_folding.sci");
root = folder + "../";

consoleDir = root + "Console/";
imageDir = root + "Images/";

if ~isdir(consoleDir) then
    mkdir(consoleDir);
end

if ~isdir(imageDir) then
    mkdir(imageDir);
end

consoleFile = consoleDir + "lab4_ex6_folding_console.txt";
figureFile = imageDir + "lab4_ex6_folding.png";

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
// 2. Folding and Shifting
// ========================================

y = zeros(1, Ny);

// y[n] = sum x[k] * h[n-k]
for n = 0:(Ny-1)

    sumValue = 0;

    for k = 0:(Nx-1)

        j = n - k;

        if (j >= 0) & (j < Nh) then
            sumValue = sumValue + x(k+1)*h(j+1);
        end

    end

    y(n+1) = sumValue;

end

// ========================================
// 3. Calculate energy
// ========================================

Ex = sum(x.^2);
Ey = sum(y.^2);

// ========================================
// 4. Console output
// ========================================

mprintf("=== LAB 4 - EXERCISE 6 ===\n");
mprintf("Method: Folding and Shifting\n\n");

disp("n_x =");
disp(nx);

disp("x(n) =");
disp(x);

disp("n_h =");
disp(nh);

disp("h(n) =");
disp(h);

disp("n_y =");
disp(ny);

disp("y(n) =");
disp(y);

mprintf("Energy of x(n): %.0f\n", Ex);
mprintf("Energy of y(n): %.0f\n", Ey);

// ========================================
// 5. Plot signals
// ========================================

scf(6);
clf();

// Original signal x(n)
subplot(3,1,1);
plot2d3(nx, x, style=2);
title("Input Signal x(n)");
xlabel("Sample index n");
ylabel("Amplitude");
xgrid();

a = gca();
a.data_bounds = [-1 -4; 5 4];

// Impulse response h(n)
subplot(3,1,2);
plot2d3(nh, h, style=2);
title("Impulse Response h(n)");
xlabel("Sample index n");
ylabel("Amplitude");
xgrid();

a = gca();
a.data_bounds = [-1 -2; 3 2];

// Output signal y(n)
subplot(3,1,3);
plot2d3(ny, y, style=2);
title("Linear Convolution - Folding and Shifting");
xlabel("Sample index n");
ylabel("Amplitude");
xgrid();

a = gca();
a.data_bounds = [-1 -5; 7 5];

// ========================================
// 6. Save result
// ========================================

xs2png(gcf(), figureFile);

mprintf("Saved figure: %s\n", figureFile);

diary(0);
