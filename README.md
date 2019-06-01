# springProject
Line Rider

May 19
+ spent time revamping class structure, and most time spent on
+ paper sorting out interaction of methods

May 20
+ created the tool the user will use to draw the track
+ created isPartOf() method for checking if a coordinate intersects with the track

May 21
+ added to the drawing tool to allow it to show the user where the line is
+ following along with the mouse

May 22
+ I (Alex) had strep throat and didn't get much done today

May 23
+ Started integrating the track and the rider in terms of initial movement
+ Began testing rider's movement along the track. As of right now, some of our
+ numbers are off, but we're not far

May 24
+ Added to movement and edited the method which checks which track something is on. Hopefully will smooth out
+ bumps.

May 25
+ 

May 26


May 27
+ Created vehicle. Started working on display and deciding on vehicle shape.

May 28
+ Working on adjusting the angle of the vehicle such that it always rests on top of the track it is on.

May 29
+ Angle adjusts properly the first time and then stops for some reason. I'm working on fixing this bug.

May 30
+ Fixed angle adjustment issues. In order to sense if the rider is touching the track at any point, we decided we
+ should create a hitBox. Started calculations for hitBox.

May 31
+ The hitBox calculations work all except for one. Also rotations of the character are messed up by the hitBox
+ calculations for some reason.

June 1
+ hitBox calculations finally perfected. Working on applying the hitBox to movement.
