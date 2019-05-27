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
+ a few transitory changes since we merged. stuff like moving move decisions to move
+ instead of display, fixing issues like the ball going so fast it misses other segments
+ of the track etc

May 26
+ there was a hard coded fix to impact, which was making velY 0 after a fall
+ however if the ball fell thru a one pixel crack, it could no longer go up
+ the next segment's incline. so fixed that. Just a lot of fiddling

May 27
+ a big overhaul. Changed rider completely so that there is only one velocity 
+ and a direction. This fixed a lot of things like not rolling back down an 
+ incline once the speed got too slow
+ also added different types of lines (1, 2, 3 key press) with different frictions
+ also fixed up isConnected() and checkIfOnTrack() so that rolling thru segment 
+ problem no longer exists
