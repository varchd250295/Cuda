/*

#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <stdlib.h>
#include <stdio.h>
#include <time.h>



__global__ void addMultipleBlocks(float *d_a,float *d_b,float *d_c,int m,int n)
{
	int i=blockIdx.x*blockDim.x+ threadIdx.x;

	if(i<(m*n))
		d_c[i]=d_a[i]+d_b[i];

}


__global__ void addSingleBlock(float *d_a,float *d_b,float *d_c,int m,int n)
{
	
	int i=threadIdx.x;

	d_c[i]=d_a[i]+d_b[i];

}



int main()
{
	float *a,*b,*c;

	float *d_a,*d_b,*d_c;
	int size,m,n,i,j;
	time_t start;

	printf("Enter the number of rows and columns : \n");

	scanf("%d%d",&m,&n);

	a=(float *)malloc((size=sizeof(float)*m*n));
	b=(float *)malloc(size);
	c=(float *)malloc(size);


	for(i=0;i<m;i++)
		for(j=0;j<n;j++)
		{
			a[i*n+j]=i*2+j+0.8;
			b[i*n+j]=i*2+j+0.1;
		}

	cudaMalloc((void **)&d_a,size);
	cudaMalloc((void**)&d_b,size);
	cudaMalloc((void **)&d_c,size);

	cudaMemcpy(d_a,a,size,cudaMemcpyHostToDevice);
	cudaMemcpy(d_b,b,size,cudaMemcpyHostToDevice);

	start=time(0);

	addSingleBlock<<<1,(m*n)>>>(d_a,d_b,d_c,m,n);

	cudaMemcpy(c,d_c,size,cudaMemcpyDeviceToHost);

	printf("Result using a single block : \n");


	for(i=0;i<m;i++)
	{
		for(j=0;j<n;j++)
		printf("%f ",c[i*n+j]);

		printf("\n");
	}
	printf("\n\n\n TIME TAKEN TO COMPUTER THE ADDITION WITH SINGLE BLOCK - %f",(difftime(time(0),start)));

	cudaFree(d_c);
	free(c);

	cudaMalloc((void **)&d_c,size);
	c=(float *)malloc(size);

	start=time(0);

	addMultipleBlocks<<< (int)((m*n)/9.0+1),9>>>(d_a,d_b,d_c,m,n);

	cudaMemcpy(c,d_c,size,cudaMemcpyDeviceToHost);

	printf("Result using a multiple blocks(3x3) : \n");


	for(i=0;i<m;i++)
	{
		for(j=0;j<n;j++)
		printf("%f ",c[i*n+j]);

		printf("\n");
	}

	printf("\n\n\n TIME TAKEN TO COMPUTER THE ADDITION WITH	MULTIPLE BLOCKS - %f",(difftime(time(0),start)));


	
	free(a);
	free(b);
	free(c);
	
	cudaFree(d_a);
	cudaFree(d_b);
	cudaFree(d_c);



	return 0;
}

*/