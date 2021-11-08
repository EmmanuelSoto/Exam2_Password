#include "p16F887.inc"   ; TODO INSERT CONFIG CODE HERE USING CONFIG BITS GENERATOR
 	__CONFIG	_CONFIG1,	_INTRC_OSC_NOCLKOUT & _WDT_OFF & _PWRTE_OFF & _MCLRE_ON & _CP_OFF & _CPD_OFF & _BOR_OFF & _IESO_ON & _FCMEN_ON & _LVP_OFF 
 	__CONFIG	_CONFIG2,	_BOR40V & _WRT_OFF

RES_VECT  CODE    0x0000            ; processor reset vector
    GOTO    START                   ; go to beginning of program

MAIN_PROG CODE                      ; let linker place main program
 
i equ 0x20
j equ 0x21
k equ 0x22
m equ 0x23
cont equ 0x24 
Load_Time equ d'0' 
S1 equ 0x26
S2 equ 0x27
S3 equ 0x28
S4 equ 0x29
S5 equ 0x30
S6 equ 0x31
S7 equ 0x32
S8 equ 0x33
 
T1 equ 0x34
T2 equ 0x35
T3 equ 0x36
T4 equ 0x37
T5 equ 0x38
T6 equ 0x39
T7 equ 0x40
T8 equ 0x41 

aux equ 0x42
band equ b'00000000'


START

    BANKSEL PORTA ;
    CLRF PORTA ;Init PORTA
    BANKSEL ANSEL ;
    CLRF ANSEL ;digital I/O
    CLRF ANSELH
    BANKSEL TRISA ;
    CLRF TRISA
    CLRF TRISB
    CLRF TRISC
    CLRF TRISD
    CLRF TRISE
    BCF STATUS,RP1
    BCF STATUS,RP0
    CLRF PORTA
    CLRF PORTB
    CLRF PORTC
    CLRF PORTD
    CLRF PORTE
    
    BCF STATUS, RP1 
    BSF STATUS, RP0 
    MOVLW b'00000000' 
    MOVWF TRISC 
    MOVLW b'00001111' 
    MOVWF TRISD
    BCF STATUS, RP0 
    
    
INITLCD
    BCF PORTA,0		;reset
    MOVLW 0x01
    MOVWF PORTB
    
    BSF PORTA,1		;exec
    CALL time
    BCF PORTA,1
    CALL time
    
    MOVLW 0x0C		;first line
    MOVWF PORTB
    
    BSF PORTA,1		;exec
    CALL time
    BCF PORTA,1
    CALL time
         
    MOVLW 0x3C		;cursor mode
    MOVWF PORTB
    
    BSF PORTA,1		;exec
    CALL time
    BCF PORTA,1
    CALL time
    
 ;;;;;;;;;;;;;;;;;;;;;;;;; Inicio del programa   
INICIO
 
    CALL load	;Funcion para llamar pantalla de carga.
    CALL SETPW  ; Funcion para establecer contrasena.
    CALL TYPEPW ; Funcion para comprobar contrasena
    CALL TEST   ; Funcion para comprobar que ambas contrasenas sean iguales
  
    GOTO INICIO
    
TEST
    MOVFW S1
    XORWF T1,W ;iguales = 0 diferentes = 1
    BTFSS STATUS,Z ;XORWF =0 -> Z=1  XORWF = 1 -> Z=0
    
    CALL WRONG ; Si los digitos son diferentes
	       ;se indica que está mal. 
		
		;Si los digitos son iguales, se compara 
		;el siguiente par.
    MOVFW S2
    XORWF T2,W
    BTFSS STATUS,Z
    CALL WRONG
    
    MOVFW S3
    XORWF T3,W
    BTFSS STATUS,Z
    CALL WRONG
    
    MOVFW S4
    XORWF T4,W
    BTFSS STATUS,Z
    CALL WRONG
    
    MOVFW S5
    XORWF T5,W
    BTFSS STATUS,Z
    CALL WRONG
    
    MOVFW S6
    XORWF T6,W
    BTFSS STATUS,Z
    CALL WRONG
    
    MOVFW S7
    XORWF T7,W
    BTFSS STATUS,Z
    CALL WRONG
    
    MOVFW S8
    XORWF T8,W
    BTFSS STATUS,Z
    CALL WRONG
    
    CALL GOOD
    RETURN
    
