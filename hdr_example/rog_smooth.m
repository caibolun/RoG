function S = rog_smooth(I, lambda, sigma1, sigma2, K, dec, sep)

%   ROG_SMOOTH
%   Edge/Structure Preserving Smoothing via Relativity-of-Gaussian
%   Bolun Cai, Xiaofen Xing, Xiangmin Xu.
%   IEEE International Conference on Image Processing (ICIP), 2017 
%

    if (~exist('lambdas','var'))
        lambda=0.01;
    end   
    if (~exist('sigma1','var'))
        sigma1=1;
    end 
    if (~exist('sigma2','var'))
        sigma2=3;
    end 
    if (~exist('K','var'))
        K=1;
    end    
    if (~exist('dec','var'))
        dec=2.0;
    end
    if (~exist('sep','var'))
        sep=false;
    end

    I = im2double(I);
    S = I;
    for k = 1:K
        [wx, wy] = computeReWeights(S, sigma1, sigma2, sep);%compute weights w_x and w_y in Eq.(4)
        S = solveLinearEquation(I, wx, wy, lambda);         %update S_k using Eq.(7)
        sigma1 = sigma1./dec;
        sigma2 = sigma2./dec;
    end     
end

function [wx, wy] = computeReWeights(s, sigma1, sigma2, sep)
    eps = 0.00001;

    dx = diff(s,1,2);
    dx = padarray(dx, [0 1], 'post');
    dy = diff(s,1,1);
    dy = padarray(dy, [1 0], 'post');
 
    if sep == true
        gdx1 = fastBlur(dx, sigma1);
        gdy1 = fastBlur(dy, sigma1);
    else
        do = sqrt(dx.^2+dy.^2);
        gdo = fastBlur(do, sigma1);
        gdx1 = gdo;
        gdy1 = gdo;
    end
    
    gdx2 = fastBlur(dx, sigma2);
    gdy2 = fastBlur(dy, sigma2); 

    wx = max(mean(abs(gdx1),3).*mean(abs(gdx2),3),eps).^(-1);
    wy = max(mean(abs(gdy1),3).*mean(abs(gdy2),3),eps).^(-1);
    wx = fastBlur(wx, sigma1/2);
    wy = fastBlur(wy, sigma1/2);
    wx(:,end) = 0;
    wy(end,:) = 0;
end

function res = fastBlur(img, sigma)
    ksize = bitor(round(5*sigma),1);
    g = fspecial('gaussian', [1,ksize], sigma);
    res = img;
    for c = 1:size(res,3)
        ret = conv2(img(:,:,c),g,'same');
        ret = conv2(ret,g','same');  
        res(:,:,c) = ret;
    end   
end

function out = solveLinearEquation(in, wx, wy, lambda)  
    [h,w,c] = size(in);
    n = h*w;

    wx = wx(:);
    wy = wy(:);

    ux = padarray(wx, h, 'pre'); ux = ux(1:end-h);
    uy = padarray(wy, 1, 'pre'); uy = uy(1:end-1);
    D = wx+ux+wy+uy; 
    B = spdiags([-wx, -wy],[-h,-1],n,n);
    L = B + B' + spdiags(D, 0, n, n);	% a sparse five-point Laplacian matrix

    A = speye(n) + lambda*L; 
    if exist('ichol','builtin')
        F = ichol(A,struct('michol','on'));    
        out = in;
        for i=1:c
            tin = in(:,:,i);
            [tout, ~] = pcg(A, tin(:),0.1,100, F, F'); 
            out(:,:,i) = reshape(tout, h, w);
        end    
    else
        out = in;
        for i=1:c
            tin = in(:,:,i);
            tout = A\tin(:);
            out(:,:,i) = reshape(tout, h, w);
        end    
    end
end