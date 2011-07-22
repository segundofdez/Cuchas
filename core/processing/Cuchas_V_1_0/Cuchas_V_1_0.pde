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

import pitaru.sonia_v2_9.*; //importa la libreria sonia para el sonido

import processing.pdf.*; //importa la libreria para exportar como pdf

import processing.serial.*; //importa la libreria para comunicacion puerto serie
Serial port; //declara la variable port

Celda miCelda; //declara el objeto miCelda

Sample[] Samples = new Sample[5]; //declara el objeto mySample con el segundo sonido

int componentes = 9;  //numero de componentes

int[] datosEntrantes = new int[componentes]; //aqui pondremos lo que nos llega
int cuantosDatos = 0; //contador de cuantos bytes nos llegan

float valPosX;  //variables posicion x / float para calcular el ancho
float valPosY;  //variables posicion y / float para calcular el alto

float factDespX; //factor de desplazamiento x
float factDespY; //factor de desplazamiento y

int valFactDespX; //almacena valor con redondeo
int valFactDespY; //almacena valor con redondeo

int valRed; //variable color R
int valGreen; //variable color G
int valBlue; //variable color B

int valBoton1; //variable del boton1 pin7
int valBoton2; //variable del boton2 pin6
int valBoton3; //variable del boton3 pin5
int valBoton4; //variable del boton4 pin4

boolean hayDatos = false; 

int ancho=screen.width; //medidas escenario
int alto=screen.height;

void setup() {
  size(ancho, alto);

  Sonia.start(this); //arranca Sonia

  Samples[0] = new Sample("base.wav"); //declara los sonidos
  Samples[1] = new Sample("piano.wav");
  Samples[2] = new Sample("bass.wav");
  Samples[3] = new Sample("atmos.wav");
  Samples[4] = new Sample("flute.wav");

  Samples[0].repeat();

  factDespX=ancho/255.0; //calcula el factor de desplazamiento para valores de entrada entre 0 a 255
  factDespY=alto/255.0;

  background(0,0,0,10);
  noCursor();
  frameRate(30);

  println(Serial.list());
  port = new Serial(this, Serial.list()[0], 9600);
  port.write(65); // Envia un dato

}

void draw() {
  fill(0,0);
  noStroke();
  rect(0,0,ancho,alto);

  smooth();  //antialiasing

  float PotX = (datosEntrantes[0]*factDespX); //valores del potenciometro sin redondeo, controla EJE X
  float PotY = (datosEntrantes[1]*factDespY); //valores del potenciometro sin redondeo, controla EJE Y
  int PotR = (datosEntrantes[2]); //valores del potenciometro, color Red/rojo
  int PotG = (datosEntrantes[3]); //valores del potenciometro, color Green/verde
  int PotB = (datosEntrantes[4]); //valores del potenciometro, color Blue/azul

  int Boton1 = (datosEntrantes[5]); //valores del boton1
  int Boton2 = (datosEntrantes[6]); //valores del boton2
  int Boton3 = (datosEntrantes[7]); //valores del boton3
  int Boton4 = (datosEntrantes[8]); //valores del boton4

  if (hayDatos == false) { //si no hay datos envia uno
    port.write(65);
  }

  if(valBoton1=='H') {  //si el valor del boton es H ellipse, sino, nada
    Samples[1].repeatNum(1);   
    noStroke();
    fill(PotR,PotG,PotB,10);
    ellipse(valFactDespX,valFactDespY,50,50); //se desplaza en relacion a la posicion
  }
  if(valBoton2 =='H'){
    Samples[2].play(); 
    noStroke();
    fill(PotR,PotG,PotB,10);
    ellipse(valFactDespX,valFactDespY,150,150); //se desplaza en relacion a la posicion
    escribe();
  }
  if(valBoton3 =='H'){
    Samples[3].play();
    stroke(PotR,PotG,PotB,40);
    line(valFactDespX,valFactDespY,random(0,width),random(0,height));
  }
  if(valBoton4 =='H'){
    Samples[4].play(); 
    stroke(PotR,PotG,PotB,40);
    line(valFactDespX,valFactDespY,random(0,100),noise(0,width));
  }

  else{
    miCelda = new Celda(valPosX,valPosY,5,PotR,PotG,PotB); //construye el objeto
    miCelda.display(); //llama a la funcion display del objeto

  }
  
  //comprobar por consola
  println("Ancho x alto "+ ancho+ "x"+ alto);
  println("PotX eje X sin redondeo "+ PotX); 
  println("PotY eje Y sin redondeo "+ PotY);
  println("factor de desplazmiento x: "+ factDespX);
  println("factor de desplazmiento y: "+ factDespY);
  println("valPosX sin el factor de desplazamiento ni redondeo: "+ valPosX);
  println("valFactDespX con el factor de desplazamiento y redondeo: "+ valFactDespX);
  println("valFactDespX con el factor de desplazamiento y redondeo: "+ valFactDespY);
  println("PotR color Red "+ PotR);
  println("PotG color Green "+ PotG);
  println("PotB color Blue "+ PotB);
  println("valBoton1 valor del boton Hight 72 H o Low 76 L: "+ valBoton1);
  println("valBoton2 valor del boton Hight 72 H o Low 76 L: "+ valBoton2);
  println("valBoton3 valor del boton Hight 72 H o Low 76 L: "+ valBoton3);
  println("valBoton4 valor del boton Hight 72 H o Low 76 L: "+ valBoton4);
}

