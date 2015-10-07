#include <stdlib.h>
#include <stdio.h>

int main(void) {
  int i = 0;
  FILE *f1 = NULL, *f2 = NULL;
  char buf[150] = {0}, link[150] = {0};
  f1 = fopen("ls.txt","r");
  f2 = fopen("list_sources.txt","w");
  while(!feof(f1)) {
    fgets(buf,150,f1);
    if(sscanf(buf,"Download:%s",link) > 0)
       fprintf(f2,"%s\n",link);
    for(i=0;i<150;i++)
      link[i] = '\0';
  }
  fclose(f1);
  fclose(f2);
  return 0;
}
