erlambda
=====
[![Build
Status](https://travis-ci.org/pzel/erlambda.svg?branch=master)](https://travis-ci.org/pzel/erlambda)

Contents
-------

  - `erlambda` -- an incarnation of [Matt Might's tiny interpreter](http://matt.might.net/articles/implementing-a-programming-language/)

## Example usage

```

$ cat test/ex01.tlc
((\x:Unit -> \y:Number -> y) ()) 2473296498327643
$ ./erlambda test/ex01.tlc
2473296498327643

$ cat test/ex02.tlc
(\i:Number -> i) True
$ ./erlambda test/ex02.tlc
{constraint_failed,{{app,{lambda,{param,i,{'Number'}},i},'True'},{'Fun',{'Number'},{'Number'}},{'Boolean'}}}

$ cat test/ex03.tlc
(\f:(Number->Number) -> f 5) (\n -> n)
$ ./erlambda test/ex03.tlc
5
```
