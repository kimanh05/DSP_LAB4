
clc;
clear;

// ========================================
// Lab 4 - Exercise 5
// Image Processing: Blurring & Histogram
// ========================================

// Get script directory
folder = get_absolute_file_path("lab4_ex5.sci");

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

consoleFile = consoleDir + "lab4_ex5_console.txt";
figureFile = imageDir + "lab4_ex5_image.png";

// Remove old Console file
if isfile(consoleFile) then
    mdelete(consoleFile);
end

diary(consoleFile);

// ========================================
// 1. Generate a grayscale test image
// ========================================

H = 256;
W = 256;

I = zeros(H, W);

// Gradient background
for c = 1:W
    I(:, c) = (45 + 0.3*c) * ones(H, 1);
end

// Bright square with dark center
I(25:100, 25:105) = 225;
I(40:85, 40:90) = 45;

// Circular object
for r = 120:220
    for c = 20:120
        d2 = (r-170)^2 + (c-70)^2;

        if d2 <= 40^2 then
            I(r,c) = 230;
        end

        if d2 <= 18^2 then
            I(r,c) = 35;
        end
    end
end

// Vertical stripe pattern
I(130:210, 150:230) = 55;

for c = 155:9:220
    I(135:205, c:c+3) = 245;
end

// Convert to integer gray levels
I = round(I);

// ========================================
// 2. Image blurring - Mean filter
// ========================================

// 9x9 averaging filter
kernelSize = 9;
kernel = ones(kernelSize, kernelSize) / ...
         (kernelSize * kernelSize);

// Apply 2D convolution
J = conv2(I, kernel, "same");
J = round(J);

// ========================================
// 3. Calculate image statistics
// ========================================

meanOriginal = mean(I(:));
meanBlurred = mean(J(:));

difference = abs(I - J);
meanDifference = mean(difference(:));

mprintf("=== LAB 4 - EXERCISE 5 ===\n");

mprintf("Image type: Grayscale\n");
mprintf("Image size: %d x %d pixels\n", H, W);

mprintf("Filter: Mean blur\n");
mprintf("Kernel size: %d x %d\n", ...
    kernelSize, kernelSize);

mprintf("Original minimum: %.0f\n", min(I));
mprintf("Original maximum: %.0f\n", max(I));

mprintf("Blurred minimum: %.0f\n", min(J));
mprintf("Blurred maximum: %.0f\n", max(J));

mprintf("Original mean intensity: %.4f\n", ...
    meanOriginal);

mprintf("Blurred mean intensity: %.4f\n", ...
    meanBlurred);

mprintf("Mean absolute difference: %.4f\n", ...
    meanDifference);

// ========================================
// 4. Display images and histograms
// ========================================

scf(5);
clf();

// Grayscale colormap (Scilab 2026)
gcf().color_map = gray(256);

// Original image
subplot(2,2,1);
Matplot(I + 1);
title("Original Grayscale Image");
xlabel("Pixel X");
ylabel("Pixel Y");

// Blurred image
subplot(2,2,2);
Matplot(J + 1);
title("Blurred Image (9x9 Mean Filter)");
xlabel("Pixel X");
ylabel("Pixel Y");

// Original histogram
subplot(2,2,3);
histplot(32, I(:), normalization=%f);
title("Original Image Histogram");
xlabel("Gray Level");
ylabel("Pixel Count");
xgrid();

// Blurred histogram
subplot(2,2,4);
histplot(32, J(:), normalization=%f);
title("Blurred Image Histogram");
xlabel("Gray Level");
ylabel("Pixel Count");
xgrid();

// ========================================
// 5. Save Figure and Console
// ========================================

xs2png(gcf(), figureFile);

mprintf("Saved figure: %s\n", figureFile);

diary(0);
