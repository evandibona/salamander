! Copyright (C) 2014 Your name.
! See http://factorcode.org/license.txt for BSD license.
USING: kernel sequences  ;
IN: salamander.belts

: drop-end ( seq -- seq ) 0 swap remove-nth ; 

: click ( x seq -- seq ) suffix drop-end ; 
: new-belt ( len -- belt ) { } new-sequence ; 
