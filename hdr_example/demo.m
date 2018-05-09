%   HDR tonemapping using RoG
%
%   One of the challenges in image processing is the rendering of a 
%   High-Dynamic Range (HDR) scene on a conventional Low-Dynamic Range 
%   (LDR) display. RoG smoothing is also easily harnessed to perform tone 
%   mapping of HDR images. Based on LCIS, the LCIS-based decomposition is 
%   simply replaced by our RoG-based smoothing. Since multi-exposure 
%   fusion is the major problem to display surface reflections for HDR 
%   tone mapping, an exact base-layer decomposition is the key to produce 
%   a LDR image.
%   
%   Edge/Structure Preserving Smoothing via Relativity-of-Gaussian
%   Bolun Cai, Xiaofen Xing, Xiangmin Xu.
%   IEEE International Conference on Image Processing (ICIP), 2017
clear;
close all;
addpath('../');
%% Load Image
filename = 'desk.hdr';

hdr = im2double(hdrread(filename));
figure;imshow(hdr);title('Input');
I = 0.299*hdr(:,:,1) + 0.587*hdr(:,:,2) + 0.114*hdr(:,:,3)+1e-6;
rgb=bsxfun(@rdivide,hdr,I);

%% RoG Smooth
u0 = I;
u1 = rog_smooth(I, 0.01, 0.5, 1.0, 1);
u2 = rog_smooth(I, 0.01, 1.0, 1.5, 1);
u3 = rog_smooth(I, 0.01, 1.5, 2.0, 1);

%% Compute detail layers
base = log(u3);
detail0 = log(u0./u1);
detail1 = log(u1./u2);
detail2 = log(u2./u3);

%% Recombine the layers together with stronger emphasis on fine detail
w0 = 2.0;
w1 = 1.0; 
w2 = 0.5;
w3 = 0.2;
cLL = w0*detail0 + w1*detail1 + w2*detail2 + w3*base;

%% Convert back to RGB
sat = 0.6;
exposure = 2.5;
Inew = exp(cLL);
sI = sort(Inew(:));
mx = sI(round(length(sI) * (99.9/100)));
Inew = exposure*Inew/mx;

rgb = bsxfun(@times,Inew,rgb.^sat);
figure;imshow(rgb);title('HDR');
imwrite(rgb,'result.png');