#include <stdio.h>
#include <math.h>

int main()
{
	double a = 4.5, c = 1.7, d = 3.8, c1 = 5.0, c2 = 36.0, c3 = 4, c4 = 3, c5 = 9, c6 = 7.0,
	result;
	result = ((c1 * c - d * a) + sqrt(c2 * d - c3)) / (c4 - a / c5 + c6 * d);
	printf("Result: %lf", result);
	return 0;
}
