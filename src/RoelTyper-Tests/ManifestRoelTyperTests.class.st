"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : 'ManifestRoelTyperTests',
	#superclass : 'PackageManifest',
	#category : 'RoelTyper-Tests-Manifest',
	#package : 'RoelTyper-Tests',
	#tag : 'Manifest'
}

{ #category : 'code-critics' }
ManifestRoelTyperTests class >> ruleFloatReferencesRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGPackageDefinition #(#'RoelTyper-Tests')) #'2024-09-05T13:06:47.83+02:00') )
]

{ #category : 'code-critics' }
ManifestRoelTyperTests class >> ruleGRTemporaryNeitherReadNorWrittenRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#TypeCollectorTest #methodWithTmpInBlock: #false)) #'2018-11-15T18:15:36.392243+01:00') )
]

{ #category : 'code-critics' }
ManifestRoelTyperTests class >> ruleRefersToClassRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMethodDefinition #(#InstvarInterfaceExtractorTest #mainTestClass #false)) #'2024-09-05T21:27:56.841+02:00') )
]
