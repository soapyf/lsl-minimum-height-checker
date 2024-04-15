float minHeight = 1.5;

llSetLinkText(integer link, string text, vector color){
    llSetLinkPrimitiveParamsFast(link,[PRIM_TEXT,text,color,1]);
}
default
{
    state_entry(){
        llSetLinkText(-1,"",<0,1,0>);
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
                float height = s.z + 0.2;
                if(height<minHeight)
                {
                    short+= [llKey2Name(agent) , llGetSubString((string)height,0,3)];
                }
            }
        }
        
        integer shortNum = llGetListLength(short);
        if(shortNum > 1){
            list text;
            short = llListSortStrided(short,2,1,1);
            integer x; for(; x<shortNum; x+=2){
                text += llList2String(short,x) + " - " + llList2String(short,x+1);
            }
            llSetLinkText(-1,"",<0,1,0>);
            string n;
            x = 0; for(; x<llGetListLength(text); x++){
                n = " \n ";
                integer i = x+1;
                while(i--){
                    n+= " \n ";
                }
                if(x==0){llSetLinkText(x+2,llList2String(text,x) + n,<1,0,0>);}
                else{llSetLinkText(x+1,llList2String(text,x) + n,<1,0,0>);}
            }
            llSetLinkText(1,"agents in region below " + llGetSubString((string)minHeight,0,3) + "m limit" + n + " \n \n ",<1,0,0>);
        }
        else{
            llSetLinkText(-1,"",<0,1,0>);
            llSetLinkText(1,"All agents in region taller than " + llGetSubString((string)minHeight,0,3)+"m",<0,1,0>);
        }
    }
    changed(integer what){
        if(what & CHANGED_LINK){
            llResetScript();
        }
    }
}
