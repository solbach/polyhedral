# Author: Markus Solbach (polyhedral@eecs.yorku.ca)
from websocket import create_connection
import io, sys, json, base64
from json import dumps
try:
    from PIL import Image
except ImportError:
    print("PIL not installed on system. Running lightweight example.")

# Create Connection
ws = create_connection("ws://polyhedral.eecs.yorku.ca/api/")

# Mandatory
parameter = {
    'ID':'YOUR ID HERE',
    'light_fixed':'true',
    'random_cam': 'true',
    'cam_x':-0.911,
    'cam_y':1.238,
    'cam_z':-4.1961,
    'cam_qw':-0.0544,
    'cam_qx':-0.307,
    'cam_qy':0.9355,
    'cam_qz':0.16599
}

json_params = dumps(parameter, indent=2)
ws.send(json_params)

while True:
    result = json.loads(ws.recv())
    print("Job Status: {0}".format(result['status']))
    if result['status'] == "SUCCESS":
        break
    elif "FAILURE" in result['status'] or "INVALID" in result['status']:
        sys.exit()

image_base64 = result['image']
image_decoded = base64.b64decode(image_base64)
random_cam_param = result['cam_pose']
print(random_cam_param)

fh = open("imageToSave.png", "wb")
fh.write(image_decoded)
fh.close()

if 'PIL' in sys.modules:
    im = Image.open(io.BytesIO(image_decoded))
    im.show()

# Close Connection
ws.close()