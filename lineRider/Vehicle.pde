class Vehicle{
  int timeCounter = 0;
  float mass, gravityVal;
  float x, y;
  float w1x, w1y; //(wheel1x, wheel1y)
  float w2x, w2y; // wheel 2
  float w1VelX, w1VelY, w1VelXo, w1VelYo;// velocities for wheel1 and their holders;
  float w2VelX, w2VelY, w2VelXo, w2VelYo; // same for wheel2
  Track t;
  boolean onTrackW1 = false;
  boolean onTrackW2 = false;
  int direction = 1;
  float theta1, theta2; //An angle for each wheel
  
  public Vehicle(float x, float y, Track t, float mass, float gravityVal){
     this.x = x;
     this.y = y;
     this.t = t;
     this.mass = mass;
     this.gravityVal = gravityVal;
     w1x = x - 25;
     w1y = y + 100;
     w2x = x + 25;
     w2y = y + 100;
  }
  
  void display(){
      ellipse(w1x, w1y, 10, 10);
      ellipse(w2x, w2y, 10, 10);
      beginShape();
      vertex(x + 50, y);
      vertex(x - 50, y);
      vertex(x - 75, y - 25);
      endShape();
      
      
  }
}
