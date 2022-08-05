include string.4th
include parser.4th

4096 constant max-line

: third ( a b c -- a b c a )
    >r over r> swap ;

: read-lines ( file-id -- )
    begin pad max-line third read-line throw
    while pad swap 2drop
    repeat 2drop ;

: usage
    ." Usage: fox <input.fox> [flags]" cr
    ." Flags:" cr
    ."   --help      Print this help message." cr ;

: fox
    argc @ 1 = if
        outfile-id
        stderr to outfile-id
        usage
        ." ERROR: Not enough arguments" cr
        to outfile-id
        1 (bye)
    then
    
    1 arg s" --help" str= if
        usage
        bye
    else
        try
            1 arg slurp-file s"  " split parse
        endtry-iferror
            1 arg type ." : " .error cr 1 (bye)
        then
        cr bye
    then ;