"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestRoelTyper,
	#superclass : #PackageManifest,
	#category : #'RoelTyper-Manifest'
}

{ #category : #'code-critics' }
ManifestRoelTyper class >> ruleGRTemporaryNeitherReadNorWrittenRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#TypeCollectorTests #methodWithTmpInBlock: #false)) #'2018-11-15T18:05:43.131645+01:00') )
]
