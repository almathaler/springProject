class Track{
   ArrayList<TrackSegment> track = new ArrayList<TrackSegment>();
   
   public Track(TrackSegment n){//for testing purposes
      track.add(n); 
   }
  
  class TrackSegment{//embedded class of TrackSegments, which ultimately make up the track
  
    float startX, startY, endX, endY, slope, theta;
    boolean isAttached;
    
    public TrackSegment(float X1, float Y1, float X2, float Y2){
      startX = X1;
      startY = Y1;
      endX = X2;
      endY = Y2;
      slope = (endY - startY) / (endX - startX);
      theta = atan(slope);
    }
    
    public void display(){
      line(startX, startY, endX, endY);
    }
    
   
    
    
  }
   void setup(){
      size(400, 400);
      TrackSegment m = new TrackSegment(50, 200, 350, 200);
       Track b = new Track(m);
    }
    
    void draw(){
       for (int i = 0; i < track.size(); i++){
          track.get(i).display(); 
       }
    }
}
