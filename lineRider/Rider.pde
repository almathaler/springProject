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
  void firstFall(){
   while (!onTrack){
    velY = velYo + (gravityVal)*(System.currentTimeMillis() / 1000); //not adding to a value, recalculating every time
   }
  }
  void move(){
    x += velX*(1/60.0); //this is compounded bc velocity is subject to a lto of changes. so since there are 60 frames per second
                        //and this method is called every frame in draw(), j add to x distance moved in 1/60 of a sec based on current vel
    y += velY * (1/60.0);
    //keep move JUST LIKE THIS!!! all thecomplicated methods change velocity. or should we haqve a check velocity first?
  }
  void display(){
    
  }
}