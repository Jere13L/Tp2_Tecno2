import fisica.*;

FWorld world;
ArrayList<FCircle> circles;
FBox platform;
FBox platform1;

void setup() {
  size(displayWidth, displayHeight);
  Fisica.init(this);

  world = new FWorld();
  world.setEdges();
  world.setGravity(0, 500); // Ajusta la gravedad en el eje y según tus necesidades
  
  circles = new ArrayList<FCircle>();

  platform = new FBox(200, 20); // Crea una plataforma con ancho de 200 y alto de 20
  platform.setPosition(120, 350); // Posición de la plataforma en la parte inferior
  platform.setStatic(true); // Hace que la plataforma sea estática y no se vea afectada por la gravedad
  world.add(platform); // Agrega la plataforma al mundo físico
  platform1 = new FBox(200,20);
  platform1.setPosition(1750, 350);
  platform1.setStatic(true);
  world.add(platform1);
  FCircle circulostatico = new FCircle(50);
  world.add(circulostatico);
  circulostatico.setPosition(130,300);
  circulostatico.setDensity(1.0);
  circles.add(circulostatico);
  circulostatico.setStatic(true);
}

void draw() {
  background(255);

  world.step();
  world.draw();
}

void mousePressed() {
  FCircle newCircle = new FCircle(50);
 
  newCircle.setDensity(1.0);
  world.add(newCircle);
  newCircle.setPosition(mouseX, mouseY);
  circles.add(newCircle);

  for (FCircle circle : circles) {
    if (circle != newCircle) {
      FDistanceJoint joint = new FDistanceJoint(newCircle, circle);
     // joint.setLength(100);
      world.add(joint);
    }
  }
}
