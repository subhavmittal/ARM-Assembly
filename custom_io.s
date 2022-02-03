.text
@ to take input size of the list and strings from the user
@ input parameters 
@ r0 contains address where strings are to be stored.
@ r2 contains list pointer (address of 1st element of list)
@Output
@ r0 has pointer to list containg the string addresses
@ r1 has the length of the list
.global input_custom
.global output_custom
input_custom:
    ldr r1,=list_size
    str r4,[sp,#-4]!
    str r3,[sp,#-4]!
    str r0,[sp,#-4]!
    str r1,[sp,#-4]!
    str r2,[sp,#-4]!
    str lr,[sp,#-4]!
    Print_prompt1:
        ldr r0,=list_size_prompt
        bl prints
    input_size:
        ldr r0,[sp,#8]
        mov r1,#4
        mov r2,#0
        bl fgets
    ascii_to_int:  @converting input size to int and storing in stack
        ldr r0,[sp,#8]
        bl atoi
        cmp r0,#0
        movlt r0,#0
        str r0,[sp,#-4]!
    Print_prompt2:
        ldr r0,=string_input_prompt
        bl prints
    input_string:
        ldr r0,[sp,#16]
        ldr r4,[sp]
        ldr r3,[sp,#8]
        mov r1,#102
        mov r2,#0
        cmp r4,#0
        ble L10
        L4:
            str r0,[r3],#4
            bl fgets
            sub r4,r4,#1
            cmp r4,#0
            bgt L4
        L10:
            ldr r0,[sp,#8]
            ldr r1,[sp]
            ldr lr,[sp,#4]
            ldr r3,[sp,#20]
            ldr r4,[sp,#24]
            add sp,sp,#28
            mov pc,lr


@to print the merged list and its size
@Input parameters
@ r0 has the list pointer (address of 1st element of the list)
@ r1 has the size of the list
output_custom:
str lr,[sp,#-4]!
mov r2,r0
mov r3,r1
ldr r0,=list_size_output_prompt
bl prints
mov r0,r1
ldr r1,=list_size_itoa
bl itoa
bl prints
ldr r0,=list_elements_output_prompt
bl prints
L5:
    ldr r0,[r2],#4
    bl prints
    sub r3,r3,#1
    cmp r3,#0
    bgt L5
    ldr pc,[sp],#4

.data
.align 2
operands:
.word 0,0,0
list_size_prompt:
.asciz "Enter size of the list (MAX 100)\n"
list_size:
.word 0  @max 5 bytes including newline and null characters
.byte 0
.align 2
string_input_prompt:
.asciz "Enter the input strings (MAX 100 characters each)\n"
list_size_output_prompt:
.asciz "The size of the sorted list is\n"
.align 2
list_size_itoa:
.space 8
list_elements_output_prompt:
.asciz "The elements of the sorted list are\n"
