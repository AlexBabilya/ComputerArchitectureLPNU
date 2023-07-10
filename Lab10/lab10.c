#include <stdio.h>
#include <math.h>

int main()
{
	double result=0, a = 4.5, c = 1.7, d = 3.8;
	if (a > (c * d))
		result = 5 * c - d * a + sqrt(fabs(36 * d - 4));
	else 
		result = sqrt(fabs(3 - a / 9 + 7 * d));
	printf("%lf", result);
	return 0;
}
