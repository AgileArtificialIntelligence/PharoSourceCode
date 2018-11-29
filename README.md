# PharoSourceCode

This repository contains the Pharo source code of the Agile Artificial Intelligence book.

You can load it via:

```
Metacello new
  package: 'NeuralNetwork';
  repository: 'github://AgileArtificialIntelligence/PharoSourceCode/src' ;
  lock;
  load.
```


If you have a local copy:
```
Metacello new
  package: 'NeuralNetwork';
  repository: 'gitlocal:///Users/alexandrebergel/Dropbox/GitRepos/PharoSourceCode' ;
  lock;
  load.
```
