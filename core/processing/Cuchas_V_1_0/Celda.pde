/*
 * CUCHAS V 1.0
 * -------------------------------------------------------------
 * 
 * visualizacion grafica a partir de interactuacion con cuchas
 * Para generar pdf pulsar A (para inicializar) y Z (para salir)
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

class Celda{
  float x;
  float y;

  int dia;

  int r;
  int g;
  int b;

  //Constructor
  Celda(float posX,float posY, int diametro, int rojo, int verde, int azul){
    this.x = posX;
    this.y = posY;

    this.dia = diametro;

    this.r = rojo;
    this.g = verde;
    this.b = azul;
  }
  void display(){
    rectMode(LEFT);
    this.circle();
  }
  void circle(){
    noStroke();

    rectMode(CENTER); //centrar los dos dibujos
    fill(r,g,b,20);

    rect(x,y,dia*2,dia*2);
    ellipse(x,y,dia,dia);

    if((r==255)||(g==255)||(b==255)){ //si el valor del Red,Green,Blue es 255
      ellipse(x,y,30,30);
      stroke(r,g,b,10);
    }
    else if((r<150)&&(r>0)){ //si el valor del Red esta entre 0 y 150
      stroke(r,34,34,20);
      for (int xCurve=0;xCurve<x; xCurve++){
        //valor,min,max
        float n =norm(xCurve,0.0,x);
        float yCurve = pow(n,0.4);
        yCurve*=y;

        stroke(r,g,b,20);

        point(xCurve,yCurve);
      }

      int radio=5*dia;
      for (int deg=0;deg<360;deg+=30){

        float angle=radians(deg);
        float xcir=x+(cos(angle)*radio);
        float ycir=y+(sin(angle)*radio);
        ellipse(xcir,ycir,5,5);
      }
    }
  }   
}

