# ARM-Assembly
Recursive MergeSort implementation in ARM Assembly Language
The code for the recursive sort is written in sort.s
There are 5 other files apart from sort.s
1. custom_io.s : contains custom input/output functions developed for taking list input
2. compare.s : contains the function to compare 2 strings
3. UsefulFunctions.s : contains some helper functions
4. merge.s : Contains the merge function
5. test3.s : contains the test program
sort.s
 The function mergesort takes 4 inputs –
 Pointer to the unsorted list
 Size Of the unsorted list
 Duplicate removal option
 Comparison mode
 All of these are passed through the stack. The exact locations in the stack are mentioned in detail using comments in sort.s The function produces 2 outputs-
 Pointer to the sorted list (in r0)
SizesSize of the sorted list (in r1)
Program Logic
The Algorithm behind the implementation is to divide the input list into 2 parts and sort them separately ; then merge them together to form the sorted list.
 For the recursive method, a base case where size is 1 is trivial to solve (already solved)
 Managing the stack and storing and loading values from it is key to this implementation
 Registers r4-r12 and the link register are initially stored in the stack
 Input list size is loaded from the stack. If it is less than or equal to 1, then the input list pointer and size are simply moved to registers r0 and r1 and the function returns
 If size is greater than 1, the other input parameters are loaded from stack
 Input parameters for sorting the first half of the list are computed and passed through the stack
 Size is Arithmetic/logical right shift of total list size, Pointer is the same)
 The mergesort function is called. The output in r0,r1 is copied to r8,r9 and the stack space of 16 bytes which was allocated in the previous step for sorting the first half of the list is reclaimed by incrementing sp by #16
 The same process is repeated for the second half of the list
 In my design, I have allowed a maximum 100 strings in a list, so I allocate a space of 400 bytes on the stack for temporarily storing the output of the merge function before it is overwritten on the original list.
 Next the input parameters for the merge function are passed through the stack by using the outputs obtained from the mergesort function on the 2 halfs of the original list
 The merge function is modified from assignment 2 to include the address of the sorted list as an input parameter too. The stack point after 400 bytes were allocated is passed in this field
The output is copied from the stack onto the original list using post-index load and store operations in a loop and then the 400 bytes of space is deallocated to conserve storage
 The original list pointer is passed in r0, the sorted list size is passed in r1 and the function returns
custom_io.s
 Contains 2 functions input_custom and output_custom
 input_custom manages the task to give the user prompts and take input the size of the list and the strings from stdin.It also stores the string addresses in a list.
A limit of 100 strings and max 100 characters per string is chosen
This function takes input parameters the address where the strings are to be stored in r0 and the pointer to the list which would store the string addresses in r1.
 The strings are stored contiguously in an efficient manner. Each of these are null terminated which mark the end of that string.
 The list size is converted to an integer using atoi function from UsefulFunctions.s
 The loop L4 for taking the input strings is efficiently implemented using few lines of code by modifying the fgets function in UsefulFunctions.s to return the address of the next byte after the null character instead of the address of the start of the string which was the original implementation.
 Output_custom manages the task to output the size of the merged list and its elements to stdout.
 It takes input parameters the pointer of the list to be printed in r0 and the size of the list in r1.
 It makes use of itoa and prints functions from UsefulFunctions.s . The itoa function is modified to include a newline character just before the null character at the end.
test.s
 It contains the test program. It takes in all the parameters like comparison mode, duplicate removal option and the list data from the user through stdin and writes the results to stdout.
 It makes use of all the functions defined. It calls input_custom once to input data for the list, mergesort once for sorting the list and output_custom once for printing the sorted list’s data
 .align directive was used (.align 2) in the .data portion to make sure all memory addresses were a multiple of 4 in the absence of which I was getting “misaligned memory access error”
Test Cases



As seen the program is robust and does not crash on edge cases like on negative list size.
