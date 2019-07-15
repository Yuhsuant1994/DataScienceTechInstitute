#include "Header.h"
void Mamal::initialise()
{
	//this->weight = 0;
	//this->voicePitch = 0;
	weight = 0;
	voicePitch = 0;
};


Mamal::Mamal()
{
	initialise();
}

Mamal::Mamal(string name)
{
	initialise();
	this->name = name;
};


void Mamal::setName(string name) {
	this->name = name;
}
Dog::Dog(string name) :Mamal(name)
{
	//if name is a private attribute of the mother class Mamal
	// it's not accessible in the context of Dog (child class)
	// this->name = name;

	//if name is private in Mamal, we must use the relevant
	//Mamal constructor by substituting the Mamal default xtor call
	//this is done in C++ via an initialiser (see method call above)

}

Cat::Cat(string name) :Mamal(name){}

void Dog::talk()
{
	cout << "I'm a dog, bark, bark, and my name is " << getName() << endl;
}

void Cat::talk()
{
	cout << "I'm a cat, miaow, miaow, and my name is " << getName() << endl;
}