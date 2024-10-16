% ==============================================================================
% Project:  Acoustic measurement
% ------------------------------------------------------------------------------
% Function: setProfile
% Author:   Woongji Kim (wj.kim@postech.ac.kr)
% Date:     2024-09-09
% ------------------------------------------------------------------------------
% Introduction
%   - This function is used to set the study profile.
% ------------------------------------------------------------------------------
% Input
%   - Profile:                  Study profile
%   - commandSpectrumAnalyzer:  command list of SR785
%   - commandStageController0:  command list of SHOT-202
%   - commandStageController1:  command list of ESP300
%   - gpibSR785:                GPIB object of SR785
%   - gpibSC202:                GPIB object of SHOT-202
%   - gpibESP300:               GPIB object of ESP300
% ==============================================================================
function setProfile(Profile, ...
    commandStageController1, ...
    gpibESP300)
% Run sequentially sub-structure's field name in 'Profile' structure
instrumentFieldnames = fieldnames(Profile);
for i = 1:numel(instrumentFieldnames)
    groupStruct     = Profile.(instrumentFieldnames{i});
    groupFieldnames = fieldnames(groupStruct);

    switch instrumentFieldnames{i}
        case 'ESP300'
            for j = 1:numel(groupFieldnames)
                commandStruct       = groupStruct.(groupFieldnames{j});
                commandFieldsnames  = fieldnames(commandStruct);

                for k = 1:numel(commandFieldsnames)
                    axisNoStruct      = commandStruct.(commandFieldsnames{k});
                    axisNoFieldnames  = fieldnames(axisNoStruct);

                    currentCmd = commandStageController1.cmd.(groupFieldnames{j}).(commandFieldsnames{k});

                    for l = 1:numel(axisNoFieldnames)
                        axisNo  = axisNoFieldnames{l}(2);
                        option  = axisNoStruct.(axisNoFieldnames{l});

                        if ismember('nn', fieldnames(currentCmd))
                            strCmd = string(axisNo) ...
                                + currentCmd.command ...
                                + string(currentCmd.nn.(option));
                        else
                            strCmd = string(axisNo) ...
                                + currentCmd.command ...
                                + string(option);
                        end

                        writeGPIB(gpibESP300, strCmd);
                        disp("<gpibESP300>: " + strCmd);
                        strCmd = [];
                    end
                end
            end
        otherwise
            error("The instrument is not defined")
    end
end
end
