#include <stdio.h>

int result=0;

int fibonacci(int i){
	if(i<=2){
		result=1;
	}
	else{
		result=fibonacci(i-1);
		int b=result;
		result=fibonacci(i-2);
		result+=b;
	}
	return result;
}

int main(){
	for(int i=1;i<=30;i++){
		printf("%i\n",fibonacci(i));
	}
}