//Final project!
//fields
LineRiderGame game;
Rider guy;
Vehicle bike; 
Track t = new Track();
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
    float GPE = 9.81 * 50.0 * (height - startY); 
    guy = new Rider(50.0, 9.81, GPE, GPE, 0, startX, startY, 0, 0);
  }
}



void setup(){
  size(1000, 800);
}

void draw(){
 t.display();
}

void mouseClicked(){
   t.add(mouseX + 0.0, mouseY + 0.0); 
}