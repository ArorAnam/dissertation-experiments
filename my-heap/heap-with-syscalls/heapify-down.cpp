#include <stdint.h>
#include <string.h>
#include <stdarg.h>
#include <stdio.h>
#include <limits.h>
#include <sys/signal.h>

#include <stdlib.h>

#include "syscalls.c"

void heapify_down(uint32_t* heap, size_t len, size_t index);

void main(int argc, char** argv) {
	
	int a = rand();
	
    uint32_t* heap = (uint32_t*)0x05000000;
	    
	size_t len = 64*4; 

	// Prepare a heap with random numbers
	for (int j = 0; j < len / 4; j++) {
	    *((volatile uint32_t*)(heap + j)) = rand() % len;
	}   

	// Read cycles and instruction count	  		
	uint64_t time1 = time(); 
	uint64_t icount1 = insn();
	
	// Heapify down
	heapify_down(heap, len, 0);

	// Read cycles and instruction count	
	uint64_t time2 = time() - time1;
	uint64_t icount2 = insn() - icount1;  
	  		  	
  	// Print result	
  	printf("heapifyDOWN N %d cyc %llu icount %llu CPI %llu.%02llu ",
  	       len / 4, time2, icount2, (time2) / (icount2), (((time2) % (icount2)) * 100) / (icount2));
	
	int error = 0;
	for (int i = 0; i < len / 4; i++) {
		printf("\n%d) %d", i, heap[i]);  		
  	}	
  	printf("\nEnd%d!\n", error);	 
    
    while (1);
    return;
}

// RS1, RD1, RS2, RD2 -> 1, 3, 2, 0
#define heap_compare_swap  ((((((( 1 << 3) | 3)) << 3) | 2) << 3) | 0)

void heapify_down(uint32_t* heap, size_t len, size_t index) { 
	while (index < len / 4) {
		// Load current node and children
		asm volatile ("c0_lv x0, %0, %1, %2":: "r"(heap), "r"(index), "I"(1 << (6)));
		asm volatile ("c0_lv x0, %0, %1, %2":: "r"(heap), "r"(2 * index + 1), "I"(2 << (6)));
		asm volatile ("c0_lv x0, %0, %1, %2":: "r"(heap), "r"(2 * index + 2), "I"(3 << (6)));

		// Compare and swap if necessary
	   	asm volatile ("c3 x0, x0, %0":: "I"(heap_compare_swap));

		// Update index to child node
		index = 2 * index + 1; // Example for moving to the left child
	}
}
