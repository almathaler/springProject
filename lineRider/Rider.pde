class Rider{
  int timeCounter = 0;//updated every time draw is called, adds one every second
  float mass, gravityVal; //used to calculate effect on Vs, also if character should die
  float x, y; //position
  float vel, velo;
  float fallingVelX, fallingVelY; //only use this for the falls
  boolean onTrack = false; //when this is false, affectVelY and use gravity
  float direction;
  boolean haveFallen;
  int trackOn = -1;
  //for testing
  float capturedVel = 0.0;
  float capturedDirection = 0.0;
  float forceApplied = 0.0;
  float frictionApplied = 0.0;
  //
  Track t;
  //added track field to rider so it can check whether or not it's on
  Rider(float mass, float gravityVal, float x, float y, float velX, float velY, Track t){
   this.mass = mass;
   this.gravityVal = gravityVal;
   this.x = x;
   this.y = y;
   this.t = t; //the track
   velo = 0.0;
   vel = 0.0;
  }

  void fall(){
   if (!onTrack){
     if (!haveFallen){
       timeCounter = 0; //if this is the start of the fall, then restart time so to affect velocity correctly
       //set up a velX that will remain constant
       fallingVelX = vel * cos(direction);
       fallingVelY = vel * sin(direction); //don't use vel, use these falling ones
     }
    direction = PI / 2.0;
    fallingVelY += (gravityVal) * (1.0 / 60.0); //increase Y
    trackOn = checkIfOnTrack();
   }
   haveFallen = true;
  }
  //
  //made this a boolean so that it can end after fall() if fall() is called
  boolean affectVelocities(){
    //for friction, mgcos(direction) = fN, * by Mu then subtract this from the force
    trackOn = checkIfOnTrack(); //if checkIfOnTrack returns true, precondition for this to be called, no -1
    if (trackOn == -1){ //check, but why does this return -1 if must be true for affectVel??
      return false;
    }
   //calculate the slope, and if it's not the same as you've been on, change and take a new time
   float theta = calcTheta(trackOn);
    if (theta != direction){
      System.out.println("trackOn changed, now it is: " + trackOn + ", at time: " + millis());
      direction = theta;
      timeCounter = 0;
      velo = vel; //make the last velocity of the old slope the one we are working off of now
      if (haveFallen){ //there is an issue w the going up hills, it's that between tracks if have falling velYo will beome zero, so falls too quick?
        velo = fallingVelX; //if you've fallen, for now assume impact is total and velY is over, only use velX
      }
    }
    //NOTE: sin(theta) will be negative if this slope is downwards
    Float force = mass * gravityVal * sin(theta); //NOTE: bc of weird coords, theta is (+) for downhills
    
    //take into account friction
    Float friction = mass * gravityVal * cos(theta) * t.getMu(t.types.get(trackOn / 4)); //subtract friction

    //testing
    //
    if (timeCounter % 60 == 0 || 
        timeCounter % 60 == 10 ||
        timeCounter % 60 == 20 ||
        timeCounter % 60 == 30 ||
        timeCounter % 60 == 40 ||
        timeCounter % 60 == 50){
      forceApplied = force;
      frictionApplied = friction;
    }
    //
    //
    if (vel < 0 && direction == theta){ //if ball is rolling against the force 
      force+=friction; //if it's downwards force, friction is upwards
    }else{ //here the ball must be rolling with the force, so you subtract friction
      force-=friction; //vice versa
    }
    
    if (vel >= 0){
      vel = velo + force / mass * timeCounter/6.0;
    }if (vel < 0){
      vel = velo - force / mass * timeCounter/6.0;
    }
    
    haveFallen = false;
    return true;
  }
  //takes in coord, returns slope AS THETA
  float calcTheta(int i) { //take in the coord of the current line
    Float slope = (t.track.get(i + 3) - t.track.get(i + 1)) / (t.track.get(i + 2) - t.track.get(i)); //
    Float theta = atan(slope);
     //moved the mismatched points to the track class
    return theta;
  }

  void move(){
    if (onTrack){
      affectVelocities();
    }else{
      fall();
    }
    if (haveFallen){
      x += fallingVelX * (1.0 / 60.0);
      y += fallingVelY * (1.0 / 60.0);
    }else{
      //are these ok timings? should update proportional to current frame rate
      x += vel * cos(direction) * (1.0 / 60.0);//*(System.currentTimeMillis() -  startTimeTheta); //this is compounded bc velocity is subject to a lto of changes. so since there are 60 frames per second
                          //and this method is called every frame in draw(), j add to x distance moved in 1/60 of a sec based on current vel
      y += vel *  sin(direction) * (1.0 / 60.0);// * (System.currentTimeMillis() - startTimeTheta);
    }
    timeCounter++; //make this zero every time direction changes
  }
  //
  //
  void display(){
    //keep x and y right at the bottom. so make
    if (onTrack){
      fill(255, 0, 0);
    }else{
      fill(0, 255, 0);
    }
    ellipseMode(CORNERS); //so now, make upper left corner and bottom right as x, y -- that's like where the front wheel will be
    float wid = mass;
    float hei = mass;
    ellipse(x-wid/2, y-hei, x+wid/2, y); //so that the bottom point of the ellipse is what is touching the line
    
    if (timeCounter % 60 == 0 || 
        timeCounter % 60 == 10 ||
        timeCounter % 60 == 20 ||
        timeCounter % 60 == 30 ||
        timeCounter % 60 == 40 ||
        timeCounter % 60 == 50){
      capturedVel = vel;
      capturedDirection = direction;
    }
    textSize(20);
    fill(255, 18, 169);
    String s = "vel: " + capturedVel + " direction: " + capturedDirection;
    text(s, x, y-hei/2.0);
    String f = "force: " + forceApplied + "friction: " + frictionApplied;
    text(f, x, y-hei/2.0 - 20);
   
  }
  // return index, also affect onTrack boolean
  //
  int checkIfOnTrack(){

    for (int i = 0; i<t.track.size() - 3; i+= 4){
     Float x1 = t.track.get(i);
     Float y1 = t.track.get(i+1);
     Float x2 = t.track.get(i+2);
     Float y2 = t.track.get(i+3);
     Float slope = (y2-y1)/(x2-x1);
     //(y1 <= y && y2 >= y)
     if (((x1 <= x && x2 >= x) && (y1 <= y && y2 >= y)) || ((x1 >= x && x2 <= x) && (y1 >= y & y2 <= y))){
      if (Math.abs((y1 - y) - (slope * (x1 - x))) < 5){
         onTrack = true;
         return i;
      }
    }
  }
    //if the above fails but there still is a piece connected ... buggy
    if (t.isConnected(trackOn)){ //if the piece the rider is on rn has another next to it
      onTrack = true;
      return (trackOn + 4);
    }
    onTrack = false;
    return -1;
 }
 
  //check if distance between line and center is within 5 pixels of radius of circle  
 int checkIfIntersecting(){
   for (int i = 0; i<t.track.size()-3; i+=4){
     float slope = (t.track.get(i + 3) - t.track.get(i + 1)) / (t.track.get(i + 2) - t.track.get(i));
     float A = slope;
     float B = -1;
     //actually these should be points of the line
     float C = (slope * -1 * t.track.get(i)) + t.track.get(i+1);
     float d;                          //
     d = A * x + B * (y-(mass/2)) + C; //y - (mass/2) as the coords x and y are the bottom mcenter of the ellipse
     if (d<0){
      d *= -1; 
     }
     d /= Math.sqrt(A * A + B * B);
     //now d is correctly initialized
     if (d >= (mass/2 - 5) && d <= (mass/2 + 5)){
      if ( i != trackOn){
       return i; 
      }
     }
   }
   return -1;
 }
}