WRONG
    BCF PORTA,0		;command mode
    CALL time
    
    MOVLW 0x01		;LCD position
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		;data mode
    CALL time 
    
    BCF PORTA,0		;command mode
    CALL time
    
    MOVLW 0x0C		;LCD position
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		;data mode
    CALL time
    
    BCF PORTA,0		;command mode
    CALL time
    
    MOVLW 0x80		;LCD position
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		;data mode
    CALL time 
    
    MOVLW b'00101000'
    MOVWF PORTB
    CALL exec
    MOVLW b'11101011'
    MOVWF PORTB
    CALL exec
    MOVLW b'10110000'
    MOVWF PORTB
    CALL exec
    MOVLW b'11101011'
    MOVWF PORTB
    CALL exec
    MOVLW b'00101001'
    MOVWF PORTB
    CALL exec
    
    BCF PORTA,0		;command mode
    CALL time
    
    MOVLW 0x8B		;LCD position
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		;data mode
    CALL time 
    
    MOVLW b'00101000'
    MOVWF PORTB
    CALL exec
    MOVLW b'11101011'
    MOVWF PORTB
    CALL exec
    MOVLW b'10110000'
    MOVWF PORTB
    CALL exec
    MOVLW b'11101011'
    MOVWF PORTB
    CALL exec
    MOVLW b'00101001'
    MOVWF PORTB
    CALL exec
    
    
   
    BCF PORTA,0		;command mode
    CALL time
    
    MOVLW 0xC5		;LCD position
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		;data mode
    CALL time
    
    MOVLW 'A'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'C'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'C'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'E'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'S'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'O'
    MOVWF PORTB
    CALL exec
    
    BCF PORTA,0		;command mode
    CALL time
    
    MOVLW 0x94		;LCD position
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		;data mode
    CALL time
    
    MOVLW 'D'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'E'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'N'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'E'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'G'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'A'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'D'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'O'
    MOVWF PORTB
    CALL exec
    
    BCF PORTA,0		;command mode
    CALL time
    
    MOVLW 0xD1		;LCD position
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		;data mode
    CALL time
    
    MOVLW 'X'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'X'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'X'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'X'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'X'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'X'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'X'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'X'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'X'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'X'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'X'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'X'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'X'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'X'
    MOVWF PORTB
    CALL exec
    
   
    GOTO HOLD
    
