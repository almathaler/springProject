class Rider{
  int timeCounter = 0;//updated every time draw is called, adds one every second
  float mass, gravityVal; //used to calculate effect on Vs, also if character should die
  float x = 100; //position
  float y = 100;
  int translateMode = 1; //decides where the rider is drawn from. will usually be 0 (for x and y), but will change sometimes for hitBox integration
  //float hx1, hx2, hx3, hx4 , hy1, hy2, hy3, hy4; //will be used for hitbox for the rider
  float[][] hitBox = {{x - 50, y}, {x - 50, y - 12.5}, {x, y - 25}, {x + 12.5, y - 12.5}}; //bottom back corner, top back corner, top, front and then x, y is the final;//hitBox for rider to detect when it is touching something
  float vel, velo;
  float fallingVelX, fallingVelY; //only use this for the falls
  boolean onTrack = false; //when this is false, affectVelY and use gravity
  float direction;
  boolean haveFallen;
  int trackOn = -1;
  float theta = 0.0;
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
   direction = 0.0;
   //hitBox = {[x - 50, y], [x - 50, y - 12.5], [x, y - 25], [x + 12.5, y - 12.5]}; //bottom back corner, top back corner, top, front and then x, y is the final
  }

  void fall(){
   if (!onTrack){
     if (!haveFallen){
       //direction = PI;
       timeCounter = 0; //if this is the start of the fall, then restart time so to affect velocity correctly
       //set up a velX that will remain constant
       fallingVelX = vel * cos(direction);
       fallingVelY = vel * sin(direction); //don't use vel, use these falling ones
     }
     
     //adjustHitBox();
      
    fallingVelY += (gravityVal) * (1.0 / 60.0); //increase Y
    trackOn = checkIfOnTrack();
    direction = PI;
   }
   haveFallen = true;
  }
  
  
  
  
  //
  //made this a boolean so that it can end after fall() if fall() is called
  boolean affectVelocities(){
    int trackOn = checkIfOnTrack(); //if checkIfOnTrack returns true, precondition for this to be called, no -1
    if (trackOn == -1){ //check, but why does this return -1 if must be true for affectVel??
      return false;
    }
   //calculate the slope, and if it's not the same as you've been on, change and take a new time
    if (calcTheta(trackOn) != direction){
      /*
      float diffTheta = calcTheta(trackOn);
      //updating points of hitBox as this is the only part where it does not change w x and y
      //each must be adjusted according to its own specific equation/position
      hitBox[0][0] = x - (50 *cos(diffTheta));
      hitBox[0][1] = y - (50 * sin(diffTheta));
      hitBox[1][0] = x - 51.5388 * cos (diffTheta + 0.2449787);
      hitBox[1][1] = y - 51.388 * sin(diffTheta +  0.2449787);
      hitBox[2][0] = x + 25 * sin(diffTheta);
      hitBox[2][1] = y - 25 * cos(diffTheta);
      hitBox[3][0] = x + 12.5 * sqrt(2) * cos(diffTheta - radians(45));
      hitBox[3][1] = y + 12.5 * sqrt(2) * sin(diffTheta - radians(45));
      */
      
      direction = calcTheta(trackOn);
      adjustHitBox();
      timeCounter = 0;
      velo = vel; //make the last velocity of the old slope the one we are working off of now
      if (haveFallen){ //there is an issue w the going up hills, it's that between tracks if have falling velYo will beome zero, so falls too quick?
        velo = fallingVelX; //if you've fallen, for now assume impact is total and velY is over, only use velX
      }
    }
    //NOTE: sin(theta) will be negative if this slope is downwards
    Float force = mass * gravityVal * sin(direction); //NOTE: bc of weird coords, theta is (+) for downhills
    vel = velo + force / mass * timeCounter;
    haveFallen = false;
    return true;
  }
  //takes in coord, returns slope AS THETA
  float calcTheta(int i) { //take in the coord of the current line
    if (i + 3 < t.track.size() && i != -1){
       Float slope = (t.track.get(i + 3) - t.track.get(i + 1)) / (t.track.get(i + 2) - t.track.get(i)); //
      Float theta = atan(slope);
      return theta;
    }
    return 0.0;
  }

  void move(){
    if (timeCounter % 6 == 0){
      System.out.println("Direction: " + direction);
      System.out.println("vel: " + vel);
      System.out.println("current seg of track: " + trackOn);
    }
    if (onTrack){
      affectVelocities();
    } else {
       fall(); 
    }
    
    if (haveFallen){
      x += fallingVelX * (1.0 / 60.0);
      y += fallingVelY * (1.0 / 60.0);
      
      
      for (int i = 0; i < hitBox.length; i++){
         hitBox[i][0] += fallingVelX * (1.0 / 60.0);
         hitBox[i][1] += fallingVelY * (1.0 / 60.0);
      }
      
    }else{
      //are these ok timings? should update proportional to current frame rate
      
      x += vel * cos(direction) * (1.0 / 60.0);//*(System.currentTimeMillis() -  startTimeTheta); //this is compounded bc velocity is subject to a lto of changes. so since there are 60 frames per second
                          //and this method is called every frame in draw(), j add to x distance moved in 1/60 of a sec based on current vel
      y += vel *  sin(direction) * (1.0 / 60.0);// * (System.currentTimeMillis() - startTimeTheta);
      
      
      for (int i = 0; i < hitBox.length; i++){// updating the hitbox coordinates with 
        hitBox[i][0] += vel * cos(direction) * (1.0 / 60.0);
        hitBox[i][1] += vel *  sin(direction) * (1.0 / 60.0);
      }
      
      
    }
    timeCounter++; //make this zero every time direction changes
  }
  //
  //
  void display(){
    direction = calcTheta(checkIfOnTrack());
    ellipseMode(CENTER);
    for (int i = 0; i < hitBox.length; i++){
       ellipse(hitBox[i][0], hitBox[i][1], 2, 2); 
    }
    if (checkIfOnTrack() == -1){
       onTrack = false; 
    } else {
       onTrack = true; 
    }
    //keep x and y right at the bottom. so make
    if (onTrack){
      fill(255, 0, 0);
    }else{
      fill(0, 255, 0);
    }
    float wid = 25.0;
     float hei = 25.0;
     ellipseMode(CORNERS);
     if (haveFallen){
       theta += vel * 0.0001;
       //rotate(theta); 
     } else {
       theta = calcTheta(trackOn);
       //rotate(calcTheta(trackOn));
     }
    //pushMatrix();
    if (translateMode == 0){
      pushMatrix();
      translate(x, y);
      //if (haveFallen){
      //  rotate(PI - direction);
      //} else {
        rotate(direction); 
      //}
      rect(0-50, -12.5, 50, 12.5);
      ellipse(-wid/2, -hei, wid/2, 0);
      fill(255, 255, 255);
      line(0, 0, -25, -12.5);
      line(-25, -12.5, -25, -25);
      line(-25, -25, 0, -25);
      ellipse(-30, -35, -20, -25);
      popMatrix();
      //rotate(calcTheta(trackOn));
     
     //translate(-x, -y);
     //rotate(-calcTheta(trackOn));
    } else if (translateMode == 1){
      
      x = hitBox[0][0] + 50 * cos(direction);
      y = hitBox[0][1] + 50 * sin(direction);
      adjustHitBox();
      pushMatrix();
      translate(x, y);
      rotate(direction); 
      rect(0-50, -12.5, 50, 12.5);
      ellipse(-wid/2, -hei, wid/2, 0);
      fill(255, 255, 255);
      line(0, 0, -25, -12.5);
      line(-25, -12.5, -25, -25);
      line(-25, -25, 0, -25);
      ellipse(-30, -35, -20, -25);
      popMatrix();
    }
    //popMatrix();
      
    /*
    ellipseMode(CORNERS); //so now, make upper left corner and bottom right as x, y -- that's like where the front wheel will be
    float wid = 50;
    float hei = 50;
    ellipse(x-wid/2, y-hei, x+wid/2, y); //so that the bottom point of the ellipse is what is touching the line
    */
  }
  // return index, also affect onTrack boolean
  //
  int checkIfOnTrack(){
    ArrayList<Integer> indicies = new ArrayList<Integer>();

    for (int i = 0; i<t.track.size() - 3; i+= 4){
     Float x1 = t.track.get(i);
     Float y1 = t.track.get(i+1);
     Float x2 = t.track.get(i+2);
     Float y2 = t.track.get(i+3);
     Float slope = (y2-y1)/(x2-x1);
     
     
     for (int j = 0; j < hitBox.length; j++){
       float hx1 = hitBox[j][0];
       float hy1 = hitBox[j][1];/*
       float hx2 = hitBox[i + 1][0];
       float hy2 = hitBox[i + 1][1];
       float hSlope = (hy1 - hy2) / (hx1 - hx2);*/
       if (((x1 <= hx1 && x2 >= hx1) || (x1 >= hx1 && x2 <= hx1)) && ((y1 <= hy1 && y2 >= hy1) || (y1 >= hy1 & y2 <= hy1))){
         if ((Math.abs((y1 - hy1) - (slope * (x1 - hx1))) < 3)){
           onTrack = true;
           indicies.add(i);
           if (j == 1){
              translateMode = 1; 
           }
           //return i;
        }
      }
     }
     
     if (((x1 <= x && x2 >= x) || (x1 >= x && x2 <= x)) && ((y1 <= y && y2 >= y) || (y1 >= y & y2 <= y))){
      if ((Math.abs((y1 - y) - (slope * (x1 - x))) < 10)){
         onTrack = true;
         indicies.add(i);
         //return i;
      }
    }
    
    if (indicies.size() != 0){
     return indicies.get(indicies.size() - 1); 
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
 
 void adjustHitBox(){
      float diffTheta = direction; 
      hitBox[0][0] = x - (50 *cos(diffTheta));
      hitBox[0][1] = y - (50 * sin(diffTheta));
      hitBox[1][0] = x - 51.5388 * cos (diffTheta + 0.2449787);
      hitBox[1][1] = y - 51.388 * sin(diffTheta +  0.2449787);
      hitBox[2][0] = x + 25 * sin(diffTheta);
      hitBox[2][1] = y - 25 * cos(diffTheta);
      hitBox[3][0] = x + 12.5 * sqrt(2) * cos(diffTheta - radians(45));
      hitBox[3][1] = y + 12.5 * sqrt(2) * sin(diffTheta - radians(45));
 }
}
