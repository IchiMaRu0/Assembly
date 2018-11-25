#include <stdio.h>
#include <stdlib.h>
int ans[9];
int num=0;

void print(){
	for(int j=1;j<=8;j++)
		printf("%i ",ans[j]);
	printf("\n");
	num++;
}

void queen(int i){
	if(i>8){
		print();
		return;
	}	
	for(int j=1;j<=8;j++){
		int k;
		for(k=1;k<i;k++){
			if(ans[k]==j || i-k==abs(ans[k]-j))
				break;
		}
		if(k==i){
			ans[i]=j;
			queen(i+1);
		}
	}
}

int main(){
	queen(1);
	printf("%i\n", num);
	return 0;
}