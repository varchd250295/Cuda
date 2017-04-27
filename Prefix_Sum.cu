/*
#define __CUDACC__
#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <stdio.h>
#include <conio.h>
#define Block_Size 4

__global__ void PrefixSumEfficient(int *A_d)
{
	int stride,index,i;
	__shared__ int XY[Block_Size*2];

	i=threadIdx.x;
	if(i<2*Block_Size)	//For prefix sum we take block size as half the input size
		XY[i]=A_d[i];	//Load from global memory to shared memory
	__syncthreads();

	for(stride=1; stride<=Block_Size; stride*=2)	//Reduction Phase
	{
		index=((threadIdx.x + 1)*stride*2)-1;
		if(index<2*Block_Size)
			XY[index]+=XY[index-stride];
		__syncthreads();
	}

	for(stride=Block_Size/2; stride>0; stride/=2)	//Post Reduction Phase
	{
		__syncthreads();
		index=((threadIdx.x + 1)*stride*2)-1;
		if(index+stride<2*Block_Size)
			XY[index+stride]+=XY[index];
	}

	__syncthreads();
	A_d[i]=XY[i];
}

int main()
{
	int i, *A_d, *A, tile;

	int size=sizeof(int)*Block_Size*2;

	A=(int *)malloc(size);

	printf("Elements to be added:\n");
	for(i=0; i<Block_Size*2; i++)
		printf("%d \t",A[i]=i+1);

	cudaMalloc((void**)&A_d,size);
	cudaMemcpy(A_d,A,size,cudaMemcpyHostToDevice);
		PrefixSumEfficient<<<1,Block_Size*2>>>(A_d);
	cudaMemcpy(A,A_d,size,cudaMemcpyDeviceToHost);
	printf("\nEfficient:\n");
	for(i=0; i<Block_Size*2; i++)
		printf("%d	",A[i]);

	cudaFree(A_d);

	getch();
	return 0;
}
*/

/* OUTPUT -

Elements to be added:
1       2       3       4       5       6       7       8
Efficient:
1       3       6       10      15      21      28      36

*/
