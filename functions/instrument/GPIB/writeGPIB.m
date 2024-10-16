% ==============================================================================
% Project:  Acoustic measurement
% ------------------------------------------------------------------------------
% Function: writeGPIB
% Author:   Woongji Kim (wj.kim@postech.ac.kr)
% Date:     2024-09-05
% ------------------------------------------------------------------------------
% Input:
%   - gpibObj: GPIB object
%   - cmd: command to write
% ==============================================================================
function writeGPIB(gpibObj, cmd)
    write(gpibObj, cmd, "string");
end