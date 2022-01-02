function [oSharpness] = getImageSharpness(iImage)

% Find the gradient Cartesian coordinates of image.
[Gx, Gy] = gradient(double(iImage));

% Calculate intermediate function.
S = sqrt(Gx.*Gx+Gy.*Gy);

% Calculate sharpness of image.
oSharpness = sum(sum(S))./(numel(Gx));

end
