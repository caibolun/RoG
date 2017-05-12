close all;
clear;
%% Load Image
filename = 'input.png';
img = imread(filename);
figure;imshow(img);title('Input');
%% RoG Smooth
result = rog_smooth(img, 0.01, 1, 3, 3);
figure;imshow(result);title('RoG Result');