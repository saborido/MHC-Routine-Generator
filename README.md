# MHC Routine Generator - For ZX Spectrum

## MicroHobby Charsets routine generator up to 32 charsets max.

You can use it in combination with [Charset Explorer](https://github.com/saborido/Charset-Explorer).

----------------

-Program to customize the asm routine from MicroHobby section number 30, pages 14 to 16 'Personaliza
 tu Spectrum'

 This MicroHobby routine allows you to change the CHARS System variable using a RANDOMIZE USR.
 Otherwise you would have to do it with two POKES, and if you are going to change a lot of charsets
 in a program, two pokes are heavier than a randomize usr, apart from the fact that the latter is
 more comfortable (and faster if you do it from BASIC).

 When you run the program, it will ask you a series of questions that I explain below:
```
>Dir. inicio de la rutina? (Routine start address?) Where you want the asm routine to start. Then you
 can load in the memory address you want, but for now, it needs to be stored somewhere. Do not enter
 an address less than 40000.

>Cuantos charsets? (How many charsets?) The number of charsets you are going to use.

>Charsets consecutivos (s-n)? (Consecutive charsets (y-n)?) If you are going to put all the charsets
 one after the other, in a row, or if you are going to put them in scattered memory addresses.

	>If the answer is NO, you will be asked for the specific address of each of the charsets.
	 Have them calculated beforehand, and make sure that the addresses do not overlap since
	 the program does not perform any check. Each charset is 768 bytes (96 characters, 8 bytes
	 per character).

	>If the answer is YES, it will ask you for the start address of the charsets. Try not to
	 step on the same routine that is going to be created. If you answer 0, it will put the
	 start address of the charsets at the end of the selection routine, and I think that is
	 the most recommended (it puts the consecutive charsets at the end of the ASM routine, so
	 that everything is together).
```
-At this moment the assembly code will begin to be created. You can get an idea of ​​the length of the
 generated code with this formula: 10 + (5 x NumberOfCharsets) bytes. For example, if the maximum
 number of charsets you can create with this program is 32, the maximum the code can weigh is
 10 + (5 x 32) = 170 Bytes.

 After generating the code, you will see a screen with some summary data and a menu, with which you
 can list the generated assembly code, the list of all the charsets with their respective memory
 address, see the CODE with the start address of the routine and its length, and you can do a
 SAVE "charsets" CODE xxxxx,yy (which can save the routine to a tape or disk).

 To select the ROM routine, a RANDOMIZE USR must be done to the starting address of the routine. For
 the following charsets, do 5 byte increments for each charset.

 Be careful not to confuse 'routine start address' with 'charset start address'. The first thing is
 the assembly code, which will look for the charsets at the address you tell it to.

```
MicroHobby's original routine:
-----------------------------

63039	21003C	J_ROM	LD HL,#3C00
63042	180D		JR (FINAL)
63044	2158F5	J_1	LD HL,#F558
63047	1808		JR (FINAL)
63049	2158F8	J_2	LD HL,#F858
63052	1803		JR (FINAL)
63054	2158FB	J_3	LD HL,#FB58
63057	22365C	FINAL	LD (CHARS)
63060	010000		LD BC,#0000
63063	C9		RET

-This routine works for 3 charsets. The routine starts at 63039, and each charset starts at 63064,
 63832, and 64600 respectively. The RANDOMIZE USR is 63039 for the ROM charset, 63044 for charset 1,
 63049 for charset 2, and 63054 for charset 3 (in increments of 5).


Breaking down the original code a bit:

Addr.	Hex.	Dec.	OPcode		Label
-----	---	---	------		-----
63039	21	33	LD HL		;J_ROM
63040	00	0	#3C00
63041	3C	60	
63042	18	24	JR
63043	0D	13	;+13 (FINAL)

63044	21	33	LD HL		;J_1
63045	58	88	#F558
63046	F5	245	
63047	18	24	JR
63048	08	8	;+8 (FINAL)

63049	21	33	LD HL		;J_2
63050	58	88	#F858
63051	F8	248	
63052	18	24	JR
63053	03	3	;+3 (FINAL)

63054	21	33	LD HL		;J_3
63055	58	88	#FB58
63056	FB	251	

63057	22	34	LD		;FINAL
63058	36	54	(23606)		;(CHARS)
63059	5C	92	
63060	01	1	LD BC
63061	00	0	0000
63062	00	0	
63063	C9	201	RET
```
