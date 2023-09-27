% Step 1: Initialize the metal plate size
n = 50; % You can change n to 10 for testing

% Step 2: Initialize the plate with uniform interior temperature
interiorTemperature = 25; % in degrees Celsius
plate = ones(n, n) * interiorTemperature;

% Step 3: Set the boundary temperatures
topBoundary = 100;
bottomBoundary = 50;
leftBoundary = 0;
rightBoundary = 75;

% Set the boundary temperatures in the plate matrix
plate(1, :) = topBoundary;       % Top boundary
plate(n, :) = bottomBoundary;    % Bottom boundary
plate(:, 1) = leftBoundary;      % Left boundary
plate(:, n) = rightBoundary;     % Right boundary



% Step 5: Call the initializePlate function
plate = initializePlate(n, interiorTemperature, topBoundary, bottomBoundary, leftBoundary, rightBoundary);

% Step 6: Visualize the initial temperature distribution
figure;
imagesc(plate);
colormaclp(jet);
colorbar;
title('Initial Temperature Distribution');
xlabel('X-axis');
ylabel('Y-axis');

% Step 7: Save the visualization as an image file (e.g., PNG)
saveas(gcf, 'initial_temperature_distribution.png');

% imwrite(uint8(plate), 'initial_temperature_distribution.png');




% Step 4: Define a function to initialize the plate
function plate = initializePlate(n, interiorTemperature, topBoundary, bottomBoundary, leftBoundary, rightBoundary)
    plate = ones(n, n) * interiorTemperature;
    plate(1, :) = topBoundary;
    plate(n, :) = bottomBoundary;
    plate(:, 1) = leftBoundary;
    plate(:, n) = rightBoundary;
end