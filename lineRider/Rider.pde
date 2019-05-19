class Rider{
  float mass, gravityVal, eTotal, GPE, KE; //used to calculate effect on Vs, also if character should die
  float x, y; //position
  float velY, velX; //velocity
  boolean onTrack = false; //when this is false, affectVelY and use gravity
  Rider(float mass, float gravityVal, float eTotal, float GPE, float KE, float x, float y, float velX, float velY){
   this.mass = mass;
   this.gravityVal = gravityVal;
   this.eTotal = eTotal;
   this.GPE = GPE;
   this.KE = KE;
   this.x = x;
   this.y = y;
   this.velY = velY;
   this.velX = velX;
  }
}
