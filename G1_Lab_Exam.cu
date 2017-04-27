/*
#ifndef __CUDACC__
#define __CUDACC__
#endif
#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <cuda.h>
#include <stdio.h>
#include <device_functions.h>
#include <string.h>


__global__ void whatever(char  *d_a,char *d_res,int len)
{
	int i=0;
	int flag=1;
	int in=blockIdx.x*blockDim.x+threadIdx.x;


	if(d_a[in]==' ')
		d_res[in]='f';
	else if((d_a[in]>=65 && d_a[in]<=90)||(d_a[in]>=97 && d_a[in]<=122))
		d_res[in]='f';
	else
	{
		for(i=in-1;i>=0 && d_a[i]!=' ';i--)
		{
			if((d_a[i]>=65 && d_a[i]<=90)||(d_a[i]>=97 && d_a[i]<=122))
			{
				flag=0;
				break;
			}
		}

		if(flag==0)
			d_res[in]='f';
		else
			d_res[in]='t';

	}

}



int main()
{
	int i;
	char h_a[1000];
	char h_res[1000];
	char *d_a;
	char *d_res;

	printf("Enter the string: \n");
	gets(h_a);

	//puts(h_a);


	int len=strlen(h_a);

	int size=sizeof(char)*len;

	cudaMalloc((void **)&d_a,size);
	cudaMalloc((void **)&d_res,size);

	cudaMemcpy(d_a,h_a,size,cudaMemcpyHostToDevice);

	whatever<<<1,len>>>(d_a,d_res,len);

	cudaMemcpy(h_res,d_res,size,cudaMemcpyDeviceToHost);

	printf("OUTPUT :\n");

	for(i=0;i<len;i++)
		printf("%c, ",h_res[i]);

	printf("\n\n");

	cudaFree(d_a);
	cudaFree(d_res);


}
*/