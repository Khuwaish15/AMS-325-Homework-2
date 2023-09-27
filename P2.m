% Step 1: Define the parameters
n = 50; % You can change n to 10 for testing
interiorTemperature = 25; % in degrees Celsius
topBoundary = 100;
bottomBoundary = 50;
leftBoundary = 0;
rightBoundary = 75;
threshold = 0.01; % Convergence threshold

% Step 2: Initialize the plate and boundary conditions
plate = initializePlate(n, interiorTemperature, topBoundary, bottomBoundary, leftBoundary, rightBoundary);


% Step 4: Create a VideoWriter object to save the evolution as a movie
videoFile = 'temperature_evolution.mp4';
videoObj = VideoWriter(videoFile, 'MPEG-4');
open(videoObj);

% Step 5: Iteratively update the temperature and save frames to the movie
maxTempChange = inf;
frameCount = 1;

while maxTempChange > threshold
    newPlate = updateTemperature(plate);
    
    % Calculate the maximum temperature change in this iteration
    maxTempChange = max(abs(newPlate - plate), [], 'all');
    
    % Plot and save the current frame
    figure;
    imagesc(newPlate);
    colormap(jet);
    colorbar;
    title(['Temperature Distribution (Iteration ' num2str(frameCount) ')']);
    xlabel('X-axis');
    ylabel('Y-axis');
    
    % Write the frame to the movie
    frame = getframe(gcf);
    writeVideo(videoObj, frame);
    
    close(gcf); % Close the figure
    plate = newPlate; % Update the current plate for the next iteration
    frameCount = frameCount + 1;
end

% Step 6: Close the video file
close(videoObj);
disp(['Simulation completed in ' num2str(frameCount-1) ' iterations.']);
disp(['Video saved as ' videoFile]);





% Step 3: Define the updateTemperature function
function newPlate = updateTemperature(currentPlate)
    [rows, cols] = size(currentPlate);
    newPlate = currentPlate; % Initialize with the current plate values
    
    for i = 2:rows-1
        for j = 2:cols-1
            % Update each interior point as the average of its neighbors
            newPlate(i, j) = (currentPlate(i-1, j) + currentPlate(i+1, j) + currentPlate(i, j-1) + currentPlate(i, j+1)) / 4;
        end
    end
end
function plate = initializePlate(n, interiorTemperature, topBoundary, bottomBoundary, leftBoundary, rightBoundary)
    plate = ones(n, n) * interiorTemperature;
    plate(1, :) = topBoundary;
    plate(n, :) = bottomBoundary;
    plate(:, 1) = leftBoundary;
    plate(:, n) = rightBoundary;
end