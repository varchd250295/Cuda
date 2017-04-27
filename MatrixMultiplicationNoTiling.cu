
#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <stdlib.h>

#include <stdio.h>
#define blockSize 16

__global__ void multiply(int *d_a,int *d_b,int *d_c,int n)
{
	int i;
	int temp=0;
    
	int row=blockIdx.y*blockDim.y + threadIdx.y;
	int column=blockIdx.x*blockDim.x + threadIdx.x;

	for(i=0;i<n;i++)
	temp+=d_a[row*n+i]*d_b[i*n+column];

	d_c[row*n+column]=temp;
}


int main()
{
	int n,i,j;
	int *h_a,*h_b,*h_c;
	int *d_a,*d_b,*d_c;
	int size;
	int temp=0;


	printf("Enter the size of the matrix :\n");
	scanf("%d",&n);

	h_a=(int *)malloc((size=(sizeof(int)*n*n)));
	h_b=(int *)malloc(size);
	h_c=(int *)malloc(size);

	dim3 grid(blockSize,blockSize);
	dim3 block((n-1)/blockSize +1,(n-1)/blockSize +1);

    cudaMalloc((void **)&d_a,size);
	cudaMalloc((void **)&d_b,size);
	cudaMalloc((void **)&d_c,size);


	for(i=0;i<n;i++)
	{
		for(j=0;j<n;j++)
		{
			h_a[i*n+j]=++temp;
			h_b[i*n+j]=1;
		}
	}


	cudaMemcpy(d_a,h_a,size,cudaMemcpyHostToDevice);
	cudaMemcpy(d_b,h_b,size,cudaMemcpyHostToDevice);

	multiply<<<grid,block>>>(d_a,d_b,d_c,n);

	cudaMemcpy(h_c,d_c,size,cudaMemcpyDeviceToHost);

	for(i=0;i<n;i++)
	{
		for(j=0;j<n;j++)
		printf("%d \n",h_c[i*n+j]);

	}

	free(h_a);
	free(h_b);
	free(h_c);
	cudaFree(d_a);
	cudaFree(d_b);
	cudaFree(d_c);
	

    return 0;
}
