# PharoSourceCode

This repository contains the Pharo source code of the Agile Artificial Intelligence book.

You can load it via:

```Smalltalk
Metacello new
  baseline: 'NeuralNetwork';
  repository: 'github://AgileArtificialIntelligence/PharoSourceCode/src' ;
  load.
```


If you have a local copy:
```Smalltalk
Metacello new
  baseline: 'NeuralNetwork';
  repository: 'gitlocal:///Users/alexandrebergel/Dropbox/GitRepos/PharoSourceCode' ;
  lock;
  load.
```
