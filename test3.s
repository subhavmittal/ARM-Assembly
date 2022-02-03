.text
.extern mergesort
.extern compare_strings
.extern merge_sorted_lists
.extern fgets
.extern atoi
.extern input_custom
.extern output_custom
.extern strlen
.extern prints
ldr r0,=Duplicate_removal_prompt
bl prints
ldr r0,=Duplicate_removal
mov r1,#4
mov r2,#0
bl fgets
ldr r0,=Duplicate_removal
bl atoi
str r0,[sp,#-4]! @duplicate removal
ldr r0,=Comparison_mode_prompt
bl prints
ldr r0,=Comparison_mode
mov r1,#4
mov r2,#0
bl fgets
ldr r0,=Comparison_mode
bl atoi
str r0,[sp,#-4]!  @comparison mode
ldr r0,=List1_strings
ldr r2,=List1_pointer
bl input_custom
str r1,[sp,#-4]! @List size
str r0,[sp,#-4]! @List pointer
bl mergesort
add sp,sp,#16 @ restore stack pointer after function is executed
bl output_custom
mov r0,#0x18
swi 0x123456
.data
.align 2
Comparison_mode_prompt:
.asciz  "Enter Comparison mode. 0 for case-insensitive, 1 for case-sensitive\n"
Comparison_mode:
.word 0
.align 2
Duplicate_removal_prompt:
.asciz "Enter 1 for removing duplicates. 0 otherwise\n"
Duplicate_removal:
.word 0
.align 2
List1_strings:
.space 10200     @as max 100 strings allowed with each of max size 100 bytes. 2 bytes added per string for newline and null characters
.align 2        
List1_pointer:
.space 400  @max 100 addresses of 4 bytes each


