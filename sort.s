.text
.extern merge_sorted_lists
.global mergesort
@ mergesort: function to sort 2 lists
@ Input parameters
@ sp-4 - sp-1 contains the duplicate removal option
@ sp-8 - sp-5 contains the comparison mode
@ sp-12 - sp-9 contains the list size
@ sp-16 - sp-13 contains the list pointer


@ Output
@ r0 contains pointer to sorted list
@ r1 contains size of sorted list
mergesort:
    stmfd sp!,{r4-r12,lr}@ storing registers and return address due to recursion
    ldr r4,[sp,#4+40]
    cmp r4,#1  @if size is equal to or less than 1 list is already sorted
    bgt loop
    ldr r0,[sp,#40] @ input list pointer
    mov r1,r4
    ldmfd sp!,{r4-r12,pc} @return
    loop:
        ldr r5,[sp,#12+40]  @duplicate removal option
        ldr r6,[sp,#8+40] @comparison mode
        ldr r7,[sp,#40] @ input list pointer
       sort1:
            str r5,[sp,#-4]!
            str r6,[sp,#-4]!
            mov r0,r4, asr #1 @list1 size
            str r0,[sp,#-4]! 
            str r7,[sp,#-4]! @list1 pointer
            bl mergesort
            add sp,sp,#16 @ restoring stack space provided for input
            mov r8,r0
            mov r9,r1
        sort2:
            str r5,[sp,#-4]! @duplicate removal option
            str r6,[sp,#-4]!@comparison mode
            mov r0,r4, asr #1
            sub r1,r4,r0  @list2 size
            str r1,[sp,#-4]! 
            add r3,r7,r0, lsl #2  @list2 pointer
            str r3,[sp,#-4]!
            bl mergesort
            add sp,sp,#16 @ restoring stack space provided for input
            mov r10,r0
            mov r11,r1
        merge:
            sub sp,sp,#800  @ allocating space on stack for merged list
            mov r0,sp  @storing address of merged list pointer
            str r5,[sp,#-4]! @loading duplicate removal input in stack
            str r6,[sp,#-4]! @loading comparison mode input in stack
            str r11,[sp,#-4]!@list2 size
            str r9,[sp,#-4]!@list1 size
            str r10,[sp,#-4]! @list2 pointer
            str r8,[sp,#-4]! @list1 pointer
            str r0,[sp,#-4]! @merged list pointer
            bl merge_sorted_lists
            add sp,sp,#28 @ restoring stack space provided for input
            mov r3,r1
            mov r4,r7
        copy:
            ldr r5,[r0],#4
            str r5,[r4],#4
            sub r3,r3,#1
            cmp r3,#0
            bgt copy
        add sp,sp,#800
        mov r0,r7
        ldmfd sp!,{r4-r12,pc} @return
.end











