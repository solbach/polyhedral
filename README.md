# [API] Random Polyhedral Scenes: An Image Generator for Active Vision System Experiments
We present a Polyhedral Scene Generator system which creates a random scene based on a few user parameters, renders the scene from random view points and creates a dataset containing the renderings and corresponding annotation files. We think that this generator will help to understand how a program could parse a scene if it had multiple angle to compare. For ambiguous scenes, typically people move their head or change their position to see the scene from different angle as well as seeing how it changes while they move; a research field called active perception. The random scene generator presented is designed to support research in this field by generating images of scenes with known complexity characteristics and with verfieable properties with respect to the distribution of features across a population. Thus, it is well-suited for research in active perception without the requirement of a live 3D environment and mobile sensing agent as well as for comparative performance evaluations. :rocket:

System: [HERE](http://polyhedral.eecs.yorku.ca)
Paper: [HERE](https://arxiv.org)

![Example Scenes](/images/scenes.jpg)


## What is this GitHub page about?
This is the home of the application program interface (**API**) for the [Random Polyhedral Scenes: An Image Generator for Active Vision System Experiments](http://polyhedral.eecs.yorku.ca) system.
The API is realized using WebSockets. Basically any programming language that supports WebSockets can be used :tada: (Java, C/C++, Python, MatLab, ...).

The example provided is written in Python 3 :snake: and can be found [HERE](api_example.py)

## Requirements for example script
* ```websocket```
* ```json```
* ```base64```
* ```io```
* ```sys```

## Optional for example script
* ```PIL```