class Rider{
  float mass, gravityVal, eTotal, GPE, KE; //used to calculate effect on Vs, also if character should die
  float x, y; //position
  float velY, velX; //velocity
  float velYo, velXo;
  boolean onTrack = false; //when this is false, affectVelY and use gravity
  Rider(float mass, float gravityVal, float eTotal, float GPE, float KE, float x, float y, float velX, float velY){
   this.mass = mass;
   this.gravityVal = gravityVal;
   this.eTotal = eTotal;
   this.GPE = GPE;
   this.KE = KE;
   this.x = x;
   this.y = y;
   this.velYo = velY; //as in, at first when u make the rider his velocity will by 0
   this.velXo = velX; //everytime u update velocity, store the old val in original. or actually j keep original if direction is the same
   //if slope is the same (on the same line), keep using velYo and velXo to cahnge veocity. once the slope changes
   //current velocities become intial ones
  }
  //
  //
  void firstFall(){ //when game is starting
   while (!onTrack){
    velY = velYo + (gravityVal)*(System.currentTimeMillis() / 1000); //not adding to a value, recalculating every time
   }
  }
  //
  //
  void move(){
    x += velX*(1/60.0); //this is compounded bc velocity is subject to a lto of changes. so since there are 60 frames per second
                        //and this method is called every frame in draw(), j add to x distance moved in 1/60 of a sec based on current vel
    y += velY * (1/60.0);
    //keep move JUST LIKE THIS!!! all thecomplicated methods change velocity. or should we haqve a check velocity first?
  }
  //
  //
  void display(){
    //keep x and y right at the bottom. so make 
    ellipseMode(CORNERS); //so now, make upper left corner and bottom right as x, y -- that's like where the front wheel will be
    float wid = 50;
    float hei = 50;
    ellipse(x-50, y-50, x, y);
  }
  //
  //
  //needs a way to 
  //a) have a track be a field of a rider
  //b) access every coordinate in the arrayList --> can j be done by using t.track.get() ...
  void checkIfOnTrack(Track t){
    for (int i = 0; i<t.track.size() - 3; i+= 4){
     Float x1 = t.track.get(i);
     Float y1 = t.track.get(i+1);
     Float x2 = t.track.get(i+2);
     Float y2 = t.track.get(i+3);
     Float slope = (y2-y1)/(x2-x1);
     if (((x1 <= x && x2 >= x) || (x1 >= x && x2 <= x)) && ((y1 <= y && y2 >= y) || (y1 >= y & y2 <= y))){
      if ((y1 - y) == slope * (x1 - x)){
         onTrack = true; 
      }
     }
    }
    onTrack = false;
 }
  /*
  public boolean isPartOf(Float a, Float b){
  for (int i = 0; i < t.track.size() - 3; i+= 4){
    Float x1 = t.track.get(i);
    Float y1 = t.track.get(i + 1);
    Float x2 = t.track.get(i + 2);
    Float y2 = t.track.get(i + 3);
    Float slope = (y2 - y1) / (x2 - x1);
    if (((x1 <= a && x2 >= a) || (x1 >= a && x2 <= a)) && ((y1 <= b && y2 >= b) || (y1 >= b & y2 <= b))){
      if ((y1 - b) == slope * (x1 - a)){
         return true; 
      }
    }
  }
  return false;
}
  */
}