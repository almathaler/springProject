# springProject
Line Rider

May 19
+ spent time revamping class structure, and most time spent on 
+ paper sorting out interaction of methods

May 20
+ class:
+  Alex spent time on Track class and made the ArrayList of points and 
+  made somethinga ctually turn up on the screen
+  Alma edited variables in rider class and wrote move() display()

May 21:
+ Alex was sick
+ Alma added isTouching() and fall() to Rider. Also I am thinking that to solve the problem of
+ How downwards momentum is transfered to upwards momentum when the rider goes
+ from downhill to uphill, there should just be a direction variable (either 1 or -1), and
+ when the slope that the rider isOn (isOnTrack()) is positive, update Vy as Vy = Vy * direction. 
+ or do that all the time and only modify direction occasionally.
+ Alma home:
+ I wrote the AffectVel() method but realized a few things:
+ +there should be an internal timer within the method so that for every segment of the track, for which slope differs
+ from the old slope, velocity can be acurately affected (vf = vi + at --> rn t is just sys.currentTimeMilli())
+ +I need to commit more frequently so i remember the things i did
