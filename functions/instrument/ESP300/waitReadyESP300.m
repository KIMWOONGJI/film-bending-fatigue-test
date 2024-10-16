function waitReadyESP300(gpibESP300)
    if gpibESP300 == 0
        disp("<gpibESP300>: moved");
    else
        while true
            result = queryGPIB(gpibESP300, "TS");
            pause(0.1)
            flush(gpibESP300)
            
            if result == "S"
                % disp("<ESP300>: busy")
            elseif result == "P"
                % disp("<ESP300>: ready")
                break
            end
            pause(0.5)
        end
    end
end