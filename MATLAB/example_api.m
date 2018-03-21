% Author: Markus Solbach (polyhedral@eecs.yorku.ca)
disp('Polyhedral example using MatLab')
server = 'ws://polyhedral.eecs.yorku.ca/api/';
message = '{"cam_y": 1.238, "cam_x": -0.911, "cam_qz": 0.16599, "cam_qw": -0.0544, "cam_qx": -0.307, "cam_qy": 0.9355, "ID": "7db4f770-8295-431d-8358-f303356538aa", "random_cam": "true", "cam_z": -4.1961, "light_fixed": "true"}';

ws = PolyClient(server);
ws.send(message);

% Uses MatlabWebSocket: https://github.com/jebej/MatlabWebSocket
% Please install first