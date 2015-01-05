! Copyright (C) 2014 Evan DiBona.
! See http://factorcode.org/license.txt for BSD license.
USING: timers prettyprint json.reader http.client urls.secure kernel 
strings assocs math.parser calendar threads arrays variables 
namespaces sequences math math.statistics io random 
salamander.belts salamander.strategies
vocabs.loader 
;

IN: salamander
SYMBOLS: whuf leather ; 

: vars-get ( -- var2 var1 ) 
    leather get whuf get ; 

: vars-set ( var2 var1 -- ) 
    whuf set leather set ; 

: overflow? ( whuf -- bool ) 
    length 15 < ; 

: get-ticker ( -- str ) 
    "https://btc-e.com/api/3/ticker/btc_usd" 
    http-get swap drop ; 

: fetch-price ( -- n ) 
    get-ticker json> "btc_usd" swap at 
    "last" swap at ; 

: record-price ( buf -- buf ) 
    fetch-price suffix ; 

: run-cycle ( belt -- )
    dup first 0 = 
      [ first . ]
      [ "salamander.strategies" reload current-strategy ] 
      if ; 

: tick ( -- ) 
    vars-get 
    record-price dup overflow? 
        [ ] 
        [ mean click dup run-cycle { } ]
    if 
    dup first number>string print 
    vars-set ; 

: salamander-kick ( -- timer )
    50 new-belt { } vars-set
    [ tick ] 10 seconds every ; 

: salamander-run ( -- ) 
    salamander-kick [ t ] [ ] while stop-timer ; 

MAIN: salamander-run
