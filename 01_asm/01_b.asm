section .rodata
    format db "%d   %d", 10, 0         ; Format string for reading an integer
    result_msg db "%d %d", 10, 0 ; Result message with newline
    result db "%d", 10, 0 ; Result message with newline

section .data
    filename db "01.in", 0    ; Filename
    mode db "r", 0            ; Mode string for fopen
    value dd 0                ; Variable to store the read value

section .bss
    file_ptr resq 1           ; Space for the FILE pointer
    left resq 1001            ; Space for left column
    right resq 1001           ; Space for right column

section .text
    extern fopen             ; Declare external functions
    extern fscanf
    extern fclose
    extern printf
    global main              ; Use `main` instead of `_start`

main:
    ; Open the file using fopen
    lea rdi, [filename]      ; Address of the filename
    lea rsi, [mode]          ; Address of the mode string ("r")
    call fopen
    mov [file_ptr], rax      ; Save the FILE* returned by fopen

    cmp rax, 0               ; Check if fopen succeeded
    je error_exit
    push rsp                 ; not sure why we need this?

    xor rbx, rbx             ; Initialize counter to 0
read_loop:
    inc rbx                  ; Increment counter

    ; Call fscanf to read an integer
    mov rdi, [file_ptr]      ; FILE* (from fopen)
    lea rsi, [format]        ; Address of the format string
    lea rdx, [left + rbx * 8] ; Address of the variable to store the integer in left array
    lea rcx, [right + rbx * 8] ; Address of the variable to store the integer in right array
    call fscanf

    ; Check if fscanf succeeded
    cmp rax, 2
    je read_loop
    dec rbx                  ; Decrement counter if fscanf failed
read_loop_end:
    mov rdi, [file_ptr]      ; FILE* to close
    call fclose              ; Close the file

    lea rdi, [left]          ; Address of the array
    mov rsi, rbx             ; Number of elements
    call bubble_sort

    lea rdi, [right]         ; Address of the array
    mov rsi, rbx             ; Number of elements
    call bubble_sort

    jmp sum_loop_init        ; skip the debug print loop

    xor r12, r12             ; Initialize counter to 0
print_loop:
    inc r12                  ; Increment counter

    ; Print the result
    lea rdi, [result_msg]    ; Address of the result message
    mov rsi, [left + r12 * 8] ; Dereference `left` and pass it to printf
    mov rdx, [right + r12 * 8] ; Dereference `right` and pass it to printf
    call printf

    cmp r12, rbx
    jl print_loop

sum_loop_init:
    ; sum_diff(left, right, length = rbx)
    xor r12, r12  ; sum
    xor rcx, rcx  ; index
sum_loop:
    cmp rbx, rcx             ; Compare index with length
    jl sum_loop_end         ; If index >= length, end the loop

    mov r13, [left + rcx * 8] ; Load left[index] into r8
    lea rdi, [right]          ; Address of the right array
    mov rsi, rbx              ; Length of the array
    mov rdx, r13              ; Value to count
    call count_right

    imul r13, rax              ; Multiply left[index] by count_right(length, left[index])
    add r12, r13              ; Add the absolute difference to the total sum
    inc rcx                  ; Increment index
    jmp sum_loop             ; Continue the loop

sum_loop_end:
    ; Print the total sum
    lea rdi, [result]        ; Address of the format string
    mov rsi, r12             ; Total sum to print
    xor rdx, rdx             ; Zero out rdx (not used in this printf)
    call printf

    ; Exit program
    xor rdi, rdi             ; Return code 0
    mov rax, 60              ; syscall: exit
    syscall


count_right:
    ; args: rdi = arr, rsi = length, rdx = value
    ; returns: rax = count of value in arr
    push rbx
    push rcx
    push rdx

    xor rax, rax             ; Initialize count to 0
    xor rcx, rcx             ; Initialize index to 0

count_loop:
    cmp rcx, rsi             ; Compare index with length
    jge count_loop_end       ; If index >= length, end the loop

    mov rbx, [rdi + rcx * 8] ; Load arr[index] into rbx
    cmp rbx, rdx             ; Compare arr[index] with value
    jne skip_inc             ; If not equal, skip increment

    inc rax                  ; Increment count

skip_inc:
    inc rcx                  ; Increment index
    jmp count_loop           ; Continue the loop

count_loop_end:
    pop rdx
    pop rcx
    pop rbx
    ret


bubble_sort:
    ; args: rdi = arr, rsi = limit
    ; Bubble sort function implementation, preserve rbx, but not r12-14
    push rbx

    ; rax and rbx temp variables are used to store i and j
    xor rax, rax
    bubble_sort_i_loop:
        cmp rax, rsi
        jge bubble_sort_end

        xor rbx, rbx
        bubble_sort_j_loop:
            cmp rbx, rsi
            jge bubble_sort_i_inc

            ; Compare arr[j] and arr[j + 1]
            mov rcx, [rdi + rbx * 8]
            mov rdx, [rdi + rbx * 8 + 8]
            cmp rcx, rdx
            jle skip_swap

            ; Swap arr[j] and arr[j + 1]
            mov [rdi + rbx * 8], rdx
            mov [rdi + rbx * 8 + 8], rcx

            skip_swap:
            inc rbx
            jmp bubble_sort_j_loop

        bubble_sort_i_inc:
        inc rax
        jmp bubble_sort_i_loop

    bubble_sort_end:
    pop rbx
    ret

error_exit:
    ; Exit with an error code
    mov rax, 60              ; syscall: exit
    mov rdi, 1               ; status: 1
    syscall