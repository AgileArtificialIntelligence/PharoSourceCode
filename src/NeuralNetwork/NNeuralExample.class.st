Class {
	#name : #NNeuralExample,
	#superclass : #Object,
	#category : #'NeuralNetwork-Examples'
}

{ #category : #examples }
NNeuralExample >> example2dPlan [

| f p r anX anY designedOutput testPoints g d d2 |
f := [ :x | (-2 * x) - 3 ].
p := Neuron new.
p step.
p weights: { 1 . 2 }.
p bias: -1.
r := Random new seed: 42.

"We are training the perceptron"
2000 timesRepeat: [ 
    anX := (r nextInt: 50) - 25.
    anY := (r nextInt: 50) - 25.
    designedOutput := (f value: anX) >= anY 
                                ifTrue: [ 1 ] ifFalse: [ 0 ].
    p train: { anX . anY } desiredOutput: designedOutput 
].

"Test points"
testPoints := OrderedCollection new.
500 timesRepeat: [ 
    testPoints add: { ((r nextInt: 50) - 25) . ((r nextInt: 50) - 25) }
].

g := RTGrapher new.
d := RTData new.
d dotShape 
    color: [ :point | (p feed: point) > 0.5 
                    ifTrue: [ Color red trans ] 
                    ifFalse: [ Color blue trans ] ].
d points: testPoints.
d x: #first.
d y: #second.
g add: d.

d2 := RTData new.
d2 noDot.
d2 connectColor: Color red.
d2 points: (-15 to: 15 by: 0.1).
d2 y: f.
d2 x: #yourself.
g add: d2.
g
]

{ #category : #examples }
NNeuralExample >> example2dPlanLearningCurve [

| learningCurve f r p anX anY trainedOutput nbOfGood nbOfTries realOutput g d |
learningCurve := OrderedCollection new.
f := [ :x | (-2 * x) - 3 ].

0 to: 2000 by: 10 do: [ :nbOfTrained |
    r := Random new seed: 42.
    p := Neuron new.
    p step.
    p weights: #(1 2).
    p bias: -1.

    nbOfTrained timesRepeat: [ 
        anX := (r nextInt: 50) - 25.
        anY := (r nextInt: 50) - 25.
        trainedOutput := (f value: anX) >= anY ifTrue: [1] ifFalse: [0].
        p train: (Array with: anX with: anY) desiredOutput: trainedOutput ].
    
    nbOfGood := 0.
    nbOfTries := 1000.
    nbOfTries timesRepeat: [ 
        anX := (r nextInt: 50) - 25.
        anY := (r nextInt: 50)- 25.
        realOutput := (f value: anX) >= anY ifTrue: [1] ifFalse: [0].
        ((p feed: { anX . anY }) - realOutput) abs < 0.2
            ifTrue: [ nbOfGood := nbOfGood + 1 ].
    ].
    learningCurve add: { nbOfTrained . (nbOfGood / nbOfTries) }.
].

g := RTGrapher new.
d := RTData new.
d noDot.
d connectColor: Color blue.
d points: learningCurve.
d x: #first.
d y: #second.
g add: d.
g axisY title: 'Precision'.
g axisX noDecimal; title: 'Training iteration'.
g
]

{ #category : #examples }
NNeuralExample >> exampleANDLearningCurve [

| learningCurveNeuron r p res d g |
learningCurveNeuron := OrderedCollection new.
0 to: 1000 do: [ :nbOfTrained |
    r := Random new seed: 42.
    p := Neuron new.
	 p sigmoid.
    p weights: #(-1 -1).
    p bias: 2.

    nbOfTrained timesRepeat: [ 
        p train: #(0 0) desiredOutput: 0.
        p train: #(0 1) desiredOutput: 0.
        p train: #(1 0) desiredOutput: 0.
        p train: #(1 1) desiredOutput: 1 ].
   
    res :=  ((p feed: #(0 0)) - 0) abs + 
            ((p feed: #(0 1)) - 0) abs +
            ((p feed: #(1 0)) - 0) abs +
            ((p feed: #(1 1)) - 1) abs.
     learningCurveNeuron add: res / 4.
    
].


g := RTGrapher new.
d := RTData new.
"d label: 'Sigmoid neuron'."
d noDot.
d connectColor: Color red.
d points: learningCurveNeuron.
d y: #yourself.
g add: d.
g axisY title: 'Error'.
g axisX noDecimal; title: 'Epoch'.
g
]

{ #category : #examples }
NNeuralExample >> exampleComparingStepAndSigmoidFunction [

| learningCurveNeuron r p res learningCurvePerceptron d g |
learningCurveNeuron := OrderedCollection new.
0 to: 1000 do: [ :nbOfTrained |
    r := Random new seed: 42.
    p := Neuron new.
    p weights: #(-1 -1).
    p bias: 2.

    nbOfTrained timesRepeat: [ 
        p train: #(0 0) desiredOutput: 0.
        p train: #(0 1) desiredOutput: 0.
        p train: #(1 0) desiredOutput: 0.
        p train: #(1 1) desiredOutput: 1 ].
   
    res :=  ((p feed: #(0 0)) - 0) abs + 
            ((p feed: #(0 1)) - 0) abs +
            ((p feed: #(1 0)) - 0) abs +
            ((p feed: #(1 1)) - 1) abs.
     learningCurveNeuron add: res / 4.
    
].

learningCurvePerceptron := OrderedCollection new.
0 to: 1000 do: [ :nbOfTrained |
    r := Random new seed: 42.
    p := Neuron new.
    p step.
    p weights: #(-1 -1).
    p bias: 2.

    nbOfTrained timesRepeat: [ 
        p train: #(0 0) desiredOutput: 0.
        p train: #(0 1) desiredOutput: 0.
        p train: #(1 0) desiredOutput: 0.
        p train: #(1 1) desiredOutput: 1 ].
   
    res :=  ((p feed: #(0 0)) - 0) abs + 
            ((p feed: #(0 1)) - 0) abs +
            ((p feed: #(1 0)) - 0) abs +
            ((p feed: #(1 1)) - 1) abs.
     learningCurvePerceptron add: res / 4.
    
].

g := RTGrapher new.
d := RTData new.
d label: 'Sigmoid neuron'.
d noDot.
d connectColor: Color blue.
d points: learningCurveNeuron.
d y: #yourself.
g add: d.

d := RTData new.
d label: 'Perceptron'.
d noDot.
d connectColor: Color green.
d points: learningCurvePerceptron.
d y: #yourself.
g add: d.
g axisY title: 'Error'.
g axisX noDecimal; title: 'Epoch'.
g legend addText: 'Perceptron vs Sigmoid neuron'.
g
]

{ #category : #examples }
NNeuralExample >> exampleXOR [

| n data |
n := NNetwork new.
n configure: 2 hidden: 3 nbOfOutputs: 2.

data := {#(0 0 0) .
    #(0 1 1) .
    #(1 0 1) .
    #(1 1 0) }.
n train: data nbEpochs: 20000
]
