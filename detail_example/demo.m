%	Multi-scale detail enhancement using RoG
%
%   As a nonlinear edge-preserving image smoothing (K = 1), our method can 
%   be used for detail enhancement via base and detail layer decomposition.
%   For example, we can simply replace the edge-preserving smoothing in 
%   the classical detail enhancement framework with RoG-based smoothing.
%   
%   Edge/Structure Preserving Smoothing via Relativity-of-Gaussian
%   Bolun Cai, Xiaofen Xing, Xiangmin Xu.
%   IEEE International Conference on Image Processing (ICIP), 2017 
clear;
close all;
addpath('../');
%% Load Image
filename = 'flower.png';
I = im2double(imread(filename));
figure;imshow(I);title('Input');
%% RoG Smooth
I0 = rog_smooth(I, 0.001, 0.5, 1.0, 1);
I1 = rog_smooth(I, 0.001, 1.0, 1.5, 1);

%% Detail Enhancement
coarse=detailenhance( I, I0, I1, 1, 25 );
figure;imshow(coarse);title('Coarse-scale boost');

fine=detailenhance( I, I0, I1, 12, 1 );
figure;imshow(fine);title('Fine-scale boost');

combine=(fine+coarse)./2;
figure;imshow(combine);title('Combine');
imwrite(combine,'result.png');
