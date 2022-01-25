_TITLE "Kanji Lookup"
ON ERROR GOTO Errhandler
COMMON SHARED rs$
OPEN "kjfile.dat" FOR RANDOM ACCESS READ AS #1 LEN = 256
OPEN "COM3:9600,N,8,1,BIN,CS0,DS0" FOR OUTPUT AS 2
FIELD #1, 2 AS A$, 20 AS B$, 2 AS C$
NR = LOF(1) / 256
DO
    fl = 0
    waitkj
    kj$ = rs$
    _CLIPBOARD$ = kj$
    FOR N = 1 TO NR
        GET #1, N
        IF INSTR(kj$, A$) THEN
            PRINT
            PRINT "Kanji you copied is in the file."
            PRINT
            PRINT "Meaning: "; B$
            PRINT
            PRINT #2, CHR$(12)
            SLEEP 1
            PRINT #2, "Kanji you copied is in the file."
            PRINT #2, ""
            PRINT #2, "Meaning: "; B$
            PRINT #2, ""
            fl = 1
        END IF
    NEXT
    IF fl = 0 THEN
        BEEP
        PRINT
        PRINT "Kanji you copied is not in the file."
        PRINT
        PRINT #2, CHR$(12)
        SLEEP 1
        PRINT #2, "Kanji you copied is not in the"
        PRINT #2, ""
        PRINT #2, "file."
        PRINT #2, ""
    END IF
LOOP
CLOSE

Errhandler:
IF ERR = 52 OR ERR = 68 THEN RESUME NEXT
PRINT "Error"; ERR; "on program file line"; _ERRORLINE


SUB waitkj

DO
    or$ = rs$
    SLEEP 1
    rs$ = LTRIM$(RTRIM$(_CLIPBOARD$))
LOOP WHILE or$ = rs$

END SUB
