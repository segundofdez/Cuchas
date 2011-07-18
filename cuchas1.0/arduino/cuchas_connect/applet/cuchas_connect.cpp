#include "WProgram.h"
/*
 * CUCHAS V 1.0
 * ------------------------------------------------------
 * Cuchas_connect: cargar en arduino
 * Primer prototipo compuesto por: 
 * 5 potenciometros y 4 pulsadores
 * comparte valores con processing via serial
 * Probado en arduino (Diecimila)
 * ------------------------------------------------------ 
 * + info
 * http://www.sond3.com | http://www.vidagrafica.com
 * 2008-2011 (c) Segundo Fdez 
 * info@sond3.com
 * ------------------------------------------------------
 Este obra esta bajo una licencia Creative Commons Reconocimiento-NoComercial-CompartirIgual 3.0 Unported.
 http://creativecommons.org/licenses/by-nc-sa/3.0/

 No se permite un uso comercial de la obra original ni de las posibles obras derivadas, 
 la distribucion de las cuales se debe hacer con una licencia igual a la que regula la obra original. 
 */

// POTENCIOMETROS
void setup();
void loop();
int pinPotX=1;  // pines de entrada analogica potenciomentro control eje X
int pinPotY=0;  // pines de entrada analogica potenciomentro control eje Y

int pinPotR=2;  // pines de entrada analogica potenciametro color R
int pinPotG=3;  // pines de entrada analogica potenciametro color G
int pinPotB=4;  // pines de entrada analogica potenciametro color B

// PULSADORES
int pinBoton1=7;  // pin entrada digital del boton 1
int pinBoton2=6;  // pin entrada digital del boton 2
int pinBoton3=5;  // pin entrada digital del boton 3
int pinBoton4=4;  // pin entrada digital del boton 4

int inByte = 0;   // valor entrante de Processing

// VALORES DE LOS POTENCIOMETROS: almacena los valores de entradas analogicas
int valPotX=0;
int valPotY=0;
int valPotR=0;
int valPotG=0;
int valPotB=0;

// VALORES DE LOS PULSADORES: almacena los valores de entradas digitales
int valBoton1=0;
int valBoton2=0;
int valBoton3=0;
int valBoton4=0;

int potX=0; // las variables que dividiran y seran mandadas por serial
int potY=0;
int potR=0;
int potG=0;
int potB=0;

void setup(){
  Serial.begin(9600); // abre la conexion con el puerto serie
}

void loop(){

  if (Serial.available() > 0) {        // si llega algun dato de processing
    inByte = Serial.read();            // lo lee

    valPotX=analogRead(pinPotX);       // lee el valor del potenciometro X
    valPotY=analogRead(pinPotY);       // lee el valor del potenciometro Y

    valPotR=analogRead(pinPotR);       // lee el valor de los potenciometros
    valPotG=analogRead(pinPotG);
    valPotB=analogRead(pinPotB);

    valBoton1=digitalRead(pinBoton1);  // lee el valor de los pulsadores
    valBoton2=digitalRead(pinBoton2);
    valBoton3=digitalRead(pinBoton3);
    valBoton4=digitalRead(pinBoton4);

    potX=(valPotX/4);                  // dividimos los valores entre 4
    potY=(valPotY/4);

    potR=(valPotR/4);
    potG=(valPotG/4);
    potB=(valPotB/4);

    Serial.print(potX,BYTE);           // los imprimimos
    Serial.print(potY,BYTE);
    Serial.print(potR,BYTE);
    Serial.print(potG,BYTE);
    Serial.print(potB,BYTE);

    if (valBoton1)
      serialWrite('H'); // hight si esta pulsado boton 1
    else 
      serialWrite('L'); // sino Low
    delay(50);

    if (valBoton2)
      serialWrite('H'); // hight si esta pulsado boton 2 
    else 
      serialWrite('L'); // sino Low
    delay(50);

    if (valBoton3)
      serialWrite('H'); // hight si esta pulsado boton 3 
    else 
      serialWrite('L'); // sino Low
    delay(50);

    if (valBoton4)
      serialWrite('H'); // hight si esta pulsado boton 4
    else 
      serialWrite('L'); // sino Low
    delay(50);
  }

}

int main(void)
{
	init();

	setup();
    
	for (;;)
		loop();
        
	return 0;
}