GOOD
    BCF PORTA,0		;command mode
    CALL time
    
    MOVLW 0x01		;LCD position
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		;data mode
    CALL time 
    
    BCF PORTA,0		;command mode
    CALL time
    
    MOVLW 0x0C		;LCD position
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		;data mode
    CALL time
    
    BCF PORTA,0		;command mode
    CALL time
    
    MOVLW 0x80		;LCD position
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		;data mode
    CALL time 
    
    MOVLW b'00101000'
    MOVWF PORTB
    CALL exec
    MOVLW b'01011110'
    MOVWF PORTB
    CALL exec
    MOVLW b'10110000'
    MOVWF PORTB
    CALL exec
    MOVLW b'01011110'
    MOVWF PORTB
    CALL exec
    MOVLW b'00101001'
    MOVWF PORTB
    CALL exec
    
    BCF PORTA,0		;command mode
    CALL time
    
    MOVLW 0x8B		;LCD position
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		;data mode
    CALL time 
    
    MOVLW b'00101000'
    MOVWF PORTB
    CALL exec
    MOVLW b'01011110'
    MOVWF PORTB
    CALL exec
    MOVLW b'10110000'
    MOVWF PORTB
    CALL exec
    MOVLW b'01011110'
    MOVWF PORTB
    CALL exec
    MOVLW b'00101001'
    MOVWF PORTB
    CALL exec
    
    
   
    BCF PORTA,0		;command mode
    CALL time
    
    MOVLW 0xC5		;LCD position
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		;data mode
    CALL time
    
    MOVLW 'A'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'C'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'C'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'E'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'S'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'O'
    MOVWF PORTB
    CALL exec
    
    BCF PORTA,0		;command mode
    CALL time
    
    MOVLW 0x94		;LCD position
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		;data mode
    CALL time
    
    MOVLW 'C'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'O'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'N'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'C'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'E'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'D'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'I'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'D'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'O'
    MOVWF PORTB
    CALL exec
    
    BCF PORTA,0		;command mode
    CALL time
    
    MOVLW 0xD1		;LCD position
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		;data mode
    CALL time
    
    MOVLW '$'
    MOVWF PORTB
    CALL exec
    
    MOVLW '$'
    MOVWF PORTB
    CALL exec
    
    MOVLW '$'
    MOVWF PORTB
    CALL exec
    
    MOVLW '$'
    MOVWF PORTB
    CALL exec
    
    MOVLW '$'
    MOVWF PORTB
    CALL exec
    
    MOVLW '$'
    MOVWF PORTB
    CALL exec
    
    MOVLW '$'
    MOVWF PORTB
    CALL exec
    
    MOVLW '$'
    MOVWF PORTB
    CALL exec
    
    MOVLW '$'
    MOVWF PORTB
    CALL exec
    
    MOVLW '$'
    MOVWF PORTB
    CALL exec
    
    MOVLW '$'
    MOVWF PORTB
    CALL exec
    
    MOVLW '$'
    MOVWF PORTB
    CALL exec
    
    MOVLW '$'
    MOVWF PORTB
    CALL exec
    
    MOVLW '$'
    MOVWF PORTB
    CALL exec
    
    GOTO HOLD
    


TYPEPW    
;;;;;;;;;;;;;
    BCF PORTA,0		;command mode
    CALL time
    
    MOVLW 0x90		;LCD position
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		;data mode
    CALL time
    
    BCF PORTA,0		;command mode
    CALL time
    
    MOVLW 0x0F		;LCD position
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		;data mode
    CALL time
    
    MOVLW 'T'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'Y'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'P'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'E'
    MOVWF PORTB
    CALL exec
    
    MOVLW ' '
    MOVWF PORTB
    CALL exec
    
    MOVLW 'P'
    MOVWF PORTB
    CALL exec
    MOVLW 'W'
    MOVWF PORTB
    CALL exec
    MOVLW ':'
    MOVWF PORTB
    CALL exec
    
    CALL TEC
    BTFSS band,0
    GOTO $-2
    MOVFW aux
    MOVWF T1
    BCF band,0
    CALL hide
    
    CALL TEC 
    BTFSS band,0
    GOTO $-2
    MOVFW aux
    MOVWF T2
    BCF band,0
    CALL hide
    
    CALL TEC 
    BTFSS band,0
    GOTO $-2
    MOVFW aux
    MOVWF T3
    BCF band,0
    CALL hide
    
    CALL TEC 
    BTFSS band,0
    GOTO $-2
    MOVFW aux
    MOVWF T4
    BCF band,0
    CALL hide
    
    CALL TEC 
    BTFSS band,0
    GOTO $-2
    MOVFW aux
    MOVWF T5
    BCF band,0
    CALL hide
    
    CALL TEC 
    BTFSS band,0
    GOTO $-2
    MOVFW aux
    MOVWF T6
    BCF band,0
    CALL hide
    
    CALL TEC 
    BTFSS band,0
    GOTO $-2
    MOVFW aux
    MOVWF T7
    BCF band,0
    CALL hide
    
    CALL TEC 
    BTFSS band,0
    GOTO $-2
    MOVFW aux
    MOVWF T8
    BCF band,0 
    CALL hide
    RETURN
    
