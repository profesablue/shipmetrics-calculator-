% Ship parameters
shipLength = 100; % meters
shipWidth = 15; % meters
shipDraft = 8; % meters
shipDisplacement = 50000; % tons

% Engine parameters
enginePower = 10000; % kW
engineEfficiency = 0.4; % Assume 40% efficiency

% Environmental parameters
waterDensity = 1025; % kg/m^3 (typical density of seawater)
gravitationalAcceleration = 9.81; % m/s^2

% Other constants
knotsToMetersPerSecond = 0.514444; % Conversion factor from knots to m/s

% Speed range
speedKnots = 10:1:20; % Speed range in knots

% Initialize arrays to store results
fuelConsumption = zeros(size(speedKnots));
totalResistance = zeros(size(speedKnots));
powerAvailable = zeros(size(speedKnots));
propulsiveEfficiency = zeros(size(speedKnots));

% Additional parameters
hullEfficiencyFactor = 0.7; % Dimensionless
engineLoadFactor = linspace(0.2, 1, length(speedKnots)); % Dimensionless

% Calculate and plot additional parameters
for i = 1:length(speedKnots)
    speedMetersPerSecond = speedKnots(i) * knotsToMetersPerSecond;
    
    % Calculate resistance force (simplified model)
    resistanceForce = 0.5 * hullEfficiencyFactor * shipDisplacement * waterDensity * speedMetersPerSecond^2 * shipLength * shipWidth * shipDraft;
    totalResistance(i) = resistanceForce;
    
    % Calculate power required
    powerRequired = resistanceForce * speedMetersPerSecond;
    
    % Calculate fuel consumption
    fuelConsumption(i) = powerRequired / (engineEfficiency * enginePower * engineLoadFactor(i));
    
    % Calculate power available
    powerAvailable(i) = enginePower * engineLoadFactor(i);
    
    % Calculate propulsive efficiency
    propulsiveEfficiency(i) = powerRequired / powerAvailable(i);
end

% Plot fuel consumption vs. speed
subplot(2, 1, 1);
plot(speedKnots, fuelConsumption, 'LineWidth', 2);
xlabel('Speed (knots)');
ylabel('Fuel Consumption (kg/s)');
title('Fuel Consumption vs. Speed');
grid on;

% Plot other parameters vs. speed
subplot(2, 1, 2);
yyaxis left
plot(speedKnots, totalResistance, 'LineWidth', 2);
ylabel('Total Resistance (N)');
hold on;
yyaxis right
plot(speedKnots, propulsiveEfficiency, 'LineWidth', 2);
ylabel('Propulsive Efficiency');
xlabel('Speed (knots)');
legend('Total Resistance', 'Propulsive Efficiency', 'Location', 'northwest');
grid on;
