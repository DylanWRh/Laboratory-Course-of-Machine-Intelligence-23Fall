// www.lsleditor.org  by Alphons van der Heijden (SL: Alphons Jano)

string objectName = "ant";

float time = 10.3;
float range = 3;

integer number = 1;
integer i;

float angle;
vector vec;
rotation rot;

default
{
    touch_start(integer total_number)
    {
        llSleep(1.0);
        for (i = 0; i < number; i++)
        {
            angle = llFrand (PI_BY_TWO/2);
            rot = llEuler2Rot (<0.0, 0.0, angle>);
            vector offset = <0.0, 0.0, 0.0>;
            offset.x += llFrand(range);
            offset.y += llFrand(range) - range/2;
            llRezObject(objectName, llGetPos()+ offset - <0.0, 0.0, 0.5>, ZERO_VECTOR, rot, 0);
            llSleep(time);
        }
    }
}