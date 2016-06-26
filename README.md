erlambda
=====
[![Build
Status](https://travis-ci.org/pzel/erlambda.svg?branch=master)](https://travis-ci.org/pzel/erlambda)

## This is an interpreter for a small Simply Typed Lambda Calculus.

Run `make` to build, test, and produce an `erlambda` exectuable file in the project root.


## Example usage

```

$ cat examples/01_numbers.tlc
(\x:Unit -> \y:Number -> y) () 2473296498327643
$ ./erlambda examples/01_numbers.tlc
2473296498327643

$ cat examples/02_wrong_types.tlc
(\i:Number -> i) True
$ ./erlambda examples/02_wrong_types.tlc
{constraint_failed,{{app,{lambda,{param,i,{'Number'}},i},'True'},{'Fun',{'Number'},{'Number'}},{'Boolean'}}}

$ cat examples/03_higher_order_functions.tlc
let h = (\f:(Number->Number) -> f 5) 
in h (\x:Number -> x + 2)
$ ./erlambda examples/03_higher_order_functions.tlc
7
```
