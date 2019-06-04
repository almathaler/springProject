# springProject
Line Rider
# DESCRIPTION
Line Rider game, draw lines and the rider will ride the path. Try to bring the rider into the star to progress to a new screen
With a new location of the star.
# HOW TO PLAY
Playing this game is pretty simple. 
Use your mouse to click to make lines. 
Click once for the first point; then click again for the second.
Press shift to start, s to stop, e to continue and q to restart. 
You can delete sections of the track if you are in drawing mode (when s is pressed or shift 
not yet pressed) by pressing BACKSPACE or DELETE.
Enjoy watching the rider glide down your slopes! But make sure to add no loops :/
# DEV LOG
## May 17
### Alma
+ Made the repo, everything empty
## May 19
### We worked together
+ spent time revamping class structure, and most time spent on
+ paper sorting out interaction of methods

## May 20
### Alex
+ created the tool the user will use to draw the track
+ created isPartOf() method for checking if a coordinate intersects with the track

## May 21
### Alex
+ added to the drawing tool to allow it to show the user where the line is
+ following along with the mouse
### Alma
+ I was still figuring out the movement on paper

## May 22
+ I (Alex) had strep throat and didn't get much done today
### Alma
+ More work on the Rider class, put it in processing and did testing. Found ball will roll 
  through slopes if velocity is too fast, found appropriate values for gravity and mass

## May 23
### Alex
+ Started integrating the track and the rider in terms of initial movement
+ Began testing rider's movement along the track. As of right now, some of our numbers are off, but we're not far
### Alma
+ Spruced up calctheta, realized that in processing unit circle goes 0 --> pi/2 --> pi clockwise so 
  theta value of lines weren't actually wrong

## May 24
### Alma
+ a few transitory changes since we merged. stuff like moving move decisions to move
 instead of display, fixing issues like the ball going so fast it misses other segments
 of the track etc
### Alex
+ Added to movement and edited the method which checks which track something is on. Hopefully will smooth out bumps.

## May 26
### Alma
+ there was a hard coded fix to impact, which was making velY 0 after a fall
  however if the ball fell thru a one pixel crack, it could no longer go up
  the next segment's incline. so fixed that. Just a lot of fiddling
+ fixes to ball not being able to make it up inclines


## May 27
### Alma
+ a big overhaul. Changed rider completely so that there is only one velocity
  and a direction. This fixed a lot of things like not rolling back down an
  incline once the speed got too slow
  also added different types of lines (1, 2, 3 key press) with different frictions
  also fixed up isConnected() and checkIfOnTrack() so that rolling thru segment
  problem no longer exists
 + added key pressing, s and e to stop and draw
 + edited isConnected()
### Alex
+ Created vehicle. Started working on display and deciding on vehicle shape.

## May 28
### alma
+ a lot of deliberation as to how a ball should be able to detect if, while it's
  on one segment, it's hitting another (preperation for impact aspcet)
  didn't get to actual coding this though, so caught up on the bugs in
  current version
+ added a lot of testing code, like writing current vel on screen and tried out using millis() instead of 1/framer
  found that it was harder to make the transitions between lines smooth. but so far looks quite nicee
### alex
+ Working on adjusting the angle of the vehicle such that it always rests on top of the track it is on.

## May 29
### alma
+ wrote the checkIfIntersecting() method, but haven't tested it or used it
  because I got caught up in how the ball can't do a loop because
  it just goes to the top of a line. For example in this course:
   \
 \_/, you would think the ball at least somewhat goes upside down. but instead
 it travels like: \_/\ ! bc lines are considered as slopes and not objects, and because
 using atan() meant theta could only be between 3pi/2 and pi/2 (in processing pi/2 is where 3pi/s is expected to be).
 to start fixing the above problem, i transitioned from atan to atan2, cause a
 lot of problems though becuase i didn't realize the parameters need to be as
 atan2(y, x) instead of atan2(x, y).
### Alex
+ Angle adjusts properly the first time and then stops for some reason. I'm working on fixing this bug.

## May 30
### Alex
+ Fixed angle adjustment issues. In order to sense if the rider is touching the track at any point, we decided we
+ should create a hitBox. Started calculations for hitBox.
### Alma
+ no commits but reverted back to atan() and drafted checkIfIntersection. more and more testing, ball keeps bouncing when it hits another segment of the track
## May 31
### Alex
+ The hitBox calculations work all except for one. Also rotations of the character are messed up by the hitBox
+ calculations for some reason.
### Alma
+ Spent the day fixing how the player falls between tracks. tested using checkIntersections() which ultimately was dropped (just please, player, don't draw intersecting lines) and decided on hacky method that will j place vehicle (split second) where it should be if it starts falling when it shouldn't.
# June 1
### Alex
+ hitBox calculations finally perfected. Working on applying the hitBox to movement.
### Alma
+ spent more time fixing the ball's movement, seems like one step back is another step back 
in an unknown direction. But fixed up the catch in move where the player is suddenly no longer on the track. Took a while because we also were preparing to merge
## June 2
### Alma and Alex
+ time perfectin what we have been working on this weekend, merged. Looked So weird. Took a long time to merge because of how long we spent on seperate branches
## June 3
## Alma
+ small things like deleting lines and making the title screen. Whenever either one of us makes a small change, seems like something completely unrelated is screwed so a lot of edits. Also started to search through code to find out why the vehicle falls straight down and not parabolically.
+ added the star goalpost
## Alex 
+ Rider adjusting to slope kinda doesn't work after the merge, tried to fix that up but proved really difficult
+ added levels
## June 4
## Alma
+ wrote impact and how you can die if you fall from too high
## Alex
+ wrote death animation
