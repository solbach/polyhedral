classdef PolyClient < WebSocketClient
    
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
                base64 = org.apache.commons.codec.binary.Base64;
                y = base64.decode(img);
                y = mod(int16(y),256);
                y = uint8(reshape(y, 1, numel(y)));
                
                fid = fopen('temp.jpg', 'wb');
                fwrite(fid, y, 'uint8');
                fclose(fid);
                im = imread('temp.jpg');
                imshow(im)
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