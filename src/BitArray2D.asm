
        global  set_bit_elem
        global  get_bit_elem
        section .text

set_bit_elem:
        push rbp            ; save the base pointer on the stack (at rsp+8)
        mov rbp, rsp        ; set up the rbp for the bottom of this frame

        ; rdi contains array pointer
        ; rsi contains row width
        ; rdx contains row
        ; rcx contains col

        ; add your code here

        mov rax, rdx        ; get i (row)
        imul rax, rsi       ; compute row-width*row
        add rax, rcx        ; compute row-width*row + column
;-------------------------------------------------
        mov rcx, rax        ; index
        sar rcx, 3          ; byte_offset = rcx = index/8
        lea rdx, [rcx*8]    ; bit_offset = index-(byte_offset*8)
                            ; rdx = byte_offset*8
        imul rdx, -1        ; rdx = (byte_offset*8)*(-1)
        add rdx, rax        ; bit_offset = rdx = index + (byte_offset*8)(-1)
        mov rcx, 8          ; compute rcx = (8-bit_offset-1)
        sub rcx, rdx        ; rcx = 8 - bit_offset
        sub rcx, 1          ; rcx = 8 - bit_offset - 1
        mov rdx, 1          ; mask = 1
    .loop1:                 ; mask = 1 << (8-bit_offset-1)
        sal rdx, 1          ; mask = mask << 1
        dec rcx             ; rcx = rcx - 1
        cmp rcx, 0          ; compare rcx and 0
        jg  .loop1          ; if rcx > 0, continue loop

        or rdi, rdx         ; set the bit into (row, col)
;        lea rdi, [rdi]
        mov rax, rdi
;--------------------------------------------

        mov rsp, rbp        ; restore stack pointer to before we pushed parameters onto the stack
        pop rbp             ; remove rbp from the stack to restore rsp to initial value
        ret                 ; return value in rax




get_bit_elem:
        push rbp            ; save the base pointer on the stack (at rsp+8)
        mov rbp, rsp        ; set up the rbp for the bottom of this frame

        ; rdi contains array pointer
        ; rsi contains row width
        ; rdx contains row
        ; rcx contains col

        ; add your code here - for now returning 0

        mov rax, rdx
        imul rax, rsi
        add rax, rcx
;-------------------------------------
        mov rcx, rax        ; index
        sar rcx, 3          ; byte_offset = index/8
        lea rdx, [rcx*8]    ; bit_offset = index-(byte_offset*8)
                            ; rdx = byte_offset*8
        imul rdx, -1        ; rdx = (byte_offset*8)*(-1)
        add rdx, rax        ; bit offset = rdx = index + (byte_offset*8)(-1)
        mov rcx, 8          ; compute rcx = (8-bit_offset-1)
        sub rcx, rdx        ; rcx = 8 - bit_offset
        sub rcx, 1          ; rcx = 8 - bit_offset - 1
        mov rdx, 1          ; mask = 1
    .loop1:                 ; mask = 1 << (8-bit_offset-1)
        sal rdx, 1          ; mask = mask << 1
        dec rcx             ; rcx = rcx - 1
        cmp rcx, 0          ; compare rcx and 0
        jg  .loop1          ; if rcx > 0, continue loop

        and rdx, rdi        ; get the bit from (col, column)
        mov rax, rdx

;---------------------------------------
        cmp rax, 1
        setl al
        movzx rax, al

        mov rsp, rbp        ; restore stack pointer to before we pushed parameters onto the stack
        pop rbp             ; remove rbp from the stack to restore rsp to initial value
        ret                 ; return value in rax
