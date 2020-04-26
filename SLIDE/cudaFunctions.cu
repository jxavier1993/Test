#include "cudaFunctions.h"

__global__ void example_kernel(){
   printf("Hello from CUDA\n");
}

void call_example(){
   printf("able to call cuda function\n");
   example_kernel<<<1,1>>>();
   cudaDeviceSynchronize();
}
