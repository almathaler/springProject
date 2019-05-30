class Rider{
  int timeCounter = 0;//updated every time draw is called, adds one every second
  float mass, gravityVal; //used to calculate effect on Vs, also if character should die
  float x, y; //position
  float vel, velo;
  float fallingVelX, fallingVelY; //only use this for the falls
  boolean onTrack = false; //when this is false, affectVelY and use gravity
  float direction;
  float theta;
  boolean haveFallen;
  int trackOn = -1;
  //for testing
  float capturedVel = 0.0;
  float capturedDirection = 0.0;
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
    if (timeCounter % 6 == 0){
     //////System.out.println(" affectVel's trackOn: " + trackOn); 
    }
    if (trackOn == -1){ //check, but why does this return -1 if must be true for affectVel??
      return false;
    }
   //calculate the slope, and if it's not the same as you've been on, change and take a new time
    if (calcTheta(trackOn) != theta){
      theta = calcTheta(trackOn); //shld be theta
      //why does ball go down slope that is upwards? thru th eline? 
      direction = theta;
      ////System.out.println("NEW DIRECTION: " + direction);
      timeCounter = 0;
      velo = vel; //make the last velocity of the old slope the one we are working off of now
      if (haveFallen){ //there is an issue w the going up hills, it's that between tracks if have falling velYo will beome zero, so falls too quick?
        velo = fallingVelX; //if you've fallen, for now assume impact is fixed and velY is over, only use velX
      }
    }
    System.out.println("on segment: " + trackOn);
    int intersecting = checkIfIntersecting();
    if (intersecting != -1){
      System.out.println("intersecting segment: " + intersecting);
    }
    //NOTE: sin(theta) will be negative if this slope is downwards
    //shld be theta
    Float force = mass * gravityVal * sin(theta); //NOTE: bc of weird coords, theta is (+) for downhills
    if (timeCounter % 6 == 0){
     //System.out.println("force: " + force); 
    }
    //take into account friction
    //shld be theta
    Float friction = mass * gravityVal * cos(theta) * t.getMu(t.types.get(trackOn / 4)); //subtract friction
    //shld be based on direction of ball's movement
    //for instance on a \ when going from the bottom to the top, direction is between PI/2 and 3PI/2 and so
    //both friction and force are pulling the bball back down (actually it's the exact same
    //as the other case, but if vel > 0 then add friction and force and if it's less than 0 then it's going
    // in the right direction as the force so force-=friction. if the direction is between 3PI/2 and PI/2 then go into
    //the catch that is for vel < 0 (friction is with force) and vel > 0 (friction is against force, pulling it right up again)
    //fix this to back what it used to be
    if (direction > 0 && direction < PI){ //HERE
      force-=friction; //if it's you're going down, friction is upwards
    }else{
      force+=friction; //vice versa
    }
    System.out.println("net force: " + force);
    //a change
    if (direction > 0 && direction < PI ){
      vel = velo + force / mass * timeCounter/6.0;
    }else{
      vel = velo - force / mass * timeCounter/6.0;
    }
    if (vel < 0){
     System.out.println("changing direction");
     velo = -1 * vel;
     direction += PI; //keep velocity positive, just change direction
     direction %= 2*PI; //don't let it get to lik 5Pi
    }
    if (timeCounter % 6 == 0){
     ////System.out.println("friction: " + friction + " net force: " + force + " velocity: " + vel); 
    }
    haveFallen = false;
    return true;
  }
  //takes in coord, returns slope AS THETA
  float calcTheta(int i) { //take in the coord of the current line
    //Float slope = (t.track.get(i + 3) - t.track.get(i + 1)) / (t.track.get(i + 2) - t.track.get(i)); //
    float x1 = t.track.get(i);
    float y1 = t.track.get(i+1);
    float x2 = t.track.get(i+2);
    float y2 = t.track.get(i+3);
    //translate point2 to where it would be if x1 and y1 were at the origin
    //pushMatrix();
    //translate (x1, y1);
    //reason you push and pop --> bc atan2 finds it from the origin but we need the theta of a line 
    //so move the origin to on e of the end points to calculate theta
    Float theta = atan2(y2-y1, x2-x1);
    //popMatrix();
    return theta;
  }

  void move(){
    if (timeCounter % 6 == 0){
      System.out.println("Direction: " + direction);
      System.out.println("vel: " + vel);
      System.out.println("current seg of track: " + trackOn);
      if (!onTrack){
        System.out.println("falling");
      }
    }
    if (onTrack){
      affectVelocities();
    }else{
      fall();
    }
    if (haveFallen){
      if (onTrack){
       System.out.println("\n still falling tho on track"); 
      }
      x += fallingVelX * (1.0 / 60.0);
      y += fallingVelY * (1.0 / 60.0);
    }else{
      //are these ok timings? should update proportional to current frame rate
      //direction is fine
      x += vel * cos(direction) * (1.0 / 60.0);//*(System.currentTimeMillis() -  startTimeTheta); //this is compounded bc velocity is subject to a lto of changes. so since there are 60 frames per second
                          //and this method is called every frame in draw(), j add to x distance moved in 1/60 of a sec based on current vel
      y += vel *  sin(direction) * (1.0 / 60.0);// * (System.currentTimeMillis() - startTimeTheta);
    }
    timeCounter++; //make this zero every time direction changes
    //checkIfOnTrack(); //change
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
     if (((x1 <= x && x2 >= x) || (x1 >= x && x2 <= x)) && ((y1 <= y && y2 >= y) || (y1 >= y & y2 <= y))){
      if (Math.abs((y1 - y) - (slope * (x1 - x))) < 10){
         onTrack = true;
         return i;
      }
    }
  }
    //if the above fails but there still is a piece connected ... buggy
    //if (t.isConnected(trackOn)){ //if the piece the rider is on rn has another next to it
    //  onTrack = true;
    //  return (trackOn + 4);
    //}
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
