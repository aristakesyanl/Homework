#include<unistd.h>
#include<sys/stat.h>
#include<sys/types.h>
#include<sys/shm.h>
#include<errno.h>
#include<stdio.h>
#include<sys/wait.h>
#include<stdlib.h>
#include<sys/mman.h>
#include<iostream>
#include<string.h>
//typedef function pointer
typedef void (*FP) ();

void func1(){

	std::cout<<"Test1"<<std::endl;
	return;
}
void func2(){
	std::cout<<"Test2"<<std::endl;
	return;
	
}

void* CreateSharedMemory(size_t size){
	int protection=PROT_READ | PROT_WRITE;
	int visibility=MAP_SHARED | MAP_ANONYMOUS;
	return mmap(NULL, size, protection, visibility, -1, 0);
}

int Test(FP arr[], int N){
	if(N<1){
		std::cerr<<"Not enough information provided"<<std::endl;
		return -1;
	}
	void* shmID=CreateSharedMemory(1024);
	if(shmID==MAP_FAILED){
		std::cerr<<"Failed to create shared memory"<<std::endl;
		return -2;
	}

    //copy arr to shared memory
    memcpy(shmID,arr, sizeof(arr[0])*N);

    //for each function to test create a process
    for(int i=0; i<N; i++){
	    int pid=fork();
	    if(pid==-1){
	    	std::cerr<<"Failed to create child process"<<std::endl;
	    	return -3;
	    }
	    if(pid==0){
	    	//call function through function pointer
	    	arr[i]();
	    }
	    else{
	    	sleep(1);
	    }
    }
    return 0;
}

int main(int argc, char* argv[]){
	FP arr[]={func1,func2};
	Test(arr,2);
}
