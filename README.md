# springProject
Line Rider

## May 19
+ spent time revamping class structure, and most time spent on
+ paper sorting out interaction of methods

## May 20
+ created the tool the user will use to draw the track
+ created isPartOf() method for checking if a coordinate intersects with the track

## May 21
+ added to the drawing tool to allow it to show the user where the line is
+ following along with the mouse

## May 22
+ I (Alex) had strep throat and didn't get much done today

## May 23
+ Started integrating the track and the rider in terms of initial movement
+ Began testing rider's movement along the track. As of right now, some of our
+ numbers are off, but we're not far

## May 24
# Alma
+ a few transitory changes since we merged. stuff like moving move decisions to move
+ instead of display, fixing issues like the ball going so fast it misses other segments
+ of the track etc
# Alex
+ Added to movement and edited the method which checks which track something is on. Hopefully will smooth out
+ bumps.

## May 26

+ there was a hard coded fix to impact, which was making velY 0 after a fall
+ however if the ball fell thru a one pixel crack, it could no longer go up
+ the next segment's incline. so fixed that. Just a lot of fiddling


## May 27
# alma
+ a big overhaul. Changed rider completely so that there is only one velocity
+ and a direction. This fixed a lot of things like not rolling back down an
+ incline once the speed got too slow
+ also added different types of lines (1, 2, 3 key press) with different frictions
+ also fixed up isConnected() and checkIfOnTrack() so that rolling thru segment
+ problem no longer exists
# Alex
+ Created vehicle. Started working on display and deciding on vehicle shape.

## May 28
# alma
+ a lot of deliberation as to how a ball should be able to detect if, while it's
+ on one segment, it's hitting another (preperation for impact aspcet)
+ didn't get to actual coding this though, so caught up on the bugs in
+ current version
# alex
+ Working on adjusting the angle of the vehicle such that it always rests on top of the track it is on.

## May 29
# alma
+ wrote the checkIfIntersecting() method, but haven't tested it or used it
+ because I got caught up in how the ball can't do a loop because
+ it just goes to the top of a line. For example in this course:
   \
 \_/, you would think the ball at least somewhat goes upside down. but instead
 it travels like: \_/\ ! bc lines are considered as slopes and not objects, and because
 using atan() meant theta could only be between 3pi/2 and pi/2 (in processing pi/2 is where 3pi/s is expected to be).
+ to start fixing the above problem, i transitioned from atan to atan2, cause a
+ lot of problems though becuase i didn't realize the parameters need to be as
+ atan2(y, x) instead of atan2(x, y).
# Alex
+ Angle adjusts properly the first time and then stops for some reason. I'm working on fixing this bug.

## May 30
# Alex
+ Fixed angle adjustment issues. In order to sense if the rider is touching the track at any point, we decided we
+ should create a hitBox. Started calculations for hitBox.
# Alma
+ no commits but reverted back to atan() and drafted checkIfIntersection
## May 31
# Alex
+ The hitBox calculations work all except for one. Also rotations of the character are messed up by the hitBox
+ calculations for some reason.
# Alma
+ Spent the day fixing how the player falls between tracks
## June 1
# Alex
+ hitBox calculations finally perfected. Working on applying the hitBox to movement.
# Alma
+ spent more time fixing the ball's movment, seems like one step back is another step back 
in an unknown direction
## June 2
# Alma and Alex
+ time perfectin what we have been working on this weekend, merged. Looked So weird
