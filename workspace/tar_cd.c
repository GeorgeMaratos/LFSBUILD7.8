#include <stdlib.h>
#include <stdio.h>
#include <string.h>

void manipulate_string(char *buf2, char *buf) { //quick and dirty
  int str_len = strlen(buf), i = 0;
  for(i=0;i<str_len;i++) {
    if(buf[i] == '.') {
      if(i + 3 < str_len && buf[i+1] == 't' && buf[i+2] == 'a' && buf[i+3] == 'r') {
	for(;i<str_len;i++)
          buf2[i] = '\0';
      }
      else buf2[i] = buf[i];
    }
    else buf2[i] = buf[i];
  }
}
  
int main(void) {
  FILE *f1 = NULL, *f2 = NULL;
  char buf[50] = {0}, *buf2 = malloc(50);
  f1 = fopen("tc.txt","r");
  f2 = fopen("is.sh","w");
  fprintf(f2,"#! /bin/bash\nset -e\n\n");
  while(!feof(f1)) {
    fgets(buf,50,f1);
    fprintf(f2,"#%s\ntar xf %s",buf,buf);
    manipulate_string(buf2,buf);
    fprintf(f2,"cd %s\n\n",buf2);
  }
  fclose(f1);
  fclose(f2);
  return 0;
}
