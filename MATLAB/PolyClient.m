classdef PolyClient < WebSocketClient
    %CLIENT Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods
        function obj = PolyClient(varargin)
            %Constructor
            obj@WebSocketClient(varargin{:});
        end
    end
    
    methods (Access = protected)
        function onOpen(obj,message)
            % This function simply displays the message received
            fprintf('%s\n',message);
        end
        
        function onTextMessage(obj,message)
            % This function simply displays the message received
           
            jsonfied = jsondecode(message);
            if jsonfied.status == "SUCCESS"
                fprintf('Status:\n\t%s\n', jsonfied.status);
                img = jsonfied.image;
               
                if ischar(img), img = uint8(img); end

                output = typecast(org.apache.commons.codec.binary.Base64.decodeBase64(img), 'uint8')';
                disp(output)
            else
                fprintf('Status:\n\t%s\n', jsonfied.status);
            end
        end
        
        function onBinaryMessage(obj,bytearray)
            % This function simply displays the message received
            fprintf('Binary message received:\n');
            fprintf('Array length: %d\n',length(bytearray));
        end
        
        function onError(obj,message)
            % This function simply displays the message received
            fprintf('Error: %s\n',message);
        end
        
        function onClose(obj,message)
            % This function simply displays the message received
            fprintf('%s\n',message);
        end
    end
end
