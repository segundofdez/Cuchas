/*
 * CUCHAS TEST
 * -------------------------------------------------------------
 * CHECK CUCHAS INTERFACE
 * ------------------------------------------------------ 
 * + info
 * http://www.vidagrafica.com
 * 2008-2011 (c) Segundo Fdez 
 * info@vidagrafica.com
 * ------------------------------------------------------
 Este obra esta bajo una licencia Creative Commons Reconocimiento-NoComercial-CompartirIgual 3.0 Unported.
 http://creativecommons.org/licenses/by-nc-sa/3.0/

 No se permite un uso comercial de la obra original ni de las posibles obras derivadas, 
 la distribucion de las cuales se debe hacer con una licencia igual a la que regula la obra original. 
 */

void setup() {
  size(ancho, alto);
  noCursor();
  frameRate(30);
  
  println(Serial.list());
  port = new Serial(this, Serial.list()[0], 9600);
  port.write(65); // Envia un dato
}

void draw() {
  background(0);
  smooth();

  if (data == false) {                       //si no hay datos envia uno
    port.write(65);
  }

  //Basic interface
  fill(Pot3, Pot4, Pot5, 255);
  rect (0, 0, valFactDespX, valFactDespY);
  
  noFill();
  stroke(255);
  //si activamos los botones
  if (valButton1=='H') {
    ellipse (width/2, height/2, 50, 50);
  } 
  if (valButton2 =='H') {
    ellipse (width/2, height/2, 100, 100);
  }
  if (valButton3 =='H') {
    ellipse (width/2, height/2, 200, 200);
  }
  if (valButton4 =='H') {
    ellipse (width/2, height/2, 300, 300);
  }
  
}



