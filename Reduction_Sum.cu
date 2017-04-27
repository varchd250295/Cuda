/*

#ifndef __CUDACC__
#define __CUDACC__
#endif
#include "cuda_runtime.h"
#include "device_launch_parameters.h"

#include<stdio.h>
#include<conio.h>
#define width 4

__global__ void sumReductionEff(int *d_pSum, int n)
{
	int i = 0;
	__shared__ int partialSum[width];
	unsigned int t=threadIdx.x;
	partialSum[t] = d_pSum[t];
	__syncthreads();
	for(unsigned int stride=blockDim.x/2; stride>0; stride/=2)
	{
		__syncthreads();
		if(t<stride)
			partialSum[t] += partialSum[t+stride];
	}
	d_pSum[t] = partialSum[t];
}

__global__ void sumReductionIneff(int *d_pSum, int n)
{
	int i = 0;
	__shared__ int partialSum[width];
	unsigned int t=threadIdx.x;
	partialSum[t] = d_pSum[t];
	__syncthreads();
	for(unsigned int stride=1; stride<blockDim.x; stride*=2)
	{
		__syncthreads();
		if(t%2 == 0)
			partialSum[t] += partialSum[t+stride];
	}
	d_pSum[t] = partialSum[t];
}




int main()
{
	int pSum[] = {1,2,3,4,5,6,7,8};
	int n = 8, *d_pSum, i = 0;
	int size = n*sizeof(int);
	cudaMalloc((void**)&d_pSum, size);
	cudaMemcpy(d_pSum, pSum, size, cudaMemcpyHostToDevice);
	printf("\n Elements of the array : \n");
	for(i=0; i<n; i++)
		printf("%d \t", pSum[i]);
	sumReductionIneff<<<1, n>>>(d_pSum, n);
	cudaMemcpy(pSum, d_pSum, size, cudaMemcpyDeviceToHost);
	printf("\n");
	printf("Sum of the array elements = %d", pSum[0]);
	getch();

	return 0;
}

*/