/*
#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include<stdio.h>
#include<stdlib.h>
#include<conio.h>

__global__ void convolution(int *N, int *M, int *P, int mask_width, int width)
{
	int i = blockIdx.x * blockDim.x + threadIdx.x;
	int pvalue=0;
	int N_start_point=i-(mask_width/2);
	
	for(int j=0; j<mask_width; j++)
	{
		if(N_start_point+j>=0 && N_start_point+j<width)
			pvalue +=N[N_start_point+ j]*M[j];
	}
	P[i]=pvalue;
}

int main()
{
	int i, n, m, *A, *B, *C, *N, *M, *P;
	
	n=8;	
	m=5;

	A=(int *)malloc(sizeof(int)*n);
	B=(int *)malloc(sizeof(int)*m);
	C=(int *)malloc(sizeof(int)*n);

	printf("\n\nElements in A:\n");

	for(i=0; i<n; i++)
		printf("%d \t",A[i]=i+1);

	printf("\n\nElements in B:\n");

	for(i=0; i<m; i++)
		printf("%d \t",B[i]=i+1);

	cudaMalloc((void**)&N,sizeof(int)*n);
	cudaMalloc((void**)&M,sizeof(int)*m);
	cudaMalloc((void**)&P,sizeof(int)*n);

	cudaMemcpy(N,A,sizeof(int)*n,cudaMemcpyHostToDevice);
	cudaMemcpy(M,B,sizeof(int)*m,cudaMemcpyHostToDevice);

	dim3 DimGrid(1,1,1);
	dim3 DimBlock(n,1,1);
	convolution<<<DimGrid,DimBlock>>>(N,M,P,m,n);

	cudaMemcpy(C,P,sizeof(int)*n,cudaMemcpyDeviceToHost);

	printf("\n\nOutput:\n");

	for(i=0; i<n; i++)
		printf("%d \t",C[i]);
	printf("\n");

	cudaFree(N);
	cudaFree(M);
	cudaFree(P);
	getch();
	return 0;
}
*/

/* OUTPUT - 


Elements in A:
1       2       3       4       5       6       7       8

Elements in B:
1       2       3       4       5

Output:
26      40      55      70      85      100     70      44


*/