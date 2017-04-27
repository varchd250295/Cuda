/*
#ifndef __CUDACC__
#define __CUDACC__
#endif

#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <stdio.h>
#include <stdlib.h>
#include <conio.h>

__constant__ int M[3];

__global__ void convolution_1D_basic(int *N, int *P,int Mask_Width, int Width) 
{
	int i = blockIdx.x*blockDim.x + threadIdx.x;
	int Pvalue = 0;
	int N_start_point = i - (Mask_Width/2);
	for (int j = 0; j < Mask_Width; j++) 
	{
		if (N_start_point + j >=0 && N_start_point + j < Width) 
		{
			Pvalue += N[N_start_point + j]*M[j];
		}
	}
	P[i] = Pvalue;
} 

int main()
{
	const int width=5;
	int i,j,size;
	int h_M[width],h_N[width],h_P[width];
	int *d_M,*d_N,*d_P;
	
	printf("\n width= %d \n ", width);

	
	
	h_N[0]=0;
	h_N[1]=1;
	h_N[2]=0;

	printf("\n Enter elements \n", width);

	for(i=0;i<width;i++)
		scanf("%d\n",h_M[i]);

	printf("\n");
	
	size=sizeof(int)*width;
	cudaMalloc((void**)&d_M,size);
	cudaMalloc((void**)&d_N,size);
	cudaMalloc((void**)&d_P,size);

	cudaMemcpyToSymbol(M,h_N,size);

	

	convolution_1D_basic<<<1,width>>>(d_N,d_P,size,width);
	
	cudaMemcpy(h_P,d_P,size,cudaMemcpyDeviceToHost);

	cudaFree(d_N);

	cudaFree(d_P);

	printf("\n\nRESULT : \n");

	for(j=0;j<width;j++)
		printf("%d ",h_P[j]);
	
	getch();
	return 0;

}
*/