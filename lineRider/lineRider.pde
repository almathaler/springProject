//Final project!
//fields
LineRiderGame game;
Rider guy; //won't these all be in LineRiderGame?
Vehicle bike;
Track track; 
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
    track = new Track();
    //assuming gravity will be 9.81
    //should this be calculated from the first platform or from the ground?
    float GPE = 9.81 * 50.0 * (height - startY); // this always has to be calculated using (height-y), because that's the height off the bottom
    guy = new Rider(50.0, 9.81, GPE, GPE, 0, startX, startY, 0, 0, track);
  }
  void start(){
    guy.fall(); //fall is in the Rider class, will be what makes velY = velYo + (9.81)(t);
                //fall stops and becomes riding along a track once isTouching is true
  }
}

void setup(){
  size(1000, 800);
}

void draw(){
  
}
