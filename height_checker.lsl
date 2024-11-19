float minHeight = 1.5;

default
{
    state_entry()
    {
        llSetText("",<0,1,0>,1);
        llSetTimerEvent(5);
    }
    timer()
    {
        list short;
        list agents = llGetAgentList(AGENT_LIST_REGION,[]);
        integer index = llGetListLength(agents) + 1;
        

        // Create a list of agents in region whos height is below minHeight
        while(index-- >0)
        {
            key agent = llList2String(agents,index);
            if(agent!="" && agent!=NULL_KEY)
            {
                vector s = llGetAgentSize();

                // We need to add 0.2m the the height because as a fix to objects hovering with a gap between them when physical -
                // sometime in 2010 0.1m was subtracted mathmatically from all sides of objects physics shape.
                // llGetAgentSize and OBJECT_SCALE incorrectly subtract this value from avatars collision shape -
                // which is not affected by that change thus returns an incorrect value 0.2m shorter than the actual collidable height

                float height = s.z + 0.2; 
                
                if(height<minHeight)
                {
                    short+= [llKey2Name(agent) , llGetSubString((string)height,0,3)];
                }
            }
        }

        // Sort the list by height descending
        short = llListSortStrided(short,2,1,0);
        integer shortNum = llGetListLength(short);

        // Create a new list from our sorted list of agents to dump to text
        if(shortNum > 0)
        {
            list text;
            integer x; for(; x<shortNum; x+=2)
            {
                text += llList2String(short,x) + " - " + llList2String(short,x+1);
            }
            llSetText((string)llGetListLength(text) + " agents in region below " + llGetSubString((string)minHeight,0,3) + "m height limit" + " \n \n " + llDumpList2String(text,"\n"),<1,0,0>,1);
        }
        else
        {
            llSetText("All agents in region taller than " + llGetSubString((string)minHeight,0,3)+"m",<0,1,0>,1);
        }
    }
}
