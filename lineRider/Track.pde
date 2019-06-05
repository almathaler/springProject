import java.util.*;
import java.io.*;
class Track{
   int type = 1;
   //type 1, 2 and 3 to determine friction values. 1 is normal 2 is added friction and 3 is a lot of friction
   ArrayList<Float> track = new ArrayList<Float>();
   ArrayList<Integer> types = new ArrayList<Integer>(); //will contain the types of the corresponding sections
                                                        //indexing: i of types = i*4 of track
   ArrayList<Integer> connections = new ArrayList<Integer>();
   ArrayList<Integer> backConnections = new ArrayList<Integer>();
   //will have all the connections between segments. will have them by segments number 0, 4, 8

   //Track will be an arraylist of floats ordered {(x1),(y1), (x2),(y2)...}
   //if one point is equal to the last, then it is connected

   public Track(){//for testing purposes
      track = new ArrayList<Float>();
   }

   public void add(Float n, Float m){
     if (track.size() % 4 == 0){ //if you are about to start a new segment
       types.add(type); //take down the type of that segment
     }
     if (track.size() % 4 == 2){ //as in, if you've got the first points down and are adding a second pair
       track.add(n);
       track.add(m);
       checkOrder(track.size() - 4); //and then reorder the points if needed
     }else{ //adding the first points -- do the check for the line previous
       if ((track.size() >= 4) && Math.abs(n-track.get(track.size() - 2)) <= 10 && Math.abs(m-track.get(track.size() - 1)) <= 10){
         n = track.get(track.size() - 2);
         m = track.get(track.size() - 1);
         //if n and m are close enough to the other points (as in the ellipses appear on top of each other),
         //just make them those other points
       }
       track.add(n);
       track.add(m);
     }


   }
   //sees if the two points of a line are in order of closest to origin, farthest. If not, reorders them
   void checkOrder(int i){
     double d1 = Math.sqrt(pow(t.track.get(i), 2) + pow(t.track.get(i+1), 2)); //dist to origin
     double d2 = Math.sqrt(pow(t.track.get(i+2), 2) + pow(t.track.get(i+3), 2));
     if (d2 < d1){ //if point2 is clsoer to origin than point1
        float x2 = t.track.get(i);
        float y2 = t.track.get(i+1);
        t.track.set(i, t.track.get(i+2));
        t.track.set(i+1, t.track.get(i+3));
        t.track.set(i+2, x2);
        t.track.set(i+3, y2);
        //if point2 is closer to origin, make that point1 and the other point2
    }
   }

   public float getMu(int type){
     switch(type){
       case 1:
         return 0.0;
       case 2:
         return 0.10;
       case 3:
         return 0.15;
     }
     return 0.0;
   }
   //this is for impact. if the rider falls too quick, die, but the momentum threshold should
   //be different for every segment. mv = change in force, which is impulse, so if impulse is higher than
   //2 times the normal force of the character (since 2 * mass * gravityVal), die.
   //but different sections will cushion differently. for instance, black should cushion the least: cushion is 0
   // orange can cushion 10 percent of the fall
   // red can cushion 20
   //so impact will be mass * vel - (t.getCushion(t.types.get(i/4)) * mass * vel)
   //for falls vel is velY
   public float getCushion(int type){
    switch(type){
     case 1:
       return 0.0;
     case 2:
       return 0.1;
     case 3:
      return 0.2;
    }
    return 0.0;
   }
   //builds the connections() array
   boolean finalizeConnections(){
    connections.clear(); //if like stopped
    backConnections.clear();
    for (int k = 0; k<track.size() - 3; k+=4){
      backConnections.add(-1); //make everything in backConnections -1 so that if a certain segment isn't connected from the back,
                               //backConnections jsut doesn't have to be modified
    }
    for (int i = 0; i<track.size()-3; i+=4){
      isConnected(i);
    }
    System.out.println("connections: " + connections);
    System.out.println("backConnections : " + backConnections);
    return true;
   }

   public boolean isConnected(int i){ // the purpose of this method is to take the index of the first value for a piece of the track and determine if it is connected to another part
      if (i < 0){
        return false;
      }
      //didn't need other if, if i = 0 this will still work
     if (track.size() > i + 4){ //only checks the pieces added after it
         //if they are the same points, which will happen if user
         //chose two points within 10px of each other
        for (int k = 4; k < (track.size() - (i+3)); k +=4){ //go thru every set of points after this one, k is what you add to i
          if (track.get(i + 2) == track.get(i + k) && track.get(i + 3) == track.get(i + (k+1))){//if connected at the front and i != 0
            connections.add(i/4, (i+k)); //add to the connections list at this segment's spot the segment that it si connected to
            backConnections.set((i+k)/4, i); //and then add backConnections so that it registers that (i+k) is connected to i from the back
            return true;
          }
        }
      }
        /*
        if (i >= 4){
            if (Math.abs(track.get(i) - track.get(i - 2)) <= 10 && Math.abs(track.get(i + 1) - track.get(i - 1)) <= 10){//if connected at the back? maybe this is unnecessary
               return true;
            }
        }
        */
        //have to comment this out, bc game can't consider the last piece connected to another or else the getSlope gives out of bounds since
        //onTrack variable assigned to something out of range
     connections.add(i/4, -1); //make it false
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
         //for testing
         ellipseMode(CENTER);
         fill(0, 0, 255);
         ellipse(track.get(i), track.get(i+1), 10, 10);
         //textSize(20);
         
         ellipse(track.get(i+2), track.get(i+3), 10, 10);
         fill(255, 0, 0);
         //textSize(32);
         //float theta = atan((track.get(i+3)-track.get(i+1)) / (track.get(i+2)-track.get(i)));
         //String s = theta + "";
         //String f = "force: " + (sin(theta) * 50 * 20);
         //text(s, (track.get(i+2)+track.get(i))/2.0 +15 , (track.get(i+3)+track.get(i+1))/2.0); //put the slope at the midpoint
         //text(f, (track.get(i+2)+track.get(i))/2.0 +15 , (track.get(i+3)+track.get(i+1))/2.0 - 30);
        }
      }
     strokeWeight(1); //so balll isn't heavy
     stroke(0, 0, 0); //set back to black
     //System.out.println("types: " + types);
    }
}
