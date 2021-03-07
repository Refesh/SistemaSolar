Planet sun, mercury, venus, earth, mars, jupiter, saturn, uranus, jupiterSat1, jupiterSat2, saturnSat1, saturnSat2, moon;
Planet[] jupiterSats, earthSats, saturnSats;
PImage background;
float scale = 1;
float minSize;

void setup()
{
  fullScreen(P3D);
  minSize = width/140;

  
  // distance, initAngle, rotationSpeed, revolutionSpeed, radius, img, name
  sun = new Planet(0, 0, 0, 0.3, minSize*5, loadImage("Textures/sun.jpg"), "Sun");
  venus = new Planet(minSize*14, 45, 2, 0.6, minSize*2, loadImage("Textures/venus.jpg"), "Venus");
  earth = new Planet(minSize*25, 80, 1, 0.4, minSize*2.5, loadImage("Textures/earth.jpg"), "Earth");
  mars = new Planet(minSize*33, -30, -1, 0.7, minSize*2, loadImage("Textures/mars.jpg"), "Mars");
  jupiter = new Planet(minSize*50, 160, 0.7, 0.4, minSize*4, loadImage("Textures/jupiter.jpg"), "Jupiter");
  saturn = new Planet(minSize*65, 280, 0, 0.5, minSize*3, loadImage("Textures/saturn.jpg"), "Saturn");
  
  jupiterSat1 = new Planet(minSize*5.5, 280, 0, 0.7, minSize*0.6, loadImage("Textures/ceres.jpg"), "");
  jupiterSat2 = new Planet(minSize*8, 120, 0, 1.2, minSize*1.2, loadImage("Textures/haumea.jpg"), "");
  
  jupiterSats = new Planet[2];
  jupiterSats[0] = jupiterSat1;
  jupiterSats[1] = jupiterSat2;
  
  saturnSat1 = new Planet(minSize*8, 50, 0, 1.5, minSize*0.4, loadImage("Textures/makemake.jpg"), "");
  saturnSat2 = new Planet(minSize*5.5, 120, 0, 1.2, minSize*1.7, loadImage("Textures/haumea.jpg"), "");
  
  saturnSats = new Planet[2];
  saturnSats[0] = saturnSat1;
  saturnSats[1] = saturnSat2;
  
  moon = new Planet(minSize*5.5, 280, 0, 0.7, minSize*0.6, loadImage("Textures/ceres.jpg"), "");
  
  earthSats = new Planet[1];
  earthSats[0] = moon;
  
  background = loadImage("Textures/background.jpg");
  background.resize(width, height);

}
 
void draw()
{
  background(background);
  textSize(minSize*1.5);
  text("Press esc to exit", minSize*3, minSize*3);
  textSize(minSize*1.2);
  text("Use mouse wheel to zoom in/out", minSize*3, height-minSize*3);
  
  textSize(minSize*1.5);
  rotateX(radians(-50));
  translate(width/2, height/2, 0);
  scale(scale);
  sun.display();
  venus.display();
  earth.display(earthSats);
  mars.display();
  saturn.display(saturnSats);
  jupiter.display(jupiterSats);
}

void mouseWheel(MouseEvent event) {
  if(event.getCount() > 0) scale = max(0.5, scale - 0.1);
  else scale = min(2, scale + 0.1);
}

class Planet{
  float distance;
  float revolutionSpeed;
  float rotationSpeed;
  float angle;
  float rotationAngle;
  float radius;
  PShape Planet;
  String name;
  
  Planet(float distance, float initAngle, float rotationSpeed, float revolutionSpeed, float radius, PImage img, String name){
    beginShape();
    Planet = createShape(SPHERE, radius);
    Planet.setStroke(255);
    Planet.setTexture(img);
    endShape(CLOSE);
    
    this.distance = distance;
    this.revolutionSpeed = revolutionSpeed;
    this.rotationSpeed = rotationSpeed;
    this.radius = radius;
    this.name = name;
    angle = initAngle;
  }
  
  void move(){
    angle = (angle + revolutionSpeed) % 360;
    rotationAngle = (rotationAngle + rotationSpeed) % 360;
  }
  
  
  void display(){
    pushMatrix();
    rotateY(radians(angle));
    translate(distance, 0, 0);
    
    pushMatrix();
    rotateY(-radians(angle));
    text(name, 0, -radius*2 - radius /7);
    popMatrix();
    
    rotateY(radians(rotationAngle));
    shape(Planet);
    popMatrix();
    move();
  }
  
  void display(Planet[] satellites){
    pushMatrix();
    rotateY(radians(angle));
    translate(distance, 0, 0);
    for(Planet s : satellites) s.display();
    
    pushMatrix();
    rotateY(-radians(angle));
    text(name, 0, -radius*2 - radius /7);
    popMatrix();
    
    rotateY(radians(rotationAngle));
    shape(Planet);
    popMatrix();
    move();
  }
}
