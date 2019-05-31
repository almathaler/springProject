//Final project!
//Final project!
//fields
//LineRiderGame game;
Rider guy;
Vehicle bike; 
Track t = new Track();
Boolean doneWithTrack = false;
Boolean started = false;
LineRiderGame game = new LineRiderGame(100, 100);
class LineRiderGame{
  Rider guy;
  float startX, startY;
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
    guy = new Rider(50.0, 5, startX, startY, 0.0, 0.0, t);
  }
}

void keyPressed(){
   if (key ==  CODED){
     if (keyCode == SHIFT){// if the track is finished, this will become true. Helps so that the rider doesn't fall until track is done. basically starts the game
        doneWithTrack = true; 
        System.out.println();
     }
   }
}



void setup(){
  size(1000, 800);
}

void draw(){
  background(255);
  game.guy.display();
 // t.display();
  if (doneWithTrack){
    if (!started){
       game.guy.timeCounter = 0;
       started = true;
    }
    game.guy.move();
  } 
    t.display();
}


void mouseClicked(){
  
  if (!doneWithTrack){
     t.add(mouseX + 0.0, mouseY + 0.0); 
  }
  
}