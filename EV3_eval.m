function [C1, C2, C3, C5] = EV3_eval(filename)
% Inputs
% "time" : (n by 1) column vector that contains timestamps in miliseconds
% "RLI" : (n by 1) column vector that contains right light sensor readings
% "Ultra" : (n by 1) column vector that contains ultrasonic sensor readings

% Outputs
% C1 : lap time (ms)
% C2 : tracking error
% C3 : tracking smoothness
% C5 : Platooning performance

% initialize costs
C1 = Inf; C2 = Inf; C3 = Inf; C5 = Inf;

%% Main Code
try   
    % Read-in raw data
    [fPath, fName, fExt] = fileparts(filename);
    switch lower(fExt)
      case '.txt'
        data = readtable(filename);
      case '.rtf'
        fID = fopen(filename, 'r'); % Open our data file
        Temp = zeros(1,3);
        index = 1;
        while ~feof(fID) % Loop until we reach the end of the file
            tline = fgetl(fID); % Read in a line of data, discard it
            Temp(index,:) = sscanf(tline,'%f,%f,%f');
            index = index + 1;
        end
        fclose(fID);
        data = table(Temp(:,1), Temp(:,2), Temp(:,3));
      otherwise  % Under all circumstances SWITCH gets an OTHERWISE!
        disp('Unexpected file extension: %s', fExt);
    end

    time = data.(1);
    RLI = data.(2);
    Ultra = data.(3);
    % Time table
    if time(end) > 180
        ttEV3_raw = timetable(milliseconds(time),RLI,Ultra,...
        'VariableNames',{'RLI','Ultra'});
    else
        ttEV3_raw = timetable(seconds(time),RLI,Ultra,...
        'VariableNames',{'RLI','Ultra'});
    end
    
    % provide summary of the data points
    disp('============Raw Data Statistics===================');
    summary(ttEV3_raw)
    
    % Check for data validaty
    if median(diff(ttEV3_raw.Time))> milliseconds(50)
        disp('Sampling time greater than 50 ms! -> Disqualify')
        return
    end
    
    % normalize to 50 ms sampling time for grading
    ttEV3_regular = retime(ttEV3_raw,'regular','linear','TimeStep',milliseconds(50));
    % provide summary of the data points
    disp('============Normalized Data Statistics============');
    summary(ttEV3_regular)
    
    %% C1 
    C1 = milliseconds(ttEV3_raw.Time(end) - ttEV3_raw.Time(1));
    
    %% C2
    % Normalize the sensor readings to (0 ~ 100) range
    normlized_Anchor = ttEV3_regular.RLI.*(100/max(ttEV3_regular.RLI));
    % Use initial sensor reading as the reference value
    Anchor_ref = normlized_Anchor(1);
    % Tracking error
    error = normlized_Anchor - Anchor_ref;
    % Data sampling time 
    delta_T = 0.05;
    % Calculate C2
    C2 = sum((error.^2).*delta_T);
    
    %% C3
    % calculate C3
    C3 = sum(abs(diff(normlized_Anchor)./delta_T));
    
    %% C5
    % Use initial sensor reading as the reference value
    ultra_ref = 20;
    ultra_error = ttEV3_regular.Ultra - ultra_ref;
    
    C5 = sqrt(mean(sum((ultra_error.^2))));
    
    disp('=======================================================');
    fprintf('Lap time (ms) C1 is: %d\n',C1);
    fprintf('Accumulative square tracking error C2 is: %.2f\n',C2);
    fprintf('Tracking smoothness C3 is: %.2f\n',C3);
    fprintf('Platooning RMSE C5 is: %.2f\n',C5);
    
catch
    disp('Bad input data. Check your input data.');
end
end