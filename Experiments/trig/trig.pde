void setup(){
  size(1400, 1400);
  fill(0, 0, 0);
  ellipse(400, 400, 200, 200);
  fill(255, 0, 0);
  textSize(32);
  text("0", 400 + 200*cos(0.0), 400+ 200*sin(0.0));
  text("pi/2", 400+200*cos(PI/2.0), 400+200*sin(PI/2.0));
  text("pi", 400+ 200*cos(PI), 400+ 200*sin(PI));
  text("3pi/2", 400+200*cos(3 * PI/2.0), 400+200*sin(3 *PI/2.0));  
}
