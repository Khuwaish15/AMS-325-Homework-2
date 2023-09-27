# AMS-325-Homework-2
1.	Setting up the Problem
  MATLAB Code
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
    colormap(jet);
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

 

2.	Iterative Solution

MATLAB code
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



3.	Analysis
MATLAB Code

 
    % Step 2: Call the analyzePlate function
    [averageTemp, maxChangeIdx] = analyzePlate(plate, newPlate);
 
    % Step 3: Plot the temperature distribution along the diagonal
    figure;
    plot(diag(newPlate));
    title('Temperature Distribution Along the Diagonal');
    xlabel('Position');
    ylabel('Temperature (°C)');
 
    % Step 4: Save the plot as an image file (e.g., PNG)
    saveas(gcf, 'temperature_along_diagonal.png');
 
 
 
    % Step 1: Define the analyzePlate function
    function [averageTemperature, maxTempChangeIndex] = analyzePlate(initialPlate, finalPlate)
        % Compute the average temperature of the plate
        averageTemperature = mean(finalPlate(:));
    
        % Calculate the temperature change between the first and last iteration
        tempChange = abs(finalPlate - initialPlate);
    
        % Find the index of the point with the highest temperature change
        [~, maxTempChangeIndex] = max(tempChange(:));
    end
 
1.	Average Temperature:
    •	The code calculates and reports the average temperature of the metal plate after the iterative simulation.
    •	The average temperature gives an indication of the equilibrium temperature of the plate, considering the initial            conditions and the boundary temperatures.
2.	Maximum Temperature Change:
    •	The code identifies the point with the highest temperature change between the first and last iteration of the               simulation.
    •	This point indicates where the most significant temperature change occurred during the simulation.
3.	Temperature Distribution Along the Diagonal:
    •	The code plots and saves a graph of the temperature distribution along the diagonal of the plate.
    •	Analyzing the diagonal temperature distribution can provide insights into how heat is transferred across the plate          and whether any hotspots or cold spots have developed.
Interpretation:
    •	The average temperature value can help determine if the plate has reached a steady state. If the average temperature        remains relatively constant over the iterations, it suggests that the plate has reached thermal equilibrium.
    •	Identifying the point with the highest temperature change is useful for pinpointing regions where the temperature           fluctuated the most during the simulation. This information can be crucial for applications where temperature               stability is critical, such as in electronic components.
    •	Examining the temperature distribution along the diagonal can reveal patterns in how heat flows across the plate. An        even distribution along the diagonal suggests uniform heat transfer, while deviations indicate variations in                temperature profiles.
    •	Monitoring the diagonal temperature profile over time can help track how the heat distribution evolves and whether          the system is converging to a stable solution.


