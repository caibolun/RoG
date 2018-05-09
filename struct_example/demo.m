%	Structure extraction using RoG
%
%   The main structures are formed by many edge with salient but fine 
%   texture boundaries, making structure extraction very challenging. 
%   An excellent structure extraction can capture really structures and 
%   reduce texture interference.
%   
%   Edge/Structure Preserving Smoothing via Relativity-of-Gaussian
%   Bolun Cai, Xiaofen Xing, Xiangmin Xu.
%   IEEE International Conference on Image Processing (ICIP), 2017 
clear;
close all;
addpath('../');
%% Load Image
filename = 'fish.png';
I = im2double(imread(filename));
figure;imshow(I);title('Input');
%% RoG Smooth
res = rog_smooth(I, 0.01, 2, 4, 4);
bw=edge(rgb2gray(res),'canny');
tex=mapminmax(mean(abs(I-res),3),0,1);

figure;imshow(res);title('RoG Smooth');
figure;imshow(bw);title('Edge(Canny)');
figure;imshow(tex);title('Texture');
imwrite(bw,'result.png');
