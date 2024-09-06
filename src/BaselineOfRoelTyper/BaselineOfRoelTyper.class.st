"
Baseline of the RoelTyper project
"
Class {
	#name : 'BaselineOfRoelTyper',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfRoelTyper',
	#package : 'BaselineOfRoelTyper'
}

{ #category : 'baselines' }
BaselineOfRoelTyper >> baseline: spec [

	<baseline>
	spec for: #common do: [
		spec
			package: 'RoelTyper';
			package: 'RoelTyper-Tests' with: [ spec requires: #( 'default' ) ].

		spec group: 'Tests' with: #( 'RoelTyper-Tests' ) ].

	spec
		for: #( #'pharo13.x' #'pharo14.x' #'pharo15.x' #'pharo16.x' )
		do: [
			spec
				package: 'RoelTyper_Pharo13'
				with: [ spec requires: #( 'RoelTyper' ) ];
				group: 'default' with: #( 'RoelTyper_Pharo13' ) ].

	spec
		for: #( #'pharo9.x' #'pharo10.x' #'pharo11.x' #'pharo12.x' )
		do: [
			spec
				package: 'RoelTyper_Pharo9_12'
				with: [ spec requires: #( 'RoelTyper' ) ];
				group: 'default' with: #( 'RoelTyper_Pharo9_12' ) ].

	spec
		for: #( #'pharo1.x' #'pharo2.x' #'pharo3.x' #'pharo4.x' #'pharo5.x'
			   #'pharo6.x' #'pharo7.x' #'pharo8.x' )
		do: [
			spec
				package: 'RoelTyper_Pharo1_8'
				with: [ spec requires: #( 'RoelTyper' ) ];
				group: 'default' with: #( 'RoelTyper_Pharo1_8' );
				package: 'RoelTyper_Pharo1_8-Tests'
				with: [ spec requires: #( 'RoelTyper-Tests' ) ];
				group: 'Tests' with: #( 'RoelTyper_Pharo1_8-Tests' ) ]
]

{ #category : 'accessing' }
BaselineOfRoelTyper >> projectClass [
	^ MetacelloCypressBaselineProject
]
