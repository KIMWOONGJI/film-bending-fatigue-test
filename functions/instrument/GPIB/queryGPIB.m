% ==============================================================================
% Project:  Acoustic measurement
% ------------------------------------------------------------------------------
% Function: queryGPIB
% Author:   Woongji Kim (wj.kim@postech.ac.kr)
% Date:     2024-09-05
% ------------------------------------------------------------------------------
% Input:
%   - gpibObj: GPIB object
%   - cmd: command to query
% ------------------------------------------------------------------------------
% Output:
%   - recv: received data
% ==============================================================================
function recv = queryGPIB(gpibObj, cmd)
    recv = strip(writeread(gpibObj, cmd));
end