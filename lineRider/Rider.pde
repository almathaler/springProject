class Rider{
  //int currentSeg = checkIfOnTrack();
  //float velocity;
  int timeCounter = 0;//updated every time draw is called, adds one every second
  float mass, gravityVal, eTotal, GPE, KE; //used to calculate effect on Vs, also if character should die
  float x, y; //position
  float velY, velX; //velocity
  float velYo, velXo;
  boolean onTrack = false; //when this is false, affectVelY and use gravity
  int direction = 1;
  Track t;
  float startTimeTheta; //*
  float theta; //*
  //added track field to rider so it can check whether or not it's on
  Rider(float mass, float gravityVal, float eTotal, float GPE, float KE, float x, float y, float velX, float velY, Track t){
   this.mass = mass;
   this.gravityVal = gravityVal / 10;
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
   //while //Must be an if statement because it is called in draw every time
   if (!onTrack){
    //since it's first fall, velyo is just 0. but keep this for consistency?
    velY = velYo + (gravityVal)*(timeCounter / 60); //not adding to a value, recalculating every time
    //System.out.println(System.currentTimeMillis() % 1000000 - startTimeTheta % 1000000);
    //keep x speed the same
    checkIfOnTrack();
    //System.out.println(checkIfOnTrack() + "");
    //death
    //how to check this?
    //timeCounter++;
   }/* else {
   velYo = velY; //store velocity once it hits the track as velYo
   velXo = velX;
   affectVelocities(); //this method will do a while(onTrack), once that ends fall() is called again. If you fall off the screen, over
   }
   */
  }
  //
  //make a new timer every time this is called? yes bc that's the point of velYo and velXo 
  //
  //
  void affectVelocities(){
    int currentSeg = checkIfOnTrack();
    //float startTime = System.currentTimeMillis() / 1000;
    //actually no, if this is called every frame, we know that the time has just been 1/60 s
    
    //while (onTrack){
     //calculate the slope, and if it's not the same as you've been on, change and take a new time
      if (calcTheta(currentSeg) != theta){
        theta = calcTheta(currentSeg);
        System.out.println(degrees(theta));
        //startTimeTheta = System.currentTimeMillis() / 1000;
        timeCounter = 0;
        velXo = velX;
        velYo = velY; // now that we have a new theta, use the other slope's velocities as original
      }
      //NOTE: sin(theta) will be negative if this slope is downwards
      Float force = mass * gravityVal * sin(theta); //since for downhill theta will be (-), does this cancel out? yea 
     //from theta, if it's negative that means you need to add to Vx and Vy, if it's positive you are subtracting
      if (theta > 0){
       //if direction is positive that means ur going down. if theta is greater than 0, then you're going up and need to change direction 
       if ( direction > 0){ //as in, you've been going down (so adding to teh velocities)
         direction = -1;
         velYo = velYo * direction; //make that now upwards velocity, not sure how accurate this is
         //so now if you add velYo * time to current y, y will decrease and you'll go up!
       }
       //force is parallel to incline, so theta is used for both calculations
       velX = velXo + (cos(HALF_PI - theta) * force)/mass * timeCounter / 60;//(System.currentTimeMillis() / 1000 - startTimeTheta); //RED FLAGG!!!!! SHOULD HAVE COUNTER WITHIN ALGORITHIM
       velY = velYo + (sin(HALF_PI - theta) * force)/mass * timeCounter / 60; //(System.currentTimeMillis() / 1000 - startTimeTheta); //velY should be negative, add to it to be more pos
       //velYo = velY;
       //velXo = velX;
      }else{
        //but i think that that is okay, because velY will be mulitplied by sintheta which is also negative. but for x need to multiple by neg one
        direction = 1; //cuz going down as in towards the heighest coords
        velX = velXo + (cos(HALF_PI - theta)  * -1 * force)/mass * timeCounter / 60;//(System.currentTimeMillis() / 1000 - startTimeTheta);
        velY = velYo + (sin(HALF_PI - theta) * -1 *force)/mass * timeCounter / 60; //(System.currentTimeMillis() / 1000 - startTimeTheta);
        //velYo = velY; since you keep the time from mulitple calls, don't touch this until u switch sloeps
        //velXo = velX;
      }
     currentSeg = checkIfOnTrack();
    //}
    //fall();
  }
  
  
  
  //maybe new affectVelocities?
  /*
  void affectVelocities2(){
    int currentSeg = checkIfOnTrack();
    if (calcTheta(currentSeg) != theta){
        theta = calcTheta(currentSeg);
        timeCounter = 0;
        velXo = velX;
        velYo = velY; // now that we have a new theta, use the other slope's velocities as original
     }
     Float force = mass * gravityVal * sin(theta);
     velocity = 
     
  }
  */
  //takes in coord, returns slope AS THETA
  float calcTheta(int i) { //take in the coord of the current line
    Float slope = (t.track.get(i + 3) - t.track.get(i + 1)) / (t.track.get(i + 2) - t.track.get(i)); //
    //arctan(slope) = theta
    System.out.println("slope calculated in calcTheta: " + slope);
    Float theta = atan(slope);
    System.out.println("theta calculated in calcTheta: " + theta);
    return theta;
  }
  
  //
  //after it hits the track,
  //
  //
  void move(){
    //are these ok timings? should update proportional to current frame rate
    x += velX;//*(System.currentTimeMillis() -  startTimeTheta); //this is compounded bc velocity is subject to a lto of changes. so since there are 60 frames per second
                        //and this method is called every frame in draw(), j add to x distance moved in 1/60 of a sec based on current vel
    y += velY;// * (System.currentTimeMillis() - startTimeTheta);
    //keep move JUST LIKE THIS!!! all thecomplicated methods change velocity. or should we haqve a check velocity first?
    timeCounter++;
  }
  //
  //
  void display(){
    //keep x and y right at the bottom. so make 
    ellipseMode(CORNERS); //so now, make upper left corner and bottom right as x, y -- that's like where the front wheel will be
    float wid = 50;
    float hei = 50;
    ellipse(x-wid/2, y-hei, x+wid/2, y); //so that the bottom point of the ellipse is what is touching the line
  }
  //
  //
  //needs a way to 
  //a) have a track be a field of a rider
  //b) access every coordinate in the arrayList --> can j be done by using t.track.get() ...
  //return index of first coord of section of line u r on
  
  // return index, also affect onTrack boolean
  //
  int checkIfOnTrack(){
    //doesn't work rn cuz the classes haven't been merged. but track si the AL of points
    for (int i = 0; i<t.track.size() - 3; i+= 4){
     Float x1 = t.track.get(i);
     Float y1 = t.track.get(i+1);
     Float x2 = t.track.get(i+2);
     Float y2 = t.track.get(i+3);
     Float slope = (y2-y1)/(x2-x1);
     //if between the points
     //if (((x1 <= x && x2 >= x) || (x1 >= x && x2 <= x)) && ((y1 <= y && y2 >= y) || (y1 >= y & y2 <= y))){
       //and on the line 
      if ((y1 - y) - (slope * (x1 - x)) < 1000){
         onTrack = true; 
         return i;
      }
     //}
    }
    onTrack = false;
    return -1;
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
