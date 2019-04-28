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
  baseline: 'AgileArtificialIntelligence';
  repository: 'github://AgileArtificialIntelligence/PharoSourceCode/src' ;
  load.
```


If you have a local copy of both Roassal2 and PharoSourceCode:
```Smalltalk
Metacello new
  baseline: 'Roassal2';
  repository: 'gitlocal:///Users/alexandrebergel/Dropbox/GitRepos/Roassal2' ;
  lock;
  load.
  
Metacello new
  baseline: 'AgileArtificialIntelligence';
  repository: 'gitlocal:///Users/alexandrebergel/Dropbox/GitRepos/PharoSourceCode' ;
  lock;
  load.
```
