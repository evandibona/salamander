! Copyright (C) 2014 Your name.
! See http://factorcode.org/license.txt for BSD license.
USING: kernel math.statistics math.functions sequences 
math ; 
IN: salamander.filters

: ma ( seq -- n ) 
    mean ;
: ma2 ( seq s -- s l ) 
    dupd tail mean swap mean ; 


: difsq ( a mean -- n ) 
    - sq ; 

: calc-store ( seq mean n -- seq mean )
    over difsq swapd suffix swap ; 

: variance ( seq -- v ) 
    { } swap dup mean swap [ calc-store ] each drop mean ; 

: std-dev ( seq -- stdev ) 
    variance sqrt ; 
