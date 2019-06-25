# MPI and CUDA Mixed Programming and Compiling

-----
Program
------
- **adder.cu**: Adder function implemented by CUDA, as well as the c++ wrapper of the CUDA function;
- **adder.cuh**: Header file of the wrapper file, used by main.cpp;
- **main.cpp**: Main function implemented by MPI;

------
Compile
----------
- make

- **Makefile**: This is a very good Makefile for beginners. 

- **Flag**: *-lcudart* and *$"(shell dirname $(shell which nvcc))"/../lib64/* will connect the MPI based c/c++ compiler to CUDA compiler.

-----
Run
--------
- make run

------
Contact
--------

Hang Liu: asher.hangliu@gmail.com
