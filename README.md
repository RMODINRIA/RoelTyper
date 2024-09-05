# RoelTyper

## Description

A single method type inferencer. Described in the Dynamic Language Symposium http://roelwuyts.be/publications/Pluq09b-RoelTyper.pdf

## Installation

To install RoelTyper on your Pharo image you can just execute the following script:

```Smalltalk
    Metacello new
    	githubUser: 'RMODINRIA' project: 'RoelTyper' commitish: 'v1.x.x' path: 'src';
    	baseline: 'RoelTyper';
    	load
```

To add RoelTyper to your baseline just add this:

```Smalltalk
    spec
    	baseline: 'RoelTyper'
    	with: [ spec repository: 'github://RMODINRIA/RoelTyper:v1.x.x/src' ]
```

Note that you can replace the #v1.x.x by a branch as #master or #development or a tag as #v1.0.0, #v1.? or #v1.2.x.

## Smalltalk versions compatibility

| Version 		| Compatible Pharo versions 	| 
|-------------	|---------------------------	|
| 1.x.x       	| Pharo 70						|
| Dev       	| Pharo 70						|
| master       	| Pharo 61 - 12					|
