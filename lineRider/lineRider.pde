//Final project!
//Final project!
//fields
//LineRiderGame game;
Rider guy;
Vehicle bike; 
Track t = new Track();
Boolean doneWithTrack = false;
Boolean started = false;
Boolean stopped = false;
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
    time = "" + (millis() /1000.0) ;
    text(time, 700, 50);
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
   if (key == 's'){
    stopped = true; 
   }
   if (key == 'e'){
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
  size(1000, 800);
  t = new Track();
  doneWithTrack = false;
  started = false;
  stopped = false;
  //restart = false;
  clear = false;
  game = new LineRiderGame(100, 100);
}

void draw(){
  background(255);
  game.display();
  game.guy.display();
 // t.display();
  if (doneWithTrack && !stopped && !clear){
    if (!started){
       game.guy.timeCounter = 0;
       started = true;
    }
    game.guy.move();
  }
  /*
  if (doneWithTrack && restart){
    game.guy = new Rider(50, 9.81, game.startX, game.startY, 0.0, 0.0, t); //reassign so it's back at 0 and everytinig is 0
    started = true; //so that in next pass that will happen
    restart = false; //once u did this, make it so next time guy will j drop and restart
  }
  if (clear){
   t = new Track();
   game.guy = new Rider(50, 9.81, game.startX, game.startY, 0.0, 0.0, t);
   doneWithTrack = false;
   started = false;
   stopped = false;
   restart = false;
   clear = false;
  }
  */ //testing
    t.display();
    
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
  
  if (!doneWithTrack || stopped){
     t.add(mouseX + 0.0, mouseY + 0.0); 
  }
  
}