void serialEvent(Serial port) {  //funcion que se ejecuta cada vez que entra un dato
  if (hayDatos == false) {  //si no llegan datos
    hayDatos = true;
  }
  // Anhade el ultimo byte desde el puerto serie al array:
  datosEntrantes[cuantosDatos] = port.read();
  cuantosDatos++;

  // Si tenemos 6 bytes:
  if (cuantosDatos >componentes-1 ) {    
    valPosX = ((datosEntrantes[0]*factDespX)); //posicion de la X sin redondeo y con desplazamiento
    valFactDespX=round(valPosX); //Redondea la posicion de la X

    valPosY = ((datosEntrantes[1]*factDespY)); //posicion de la Y sin redondeo y con desplazamiento
    valFactDespY=round(valPosY); //Redondea la posicion de la Y

    valRed = datosEntrantes[2];  //RED
    valGreen = datosEntrantes[3];//GREEN
    valBlue = datosEntrantes[4]; //BLUE

    valBoton1 = datosEntrantes[5];  //PULSADOR1
    valBoton2 = datosEntrantes[6];  //PULSADOR2
    valBoton3 = datosEntrantes[7];  //PULSADOR3
    valBoton4 = datosEntrantes[8];  //PULSADOR4

    port.write(65); //envia la letra A para tomar nuevos valores

    cuantosDatos = 0; //pone el contador a 0
  }
}
// ESCRIBE LAS COORDENADAS
void escribe(){
  PFont font;
  font = loadFont("Futura-Medium-20.vlw");

  textFont(font);
  String txtX =str (valPosX);
  String txtY =str (valPosY);

  textSize(12);
  fill(255);

  text(txtX,valPosX+10,valPosY+5);
  text(txtY,valPosX+10,valPosY+20);
}

// GRABAR EN PDF CON TECLADO
void keyPressed() {
  if (key == 'A' || key == 'a') { // When 'A' or 'a' is pressed,
    beginRecord(PDF, "cuchas.pdf"); // start recording to the PDF
    background(0); // Set a black background
  } 
  else if (key == 'Z' || key == 'z') { // When 'Z' or 'z' is pressed,
    endRecord(); // stop recording the PDF and
    exit(); // quit the program
  }
}

// CERRAR SONIA DE FORMA SEGURA CUANDO CIERRA LA VENTANA
public void stop(){
  Sonia.stop();
  super.stop();
}


