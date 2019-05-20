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
      for (int i = 0; i < track.size() - 3; i += 4){
         line(track.get(i), track.get(i + 1), track.get(i + 2), track.get(i + 3)); 
      }
    }
    
   
    
    
}
