
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
        sar rcx, 3          ; byte_offset = index/8
        lea rdx, [rcx*8]    ; bit_offset = index-(byte_offset*8)
        imul rdx, -1        ; (byte_offset*8)*(-1)
        add rdx, rax        ; bit offset = index + (byte_offset*8)(-1)
        mov rcx, 8          ; compute rcx = (8-bit_offset-1)
        sub rcx, rdx
        sub rcx, 1
        mov rdx, 1          ; mask=1
    .loop1:                 ; mask = 1 << (8-bit_offset-1)
        sal rdx, 1
        dec rcx
        cmp rcx, 0
        jg  .loop1

        or rdi, rdx
        lea rdi, [rdi]
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
        imul rdx, -1        ; (byte_offset*8)*(-1)
        add rdx, rax        ; bit offset = index + (byte_offset*8)(-1)
        mov rcx, 8          ; compute rcx = (8-bit_offset-1)
        sub rcx, rdx
        sub rcx, 1
        mov rdx, 1          ; mask=1
    .loop1:                 ; mask = 1 << (8-bit_offset-1)
        sal rdx, 1
        dec rcx
        cmp rcx, 0
        jg  .loop1

        and rdx, rdi
        mov rax, rdx
        cmp rax, 1
        setl al
        movzx rax, al

        mov rsp, rbp        ; restore stack pointer to before we pushed parameters onto the stack
        pop rbp             ; remove rbp from the stack to restore rsp to initial value
        ret                 ; return value in rax
