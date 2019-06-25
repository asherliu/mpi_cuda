#include "adder.cuh"

__global__ void adder(int *a, int *b, int *res, int count)
{
	int tid = threadIdx.x + blockIdx.x*blockDim.x;

	while(tid < count)
	{
		res[tid] = a[tid] + b[tid];
		tid += blockDim.x * gridDim.x;
	}

	return;
}

void adder(int *a, int *b, int *res, int count, int threadcount, int blockcount)
{

	int *a_d, *b_d, *res_d;
	cudaMalloc((void **)&a_d, sizeof(int)*count);
	cudaMalloc((void **)&b_d, sizeof(int)*count);
	cudaMalloc((void **)&res_d, sizeof(int)*count);

	cudaMemcpy(a_d, a, sizeof(int)*count, cudaMemcpyHostToDevice);
	cudaMemcpy(b_d, b, sizeof(int)*count, cudaMemcpyHostToDevice);
	adder<<<threadcount, blockcount>>>(a_d, b_d, res_d, count);
	
	cudaMemcpy(res, res_d, sizeof(int)*count, cudaMemcpyDeviceToHost);

	return;
}
