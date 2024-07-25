   1 CLEAR 34999
   4 REM :USR 25000
   5 REM :LEN a$\#19932,b$\#19910
   7 REM :INT+ b,c,e,i,k,l,n,x,z,da,db,di,ii,nn
   9 REM :OPEN #
  10 IF PEEK 24995=255 THEN GO TO 370
  13 LET a$="--------------------------------": DIM c(32): GO TO 100
  19 REM \: Subroutines\ :
  20 POKE 23560,0: POKE 23658,0: PAUSE 0: LET k=PEEK 23560: RETURN : REM \: ChkKbd\ :
  30 INK 1: PLOT 79,0: DRAW 0,175: PLOT 167,0: DRAW 0,175: INK 4: RETURN
  40 PRINT #1;"Continue...": PAUSE 0: RETURN
  50 PRINT #1;"Press a key to return...": BEEP .09,12.9: PAUSE 0: RETURN
  60 LET db=INT (di/256): LET da=di-db*256: RETURN
  70 CLS : PRINT TAB 3; BRIGHT 1;"Charset "; INK 5;"Address:";TAB 22; INK 3;"ASM "; INK 6;"Call:"' INK 7; BRIGHT 0;a$: RETURN
  80 GO SUB 40: GO SUB 70: RETURN
  81 GO SUB 90: PRINT #1; INK 6;" In this start address, you are limited to "; INK 7;INT ((65535-i-10)/5); INK 6;" charset(s)."''" If you want "; INK 7;n; INK 6;" charsets, you"'"need to start on address #"; INK 5;65535-n*5-10' INK 6;"or below."'' INK 4;" Change the number of ("; INK 3;"C"; INK 4;")harsetsor change the ("; INK 3;"R"; INK 4;")outine start   address..."; INK 7; PAPER 1; FLASH 1;" "
  82 GO SUB 20: IF k= CODE "c" OR k= CODE "C" OR k=13 THEN GO TO 120
  83 IF k= CODE "r" OR k= CODE "R" THEN GO TO 100
  84 GO TO 82
  85 GO SUB 90: PRINT #1; INK 6;" If you want charsets next to"'"routine, you need to start on"'"address #"; INK 5;65535-n*5-10-n*768; INK 6;" or below."'' INK 4;" You can ("; INK 3;"C"; INK 4;")hange this, or"'"("; INK 3;"R"; INK 4;")estart the program..."; INK 7; PAPER 1; FLASH 1;" "
  86 GO SUB 20: IF k= CODE "c" OR k= CODE "C" OR k=13 THEN GO TO 173
  87 IF k= CODE "r" OR k= CODE "R" THEN GO TO 100
  88 GO TO 86
  90 PRINT #1;AT 0,0; INK 2;"ERROR! Not enough memory"'': BEEP .1,-13: RETURN
  99 REM \: ProgStartsHere\ :
 100 PAPER 0: BORDER 0: INK 4: BRIGHT 0: CLS
 105 PRINT INK 1;"S. Saborido";AT 0,27;"2023"'' INK 7;a$; BRIGHT 1;AT 2,7; PAPER 2; INK 0;"Micro"; INK 7; PAPER 8;"Hobby"; INK 6;" Charsets"'' INK 7; BRIGHT 0;a$;AT 4,8; BRIGHT 1; INK 5;"Routine Generator"
 110 INPUT AT 0,0;"Routine start address (>"; INK 6;"31999"; INK 7;"    & <"; INK 6;"65520"; INK 7;")? ";i: IF i<32e3 OR i>USR "t" THEN GO TO 110
 120 PRINT AT 7,1;">Routine start address: "; INK 6;i: LET ii=i: INPUT AT 0,0;"How many charsets (max. 32)? ";n: IF n<1 OR n>32 THEN GO TO 120
 125 IF i+n*5+10>65535 THEN GO TO 81
 130 PRINT '" >Charsets: "; INK 6;n: IF n=1 THEN GO TO 173
 135 PRINT #1;AT 0,0;"Consecutive charsets (y-n)? "
 140 GO SUB 20: IF k= CODE "y" OR k= CODE "Y" OR k=13 THEN GO TO 170
 150 IF k= CODE "n" OR k= CODE "N" THEN GO TO 220
 160 GO TO 140
 170 PRINT '" >Consecutive charsets: "; INK 6;"Yes"
 173 INPUT AT 0,0;"Start charsets Address (0 for"'"next to routine)? ";c
 175 IF (i AND NOT c)+c+n*5+10+n*768>65535 THEN GO TO 85
 176 IF (c+n*768>65535 AND c) THEN GO TO 170
 177 IF NOT c THEN PRINT '" >Charsets "; INK 6;"next"; INK 4;" to routine."
 180 IF (c<32e3 AND c) OR c>65535 THEN GO TO 170
 190 IF c THEN PRINT '" >Charsets start address: "; INK 6;c
 200 IF NOT c THEN LET c=i+5*n+10
 210 LET x=c: FOR z=1 TO n: LET c(z)=x: LET x=x+768: NEXT z: GO TO 230
 220 PRINT '" >Consecutive charsets: "; INK 6;"No": FOR z=1 TO n: INPUT INK 5; BRIGHT 1;"Charset "; INK 6;"#";(z); INK 5;" address? ";c(z): POKE 23692,255: PRINT INK 5;"   >Charset "; INK 6;"#";z; INK 5;" address: "; INK 6;c(z): NEXT z
 230 PRINT #1;AT 0,0;TAB 8;"All right (y-n)?": BEEP .1,13
 240 GO SUB 20: IF k= CODE "n" OR k= CODE "N" THEN GO TO 10
 250 IF k= CODE "y" OR k= CODE "Y" OR k=13 THEN GO TO 270
 260 GO TO 240
 269 REM \: Generate_ASM\ :
 270 PRINT #1;AT 0,0,,AT 0,0;"Generating ASM";: RESTORE 800: FOR z=0 TO 3: READ b: POKE ii+z,b: PRINT #1; INK 1;".";: NEXT z: LET ii=ii+z
 280 LET x=1: LET nn=n: FOR z=ii TO ii+n*5-1 STEP 5: POKE z,3+(nn-1)*5: LET di=c(x)-256: GO SUB 60: POKE z+1,33: POKE z+2,da: POKE z+3,db: POKE z+4,24: LET x=x+1: LET nn=nn-1: PRINT #1; INK 5;".";: NEXT z: LET ii=z-1
 290 RESTORE 810: FOR z=ii TO ii+6: READ b: POKE z,b: PRINT #1; INK 7;".";: NEXT z: LET e=z-1: LET l=e-i+1: GO TO 370
 294 REM \: ListASM\ :
 295 BORDER 1: CLS : LET x=0: LET b=0: LET nn=0: GO SUB 30
 300 FOR z=i TO e: PRINT AT b,x; BRIGHT nn; INK 5;z; INK 4;","; INK 6;PEEK z: LET b=b+1: LET nn=NOT nn: IF b=22 THEN GO SUB 331
 310 IF x<23 THEN GO TO 330
 320 LET x=0: GO SUB 40: CLS : GO SUB 30: LET nn=NOT nn
 330 NEXT z: GO TO 50
 331 LET b=0: LET x=x+11: LET nn=NOT nn: RETURN
 334 REM \: CharsetAddressList\ :
 335 GO SUB 70
 340 PRINT INK 1; BRIGHT 1;" ROM "; INK 4;"Charset: "; INK 5;"15616"; INK 2;" > "; INK 3;"USR "; INK 6;i
 350 LET b=1: FOR z=1 TO n: PRINT BRIGHT 1; PAPER 1 AND b;" " AND z<10;" Charset #"; INK 6;z; INK 4;": "; INK 5;c(z); INK 2;" > "; INK 3;"USR "; INK 6;i+z*5;" ": LET b=NOT b: IF n>19 AND z=16 THEN GO SUB 80
 360 NEXT z: GO TO 50
 369 REM \: MenuScreen\ :
 370 BORDER 0: CLS : PRINT "   >ASM start address: "; INK 6;i'' INK 4;"    >ASM end address: "; INK 6;e'' INK 4;TAB 7;">Lenght: "; INK 6;l; INK 4;" Bytes"''" >First charset address: "; INK 6;c(1)'' INK 7;a$
 390 PRINT AT 10,4;"1 "; INK 5;"List"; INK 4;" decimal ASM."''"    2 "; INK 5;"List"; INK 4;" charsets address."''"    9 "; INK 3;"Save"; INK 4;" generated code."''"    R "; INK 2;"Restart"; INK 4;" program."''"    Q Exit to "; INK 7;"BASIC"; INK 4;".": FOR z=10 TO 18 STEP 2: PRINT AT z,4; PAPER 1; INK 6; OVER 1; BRIGHT 1;" ": NEXT z
 400 GO SUB 20: IF k= CODE "1" OR k= CODE "2" OR k= CODE "9" OR k= CODE "r" OR k= CODE "R" OR k= CODE "q" OR k= CODE "Q" THEN GO TO 410
 405 GO TO 400
 410 IF k= CODE "1" THEN GO SUB 295
 420 IF k= CODE "2" THEN GO SUB 335
 430 IF k= CODE "9" THEN GO TO 490
 440 IF k= CODE "r" OR k= CODE "R" THEN GO TO 590
 450 IF k= CODE "q" OR k= CODE "Q" THEN GO TO 690
 460 GO TO 370
 489 REM \: SaveData\ :
 490 POKE 24995,1: LET b=24996: LET z=i: GO SUB 520: LET b=24998: LET z=l: GO SUB 520: STOP
 520 POKE b+1,INT (z/256): POKE b,z-(256*PEEK (b+1)): RETURN : REM \: Poke4Save
 589 REM \: RestartProg\ :
 590 PRINT #1; INK 2; BRIGHT 1;"RESTART"; INK 6;" - Sure (y-n)?": BEEP .1,13
 600 GO SUB 20: IF k= CODE "y" OR k= CODE "Y" OR k=13 THEN GO TO 630
 610 GO TO 370
 630 POKE 24995,0: GO TO 100
 685 REM \: ExitToBASIC\ :
 690 POKE 24995,255: PRINT #1;AT 0,0;">Type RUN to return to this"'" screen": BORDER 7: BEEP .1,13: PAUSE 0: STOP
 800 DATA INT 33,0,60,24
 810 DATA INT 34,54,92,1,0,0,201
 960 REM \: Saul Saborido - 2023\ :
 990 REM :CLOSE #
