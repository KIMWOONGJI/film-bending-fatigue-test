% ==============================================================================
% Project:  Acoustic measurement
% ------------------------------------------------------------------------------
% Function: initializeESP300
% Author:   Woongji Kim (wj.kim@postech.ac.kr)
% Date:     2024-09-11
% ------------------------------------------------------------------------------
% Introduction
%   - This function is used to initialize the Spectrum Analyzer ESP300
% ------------------------------------------------------------------------------
% Input:
%   - instList: instrument list
% ------------------------------------------------------------------------------
% Output:
%   - instESP300: instrument information of ESP300
%   - gpibESP300: GPIB object of ESP300
% ==============================================================================
function [instESP300, gpibESP300] = initializeESP300(instList, gpibESP300, configMotorizedActuator)
    % Set up ESP300
    instESP300.ResourceName = "GPIB0::1::INSTR";
    % Check if ESP300 is in the resource list
    instESP300 = instList(instList.ResourceName == instESP300.ResourceName , :);
    if ~isobject(gpibESP300)
        gpibESP300 = visadev(instESP300.ResourceName);
        configureTerminator(gpibESP300,"CR");  
        % Check communication by querying ESP300 IDN string
        if  queryGPIB(gpibESP300,"*IDN?") == ...
                "ESP300 Version 3.03"
            setBacklashESP300(gpibESP300, configMotorizedActuator);
            defineHomeESP300(gpibESP300);
            disp("<ESP300>: initialized")
        else
            disp("<ESP300>: not found")
        end
    else
        setBacklashESP300(gpibESP300, configMotorizedActuator);
        defineHomeESP300(gpibESP300);
        disp("<ESP300>: already initialized")
    end
end

function defineHomeESP300(gpibESP300)
    % turn off all the motorized actuators
    writeGPIB(gpibESP300, "1MF");
    writeGPIB(gpibESP300, "2MF");
    % writeGPIB(gpibESP300, "3MF");

    f = msgbox(["To ensure that all actuators operate properly," ...
        "manually set the starting position" ...
        "so that the actuators' the end of the rod and the actuator push block" ...
        "are in contact with each other." ...
        "" ...
        "If you do so, click 'OK'" ], ...
        'Help', ...
        "help");
    uiwait(f)

    writeGPIB(gpibESP300, "1DH");
    writeGPIB(gpibESP300, "2DH");
    writeGPIB(gpibESP300, "1MO");
    writeGPIB(gpibESP300, "2MO");
end
    
function setBacklashESP300(gpibESP300, configMotorizedActuator)
    % Set the backlash
    writeGPIB(gpibESP300, "1BA" + string(configMotorizedActuator(1).setting.backlash.value));
    writeGPIB(gpibESP300, "2BA" + string(configMotorizedActuator(2).setting.backlash.value));
    % writeGPIB(gpibESP300, "3BA" + string(configMotorizedActuator(3).setting.backlash.value));
end