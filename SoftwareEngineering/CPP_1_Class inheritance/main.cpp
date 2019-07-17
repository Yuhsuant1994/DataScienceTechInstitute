#include "Header.h"
int main()
{
	/*
	Mamal M1;
	Mamal M2("Prince");

	M1.setName("M1");
	M1 = M2;*/

	Dog D1("Dog1");
	D1.talk();

	Cat C1("Sandy");
	C1.setName("Rex");
	C1.talk();

	Mamal* maList[2];
	maList[0] = &D1;
	maList[1] = &C1;
	maList[0]->talk();
	maList[1]->talk();
	

	system("pause");
	return 0;
}
