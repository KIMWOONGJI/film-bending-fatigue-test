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