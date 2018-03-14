# [API] Random Polyhedral Scenes: An Image Generator for Active Vision System Experiments
_Markus D. Solbach, Stephen Voland and John K. Tsotsos_

We present a Polyhedral Scene Generator system which creates a random scene based on a few user parameters, renders the scene from random view points and creates a dataset containing the renderings and corresponding annotation files. We think that this generator will help to understand how a program could parse a scene if it had multiple angle to compare. For ambiguous scenes, typically people move their head or change their position to see the scene from different angle as well as seeing how it changes while they move; a research field called active perception. The random scene generator presented is designed to support research in this field by generating images of scenes with known complexity characteristics and with verfieable properties with respect to the distribution of features across a population. Thus, it is well-suited for research in active perception without the requirement of a live 3D environment and mobile sensing agent as well as for comparative performance evaluations. :rocket:

System: :point_right: [HERE](http://polyhedral.eecs.yorku.ca)

Paper: [HERE](https://arxiv.org) :point_left:

![Example Scenes](/img/scenes.jpg)
Six different scenes (left to right) rendered from three different views (top to bottom). See the [paper](https://arxiv.org) for more information:heavy_exclamation_mark:

## What is this GitHub page about?
This is the home of the application program interface (**API**) for the [Random Polyhedral Scenes: An Image Generator for Active Vision System Experiments](http://polyhedral.eecs.yorku.ca) system.
The API is realized using WebSockets. Basically any programming language that supports WebSockets can be used :tada: (Java, C/C++, Python, MatLab, ...).

The example provided is written in Python 3 :snake::snake::snake: and can be found [HERE](api_example.py).

## Requirements for example script
* ```websocket```
* ```json```
* ```base64```
* ```io```
* ```sys```

## Optional for example script
* ```PIL```

## Simple Example
```python
# Author: Markus Solbach (polyhedral@eecs.yorku.ca)
from websocket import create_connection
import io, sys, json, base64
from json import dumps

# Create Connection
ws = create_connection("ws://polyhedral.eecs.yorku.ca/api/")
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

# Close Connection
ws.close()
```


## Contact
* polyhedral@eecs.yorku.ca

## Notice
* We provide no guarantees for system performance.
* The system is provided as is.
* Developed for research purposes only and commercial use is not permitted.
* For comments, problems and questions, please send us an email (replies are not guaranteed).
* If you use any aspect of this system, we respectfully request that all relevant publications that result from any use of this paper or system cite the [paper](https://arxiv.org).