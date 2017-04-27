/*
#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <conio.h>
#include <stdio.h>

__constant__ int d_m[6];

__global__ void convolution(int *N,int *P,int maskwidth,int width)
{
    int i =blockIdx.x*blockDim.x+ threadIdx.x;
	int pvalue=0;
	int startpt=i-(maskwidth/2);

	for(int j=0;j<maskwidth;j++)
	{
          if(startpt+j >=0 && startpt+j<width)
		{
              pvalue+=N[startpt+j]*d_m[j];
		}
	}
	P[i]=pvalue;
}
 
int main()   
{
       int i,n1=6,mw=3,n[6]={1,2,3,4,5,6},m[3]={1,2,3},p[6],*n_d,*p_d;
       int size=sizeof(int)*n1;

	   printf(" ORIGINAL ARRAY \n");
	   for(i=0;i<6;i++)
	       printf("%d \t",n[i]);

	   printf("\n MASK ARRAY \n");
	   for(i=0;i<3;i++)
	       printf("%d \t",m[i]);

	cudaMalloc((void**)&n_d,size);
       cudaMalloc((void**)&p_d,size);
       cudaMemcpy(n_d,n,size,cudaMemcpyHostToDevice);
               cudaMemcpyToSymbol(d_m,m,size);

		//cudaMemcpy(p_d,p,size,cudaMemcpyHostToDevice);

		convolution<<<1,n1>>>(n_d,p_d,mw,n1); 
        cudaMemcpy(p,p_d,size,cudaMemcpyDeviceToHost);

		printf("\n Array after convolution is:\n");

        for(i=0;i<n1;i++)
	       printf("%d \t",p[i]);

        cudaFree(n_d);
		cudaFree(d_m);
		cudaFree(p_d);
		getch();
		return 0;
}
*/

/* OUTPUT -

 ORIGINAL ARRAY
1       2       3       4       5       6
 MASK ARRAY
1       2       3
 Array after convolution is:
8       14      20      26      32      17


*/
