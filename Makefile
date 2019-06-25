exe=mpi_test.bin

#commflags=-lcudart -L/sw/summit/cuda/10.1.105/lib64
cucc= "$(shell which nvcc)"
cc= "$(shell which mpicxx)"
#cuflags= -arch=sm_35  $(commflags) #-Xptxas -dlcm=cg#disable l1 cache
#cuflags+=-D__VOTE__
commflags=-lcudart -L"$(shell dirname $(cucc))"/../lib64
cuflags= --compiler-options -Wall -Xptxas -v -Xcudafe -\# --resource-usage 


ifeq ($(debug), 1)
	cuflags+= -G -g -O0
	cflags += -g -O0
else
	cflags += -O3
	cuflags+= -O3
endif

objs	= $(patsubst %.cu,%.o,$(wildcard *.cu)) \
	$(patsubst %.cpp,%.o,$(wildcard *.cpp))

deps	= $(wildcard ./*.cuh) \
		  Makefile

%.o:%.cu $(deps)
	$(cucc) -c $(cuflags) $< -o $@

%.o:%.cpp $(deps)
	$(cc) -c  $< -o $@

$(exe):$(objs)
	$(cc) $(objs) $(commflags) -o $(exe)

test:$(exe)
	mpirun -n 1 -host localhost $(exe)
clean:
	rm -rf *.o generator/*.o ${exe}


