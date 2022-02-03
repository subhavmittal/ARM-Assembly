.text
.global compare_strings
@to compare 2 input strings
@Input parameters
@ r0,r1 contain the pointers to the 2 input null terminated strings to be compared
@ r2 contains the comparison mode. 0 for case-insensitive , 1 for case-sensitive
@ Output
@ function returns output in r0. 
@ 0 if the first string is lesser than the second 
@ 1 if the first string is equal to the second
@ 2 if the first string is greater than the second
compare_strings:
    stmfd sp!, {r4-r12,lr}
    cmp r2,#0
    bne case_sensitive
    case_insensitive:
        ldrb r4,[r0],#1
        ldrb r5,[r1],#1
        cmp r4,#'A'
        rsbges r6,r4,#'Z'
        addge r4,r4,#'a'-'A'
        cmp r5,#'A'
        rsbges r6,r5,#'Z'
        addge r5,r5,#'a'-'A'
        cmp r4,r5
        bgt ret2_compare_strings
        blt ret0_compare_strings
        cmp r4,#0
        beq ret1_compare_strings
        b case_insensitive
    case_sensitive:
        ldrb r4,[r0],#1
        ldrb r5,[r1],#1
        cmp r4,r5
        bgt ret2_compare_strings
        blt ret0_compare_strings
        cmp r4,#0
        beq ret1_compare_strings
        b case_sensitive
    ret0_compare_strings:
        mov r0,#0
        ldmfd sp!,{r4-r12,pc}
    ret1_compare_strings:
        mov r0,#1
        ldmfd sp!,{r4-r12,pc}
    ret2_compare_strings:
        mov r0,#2
        ldmfd sp!,{r4-r12,pc}    
        




