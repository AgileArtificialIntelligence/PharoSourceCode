Class {
	#name : #CExampleWithGA,
	#superclass : #Object,
	#category : #Creature
}

{ #category : #'genetic algorithm' }
CExampleWithGA >> result02 [

"mg := CMuscleGenerator new
		minStrength: 1.5;
		deltaStrength: 5;
		deltaTime: 200;
		minTime: 20;
		minLength: 10;
		deltaLength: 80.
g := GAEngine new.
g crossoverOperator: (GAConstrainedCrossoverOperation new possibleCutpoints: (1 to: 15 by: 5)).
g mutationRate: 0.1.
g endForMaxNumberOfGeneration: 20.
g populationSize: 1000.
g numberOfGenes: 3 * 5.
g createGeneBlock: [ :r :index | mg valueForIndex: index ].
g fitnessBlock: [ :genes |
	creature := CCreature new configureNbNodes: 3 nbMuscles: 3.
	creature materialize: genes.
	creature resetPosition.
	c := CCanvas new.
	c addPlatform: CPlatform new.
	c addCreature: creature.
	1000 timesRepeat: [ c beat ].
	creature position x
].

g run.
g."

| creature c |
creature := CCreature new configureNbNodes: 3 nbMuscles: 3.
"creature materialize: g result."
	creature materialize:  #(54 86 4.939039338118881 50 46 12 14 2.1024524874996637 186 77 70 87 3.5876934901288213 83 89).
	creature resetPosition.
	c := CCanvas new.
	c addPlatform: CPlatform new.
	c addCreature: creature.
	c open

]

{ #category : #'genetic algorithm' }
CExampleWithGA >> result03 [
"

mg := CMuscleGenerator new
		minStrength: 1.5;
		deltaStrength: 5;
		deltaTime: 200;
		minTime: 20;
		minLength: 10;
		deltaLength: 80.
g := GAEngine new.
g crossoverOperator: (GAConstrainedCrossoverOperation new possibleCutpoints: (1 to: 25 by: 5)).
g mutationRate: 0.1.
g endForMaxNumberOfGeneration: 20.
g populationSize: 1000.
g numberOfGenes: 5 * 5.
g createGeneBlock: [ :r :index | mg valueForIndex: index ].
g fitnessBlock: [ :genes |
	creature := CCreature new configureNbNodes: 4 nbMuscles: 5.
	creature materialize: genes.
	creature resetPosition.
	c := CCanvas new.
	c addPlatform: CPlatform new.
	c addCreature: creature.
	1000 timesRepeat: [ c beat ].
	creature position x
].

[g run ] timeToRun.
g
"

| c creature |
creature := CCreature new configureNbNodes: 4 nbMuscles: 5.
	creature materialize: #(57 61 2.948715797834432 137 49 31 28 1.92998272247146 54 217 30 88 3.4641803516839538 67 128 87 82 3.2223055156517333 209 166 18 13 4.318311728918139 216 57).
	creature resetPosition.
	c := CCanvas new.
	c addPlatform: CPlatform new.
	c addCreature: creature.
	c open
]

{ #category : #'genetic algorithm' }
CExampleWithGA >> result04 [
"mg := CMuscleGenerator new
		minStrength: 1.5;
		deltaStrength: 5;
		deltaTime: 200;
		minTime: 20;
		minLength: 10;
		deltaLength: 80.
g := GAEngine new.
g crossoverOperator: (GAConstrainedCrossoverOperation new possibleCutpoints: (1 to: 25 by: 5)).
g selection: (GATournamentSelection new tournamentSize: 30).
g mutationRate: 0.1.
g endForMaxNumberOfGeneration: 30.
g populationSize: 1000.
g numberOfGenes: 5 * 5.
g createGeneBlock: [ :r :index | mg valueForIndex: index ].
g fitnessBlock: [ :genes |
	creature := CCreature new configureNbNodes: 4 nbMuscles: 5.
	creature materialize: genes.
	creature resetPosition.
	c := CCanvas new.
	c addPlatform: CPlatform new.
	c addCreature: creature.
	1000 timesRepeat: [ c beat ].
	creature position x
].

[g run ] timeToRun.
g."

| c creature |

creature := CCreature new configureNbNodes: 4 nbMuscles: 5.
	creature materialize: #(84 86 4.847119399508051 134 148 58 12 6.253399093054886 26 65 20 21 1.7179966076361 87 61 37 41 1.981972552594716 131 102 24 25 4.620223951116309 85 65).
	creature resetPosition.
	c := CCanvas new.
	c addPlatform: CPlatform new.
	c addCreature: creature.
	c open


 
]

{ #category : #'genetic algorithm' }
CExampleWithGA >> result05 [
"mg := CMuscleGenerator new
		minStrength: 1.5;
		deltaStrength: 5;
		deltaTime: 200;
		minTime: 20;
		minLength: 10;
		deltaLength: 80.
g := GAEngine new.
g crossoverOperator: (GAConstrainedCrossoverOperation new possibleCutpoints: (1 to: 8*5 by: 5)).
g selection: (GATournamentSelection new tournamentSize: 30).
g mutationRate: 0.1.
g endForMaxNumberOfGeneration: 30.
g populationSize: 1000.
g numberOfGenes: 8 * 5.
g createGeneBlock: [ :r :index | mg valueForIndex: index ].
g fitnessBlock: [ :genes |
	creature := CCreature new configureNbNodes: 6 nbMuscles: 8.
	creature materialize: genes.
	creature resetPosition.
	c := CCanvas new.
	c addPlatform: CPlatform new.
	c addCreature: creature.
	1000 timesRepeat: [ c beat ].
	creature position x
].
g run. 
g."

| creature c |
creature := CCreature new configureNbNodes: 6 nbMuscles: 8.
	creature materialize: #(71 76 2.9511110756784262 67 159 13 25 4.056027300914762 115 109 89 49 5.323848927311529 26 30 28 27 3.6052427459998255 173 213 17 12 5.712459558254322 122 196 85 62 3.1004695238547724 113 67 12 16 2.3213147152314497 140 95 27 17 5.637003838148435 174 209).
 	creature resetPosition.
	c := CCanvas new.
	c addPlatform: CPlatform new.
	c addCreature: creature.
	c open



 
]

{ #category : #'genetic algorithm' }
CExampleWithGA >> result06 [
"BALL CREATURE. WORK!!!"
"numberOfMuscles := 90.
mg := CMuscleGenerator new
		minStrength: 0.01;
		deltaStrength: 0.5;
		minLength: 10;
		deltaLength: 80;
		deltaTime: 200;
		minTime: 20.
g := GAEngine new.
g crossoverOperator: (GAConstrainedCrossoverOperation new possibleCutpoints: (1 to: numberOfMuscles*5 by: 5)).
g selection: (GATournamentSelection new tournamentSize: 40).
g mutationRate: 0.1.
g endForMaxNumberOfGeneration: 50.
g populationSize: 1000.
g numberOfGenes: numberOfMuscles * 5.
g createGeneBlock: [ :r :index | mg valueForIndex: index ].
g fitnessBlock: [ :genes |
	creature := CCreature new configureBall: 10.
	creature materialize: genes.
	creature resetPosition.
	c := CCanvas new.
	c addPlatform: CPlatform new.
	c addCreature: creature.
	3000 timesRepeat: [ c beat ].
	creature position x
].
g run. 
g.
"
|creature c |
creature := CCreature new  configureBall: 10.
	creature materialize: #(72 47 0.39463897788181856 116 213 68 69 0.037057391371139045 187 32 55 61 0.19903225063766924 57 218 21 24 0.39874715025944035 197 30 58 68 0.19476326772233624 107 172 61 65 0.07503646730679854 152 202 25 23 0.37170459741805895 52 44 29 62 0.08570627428391309 122 173 90 62 0.44506213344403645 130 29 50 16 0.30675197265890985 88 49 11 32 0.27740354870790784 84 150 87 11 0.4662545809691095 26 37 23 35 0.08115693952476463 25 43 13 30 0.4900806732289869 168 38 39 24 0.22181016518353028 206 60 40 80 0.4793826485748322 81 201 38 44 0.3342791799475808 135 66 18 16 0.4449115222855059 45 62 27 33 0.3413456623960965 186 207 30 85 0.23663195325370504 144 197 79 82 0.055566653388350574 72 133 33 40 0.27732149895621533 125 165 55 16 0.48488481131144096 56 178 79 54 0.3331458488493906 57 126 75 69 0.09046341481640162 70 41 18 42 0.20347787983411825 117 47 19 37 0.3990237113875447 150 165 53 45 0.13812508625356718 155 160 56 23 0.01479977927394201 149 175 34 55 0.14182815356730863 75 185 86 11 0.08218634131000672 130 117 58 40 0.01944856135614615 130 158 59 89 0.26323249783983105 188 34 72 59 0.08859119404041729 204 93 63 20 0.08163591313717695 173 132 38 17 0.04437861103302735 170 214 54 86 0.12924847686628274 63 54 44 26 0.17914043443703115 208 48 78 19 0.4354223617843456 118 50 44 42 0.025530015581999913 34 130 71 63 0.08520111863277904 119 188 44 28 0.2617012454344431 214 209 79 79 0.2022125069853908 107 76 13 54 0.05774230837251167 58 166 23 88 0.1547564112696594 135 126 64 87 0.34711349118366536 135 217 52 77 0.508513797064551 55 142 44 49 0.4727480236639958 100 148 69 30 0.09322318507508523 156 63 75 47 0.016816875891209056 120 185 81 23 0.21133790476309972 175 184 66 61 0.3601989791869181 133 49 33 13 0.3715107647429736 150 202 78 28 0.33796760454213604 196 215 19 35 0.1668045912574998 185 145 12 75 0.1660420196764367 135 139 37 75 0.10822470187126877 144 196 72 67 0.18549547863914423 123 213 44 48 0.0614789649990755 185 106 88 40 0.1332288550228015 95 144 37 39 0.15336994413443375 104 141 21 56 0.27560200437232946 64 210 77 16 0.373816235383887 26 140 31 83 0.1286510674276627 217 70 71 35 0.09183399009603727 114 148 88 45 0.09170162960034871 145 134 56 51 0.26861416559601864 117 105 36 76 0.39387154409842173 112 43 41 37 0.20001720156055747 22 63 11 13 0.15728485939432163 28 101 20 19 0.4266318403634391 146 212 82 71 0.17849025672697008 196 40 61 64 0.2238289125700616 104 159 56 88 0.08589308758075026 35 169 16 62 0.3579907097518401 172 149 26 25 0.1898587991762249 140 34 60 28 0.17737507501029182 155 185 43 27 0.09797876145130896 125 112 58 40 0.28276033222338204 46 66 64 53 0.29290367838130504 63 143 65 88 0.4451951600681968 143 88 81 88 0.33135717678878324 94 215 52 63 0.21385874374949315 110 162 83 71 0.2639061977313395 97 27 75 90 0.14866119442445283 111 171 37 50 0.2548601016052347 145 115 70 68 0.43680335041452356 81 110 60 69 0.3352646708047319 134 193 89 46 0.14126485381799977 88 40 38 88 0.037289590345364804 206 69 ).
 	creature resetPosition.
	c := CCanvas new.
	c addPlatform: CPlatform new.
	c addCreature: creature.
	c open
	

]

{ #category : #'genetic algorithm' }
CExampleWithGA >> run [

| g creature c mg |
mg := CMuscleGenerator new
		minStrength: 3;
		deltaStrength: 8.
g := GAEngine new.
g populationSize: 100.
g numberOfGenes: 5 * 5.
g createGeneBlock: [ :r :index | mg valueForIndex: index ].
g fitnessBlock: [ :genes |
	creature := CCreature new configureNbNodes: 4 nbMuscles: 5.
	creature materialize: genes.
	c := CCanvas new.
	c addPlatform: CPlatform new.
	c addCreature: creature.
	50 timesRepeat: [ c beat ].
	creature position x
].

g run.

(g logs collect: #fitness) plot.

g result "#(35 16 6 32 28 5 18 24 6 13 11 3)"
]

{ #category : #'genetic algorithm' }
CExampleWithGA >> runOLD [

| g creature c |
g := GAEngine new.
g populationSize: 100.
g numberOfGenes: 4 * 3.
g createGeneBlock: [ :r :index |
	(index - 1 % 3) == 0 
		ifTrue: [ 10 + (r nextInt: 30) ]
		ifFalse: [ (index - 1 % 3) == 1 
							ifTrue: [  10 + (r nextInt: 30)  ]
							ifFalse: [ (r nextInt: 4) + 2 ] ]
].
g fitnessBlock: [ :genes |
	creature := CCreature new configureNbNodes: 4 nbMuscles: 4.
	creature materialize: genes.
	c := CCanvas new.
	c addPlatform: CPlatform new.
	c addCreature: creature.
	50 timesRepeat: [ c beat ].
	creature position x
].

g run.

(g logs collect: #fitness) plot.

g result "#(35 16 6 32 28 5 18 24 6 13 11 3)"
]

{ #category : #simple }
CExampleWithGA >> simpleExample01 [
	| mg cr c |
	mg := CMuscleGenerator new
		minStrength: 3;
		deltaStrength: 8.
	cr := CCreature new
		muscleGenerator: mg;
		configureNbNodes: 4 nbMuscles: 5.
	c := CCanvas new.
	c addCreature: cr.
	c addPlatform: CPlatform new.
	c open
]
