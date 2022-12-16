#!/bin/sh

ctrl=false
alt=false
super=false
shift=false
keypress=false
altgr=false
printed=""

xinput --test-xi2 --root 3 |
while IFS= read -r line
do
    case "$line" in
        *KeyPress*) keypress=true
                  ;;
        *detail*) key="${line#*:}"
                  case "$key" in
                      *37) ctrl=$keypress
                           ;;
                      *64) alt=$keypress
                           ;; 
                      *133) super=$keypress
                           ;; 
                      *50) shift=$keypress
                           ;; 
                      *108) altgr=$keypress
                           ;; 
                  esac
                  keypress=false
                  ;;
    esac
    p=""
    if $ctrl ; then
        p=$p" ctrl" 
    fi    
    if $alt ; then
        p=$p" alt" 
    fi    
    if $super ; then
        p=$p" super" 
    fi    
    if $shift ; then
        p=$p" shift" 
    fi
    if $altgr ; then
        p=$p" altgr" 
    fi
    if [ "$p" != "$printed" ] ; then
        printed=$p
        echo $p
    fi
done
      
