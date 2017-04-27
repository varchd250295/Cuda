#ifndef __CUDACC__
#define __CUDACC__
#endif
#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <cuda.h>
#include <stdio.h>
#include <device_functions.h>
#include <string.h>
#define SIZE 100



__global__ void rows(int a[],int b[],int r,int c,int row)
{
	int i=threadIdx.x;
	int suma=0,sumb=0;

	for(int j=0;j<c;j++)
	{
		suma+=a[i*r+j];
	}

	for(int j=0;j<r;j++)
	{
		sumb=0;

		for(int k=0;k<c;k++)
		{
			sumb+=b[j*r+k];
		}

		if(suma==sumb)
			row++;

	}

}

__global__ void ele(int a[],int b[],int r,int c)
{





}



int main()
{
	int a[SIZE],b[SIZE],r=0,c=0,i=0,j=0;
	int *d_a,*d_b,*d_r;
	int row[SIZE];

	printf("Enter the no. of rows and columns : \n");
	scanf("%d\n%d",&r,&c);

	printf("Enter the 1st array elements : \n");
	for(i=0;i<r;i++)
		for(j=0;j<c;j++)
			scanf("%d",&a[r*i+j]);

	printf("Enter the 2nd array elements : \n");
	for(i=0;i<r;i++)
		for(j=0;j<c;j++)
			scanf("%d",&b[r*i+j]);


	
	
	int size=sizeof(int)*(r*c);

	cudaMalloc((void **)&d_a,size);
	cudaMalloc((void **)&d_b,size);
	cudaMalloc((void**)&d_r,sizeof(int)*r);

	cudaMemcpy(d_a,a,size,cudaMemcpyHostToDevice);
	cudaMemcpy(d_r,row,sizeof(int),cudaMemcpyHostToDevice);

	rows<<<1,r>>>(d_a,a,r,c,row);

	printf("No. of same rows = %d",row);

	

	cudaFree(d_a);
	cudaFree(d_b);


}