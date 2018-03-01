Class {
	#name : #BaselineOfRoelTyper,
	#superclass : #BaselineOf,
	#category : #BaselineOfRoelTyper
}

{ #category : #baselines }
BaselineOfRoelTyper >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec 
			package: 'RoelTyper'.]
			"package: 'RoelTyper-Tests' with: [spec requires: #(RoelTyper)]
		spec 
			group: 'default' with: #('Core' 'Tests');
			group: 'Core' with: #('RoelTyper');
			group: 'Tests' with: #('RoelTyper-Tests')" 
]
