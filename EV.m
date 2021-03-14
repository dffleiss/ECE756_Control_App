classdef EV < handle
    properties
        % Networking
        inPort = 0;
        outPort = 0;
        udpReceiver;
        udpSender;
        
        % GUI handles for positions, sensors, and performance values
        x          = 0.0;
        y          = 0.0;
        th         = 0.0;
        leftRLI    = 0.0;
        rightRLI   = 0.0;
        ultrasonic = 0.0;
        battery    = 0.0;
        C1         = 0.0;
        C2         = 0.0;
        C3         = 0.0;
        
        % Vehicle state information which feeds back to Simulink
        leader = true; % Leader = true, Follower = false
        drive  = true; % drive = true, stop = false
        park   = false; % 
        reset  = false; % Resets C values and start position
    end
    
    methods
        % Constructor, create UDP receiver and set up callback.
        % Create UDP sender
        function obj = EV(inPort, outPort)
            fprintf('EV created: inPort=%d  outPort=%d\n', inPort, outPort)
            obj.inPort = inPort;
            obj.outPort = outPort;
            
            % Initialize input port
            obj.udpReceiver = udpport("datagram", "LocalPort", obj.inPort);
            obj.udpReceiver.UserData = 0;
            obj.udpReceiver.OutputDatagramSize = 40;
            
            % Initialize output port
            obj.udpSender = dsp.UDPSender('RemoteIPPort',obj.outPort);
            
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
        
        % Sends UDP data to Simulink
        function sendData(obj)
            % Send a bit map of booleans to simulink
            obj.udpSender([boolean(obj.leader), boolean(obj.drive), boolean(obj.park) ...
                boolean(obj.reset)]);
        end
    end
end