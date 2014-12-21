DirMap
======

## Updated: 19/12/2014
* Added param for dir so it can be called by another script for recursive work. Usage as follows:

Supply a path as a parameter and it'll scan all folders under it and output the map file in the root

```
perl dirmap.pl /Users/matt/Development/Media
```

By default, with no params, it uses a hard-coded value in the file itself.

```
perl dirmap.pl
```


## What's this then?
DirMap creates a simple Freemind map of a given directory.Tested and working in Freemind 0.9.0, using Perl 5 v18, on OSX. 

![Image of a file map created by the script](http://mattfenlon.com/img/Screen%20Shot%202014-12-18%20at%2009.22.10.png)

# Usage

* Clone it.
* Open up *dirmap.pl* and edit the *$dir* var to the full path of the directory that you want to map, without the trailing */*.
* Run *perl dirmap.pl*
* The file *filemap.mm* will have been created in the directory that you specified, open it up in Freemind.
* That's it...

[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/noln/dirmap/trend.png)](https://bitdeli.com/free "Bitdeli Badge")