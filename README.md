# lsl-minimum-height-checker
A script with hover text display to keep track of agents in a region who's height does not meet a set requirement


Simply create an object and place this script inside to get working.
Change the minimum height at the top of the script.


0.2m is added to the height of agents because of a change to the SL havok implimentation that subtracts 0.1m from all sides of an objects physics shape to prevent a gap when physical
This modification is not performed on avatars but functions like llGetAgentSize(); and llGetObjectDetails(agent,[OBJECT_SCALE]); Return a value with the 0.1m subtracted
