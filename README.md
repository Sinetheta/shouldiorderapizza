# ShouldIOrderAPizza.com [![Build Status](http://sinetheta-jenkins.bitnamiapp.com/jenkins/buildStatus/icon?job=shouldiorderapizza)](http://sinetheta-jenkins.bitnamiapp.com/jenkins/job/shouldiorderapizza/)

Answering the important questions.

## Getting Started

1. `npm install bower grunt-cli -g` to install Bower and Grunt.
2. `npm install` to install development dependencies.
3. `bower install` to install website assets.
4. `grunt serve` to start a webserver and open the app.


## Before Committing

1. `grunt test` to make sure everything is still passing.
2. `grunt serve:dist` to verify that any changes you have made will survive the
build process. Sometimes minification can have unnexpected side-effects.

## After Committing

Build progress can be monitored at http://jenkins.sinetheta.ca/jenkins/job/shouldiorderapizza/
Healthy builds will be deployed automatically #YOLO
