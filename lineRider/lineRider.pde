//Final project!
//Final project!
//fields
//LineRiderGame game;
PFont font;
PImage openingImage;
Rider guy;
Vehicle bike; 
Track t = new Track();
Boolean doneWithTrack = false;
Boolean started = false;
Boolean stopped = false;
Boolean exitTitle = false;
//Boolean restart = false;
Boolean clear = false;
LineRiderGame game = new LineRiderGame(100, 100);
class LineRiderGame{
  Rider guy;
  float startX, startY;
  String time;
  //i also made gravity val a field for the rider. but maybe rider should be
  //made by lineRiderGame?
  //i decided to make massChar and energyTotal fields for the Rider
  //since the game board itself isn't really affected by that, and Rider
  //is a parameter in the constructor not made by the game itself (can be changed)
  LineRiderGame(float startX, float startY){
    this.startX = startX;
    this.startY = startY;
    //assuming gravity will be 9.81
    //should this be calculated from the first platform or from the ground?
    //float GPE = 9.81 * 50.0 * (height - startY); 
    guy = new Rider(50, 20, startX, startY, 0.0, 0.0, t);
  }
  void display(){
    time = "" + (millis() /1000) ;
    text(time, 700, 50);      textSize(20);
    fill(85, 160, 74);
    text("time: " + time, 1100, 50);
    fill(188, 188, 55);
    pushMatrix();
    translate(1100, 700);
    rotate(frameCount / -100.0);
    star(0, 0, 30, 70, 5); 
    popMatrix();

  }
}

void keyPressed(){
   if (key ==  CODED){
     if (keyCode == SHIFT){// if the track is finished, this will become true. Helps so that the rider doesn't fall until track is done. basically starts the game
        doneWithTrack = true; 
        t.finalizeConnections();
        System.out.println();
     }
   }
   if (key == BACKSPACE || key == DELETE){
       if (!doneWithTrack){
         t.track.remove(t.track.size()-1);
         t.track.remove(t.track.size()-1);
         t.track.remove(t.track.size()-1);
         t.track.remove(t.track.size()-1); //remove the last four points
       }
   }
   if (key == 's'){
    stopped = true; 
   }
   if (key == 'e'){
    t.finalizeConnections();
    stopped = false; 
   }
   if (key == 'q'){ //put at top of game
    //restart = false; 
    setup();
   }
   if (key == 'c'){ //clear and put at top
    //clear = true; 
   }
   if (key == '1'){
     t.type = 1;
   }
   if (key == '2'){
     t.type = 2;
   }
   if (key == '3'){
     t.type = 3;
   }
}



void setup(){
  size(1200, 800);
  t = new Track();
  font = loadFont("ArialRoundedMTBold-32.vlw");
  openingImage = loadImage("opening.png");
  doneWithTrack = false;
  started = false;
  stopped = false;
  //restart = false;
  clear = false;
  game = new LineRiderGame(100, 100);
}

void draw(){
  background(255);
 // t.display();
  if (doneWithTrack && !stopped && !clear){
    if (!started){
       game.guy.timeCounter = 0;
       started = true;
    }
    game.guy.move();
    game.guy.framer = frameRate;
  }
  if (exitTitle){
    t.display();
    game.display();
    game.guy.display();
  }else{
    //make the button
   pushMatrix();
   translate(450, 600);
   fill(226, 170, 234);
   rect(0, 0, 300, 80, 10, 10, 10, 10);
   fill(5, 5, 5);
   //textSize(32);
   textFont(font, 32);
   text("Click Here to Play", 11, 50);
   popMatrix();
   //make the border
   fill(226, 170, 234);
   rect(10, 10, 1180, 20);
   rect(10, 770, 1180, 20);
   
   //put lineRider
   image(openingImage, 300, 200);
  }
    
}
//i feel like this should be part of the 
//rider class, it will take in a Track as a paramtere
//and just do all this inside of the rider class 
public boolean isPartOf(Float a, Float b){
  for (int i = 0; i < t.track.size() - 3; i+= 4){
    Float x1 = t.track.get(i);
    Float y1 = t.track.get(i + 1);
    Float x2 = t.track.get(i + 2);
    Float y2 = t.track.get(i + 2);
    Float slope = (y2 - y1) / (x2 - x1);
    if (((x1 <= a && x2 >= a) || (x1 >= a && x2 <= a)) && ((y1 <= b && y2 >= b) || (y1 >= b & y2 <= b))){
      if ((y1 - b) == slope * (x1 - a)){
         return true; 
      }
    }
  }
  return false;
}

void mouseClicked(){
 if (exitTitle){      
   if (!doneWithTrack || stopped){
     t.add(mouseX + 0.0, mouseY + 0.0);          
     //t.add(mouseX + 0.0, mouseY + 0.0); 
    }
  }else{ 
   if(mouseX < 750 && mouseX > 450 && mouseY < 700 && mouseY > 500){
    exitTitle = true; 
   }
  } 
}  

//not ours, from a processing example
void star(float x, float y, float radius1, float radius2, int npoints) {
    float angle = TWO_PI / npoints;
    float halfAngle = angle/2.0;
    beginShape();
    for (float a = 0; a < TWO_PI; a += angle) {
      float sx = x + cos(a) * radius2;
      float sy = y + sin(a) * radius2;
      vertex(sx, sy);
      sx = x + cos(a+halfAngle) * radius1;
      sy = y + sin(a+halfAngle) * radius1;
      vertex(sx, sy);
    }
    endShape(CLOSE);
} 
