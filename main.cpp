#include <stdio.h>
#include <string.h>
#include <mpi.h>
#include "adder.cuh"
#include <stdlib.h>
#include <assert.h>
#include <iostream>

int main(int argc, char *argv[])
{
    char message[20];
    int myrank, tag=99;
    MPI_Status status;

    /* Initialize the MPI library */
    MPI_Init(&argc, &argv);
    /* Determine unique id of the calling process of all processes participating
 *        in this MPI program. This id is usually called MPI rank. */
    MPI_Comm_rank(MPI_COMM_WORLD, &myrank);
	
	int count = 128;
	int threadcount=128;
	int blockcount=128;

	int *a = new int [count];
	int *b = new int [count];
	int *res = new int [count];
	int *res_cpu = new int [count];
	
	for(int i = 0; i < count; i ++)
	{
		a[i]=rand()%(myrank+4);
		b[i]= rand()%(myrank + 6);
		res_cpu[i]=a[i]+b[i];
	}
	
	
	adder(a, b, res, count, threadcount, blockcount);
	
	//for(int i = 0; i < count; i ++)
	//{
	//std::cout<<"cpu vs gpu:"<<res_cpu[i]<<" "<<res[i]<<"\n";
	//}
	if(0==memcmp(res_cpu, res, sizeof(int)*count))
		std::cout<<"Succeed\n";

    /* Finalize the MPI library to free resources acquired by it. */
    MPI_Finalize();
    return 0;
}
