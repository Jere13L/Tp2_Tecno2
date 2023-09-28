// Youtube 
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;



import fisica.*;
import java.util.ArrayList;
import oscP5.*;
OscP5 osc;

Minim minim;
//COPIAR
AudioPlayer pinguino;
AudioPlayer Fondo;
AudioPlayer ganar;
AudioPlayer perder;

PImage Pinguino,Plataforma;
//LISTO
boolean dedosTocandose = false; //Declaracion de la variable global

PhysicsSimulation physics;
Handpose handpose;
VictoryArea victoryArea;
DefeatArea defeatArea;

int estadoJuego = 0; // 0 para la pantalla de inicio, 1 para el juego en curso

void setup() {
  fullScreen();
  
  Plataforma = loadImage("plataforma.png");
  Pinguino = loadImage("pinguino1.png");
  
  minim = new Minim (this);
  Fondo = minim.loadFile("Fondo.mp3", 2048);
  Fisica.init(this);
  physics = new PhysicsSimulation();
   handpose = new Handpose(); // Crear una instancia de la clase Handpose
 //handpose.Handpose(); // Llamar al constructor de Handpose si es necesario
 
  float platform1X = displayWidth - 120;
  float platform1Y = 350;

  victoryArea = new VictoryArea(platform1X - 100, platform1Y - 40, 200, 20);
  defeatArea = new DefeatArea(0, height - 20, width, 20);

}

void draw() {
  background(255);
   if (estadoJuego == 0) {
         if (Fondo.isPlaying())
    {
     
    } else {
       Fondo.loop();
    }
      PVector pulgar = handpose.getPulgar();
      PVector indice = handpose.getIndice();
      ellipse(pulgar.x, pulgar.y, 10, 10);
      ellipse(indice.x, indice.y, 10, 10);

    // Dibujar el rectángulo en el centro de la pantalla
    rect(200, 200, 200, 200);

    // Acceder a las variables pulgar e indice de la instancia de Handpose

    // Verificar si el círculo (pulgar o índice) está dentro del rectángulo
    boolean colisionPulgar = (pulgar.x >= 200 && pulgar.x <= 400 && pulgar.y >= 200 && pulgar.y <= 400);
    boolean colisionIndice = (indice.x >= 200 && indice.x <= 400 && indice.y >= 200 && indice.y <= 400);

    // Si hay una colisión, cambia el estado a 1
    if (colisionPulgar || colisionIndice) {
      estadoJuego = 1;
    }
  } else if (estadoJuego == 1) {
    // Lógica y dibujo del juego en curso
    physics.update();
    handpose.dibujar();
  }

  victoryArea.display();
  defeatArea.display(); // Mostrar el área de derrota// Mostrar el área de victoria

    // Verificar si se ha alcanzado la victoria
  victoryArea.checkForVictory(circles);
  defeatArea.checkForDefeat(circles);
}


void mousePressed() {
  physics.addDynamicCircle(mouseX, mouseY);
}
