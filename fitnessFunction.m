function [oFit] = fitnessFunction(iE, iM, iN)

% Gradient magnitude and direction of an input enhanced image using 
% Sobel gradient operator.
EGrad = imgradient(iE, 'sobel');

% Calculate sum of pixel intensities (number of nonzero matrix elements).
sumIntensities = sum(sum(EGrad));

% Number of pixels, whose intensity value is greater than 
% a threshold in Sobel edge image.
numberEdgels = nnz(EGrad);

% Calculate Entropy of enhanced image.
entropyEnh = entropy(iE);

% Compute objective function which tells us about the quality of 
% the input enhanced image.
oFit = log(log(sumIntensities)).*(numberEdgels./(iM.*iN)).*entropyEnh;

end