/*

#ifndef __CUDACC__
#define __CUDACC__
#endif

#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <stdio.h>
#include <stdlib.h>*
#include <conio.h>

const int TILE_WIDTH=2;


__global__ void MatrixMulKernel(float* Md, float* Nd, float* Pd, int Width)
{
	__shared__ float Mds[TILE_WIDTH][TILE_WIDTH];
	__shared__ float Nds[TILE_WIDTH][TILE_WIDTH];

	// Identify the row and column of the Pd element to work on
	int Row = blockIdx.y * TILE_WIDTH + threadIdx.y;
	int Col = blockIdx.x * TILE_WIDTH + threadIdx.x;
	float Pvalue = 0;

	// Loop over the Md and Nd tiles required to compute the Pd element
	for (int m = 0; m < Width/TILE_WIDTH; ++m) 
	{

		// Collaborative loading of Md and Nd tiles into shared memory
		Mds[threadIdx.y][threadIdx.x] = Md[Row*Width + (m*TILE_WIDTH + threadIdx.x)];
		Nds[threadIdx.y][threadIdx.x] = Nd[Col + (m*TILE_WIDTH + threadIdx.y)*Width];
		__syncthreads();
		for (int k = 0; k < TILE_WIDTH; ++k)
		Pvalue += Mds[threadIdx.y][k] * Nds[k][threadIdx.x];
		__syncthreads();
	}

	Pd[Row*Width+Col] = Pvalue;
}

int main()
{
	const int width=4;
	int i,j,size;
	float h_M[width][width],h_N[width][width],h_P[width][width];
	float *d_M,*d_N,*d_P;
	
	printf("\n width= %d \n ", width);
	
	for(i=0;i<width;i++)
	{
		for(j=0;j<width;j++)
			{ 
				h_M[i][j]=1;
				h_N[i][j]=1;
		   }
	}

	

	printf("\nh_M array is: \n");
	for(i=0;i<width;i++)
	{   
		printf("\n");
		for(j=0;j<width;j++)
			printf("%d ",h_M[i][j]);
	}
	
	printf("\n\nh_N array is: \n");
	for(i=0;i<width;i++)
	{   
		printf("\n");
		for(j=0;j<width;j++)
			printf("%d ",h_N[i][j]);
	}
	
	size=sizeof(int)*width*width;
	cudaMalloc((void**)&d_M,size);
	cudaMalloc((void**)&d_N,size);
	cudaMalloc((void**)&d_P,size);
	cudaMemcpy(d_M,h_M,size,cudaMemcpyHostToDevice);
	cudaMemcpy(d_N,h_N,size,cudaMemcpyHostToDevice);

	dim3 dimGrid((width/TILE_WIDTH),(width/TILE_WIDTH),1);
	dim3 dimBlock(TILE_WIDTH,TILE_WIDTH,1);

	MatrixMulKernel<<<dimGrid,dimBlock>>>(d_M,d_N,d_P,width);
	
	cudaMemcpy(h_P,d_P,size,cudaMemcpyDeviceToHost);
	cudaFree(d_M);
	cudaFree(d_N);
	cudaFree(d_P);

	printf("\n\nMultiplied array is: \n");
	for(i=0;i<width;i++)
	{   
		printf("\n");
		for(j=0;j<width;j++)
			printf("%d ",h_P[i][j]);
	}
	
  getch();
  return 0;
}

*/