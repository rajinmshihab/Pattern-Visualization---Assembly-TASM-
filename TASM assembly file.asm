.model small
.stack 100h
.data
ASTER DB ?
EMPTY DB ?

 ; Declaring Counters

 cnt1 dw 0
 cnt2 dw 0
 cnt4 dw 7
 cnt3 dw 3
 cnt5 dw 0
 cnt6 dw 1
 
 ; Source code for the Banner, Student Info, Main Menu
 
 prompt_Menu db "*************************************************************************",10
             db "*       AAA AA AAA   PPP PP PPP  UUU    UUU  EEE EE EEE  MMMM   MMMMMM  *",10
             db "*      AAA    AAA  PPP     PPP  UUU    UUU  EEE         MMM MM MM MMM   *",10
             db "*     AAA    AAA  PPP     PPP  UUU    UUU  EEE         MMM  MMM  MMM    *",10
             db "*    AAA AA AAA  PPP PPP PPP  UUU    UUU  EEE EE EEE  MMM   M   MMM     *",10
             db "*   AAA    AAA  PPP          UUU    UUU  EEE         MMM       MMM      *",10
             db "*  AAA    AAA  PPP          UUU    UUU  EEE         MMM       MMM       *",10
             db "* AAA    AAA  PPP          UUU UU UUU  EEE EE EEE  MMM       MMM        *",10
             db "*************************************************************************",10
             db "*                Name: Rajin Muhtadee Shihab [TP059508]                 *",10
             db "*************************************************************************",10
             db 10,"        *******************************************************"
             db 10,"        *                       Main Menu                     *"
             db 10,"        *******************************************************"
             db 10,"                            Select an Option!"
             db 10,""
             db 10,"1. Number Pattern [Diamond]"
             db 10,"2. Number Pattern [Arrowhead]"
             db 10,"3. Design Pattern"
             db 10,"4. Box Pattern"
             db 10,"5. Nested Loop Pattern"
             db 10,"6. Exit"
             db 10,""
             db 10,"   Enter a Number [1-6]: $"

 ; Declaring overall Prompt Messages            
 
 promptCont  db 10,13,"Press any key to continue!$"  ; Continue prompt message
 promptnum   db 10,13,"   Enter a Number [1-5]: $"   ; Input prompt message
 promptPrint db 10,13,"$"                            ; Used as a dummy, so that the menu does not show up when an option is selected
 
 db 10,13,"$"

 promptError db 9,10,13,"Incorrect input! Please try again!$"    ; Incorrect input prompt message
 db 10,13,"Press any key to continue!$"

 promptExit db 9,10,13,"Press any key to continue!"

 .code
 .386                                   ; Enables assembly of nonprivileged instructions for the 80386 processor. Disabling it will reduce jump range.

 
 ; Some basic clarifications about general purpose registers:
 ; AX -> Accumulator
 ; BX -> Base Register
 ; CX -> Count Register
 ; DX -> Data Register
 
 
 MAIN proc                              ; Main
    mov ax,@data
    mov ds,ax


 Begin:                                 ; Initialize

    mov ah,00
    mov al,02
    int 10h
 
 Banner:                                ; Calling the main menu and banner
    mov ah,09h
    mov dx,offset prompt_Menu   
    int 21h


    mov ah,01h
    mov dl,al
    int 21h
    cmp al,49                           ; Option number 1 : ( Dec 1 -> 49 )
    je NumberPat                        ; Call the Number Pattern Function [Diamond]

    cmp al,50                           ; Option number 2 : ( Dec 2 -> 50 )
    je NumberPat1                       ; Call the Number Pattern Function [Arrowhead]
    
    cmp al,51                           ; Option number 3 : ( Dec 3 -> 51 )
    je DesignPat                        ; Call the Design Pattern Function
    
    cmp al,52                           ; Option number 4 : ( Dec 4 -> 52 )
    je BoxPat                           ; Call the Box Pattern Function
    
    cmp al,53                           ; Option number 5 : ( Dec 5 -> 53 )
    je NestedPat                        ; Call the Nested Loop Function
    
    cmp al,54                           ; Option number 6 : ( Dec 6 -> 54 )
    je Finisher                         ; Function Termination
    
    jmp Error                           ; Calling for Error handler

    Error:                              ; Error Handler
    mov ah,00
    mov al,02
    int 10h
    
    mov ah,09h
    mov dx,offset promptError
    int 21h 
    
    mov ah, 01h
    mov dl,al
    int 21h
    
    jmp Begin                           ; Trasnferring Control back to 'Begin'

    NumberPat:                          ; Number Pattern [Diamond]
        MOV AH,00
        MOV AL,02
        INT 10H

        MOV CX,5
        MOV BX,1
        
       L1:
            PUSH CX
        
       L2:
            MOV AH,2
            MOV DL,32
            INT 21H
            LOOP L2
           
        
            MOV CX,BX
       L3:
            MOV AH,2
            MOV DL,'*'
            INT 21H
            LOOP L3
        
            MOV AH,2
            MOV DL,10
            INT 21H
            MOV DL,13
            INT 21H
        
            INC BX
            INC BX
        
            POP CX
            LOOP L1
        
            MOV CX,4
            MOV BH,7
            MOV BL,2
            
            MOV ASTER,BH
            MOV EMPTY,BL
            
       L4:
            CMP EMPTY,0
            JE L5
            MOV AH,2
            MOV DL,32
            INT 21H
            DEC EMPTY
            JMP L4                          
        
       L5:
            MOV AH,2
            MOV DL,'*'
            INT 21H
            DEC ASTER
            CMP ASTER,0
            JNE L5
       L6:  
            MOV AH,2
            MOV DL,10
            INT 21H
            MOV DL,13
            INT 21H
        
        DEC BH
        DEC BH
        MOV ASTER,BH
        
        INC BL
        MOV EMPTY,BL
        
        LOOP L4
        jmp return

    NumberPat1:                          ; Number Pattern [Arrowhead]
        MOV AH,00
        MOV AL,02
        INT 10H

        MOV CX,5
        MOV BX,1
        
       L11:
            PUSH CX
        
       L12:
            MOV AH,2
            MOV DL,32
            INT 21H
            LOOP L12
           
        
            MOV CX,BX
       L13:
            MOV AH,2
            MOV DL,''
            INT 21H
            MOV DL,'*'
            INT 21H
            MOV DL,''
            INT 21H
            LOOP L13
        
            MOV AH,2
            MOV DL,10
            INT 21H
            MOV DL,13
            INT 21H
        
            INC BX
            INC BX
        
            POP CX
            LOOP L11
        
            MOV CX,4
            MOV BH,7
            MOV BL,2
            
            MOV ASTER,BH
            MOV EMPTY,BL
            
       L14:
            CMP EMPTY,0
            JE L15
            MOV AH,2
            MOV DL,32
            INT 21H
            DEC EMPTY
            JMP L14
        
       L15:
            MOV AH,2
            MOV DL,''
            INT 21H
            MOV DL,'*'
            INT 21H
            MOV DL,''
            INT 21H
            DEC ASTER
            CMP ASTER,0
            JNE L15
       L16:  
            MOV AH,2
            MOV DL,10
            INT 21H
            MOV DL,13
            INT 21H
        
        DEC BH
        DEC BH
        MOV ASTER,BH
        
        INC BL
        MOV EMPTY,BL
        
        LOOP L14
        jmp return




 return:
    mov ah,09h
    mov dx,offset promptCont
    int 21h
    
    mov ah,01h
    mov dl,al
    int 21h
    
    jmp Begin                          ; Trasnferring Control back to 'Begin'
    

 DesignPat:                            ; Design Pattern Function. Will redirect to the 'farawary' function 
    mov ah,00
    mov al,02                          ;                 and will finalize in 'returnfromfaraway' function
    int 10h
    
    mov ah,09h
    mov dx,offset promptPrint
    int 21h
    
    jmp faraway                       ; Trasnferring Control back to 'faraway'


 returnfromfaraway:

    mov ah,01h
    mov dl,al
    int 21h
    jmp Begin                         ; Trasnferring Control back to 'Begin'

 BoxPat:
    mov ah,00
    mov al,02
    int 10h
    
    mov ah,09h
    mov dx,offset promptPrint
    int 21h
    
 
    mov ah,2
    mov cx,6

 sqpat:

    mov cx,10
    mov bx,5

        S1:
            push cx
            mov cx,20

        S2:
            mov ah,2
            mov dl,'#'
            int 21h

            Loop S2

        mov ah,2
        mov dl,10
        int 21h
        mov dl,13
        int 21h

        pop cx
        Loop S1
    mov dl,10

    mov ah,09h
    mov dx,offset promptCont
    int 21h

    mov ah,01h
    mov dl,al
    int 21h

    jmp Begin                       ; Trasnferring Control back to 'Begin'
            
 NestedPat:
    mov ah,00
    mov al,02
    int 10h
    
    mov ah,09h
    mov dx,offset promptPrint
    int 21h

    mov ah,2
    mov cx,6

    mov ah,2  
    mov bl,5                       ; A starting value of 5 
    mov cl,0                       ; A starting value of 0. It will keep returning to 0.
    mov ch,1                       ; A starting value of 1. Increments 1. 
    mov bh,6                       ; Starting value of 6. Decrements 1.

 upper:
    inc cl                         
    mov dl,"+" 
    int 21h
    cmp cl,ch                      ; Compare cl & ch. If they are not equal, go back to upper and increment cl by 1.
    jne upper                      ; If equal, move to space.

 space:  
    dec bh    
    mov dl,32
    int 21h

    cmp bh,0                       ; As long as not 0, will decrement from 6.
    jne space

 right:
    inc bh
    mov dl,"-"
    int 21h

    cmp bh,bl
    jne right   


    mov dl,10                      ; Move to next line.
    int 21h

    mov cl,0                       ; Turn cl value to 0 and increment.
    inc ch

    dec bl   
    cmp bl,0 
    jne upper                      ; As long as bl is not equal to 0, keep going back to upper.

    mov dl,10                      ; Move to third triangle new line.
    int 21h

    ; From here on out, the triangle functions will be similar in structure. 
    ; Minor adjustments will be made to change the shape of the triangles.
    
    mov bl,5                       
    mov cl,0                       
    mov ch,1                       
    mov bh,6                       

 upper2:

      inc cl    
      mov dl,"*"
      int 21h
      cmp cl,ch ; 
      jne upper2   

 space2:  
      dec bh 
      mov dl,32
      int 21h

      cmp bh,0 
      jne space2

 right2:
      inc bh 
      mov dl,"/"
      int 21h

      cmp bh,bl  
      jne right2 


      mov dl,10 
      int 21h

      mov cl,0 
      inc ch   

      dec bl   
      cmp bl,0 
      jne upper2 





    mov ah,09h
    mov dx,offset promptCont
    int 21h
    
    mov ah,01h
    mov dl,al
    int 21h
    
    jmp Begin                       ; Trasnferring Control back to 'Begin'

 Finisher:
    mov ah,00
    mov al,02
    int 10h
    
    mov ah,09h
    mov dx,offset promptExit
    int 21h
    
    mov ah,4ch
    int 21h
    
 faraway:

    precheck:

    inc cnt1                    ; Check to see if it's the first line.
        cmp cnt1,2
        jl reBegin

        mov cx,cnt2

    rea:
        cmp cnt2,0
        je jumprea

        mov dl,32
        mov ah,2
        int 21h
        loop rea

    jumprea:

        inc cnt2
        cmp cnt1,5              ; Similar check for middle line
        je reBegin
        mov dl,254
        mov ah,2
        int 21h

    reBegin:

        mov cx,cnt3

    pat_header:

        mov bx,cx
        mov cx,cnt4

        cmp cnt1,5              ; Again check for middle line
        je dummy2

    dummy1:
        mov dl,32
        mov ah,2
        int 21h

        loop dummy1


    dummy2:
        mov dl,254
        mov ah,2
        int 21h

        mov cx,cnt5

    dummy3:
        cmp cnt5,0
        je dummy4

        mov dl,32
        mov ah,2
        int 21h

        loop dummy3

    dummy4:
        cmp cnt1,5              
        je jump_dummy4 


    mov dl,254
    mov ah,2
    int 21h
    jump_dummy4:

    mov cx,bx

    loop pat_header


    cmp cnt1,5                  
    jne recreate_nl

    mov dl,254
    mov ah,2
    int 21h
    
    recreate_nl:

        mov dl,10
        mov ah,2
        int 21h

        mov dl,13
        int 21h

 
        cmp cnt6,5
        je end_pat_header
        inc cnt5
        inc cnt5
        
        dec cnt4
        dec cnt4

        inc cnt6

        cmp cnt6,6
        jne precheck

    end_pat_header:
        dec cnt2
        dec cnt2


        inc cnt4
        inc cnt4

        dec cnt5
        dec cnt5


    precheck1:
        dec cnt1               ; Check if the position is the final line.
        cmp cnt1,2
        jl reBegin_opt



        mov cx,cnt2

    rea1:
        cmp cnt2,0
        je jumprea_opt

        mov dl,32
        mov ah,2
        int 21h

        loop rea1


    jumprea_opt:

        dec cnt2

        mov dl,42
        mov ah,2
        int 21h
    reBegin_opt:

        mov cx,cnt3


    pattern_tail:

        mov bx,cx
        mov cx,cnt4

    dummy5:
        mov dl,32
        mov ah,2
        int 21h

    loop dummy5

    dummy6:
        mov dl,42
        mov ah,2
        int 21h

        mov cx,cnt5

    dummy7:
        cmp cnt5,0
        je dummy8

        mov dl,32
        mov ah,2
        int 21h

    loop dummy7

    dummy8:
        mov dl,42
        mov ah,2
        int 21h

        mov cx,bx

    loop pattern_tail

    recreate_nl_tail:

        mov dl,10
        mov ah,2
        int 21h

        mov dl,13
        int 21h

        dec cnt5
        dec cnt5

        inc cnt4
        inc cnt4

        dec cnt6 


        cmp cnt6,1
        jne precheck1


        mov ah,09h
        mov dx,offset promptCont
        int 21h


        jmp returnfromfaraway               ; Trasnferring Control back to 'returnfromfaraway'. Finishing up Design Pattern



    MAIN ENDP
 END MAIN