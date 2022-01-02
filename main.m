
clc; clear all; close all;
lenaimg = double(imread('abcd.bmp'));
figure;
imshow(double(lenaimg), [0, 255]);
title('Original image')

level = 2; %level to select the wavelet transform
h=[0.48296 0.83652 0.22414 -0.12941]; % Daubechies D4 filter for image

%Wavelet Transform Decomposition
imgdec = multiwaveletdecomposition(lenaimg, h, level);
figure;
imshow(imgdec,[]);
title('Decomposition of the image')

%Wavelet Transform Reconstruction
imgrec = multiwaveletreconstruction(imgdec, h, level);
figure;
imshow(imgrec, []);
title('Reconstruction of the image')
imwrite(mat2gray(imgrec),'A24.bmp');

%% PSO Parameters

wmax=0.9; % Maximal inertia weight.
wmin=0.4; % Minimal inertia weight.

c1=2.4; % Cognitive acceleration coefficient.
c2=1.7; % Social acceleration coefficient.

swarmSize = 24; % Population size.
localSize = 7; % Local window size.
maxIterValue = 50; % Maximum number of iterations.

% Uniformly distributed generated numbers within range [0,1].
r1 = rand;
r2 = rand;

fit_val=[]; % Vector for storing fitness values.
P_best=[]; % Vector for storing pbest values.
G_best=[]; % Vector for storing gbest values.

pbest = 0; % Local best position of the group.
gbest = 0; % Global best position of the swarm.


I = imread('A24.bmp');

% Get image size m*n.
[n, m] = size(I);

%% Particle initialization

for i = 1:swarmSize
    % Updating optimum vales for particle position.
    a(i) = (1.5).*rand(1,1); % [0, 1.5]
    b(i) = (0.5).*rand(1,1); % [0, 0.5]
    c(i) = rand(1,1); % [0, 1]
    k(i) = 0.5 + 1.*rand(1,1); % [0.5, 1.5]
    % Updating particle velocity.
    v(i) = rand; % [0, 1]
    % Zeros vector of current positions of i'th particle.
    x(i) = 0;
end

%% Enhancing
for i = 1:maxIterValue
    % Calculating inertia weight.
    w = wmax -(wmax - wmin) * i / maxIterValue;
    
    for j = 1:swarmSize
        % Generating enhanced image by transformation function.
        E = enhanceGsclImage(I, localSize, a(j), b(j), c(j), k(j));
        
        % Calculating fitness value.
        fitness = fitnessFunction(E, m, n);
        
        % Add calculated fitness value to specific vector.
        fit_val = [fit_val, fitness];
        
        % Get max value in the vector of fitvalues.
        maxFit = max(fit_val);
        
        if (fitness < x(j))
            % Calculate pbest position.
            pbest = x(j);
            % Add calculated pbest value to specific vector.
            P_best = [P_best, pbest];
        else
            % Calculate pbest position.
            pbest = fitness;
            % Add calculated pbest value to specific vector.
            P_best = [P_best, pbest];
        end
    end
    
    gbest = max(P_best);
    
    for j = 1:swarmSize
        % Updating velocity.
        v(j) = w*v(j) + c1.*r1.*(P_best(j) - x(j)) + c2.*r2.*(gbest - x(j));
        
        % Updating particle position.
        x(j) = x(j) + v(j);
    end
    
    P_best = [];
end

% Plot enhanced image
figure;
imshow(E);
title('Enhanced image', 'fontsize', 10);
imwrite(E,'A0.bmp')