SETPW  
    BCF PORTA,0		;command mode
    CALL time
    
    MOVLW 0xC0		;LCD position
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		;data mode
    CALL time
    BCF PORTA,0		;command mode
    CALL time
    
    MOVLW 0x0F		;LCD position
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		;data mode
    CALL time
    
    MOVLW 'S'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'E'
    MOVWF PORTB
    CALL exec
   
    MOVLW 'T'
    MOVWF PORTB
    CALL exec

    MOVLW ' '
    MOVWF PORTB
    CALL exec
    
    MOVLW 'P'
    MOVWF PORTB
    CALL exec
    MOVLW 'W'
    MOVWF PORTB
    CALL exec
    MOVLW ':'
    MOVWF PORTB
    CALL exec
    
    
    
    CALL TEC    
    BTFSS band,0
    GOTO $-2
    MOVFW aux
    MOVWF S1
    BCF band,0
    
    
    CALL TEC 
    BTFSS band,0
    GOTO $-2
    MOVFW aux
    MOVWF S2
    BCF band,0
    
    
    CALL TEC 
    BTFSS band,0
    GOTO $-2
    MOVFW aux
    MOVWF S3
    BCF band,0
    
    
    CALL TEC 
    BTFSS band,0
    GOTO $-2
    MOVFW aux
    MOVWF S4
    BCF band,0
    
    
    CALL TEC 
    BTFSS band,0
    GOTO $-2
    MOVFW aux
    MOVWF S5
    BCF band,0
    
    CALL TEC 
    BTFSS band,0
    GOTO $-2
    MOVFW aux
    MOVWF S6
    BCF band,0
    
    CALL TEC 
    BTFSS band,0
    GOTO $-2
    MOVFW aux
    MOVWF S7
    BCF band,0
    
    CALL TEC 
    BTFSS band,0
    GOTO $-2
    MOVFW aux
    MOVWF S8
    BCF band,0
    
    RETURN
    
TEC
    BSF PORTC,0
    CALL time
    BTFSC PORTD,0
    CALL one
    BTFSC PORTD,1
    CALL four
    BTFSC PORTD,2
    CALL seven
    BCF PORTC,0
    
    BSF PORTC,1
    CALL time
    BTFSC PORTD,0
    CALL two
    BTFSC PORTD,1
    CALL five
    BTFSC PORTD,2
    CALL eight
    BTFSC PORTD,3
    CALL zero
    BCF PORTC,1
    
    BSF PORTC,2
    CALL time
    BTFSC PORTD,0
    CALL three
    BTFSC PORTD,1
    CALL six
    BTFSC PORTD,2
    CALL nine
    BCF PORTC,2
 
    RETURN
    
hide
    BCF PORTA,0		
    CALL time
    MOVLW 0x10	   ;Comando para recorrer el cursor a la izquierda	
    MOVWF PORTB
    CALL exec
    BSF PORTA,0		
    CALL time
    MOVLW '*'   ;Cuando el cursor está en la izquierda, se escribe un asterisco.
    MOVWF PORTB
    CALL exec
    RETURN
  
    
zero
    
    
    MOVLW b'00000000'
    MOVWF aux
    
    MOVLW '0'
    MOVWF PORTB
    CALL exec
    
    BSF band,0
    
    BTFSC PORTD,3
    GOTO $-1
    
    
    RETURN
    
one
    MOVLW b'00000001'
    MOVWF aux
    
    MOVLW '1'
    MOVWF PORTB
    CALL exec
    
    BSF band,0
    
    BTFSC PORTD,0
    GOTO $-1
    
    RETURN

two
    MOVLW b'00000010'
    MOVWF aux
    
    MOVLW '2'
    MOVWF PORTB
    CALL exec
    
    BSF band,0
    
    BTFSC PORTD,0
    GOTO $-1
    
    
    RETURN

three
    
    MOVLW b'00000011'
    MOVWF aux
    
    MOVLW '3'
    MOVWF PORTB
    CALL exec
    
  
    BSF band,0
    
    BTFSC PORTD,0
    GOTO $-1
    
    RETURN
    
four
    
    MOVLW b'00000100'
    MOVWF aux
    
    MOVLW '4'
    MOVWF PORTB
    CALL exec
    
   
     
    BSF band,0
    
    BTFSC PORTD,1
    GOTO $-1
    
    RETURN
  
