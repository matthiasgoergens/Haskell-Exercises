#include <stdio.h>

#define	MAXLINE	80	/* maximum input line size */ 

int getlinex(char line[], int maxline); 
void copy(char to[], char from[]);

/* print longest input line */ 

int main()

{
	int 	len;			/* current line length */ 
	int 	max;			/* maximum length seen so far */
	char 	line[MAXLINE];		/* current input line */
	char 	longest[MAXLINE];	/* longest line saved here */ 

	max = 0; 
	while ((len=getlinex(line, MAXLINE)) > 0)
		if (len > MAXLINE) { 
			copy (line, line);
		}
	//if (max > 0)	/* there was a line */ 
		//printf("%d\t%s", max, longest);
	return 0;
}

/* getlinex: read a line into s, return length */ 

int getlinex(char s[], int lim)
{
	int c, i = 0; 
	for (i=0; (c=getchar())!=EOF && c!='\n'; ++i) {
		s[i] = c;
	}
	if (c == '\n') {
		s[i] = c; 
		++i;
		s[i] = '\0';
	}
	else {
		s[i] = '\0';
		if(i >= lim - 1) {
			while((c = getchar())!=EOF && c!='\n')
				++i;
		}
	}
	return i;
}

/* copy: copy 'from' into 'to'; assume to is big enough */ 
void copy(char to[], char from[])
{
	int i; 

	i = 0;
	while ((to[i] = from[i]) != '\0')
		++i;
}

 
