/*

#ifndef __CUDACC__
#define __CUDACC__
#endif


#include "cuda_runtime.h"
#include "device_launch_parameters.h"


#include <stdio.h>
#include <conio.h>

const int TILE_WIDTH=2;
const int width=4;

__global__ void matrixmul(int *d_M,int *d_N,int *d_P)
{
	__shared__ int dS_M[TILE_WIDTH][TILE_WIDTH];
	__shared__ int dS_N[TILE_WIDTH][TILE_WIDTH];
	
	int by= blockIdx.y;
	int ty=threadIdx.y;
	int bx=blockIdx.x;
	int tx=threadIdx.x;

	int Row= by*TILE_WIDTH+ty;
	int Col= bx*TILE_WIDTH+tx;
	int pvalue=0;
	for(int m=0;m<(width/TILE_WIDTH);m++)
	{   dS_M[ty][tx]=d_M[Row*width + (m*TILE_WIDTH+tx)] ;
	    dS_N[ty][tx]=d_N[Col+(m*TILE_WIDTH+ty)*width] ;
		__syncthreads();
		for(int k=0;k<TILE_WIDTH;k++)
		{
			pvalue += dS_M[ty][k]*dS_N[k][tx] ;
			
		__syncthreads();
		}
		d_P [Row*width +Col]=pvalue;

	}

}
int main()
{
	int i,j,size;
	int h_M[width][width],h_N[width][width],h_P[width][width];
	int *d_M,*d_N,*d_P;
	
	printf("\n Enter according to width= %d \n ", width);
	
	for(i=0;i<width;i++)
	{
		for(j=0;j<width;j++)
			{ h_M[i][j]=2;
		      h_N[i][j]=2;
		     if(i==j)
		       {
				   h_N[i][j]= 1;
			     h_M[i][j]= 1;
			  }
   }
	}

	

	printf("\nh_M array : \n");
	for(i=0;i<width;i++)
	{   printf("\n");
		for(j=0;j<width;j++)
			printf("%d ",h_M[i][j]);
	}
	
	printf("\n\nh_N array : \n");
	for(i=0;i<width;i++)
	{   printf("\n");
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

	matrixmul<<<dimGrid,dimBlock>>>(d_M,d_N,d_P);
	
	cudaMemcpy(h_P,d_P,size,cudaMemcpyDeviceToHost);
	cudaFree(d_M);
	cudaFree(d_N);
	cudaFree(d_P);

	printf("\n Resultant Array ( h_M * h_N ): \n");
	for(i=0;i<width;i++)
	{   printf("\n");
		for(j=0;j<width;j++)
			printf("%d ",h_P[i][j]);
	}
	
  getch();
  return 0;
}

*/