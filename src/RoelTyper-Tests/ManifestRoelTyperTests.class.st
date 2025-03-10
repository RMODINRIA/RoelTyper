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
ManifestRoelTyperTests class >> ruleEqualNotUsedRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGClassDefinition #(#ASampleClass)) #'2025-03-24T15:22:36.333+01:00') )
]

{ #category : 'code-critics' }
ManifestRoelTyperTests class >> ruleModifiesCollectionRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGClassDefinition #(#ASampleClass)) #'2025-03-24T15:22:44.782+01:00') )
]

{ #category : 'code-critics' }
ManifestRoelTyperTests class >> ruleStringConcatenationRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGClassDefinition #(#ASampleClass)) #'2025-03-24T15:22:40.969+01:00') )
]

{ #category : 'code-critics' }
ManifestRoelTyperTests class >> ruleTempsReadBeforeWrittenRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGClassDefinition #(#ASampleClass)) #'2025-03-24T15:22:31.017+01:00') )
]
