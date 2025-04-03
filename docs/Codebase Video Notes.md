## Intro
- Crimson Needle 2.5 spoilers :ooo
- First I was going to make Quiet Evening Calm Wind. I story driven platformer with a wind mechanic.
- Talk about the cutscene. The story about the robot, and the mad scientist.
- Repurposing Stage 2 of a scrapped project instead (POST-SUDOKU)
- Porting (Nader helped with the recreation of the rooms in GMS1)
- Not much had to be changed to port the GMS2.3 project to GMS1.4 since it wasn't using new GML apis, nor was it using any of the new resource types.

## Cool things in the codebase

What some people point out right off the bat is "wow, there's a map window."
Gamemaker doesn't outright have any functionality that makes it easy to create a bigger map out of multiple rooms. And once you've worked in the room editor for a while you'll notice it start to slow down. And painting tiles gets slower. Placing objects gets slower. So you're practically forced to blindly connect them by creating warps in between, and doing something like creating a script that returns a bunch of information about the room.

Well. That's not what I decided to do. I started out not thinking this was going to be as big as it turned out to be. So I just started out putting things into the 