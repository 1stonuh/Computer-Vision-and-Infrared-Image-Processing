function [oEnhancedImg] = enhanceGsclImage(iGsclImg, iLocalSize, iA, iB, iC, iK)
% Converting input grayscaled image to double
doubleGsclImg = im2double(iGsclImg);

% Calculating global mean
gmean = mean2(doubleGsclImg);

% Calculating local std 
lstd = stdfilt(doubleGsclImg);

% Calculating local mean.
% Has brightening & smoothing effect thus smooths the output image 
% and the four parameters introduced in the transformation function.
lmean = conv2(doubleGsclImg, ones(iLocalSize)/9, 'same');

% Calculating enhancement function
kFunc = (iK.*gmean)./(lstd + iB);

% Compute transformation function
oEnhancedImg = kFunc.*(doubleGsclImg - (iC.*lmean)) + (lmean.^iA);

end
