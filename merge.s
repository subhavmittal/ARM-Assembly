.text
.extern compare_strings
.global merge_sorted_lists
@Input
@load parameters in stack
@ sp-4 - sp-1 : duplicate removal option
@ sp-8 - sp-5 : comparison mode
@ sp-12 - sp-9 : List2 size
@ sp-16 - sp-13 : List1 size
@ sp-20 - sp-17 : List2 pointer
@ sp-24 - sp-21 : List1 pointer
@ sp-28 - sp-25 : merged list pointer(memory address where to store merged list)
@Output
@ r0 has merged list pointer
@ r1 has merged list size

merge_sorted_lists:
    stmfd sp!,{r4-r12,lr} @storing value of registers and return address in stack
    ldr r4,[sp,#40+4]  @List1 pointer and List1 iterator
    ldr r5,[sp,#4+40+4]  @List2 pointer and List2 iterator
    ldr r2,[sp,#16+40+4] @comparison mode
    ldr r0,[sp,#8+40+4] @ List1 size
    ldr r1,[sp,#12+40+4]@ List 2 size
    add r10,r4,r0,lsl #2 @ List1 end marker
    add r11,r5,r1,lsl #2 @List2 end marker
    ldr r7,[sp,#40] @merged list pointer and merged list iterator
    ldr r12,[sp,#20+40+4] @duplicate removal option. 1 if duplicates should be removed. 0 if otherwise
    mov r6,#0 @size of merged list
    cmp r4,r10
    beq L2
    cmp r5,r11
    beq L2
    L1:
        ldr r8,[r4],#4
        ldr r9,[r5],#4
        mov r0,r8
        mov r1,r9
        bl compare_strings
        cmp r0,#0
        streq r8,[r7],#4
        subeq r5,r5,#4
        cmp r0,#1
        streq r8,[r7],#4
        cmpeq r12,#0
        subeq r5,r5,#4
        cmp r0,#2
        streq r9,[r7],#4
        subeq r4,r4,#4
        add r6,r6,#1
        cmp r4,r10
        cmplt r5,r11
        blt L1
    L2:
        cmp r4,r10
        bge L3
        ldr r8,[r4],#4
        str r8,[r7],#4
        add r6,r6,#1
        b L2

    L3:
        cmp r5,r11
        bge ret_merge_sorted_lists
        ldr r9,[r5],#4
        str r9,[r7],#4
        add r6,r6,#1
        b L3
    ret_merge_sorted_lists:
        sub r0,r7,r6,lsl #2
        mov r1,r6
        ldmfd sp!,{r4-r12,pc} @restoring register values and returning from the function
.end









