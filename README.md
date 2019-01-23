# PharoSourceCode

This repository contains the Pharo source code of the Agile Artificial Intelligence book.

Before loading the code, you need to have the Roassal visualization engine installed. You can do so with:

```Smalltalk
Metacello new
    baseline: 'Roassal2';
    repository: 'github://ObjectProfile/Roassal2/src';
    load.
```

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
