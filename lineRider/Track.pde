import java.util.*;
import java.io.*;
class Track{
   int type = 1;
   //type 1, 2 and 3 to determine friction values. 1 is normal 2 is added friction and 3 is a lot of friction
   ArrayList<Float> track = new ArrayList<Float>();
   ArrayList<Integer> types = new ArrayList<Integer>(); //will contain the types of the corresponding sections
                                                        //indexing: i of types = i*4 of track
   //Track will be an arraylist of floats ordered {(x1),(y1), (x2),(y2)...}
   //if one point is equal to the last, then it is connected
   
   public Track(){//for testing purposes
      track = new ArrayList<Float>();
   }
   
   public void add(Float n, Float m){
     if (track.size() % 4 == 0){ //if you are about to start a new segment
       types.add(type); //take down the type of that segment
     }
     track.add(n);
     track.add(m);
   }
   
   
   public boolean isConnected(int i){ // the purpose of this method is to take the index of the first value for a piece of the track and determine if it is connected to another part
      if (i < 0){
        return false;
      }
      if (i == 0 && track.size() > 4){
          if (Math.abs(track.get(2) - track.get(4)) <= 10 && Math.abs(track.get(3) - track.get(5)) <= 10){//if connected at the front
            return true;
          }
      } else {
        if (track.size() > i + 4){
          if (Math.abs(track.get(i + 2) - track.get(i + 4)) <= 10 && Math.abs(track.get(i + 3) - track.get(i + 5)) <= 10){//if connected at the front and i != 0
           return true; 
          }
        }
        if (i >= 4){
            if (Math.abs(track.get(i) - track.get(i - 2)) <= 10 && Math.abs(track.get(i + 1) - track.get(i - 1)) <= 10){//if connected at the back? maybe this is unnecessary
               return true; 
            }
        }
      }
     
     
     return false;
   }
  
    
    public void display(){
      strokeWeight(4);
      for (int i = 0; i < track.size(); i += 4){
        switch(types.get(i/4)){ //get the corresponding color
           case 1: 
             stroke(0, 0, 0); //black
             break;
           case 2:
             stroke(255, 141, 0); //orange
             break;
           case 3:
             stroke(255, 0, 0); //red
             break;
          }
        if (i == track.size() - 2){           //for implementing a feature where the user can see the line that they are drawing before confirming it
          //pushMatrix();
          line(track.get(i), track.get(i + 1), mouseX, mouseY);
          //popMatrix();
        } else
        if (i < track.size() - 3){
         
         line(track.get(i), track.get(i + 1), track.get(i + 2), track.get(i + 3)); 
        }
      }
     strokeWeight(1); //so balll isn't heavy
     stroke(0, 0, 0); //set back to black
     //System.out.println("types: " + types);
    }
    
   
    
    
}
