class Rider{
  float mass, gravityVal, eTotal, GPE, KE; //used to calculate effect on Vs, also if character should die
  float x, y; //position
  float velY, velX; //velocity
  float velYo, velXo;
  boolean onTrack = false; //when this is false, affectVelY and use gravity
  Track t;
  //added track field to rider so it can check whether or not it's on
  Rider(float mass, float gravityVal, float eTotal, float GPE, float KE, float x, float y, float velX, float velY, Track t){
   this.mass = mass;
   this.gravityVal = gravityVal;
   this.eTotal = eTotal;
   this.GPE = GPE;
   this.KE = KE;
   this.x = x;
   this.y = y;
   this.t = t; //the track
   this.velYo = velY; //as in, at first when u make the rider his velocity will by 0
   this.velXo = velX; //everytime u update velocity, store the old val in original. or actually j keep original if direction is the same
   //if slope is the same (on the same line), keep using velYo and velXo to cahnge veocity. once the slope changes
   //current velocities become original ones
  }
  //
  //when u update velocity:
  //
  //velX = velXo + (cos(theta)*F)/m * (System.currentTimeMillis() / 1000);
  //velY = velYo + (sin(theta)*F)/m * (System.currentTimeMillis() / 1000);
  //F is calculated based on slope (theta) of that segment of the track. It's mgsinTheta, add to velX and velY if it's
  //downhill and subtract to x add to y (since if going up, velY should be (-)) for incline
  //once you're on a new piece of track, make velYo and velXo velY and velX
  //
  void fall(){ //when game is starting, you don't need to do anything to velX. but i guess we can just have
                    //one fall function called fall() which does same thing to velY and keeps x just the same... well that's every fall
                    //i guess we can just have on fall(0 function and then one affectVelocities function 
   while (!onTrack){
    //since it's first fall, velyo is just 0. but keep this for consistency?
    velY = velYo + (gravityVal)*(System.currentTimeMillis() / 1000); //not adding to a value, recalculating every time
    //keep x speed the same
    checkIfOnTrack();
    //death
    //how to check this?
   }
   velYo = velY; //store velocity once it hits the track as velYo
   affectVelocities(); //this method will do a while(onTrack), once that ends fall() is called again. If you fall off the screen, over
  }
  //
  //
  void affectVelocities(){
   //check which part of track we are on
   //calculate the slope from that
   //arctan(slope) = theta
   //from theta, if it's negative that means you need to add to Vx and Vy, if it's positive you are subtracting
   //from vX and adding to vY (which upon hittin an incline should turn negative. where will we write that? here
   //just do if theta > 0, well first off if you're coming from a horizontal, turn vX into vY and vX componnents based on the slope
   //of the new hill. if it's one slope into another, calculate the downwards force of the ball, then Fy, then to calculate
   //it's velocity up (Fy from the downhill is what powers it up), Fyfromdownhill - Fyfrominclineit'sdealingwith = Fycurrent, Fyc/m = a
   //and j add that to the velocity. but ig what i mean is how does it know to set the upwards velocity at 0 for a split second?
   //that's not what happens IRL
   //have a direction int? just 1 or -1? and if the new slope is upwards, direction is -1
  }
  //
  //after it hits the track,
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
    ellipse(x-wid, y-hei, x, y);
  }
  //
  //
  //needs a way to 
  //a) have a track be a field of a rider
  //b) access every coordinate in the arrayList --> can j be done by using t.track.get() ...
  void checkIfOnTrack(){
    //doesn't work rn cuz the classes haven't been merged. but track si the AL of points
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
