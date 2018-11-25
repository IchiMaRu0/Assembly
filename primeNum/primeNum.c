#include <stdio.h>
int main(){
	for(int i=2;i<=100;i++){
		for(int j=2;j<=i;j++){
			if(j==i)
				printf("%i\n",i);
			else if(i%j==0)
				break;
		}
	}
}