% ==============================================================================
% Project:  Acoustic measurement
% Author:   Woongji Kim (wj.kim@postech.ac.kr)
% Date:     2024-09-05
% ------------------------------------------------------------------------------
% Introduction
%   - This script is used to set up the environment for the project
% ==============================================================================
close all force
clear
clc
Project = currentProject;
Date    = string(datetime('now','Format','yyMMdd'));
instList = visadevlist;

commandStageController300  = importJSON("commandESP300.json");
disp("<Config>: Stage controller (ESP-300) configuration loaded")
configMotorizedActuator(1)  = importJSON("configLTA-HS_1.json");
configMotorizedActuator(2)  = importJSON("configLTA-HS_2.json");
disp("<Config>: Motorized actuator configuration loaded")

gpibESP300 = 0;

function dataStruct = importJSON(filename)
    % Open the file
    fid = fopen(filename, 'r');

    % Check if file exists
    if fid == -1
        error('Cannot open file: %s', filename);
    end

    % Read the file
    raw = fread(fid, inf);

    % Close the file
    fclose(fid);

    % Convert to string
    str = char(raw');

    % Parse JSON string
    dataStruct = jsondecode(str);
    % dataTable = struct2table(data, 'AsArray', true);
    % dataTable.Properties.RowNames = dataTable.name;
end