

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