import processing.serial.*;            //importa la libreria para comunicacion puerto serie
Serial port;                           //declara la variable port

int ancho=screen.width;                //medidas escenario
int alto=screen.height;

int components = 9;                    //numero de componentes

int[] getData = new int[components];   //valores entrantes
int DataCheck = 0;                     //contador de cuantos bytes nos llegan

float valPot1;                         //variable posicion x / float para calcular el ancho
float valPot2;                         //variable posicion y / float para calcular el alto

float factDespX;                       //factor de desplazamiento x
float factDespY;                       //factor de desplazamiento y

int valFactDespX;                      //almacena valor con redondeo
int valFactDespY;                      //almacena valor con redondeo

int valPot3;                           //variable Pot3
int valPot4;                           //variable Pot4
int valPot5;                           //variable Pot5

int valButton1;                        //variable del Button1 pin7
int valButton2;                        //variable del Button2 pin6
int valButton3;                        //variable del Button3 pin5
int valButton4;                        //variable del Button4 pin4

boolean data = false; 

float Pot1 = (getData[0]*factDespX);   //valores del potenciometro sin redondeo
float Pot2 = (getData[1]*factDespY);   //valores del potenciometro2 sin redondeo
int Pot3 = (getData[2]);               //valores del potenciometro3
int Pot4 = (getData[3]);               //valores del potenciometro4
int Pot5 = (getData[4]);               //valores del potenciometro5

int Button1 = (getData[5]);            //valores del Button1
int Button2 = (getData[6]);            //valores del Button2
int Button3 = (getData[7]);            //valores del Button3
int Button4 = (getData[8]);            //valores del Button4

void serialEvent(Serial port) {        //funcion que se ejecuta cada vez que entra un dato
  if (data == false) {                 //si no llegan datos
    data = true;
  }
  
  //valores de los potenciometros
  Pot3=valPot3;
  Pot4=valPot4;
  Pot5=valPot5;

  //calcula el factor de desplazamiento X e Y para valores de entrada entre 0 a 255
  factDespX=ancho/255.0; 
  factDespY=alto/255.0;

  // Anhade el ultimo byte desde el puerto serie al array:
  getData[DataCheck] = port.read();
  DataCheck++;

  // Si tenemos 6 bytes:
  if (DataCheck >components-1 ) {    
    valPot1 = ((getData[0]*factDespX)); //posicion de la X sin redondeo y con desplazamiento
    valFactDespX=round(valPot1);        //Redondea la posicion de la X

    valPot2 = ((getData[1]*factDespY)); //posicion de la Y sin redondeo y con desplazamiento
    valFactDespY=round(valPot2);        //Redondea la posicion de la Y

    valPot3 = getData[2];               //POTENCIOMETRO3
    valPot4 = getData[3];               //POTENCIOMETRO4
    valPot5 = getData[4];               //POTENCIOMETRO5

    valButton1 = getData[5];            //PULSADOR1
    valButton2 = getData[6];            //PULSADOR2
    valButton3 = getData[7];            //PULSADOR3
    valButton4 = getData[8];            //PULSADOR4

    port.write(65);                     //envia la letra A para tomar nuevos valores
    DataCheck = 0;                      //pone el contador a 0
  }
  //valores por consola
  println("ancho x alto: "+ ancho+ "x"+ alto);
  println("factor de desplazmiento x: "+ factDespX);
  println("factor de desplazmiento y: "+ factDespY);

  println("Pot1 sin redondeo "+ Pot1); 
  println("valFactDespX > Pot1 con el factor de desplazamiento y redondeo: "+ valFactDespX);
  println("Pot2 sin redondeo "+ Pot2);
  println("valFactDespY > Poy2 con el factor de desplazamiento y redondeo: "+ valFactDespY);
  println("Pot3: "+ Pot3);
  println("Pot4: "+ Pot4);
  println("Pot5: "+ Pot5);

  println("valButton1 valor del boton Hight 72 H o Low 76 L: "+ valButton1);
  println("valButton2 valor del boton Hight 72 H o Low 76 L: "+ valButton2);
  println("valButton3 valor del boton Hight 72 H o Low 76 L: "+ valButton3);
  println("valButton4 valor del boton Hight 72 H o Low 76 L: "+ valButton4);
}

