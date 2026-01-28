INCLUDE c:\Users\Texon\.vscode\extensions\istareatscreens.masm-runner-0.9.1\native\irvine\Irvine32.inc
.data
    msgInputMenu  BYTE "==========================", 0Ah
                  BYTE "   BASE CONVERTER MENU    ", 0Ah
                  BYTE "==========================", 0Ah
                  BYTE "1. Binary Input", 0Ah
                  BYTE "2. Octal Input", 0Ah
                  BYTE "3. Decimal Input", 0Ah
                  BYTE "4. Hexadecimal Input", 0Ah
                  BYTE "5. Exit Program", 0Ah
                  BYTE "--------------------------", 0Ah
                  BYTE "Select choice (1-5): ", 0

    msgOutputMenu BYTE 0Ah, "--- Convert to which format? ---", 0Ah
                  BYTE "1. Binary", 0Ah
                  BYTE "2. Octal", 0Ah
                  BYTE "3. Decimal", 0Ah
                  BYTE "4. Hexadecimal", 0Ah
                  BYTE "Select output base (1-4): ", 0

    msgEnterVal   BYTE "Enter the value: ", 0
    msgResult     BYTE "Result: ", 0
    msgError      BYTE "Please add positve numbers:", 0Ah, 0
    msgGoodbye    BYTE "Goodbye!", 0Ah, 0
    
    buffer        BYTE 33 DUP(0)
     inputType DWORD ?
.code
main PROC    
MainLoop:
    call Clrscr 
    
                
mov  edx, OFFSET msgInputMenu
    call WriteString

    call ReadDec
    mov  inputType, eax     
    cmp  eax, 5
    je   QuitProgram

    cmp  eax, 1
    jl   InputError
    cmp  eax, 4
    jg   InputError

    mov  edx, OFFSET msgEnterVal
    call WriteString
    mov  eax, inputType
    cmp  eax, 1
    je   InputBinary
    cmp  eax, 2
    je   InputOctal
    cmp  eax, 3
    je   InputDecimal
    cmp  eax, 4
    je   InputHex 

InputBinary:
    mov  edx, OFFSET buffer
    mov  ecx, SIZEOF buffer
    call ReadString
    call ParseBinary        
    jmp  GetOutputChoice

InputOctal:
    mov  edx, OFFSET buffer
    mov  ecx, SIZEOF buffer
    call ReadString
    call ParseOctal         
    jmp  GetOutputChoice

InputDecimal:
    call ReadDec           
    jmp  GetOutputChoice
InputHex
    call ReadHex            
    jmp  GetOutputChoice

InputError:
    mov  edx, OFFSET msgError
    call WriteString
    call WaitMsg
    jmp  MainLoop  
            
GetOutputChoice:
    push eax             ;   add  5 now
    mov  edx, OFFSET msgOutputMenu  ;add adress of msg into edx
    call WriteString; print msg
    call ReadDec      ;read that number jis mei ab hume 4 ko convert karna hai. the choice user makes .
    mov  ebx, eax         ;shift 5 from eax to ebx because eax can return the values but not bx.   
    pop  eax         ;remove 5      actually here it is going in stack so that when user click any other coice it doesnt dlt or replace . 
    mov  edx, OFFSET msgResult   ;again copy the address of menmory in edz
    call WriteString
    cmp  ebx, 1 ;compare if 5 supposed one is equal to 1 then jmp to binary result fn .
    je   OutputBinary
    cmp  ebx, 2  ;if its 2 in eax which willbe now jmp in octal fn result.
    je   OutputOctal
    cmp  ebx, 3
    je   OutputDecimal
    cmp  ebx, 4
    je   OutputHex; till this we did the same of comparing 
    mov  edx, OFFSET msgError  ; its not between these 4 number  set the adress of msg error into edx  and then print it
    call WriteString
    call WaitMsg 
; here waiting is the main part other wise our system will stop after one conversion 
;but we want user can do conversion mutlipe times so there is waitmsg by assembly language help to  make the instruction wait.
    jmp  MainLoop 
OutputBinary:
    mov  ebx, 1   ;stack concept 1,4,8,12,.. k u dont have to print huge 32 bits just print the last bits from this long chain      
    call WriteBin
    jmp  EndOfRun

OutputOctal:
    call WriteOctal        
    jmp  EndOfRun

OutputDecimal:
    call WriteDec
    jmp  EndOfRun

OutputHex:
    call WriteHex
    jmp  EndOfRun

EndOfRun:
    call Crlf
    call WaitMsg          
    jmp  MainLoop        

QuitProgram:
    mov  edx, OFFSET msgGoodbye
    call WriteString
    exit

main ENDP

ParseBinary PROC USES edx esi ecx ;here uses is the backup of memory a small stack means small section of meonry
;eax is always used for return values to 
;why didtnt use that we just used other reigister fro a safe check as they wont return there values
; again and here ecx is not working but it also doesnt cause any problem to the system 
    mov  esi, OFFSET buffer
    mov  eax, 0             
L1:
    movzx edx,byte ptr [esi]  
    cmp   dl, 0               
    je    DoneBin
    shl   eax, 1   ;basepower           
    sub   dl, '0'   ;31h-30h=1          
    or    al, dl       ;this 1 is now shifted in al      
    inc   esi ;loop increment
    jmp   L1 ;jmp dounded the binary value
DoneBin:
    ret
ParseBinary ENDP
ParseOctal PROC USES edx esi
    mov  esi, OFFSET buffer
    mov  eax, 0
L2:
    movzx edx, byte ptr [esi]
    cmp   dl, 0
    je    DoneOct
    shl   eax, 3              
    sub   dl, '0'             
    or    al, dl              
    inc   esi
    jmp   L2
DoneOct:
    ret
ParseOctal ENDP
WriteOctal PROC USES eax edx ecx
    mov  ecx, 0           ;pushing in stack  
    mov  ebx, 8    ;for octal conversion its base is 8         
DivideLoop:
    mov  edx, 0             
    div  ebx                
    push edx   ; to arrange the number of order             
    inc  ecx                
    cmp  eax, 0
    jne  
PrintLoop:
    pop  eax                
    add  al, '0'            
    call WriteChar
    loop PrintLoop          
    ret
WriteOctal ENDP
END main