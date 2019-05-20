import java.util.*;
import java.io.*;
class Track{
   ArrayList<Float> track = new ArrayList<Float>();
   //Track will be an arraylist of floats ordered {(x1),(y1), (x2),(y2)...}
   //if one point is equal to the last, then it is connected
   
   public Track(){//for testing purposes
      track = new ArrayList<Float>();
   }
   
   public void add(Float n, Float m){
     track.add(n);
     track.add(m);
   }
   
  
    
    public void display(){
      for (int i = 0; i < track.size(); i += 4){
        /*if (i == track.size() - 2){           //for implementing a feature where the user can see the line that they are drawing before confirming it
          pushMatrix();
          line(track.get(i), track.get(i + 1), mouseX, mouseY);
          popMatrix();
        } else */
        if (i < track.size() - 3){
         line(track.get(i), track.get(i + 1), track.get(i + 2), track.get(i + 3)); 
        }
      }
    }
    
   
    
    
}
