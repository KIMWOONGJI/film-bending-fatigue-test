% ==============================================================================
% Project:  Acoustic measurement
% ------------------------------------------------------------------------------
% Function: commandESP300
% Author:   Woongji Kim (wj.kim@postech.ac.kr)
% Date:     2024-09-09
% ------------------------------------------------------------------------------
% Introduction
%   - This function is used to command ESP300
% ------------------------------------------------------------------------------
% Output
%   - recv: received data when command is query
% ------------------------------------------------------------------------------
% Input
%   - gpibESP300:               GPIB object of ESP300
%   - commandStageController300:command list of ESP300
%   - command:                  command name
%   - option:                   command option
%   - type:                     command type (write, query)
% ==============================================================================
function recv = commandESP300(gpibESP300, ...
    commandStageController300, ...
    category, ...
    command, ...
    axis, ...
    option, ...
    type)

    if nargin < 7
        type = "write";
    end

    currentCmd  = commandStageController300.cmd.(category).(command);
    commandInst = currentCmd.command;
    
    if isempty(option)
        option = "";
    else
        option = string(option);
    end
    
    strCmd = string(axis) ...
        + commandInst ...
        + string(option);
   
    if type == "write"
        if gpibESP300 == 0
            disp("<gpibESP300>: " + strCmd);
        else
            writeGPIB(gpibESP300, strCmd);
        end
    elseif type == "query"
        if gpibESP300 == 0
            recv = "1";
            disp("<gpibESP300>: " + strCmd + " -> " + recv);
        else
            recv = queryGPIB(gpibESP300, strCmd);
        end
    else

    end
end
