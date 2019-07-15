#pragma once
#include <cstdlib>
#include <string>
#include <iostream> //for cout

using namespace std;

class Mamal {
private:
	string name;
	string color;
	double weight;
	double voicePitch;
	void initialise();
public:
	Mamal();
	Mamal(string name);
	void setName(string name);
	string getName() { return name; }
	//after setting virtual, Mamal cannot be call
	/*	

	void operator=(Mamal m) {
		this->name = m.name;
		this->color = m.color;
		this->weight = m.weight;
		this->voicePitch = m.voicePitch;
	}*/
	virtual void talk() = 0;
};

class Dog : public Mamal {
public:
	Dog() {};
	Dog(string name);
	void talk();
};

class Cat : public Mamal
{
public:
	Cat() {}
	Cat(string name);
	void talk();
};
