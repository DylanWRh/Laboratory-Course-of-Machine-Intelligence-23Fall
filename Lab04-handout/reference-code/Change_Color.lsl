// www.lsleditor.org  by Alphons van der Heijden (SL: Alphons Jano)

integer flag = 0;
string death = "death";
string live = "live";

default
{ 
    on_rez(integer param)
    {
        llResetScript();
    }
    touch_start(integer num_detected)
    {
        if (flag == 0)
        {
            llSetColor(<0.0, 1.0, 0.0>, ALL_SIDES);
            flag = 1;
            llSetObjectName(live);
        }
        else
        {
            llSetColor(<1.0, 1.0, 1.0>, ALL_SIDES);
            flag = 0;
            llSetObjectName(death);            
        }
    }
}
