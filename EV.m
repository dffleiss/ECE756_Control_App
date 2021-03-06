classdef EV < handle
    properties
        % Networking
        port = 0;
        udpReceiver;
        
        % GUI handles for positions, sensors, and performance values
        x          = 0;
        y          = 0;
        th         = 0;
        leftRLI    = 0;
        rightRLI   = 0;
        ultrasonic = 0;
        battery    = 0;
        C1         = 0;
        C2         = 0;
        C3         = 0;
    end
    
    methods
        % Constructor, create UDP receiver and set up callback
        function obj = EV(port)
            disp('EV object created!')
            obj.port = port;
            obj.udpReceiver = udpport("datagram", "LocalPort", port);
            obj.udpReceiver.UserData = 0;
            obj.udpReceiver.OutputDatagramSize = 40;
            %obj.udpReceiver.UserData = obj;

            configureCallback(obj.udpReceiver, "datagram", 1, @obj.receiveData);
        end

        % Callback function that receives UDP data and parses it out into
        % member variables
        function receiveData(obj, src, ~)
            data = read(src,1,"single");
            obj.x          = data.Data(1);
            obj.y          = data.Data(2);
            obj.th         = data.Data(3);
            obj.leftRLI    = data.Data(4);
            obj.rightRLI   = data.Data(5);
            obj.ultrasonic = data.Data(6);
            obj.battery    = data.Data(7);
            obj.C1         = data.Data(8);
            obj.C2         = data.Data(9);
            obj.C3         = data.Data(10);
        end
    end
end