float minHeight = 1.5;

default
{
    state_entry(){
        llSetText("",<0,1,0>,1);
        llSetTimerEvent(5);
    }
    timer(){
        list short;
        list agents = llGetAgentList(AGENT_LIST_REGION,[]);
        integer index = llGetListLength(agents) + 1;
        
        while(index-- >0){
            key agent = llList2String(agents,index);
            if(agent!="" && agent!=NULL_KEY)
            {
                vector s = llList2Vector(llGetObjectDetails(agent, [OBJECT_SCALE]), 0);
                float height = s.z + 0.2; // this is done because havok in SL adds 0.1m to every face of a physics shape
                if(height<minHeight)
                {
                    short+= [llKey2Name(agent) , llGetSubString((string)height,0,3)];
                }
            }
        }
        
        integer shortNum = llGetListLength(short);
        if(shortNum > 1){
            list text;
            short = llListSortStrided(short,2,1,0);
            integer x; for(; x<shortNum; x+=2){
                text += llList2String(short,x) + " - " + llList2String(short,x+1);
            }
            llSetText((string)llGetListLength(text) + " agents in region below " + llGetSubString((string)minHeight,0,3) + "m height limit" + " \n \n " + llDumpList2String(text,"\n"),<1,0,0>,1);
        }
        else{
            llSetText("All agents in region taller than " + llGetSubString((string)minHeight,0,3)+"m",<0,1,0>,1);
        }
    }
}