five
    
    MOVLW b'00000101'
    MOVWF aux
    
    MOVLW '5'
    MOVWF PORTB
    CALL exec
    
    
    BSF band,0
    
    BTFSC PORTD,1
    GOTO $-1
    RETURN

six
    
    MOVLW b'00000110'
    MOVWF aux
    
    MOVLW '6'
    MOVWF PORTB
    CALL exec
   
      
    BSF band,0
    
    BTFSC PORTD,1
    GOTO $-1
    
    RETURN
 
seven
    
    MOVLW b'00000111'
    MOVWF aux
    
    MOVLW '7'
    MOVWF PORTB
    CALL exec
    
    
    BSF band,0
    
    BTFSC PORTD,2
    GOTO $-1
    
    RETURN

eight
    
    MOVLW b'00001000'
    MOVWF aux
    
    MOVLW '8'
    MOVWF PORTB
    CALL exec
   
   
    BSF band,0
    
    BTFSC PORTD,2
    GOTO $-1
    RETURN

nine
    MOVLW b'00001001'
    MOVWF aux
    
    MOVLW '9'
    MOVWF PORTB
    CALL exec
   
    
    BSF band,0
    
    BTFSC PORTD,2
    GOTO $-1
    RETURN
    
load	    ;Patalla de carga
  
    BCF PORTA,0		
    CALL time
    
    MOVLW 0xC4		
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		
    CALL time
    
    MOVLW 'B'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'I'
    MOVWF PORTB
    CALL exec
   
    MOVLW 'E'
    MOVWF PORTB
    CALL exec

    MOVLW 'N'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'V'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'E'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'N'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'I'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'D'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'O'
    MOVWF PORTB
    CALL exec

    BCF PORTA,0		
    CALL time
    
    MOVLW 0xD0		
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		
    CALL time
    
    MOVLW 'C'
    MOVWF PORTB
    CALL exec 

    MOVLW 'A'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'R'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'G'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'A'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'N'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'D'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'O'
    MOVWF PORTB
    CALL exec
    
   
    MOVLW d'3'
    MOVWF cont
   
   rep:		;Efecto de carga
    BCF PORTA,0		
    CALL time
    
    MOVLW 0xD8		
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		
    CALL time
  
    MOVLW '.'
    MOVWF PORTB
    CALL exec
    CALL time1
    MOVLW '.'
    MOVWF PORTB
    CALL exec
    CALL time1
    MOVLW '.'
    MOVWF PORTB
    CALL exec
    CALL time1
    
    BCF PORTA,0		
    CALL time
    
    MOVLW 0xD8		
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		
    CALL time
    
    MOVLW ' '
    MOVWF PORTB
    CALL exec
    CALL time
    
    MOVLW ' '
    MOVWF PORTB
    CALL exec
    CALL time
    
    MOVLW ' '
    MOVWF PORTB
    CALL exec
    CALL time
    
    DECFSZ cont,f
    GOTO rep
    
    BCF PORTA,0		;command mode
    CALL time
    
    MOVLW 0x01		;LCD position
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		;data mode
    RETURN

exec

    BSF PORTA,1		;exec
    CALL time
    BCF PORTA,1
    CALL time
    RETURN
    
    
HOLD
    ;Mantiene el estado de la pantalla
    GOTO HOLD
    
time
    CLRF i
    MOVLW d'10'
    MOVWF j
ciclo    
    MOVLW d'80'
    MOVWF i
    DECFSZ i
    GOTO $-1
    DECFSZ j
    GOTO ciclo
    RETURN
    

time1
    
    movlw d'100' 
    movwf m
mloop1
    decfsz m,f
    goto mloop1
    movlw d'25' 
    movwf i
iloop1
    nop 
    movlw d'60' 
    movwf j
jloop1
    nop 
    movlw d'74' 
    movwf k
kloop1
    decfsz k,f
    goto kloop1
    decfsz j,f
    goto jloop1
    decfsz i,f
    goto iloop1
    return 
			
			
    END

