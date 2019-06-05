//Final project!
//Final project!
//fields
//LineRiderGame game;
PFont font;
boolean wonGame;
PImage openingImage;
Rider guy;
Vehicle bike; 
Track t = new Track();
int currentLevel = 0;
Boolean doneWithTrack = false;
Boolean started = false;
Boolean stopped = false;
Boolean exitTitle = false;
//Boolean restart = false;
Boolean clear = false;
LineRiderGame game = new LineRiderGame(100, 100);
int[][] levels = { // 4 levels (can be changed ofc) each stores an startX, startY, endX, endY
                   //index 0 = startX, index 1 = startY, index 2 = endX, index 3 = endY, index 4 and 5 are size of star
                  {100, 100, 1100, 700, 30, 70},
                  {1100, 100, 100, 700, 30, 70},
                  {600, 100, 100, 700, 30, 70},
                  {100, 300, 1100, 400, 15, 35},
                  {500, 500, 500, 700, 15, 35},
                  {300, 200, 1000, 750, 15, 35},
                  {1100, 500, 100, 750, 7, 17},
                  {600, 100, 400, 250, 7, 17},
                  {400, 400, 150, 500, 7, 17}
};
class LineRiderGame{
  Rider guy;
  float startX, startY;
  String time;
  int startTime = 0;
  //i also made gravity val a field for the rider. but maybe rider should be
  //made by lineRiderGame?
  //i decided to make massChar and energyTotal fields for the Rider
  //since the game board itself isn't really affected by that, and Rider
  //is a parameter in the constructor not made by the game itself (can be changed)
  LineRiderGame(float startX, float startY){
    this.startX = startX;
    this.startY = startY;
    startTime = millis() / 1000;
    //assuming gravity will be 9.81
    //should this be calculated from the first platform or from the ground?
    //float GPE = 9.81 * 50.0 * (height - startY); 
    guy = new Rider(50, 20, startX, startY, 0.0, 0.0, t);
  }
  void display(){
    time = "" + ((millis() /1000) - startTime) ;
    textSize(20);
    fill(85, 160, 74);
    text("time: " + time, 1100, 50);
    fill(188, 188, 55);
    //this is to rotate the star
    pushMatrix();
    translate(levels[currentLevel][2], levels[currentLevel][3]);//moves to the endX and endY of the current level
    rotate(frameCount / -100.0);
    star(0, 0, levels[currentLevel][4], levels[currentLevel][5], 5); 
    popMatrix();
    
  }
}

void keyPressed(){
   if (key ==  CODED){
     if (keyCode == SHIFT){// if the track is finished, this will become true. Helps so that the rider doesn't fall until track is done. basically starts the game
        doneWithTrack = true; 
        t.finalizeConnections();
        System.out.println();
     }
   }
   if (key == BACKSPACE || key == DELETE){
       if (!doneWithTrack){
         t.track.remove(t.track.size()-1);
         t.track.remove(t.track.size()-1);
         t.track.remove(t.track.size()-1);
         t.track.remove(t.track.size()-1); //remove the last four points
       }
     }
   //if (key == 'w'){
   // wonGame = true; 
  // }
   if (key == 's' || key == 'S'){
    stopped = true; 
   }
   if (key == 'e' || key == 'E' ){
    t.finalizeConnections();
    stopped = false; 
   }
   if (key == 'q' || key == 'Q'){ //put at top of game
    //restart = false; 
    setup();
   }
   if (key == '1'){
     t.type = 1;
   }
   if (key == '2'){
     t.type = 2;
   }
   if (key == '3' ){
     t.type = 3;
   }
}



void setup(){
  size(1200, 800);
  t = new Track();
  font = loadFont("ArialRoundedMTBold-32.vlw");
  openingImage = loadImage("opening.png");
  doneWithTrack = false;
  started = false;
  stopped = false;
  //restart = false;
  clear = false;
  
  game = new LineRiderGame(levels[currentLevel][0], levels[currentLevel][1]);
  
}

void draw(){
  background(255);
 // t.display();
  levelCompleted();
  
  if (game.guy.deadScreen == true){
     pushMatrix();
     translate(600, 400);
     fill(226, 170, 234);
     //rect(0, 0, 300, 80, 10, 10, 10, 10);
     fill(5, 5, 5);
     //textSize(32);
     textFont(font, 32);
     text("You Died!", -80, 0);
     text("Press Q to try again", -160, 50);
     popMatrix();
      //make the border
     fill(226, 170, 234);
     rect(10, 10, 1180, 20);
     rect(10, 770, 1180, 20);
  }else{
    if (wonGame){
    pushMatrix();
     translate(600, 400);
     fill(226, 170, 234);
     //rect(0, 0, 300, 80, 10, 10, 10, 10);
     fill(5, 5, 5);
     //textSize(32);
     textFont(font, 32);
     text("You Won!", -85, 0);
     popMatrix();
     //make the border
     fill(226, 170, 234);
     rect(10, 10, 1180, 20);
     rect(10, 770, 1180, 20);
    } else {
    if (doneWithTrack && !stopped && !clear){
      if (!started){
         game.guy.timeCounter = 0;
         started = true;
      }
      game.guy.move();
      game.guy.framer = frameRate;
    }
    if (exitTitle){ //if you exited the title by pushing 'click here to play'
      t.display();
      game.display();
      game.guy.display();
    }else{
      //make the button
     pushMatrix();
     translate(450, 600);
     fill(226, 170, 234);
     rect(0, 0, 300, 80, 10, 10, 10, 10);
     fill(5, 5, 5);
     //textSize(32);
     textFont(font, 32);
     text("Click Here to Play", 11, 50);
     popMatrix();
     //make the border
     fill(226, 170, 234);
     rect(10, 10, 1180, 20);
     rect(10, 770, 1180, 20);
     
     //put lineRider
     image(openingImage, 300, 200);
    }
    //levelCompleted();
    }
  }  
}


void mouseClicked(){
  if (exitTitle){
    if (!doneWithTrack || stopped){
       t.add(mouseX + 0.0, mouseY + 0.0); 
    }
  }else{ 
   if(mouseX < 750 && mouseX > 450 && mouseY < 700 && mouseY > 500){
    exitTitle = true; 
   }
  }
  
}

//took from example in processing reference
void star(float x, float y, float radius1, float radius2, int npoints) {
    float angle = TWO_PI / npoints;
    float halfAngle = angle/2.0;
    beginShape();
    for (float a = 0; a < TWO_PI; a += angle) {
      float sx = x + cos(a) * radius2;
      float sy = y + sin(a) * radius2;
      vertex(sx, sy);
      sx = x + cos(a+halfAngle) * radius1;
      sy = y + sin(a+halfAngle) * radius1;
      vertex(sx, sy);
    }
    endShape(CLOSE);
}

void levelCompleted(){
   if (pow(game.guy.x - levels[currentLevel][2], 2) + pow(game.guy.y - levels[currentLevel][3], 2) - pow(levels[currentLevel][5], 2) < 10){
     if (currentLevel == levels.length - 1){
         endScreen();
     } else {
      currentLevel++;
      setup();
      System.out.println("" + currentLevel);
     }
   }
}

void endScreen(){
  wonGame = true;
}
