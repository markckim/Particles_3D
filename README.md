# Particles_3D
A method to prototype 3D particles within Open GL using config files. Config files can be used to create and modify particle behavior for quick testing and easily exporting your particle parameters once you are satisfied with your results.

Particle files are in JSON format and are made up of a number of properties which can be modified. Once this JSON file is created, it can be added into the project, and the JSON filename can be added to the `resourceNames` array found in `GameViewController.m` for viewing within the app.

Here is an example of a particle config file:
```
{
    "birthRate": 4000,
    "maximumParticles": 400,
    "imageName": "spark.png",
    "lifetime": 5,
    "lifetimeRange": 0,
    "emitterLifetime": 10,
    "positionRangeX": 0.02,
    "positionRangeY": 0.02,
    "positionRangeZ": 0.02,
    "positionRadius": 0,
    "positionRadiusRange": 0,
    "positionTheta": 0,
    "positionThetaRange": 0,
    "positionPhi": 0,
    "positionPhiRange": 0,
    "forcePositionOffsetX": 0,
    "forcePositionOffsetY": 0,
    "forcePositionOffsetZ": 0,
    "forceValue": 0,
    "isPositionRectangular": 1,
    "isPositionRadial": 0,
    "isForcePresent": 0,
    "angle": 90,
    "angleRange": 180,
    "phi": 90,
    "phiRange": 90,
    "speed": 4,
    "speedRange": 0.5,    
    "accelerationX": 0,
    "accelerationY": 0,
    "accelerationZ": 0,
    "alpha": -1,
    "alphaRange": 0,
    "alphaSpeed": 0,
    "alphaCutoff": 0.5,
    "scale": 0.8,
    "scaleRange": 0.1,
    "scaleSpeed": 0,
    "perspectiveMaxDistance": 20,
    "rotation": 0,
    "rotationRange": 0,
    "rotationSpeed": 0,
    "emitterRotationX": 0,
    "emitterRotationY": 0,
    "emitterRotationZ": 0,
    "emitterRotationSpeedX": 0,
    "emitterRotationSpeedY": 0,
    "emitterRotationSpeedZ": 0,
    "colorR": 0,
    "colorG": 0.804,
    "colorB": 1,
    "colorEndR": 0,
    "colorEndG": 0.408,
    "colorEndB": 0.894,
    "colorRangeR": 0.3,
    "colorRangeG": 0.05,
    "colorRangeB": 0.2,
}
```

Once this JSON file is loaded within the app, it can be selected and viewed within the app. Once the app is open, tapping the screen will create an emitter to show the particle effect in Open GL 3D space. Here is a video showing the results of the above JSON file:

[![3D Particle Demo Using Config Files](http://i.imgur.com/AMt1t51.png)](https://www.youtube.com/watch?v=gVkh_agmP7U "3D Particle Demo Using Config Files")