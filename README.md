# MHC Routine Generator

## MicroHobby Charsets routine generator up to 32 charsets max.

A good tool in combination with [Charset Expllorer](https://github.com/saborido/Charset-Explorer).

----------------

-Programa para personalizar la rutina asm de la sección de MicroHobby número 30, páginas 14 a 16
 'Personaliza tu Spectrum'

 Esta rutina  de MicroHobby, te permite cambiar mediante un RANDOMIZE USR la variable del sistema CHARS. De
 otra forma habría que hacerlo con dos POKES, y si vas a cambiar mucho de charsets en un programa, dos pokes
 pesan más que un randomize usr, aparte de que es más cómodo esto último (y rápido si lo haces desde basic).

 Al ejecutar el programa te hará una serie de preguntas que explico a continuación:
```
-Dir. inicio de la rutina? Donde quieres que empiece la rutina de asm. Luego la puedes cargar en la
 dirección de memoria que desees, pero de momento, hay que meterla en algún sitio... la rutina digo.
 No pongas una dirección menor de 40000, el CLEAR está en 39999 para hacer sitio al programa basic.

-Cuantos charsets? La cantidad de charsets que vas a usar.

-Charsets consecutivos (s-n)? Si todos los charsets los vas a poner uno detras de otro, seguiditos, o si
 los vas a poner en una direcciones de memoria desperdigadas.

     -Si la respuesta es NO, te preguntará la dirección específica de cada uno de los charsets. Tenlos
      calculados de antemano, y procura que no se pisen las direcciones puesto que el programa no hace
      comprobación alguna. Cada charset son 768 bytes (96 caracteres, 8 bytes por caracter).
     
     -Si la respuesta es SI, te preguntará la dirección de inicio de los charsets. Intenta no pisar la
      misma rutina que se va a crear. Si respondes 0, pondrá la dirección de inicio de los charsets al
     final de la rutina de selección, y creo que es lo más recomendado (pone los charsets consecutivos
     al final de la rutina ASM, para que esté todo junto).
```

-En este momento se empezará a crear el código ensamblador. Puedes hacerte una idea de cual será la longitud
 del código generado con esta fórmula: 10 + (5 x NumeroDeCharsets) bytes. Por ejemplo, si el máximo de
 charsets que puedes crear con este programa son 32, lo máximo que puede llegar a pesar el código son
 10 + (5 x 32) = 170 Bytes.
 
 Después de generar el código, te saldrá una pantalla con algunos datos a modo de resumen y un menú, con el
 que puedes listar el código ensamblador generado, la lista de todos los charsets con su respectiva dirección
 de memoria, ver el CODE con la dirección de inicio de la rutina y su longitud, y podrás hacer un
 SAVE "charsets" CODE xxxxx,yy (vamos, que puedes grabar la rutina en una cinta o disco).

 Para seleccionar la rutina de la ROM, se ha de hacer un RANDOMIZE USR a la dirección de inicio de la rutina.
 Para los charsets siguientes, haz incrementos de 5 bytes por cada charset.

 Ten cuidado en no confundir 'dirección de inicio de la rutina' con 'dirección de inicio de los charsets'. Lo
 primero es el código ensamblador, que buscará los charsets en la dirección que se le diga.

```

Rutina original de MicroHobby:
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

-Esta rutina sirve para 3 charsets. La rutina empieza en 63039, y cada charset empieza en 63064, 63832 y 64600
 respectivamente. El RANDOMIZE USR es 63039 para el charset de la ROM, 63044 parta el charset 1, 63049 para el
 charset 2, y 63054 para el charset 3 (en incrementos de 5, vamos).


Destripando un poco el codigo original:

Direc.	Hex.	Dec.	OPcode		Label
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
