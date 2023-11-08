// www.lsleditor.org  by Alphons van der Heijden (SL: Alphons Jano)

float senseRange_flag = 3.0;
float senseArc_flag = PI;
float senseRate_flag = 1.0;
float sleep_time = 10.0;

integer food_number = 4;

vector MyScale = ZERO_VECTOR;
vector NewScale = ZERO_VECTOR;

default
{
    state_entry()
    {
        llSleep(sleep_time);
        MyScale = llGetScale();
//        llOwnerSay("My scale is "+(string)MyScale);
//        llOwnerSay("I am searching for flag.");
        llSensorRepeat("flag", NULL_KEY, (PASSIVE|ACTIVE), senseRange_flag, senseArc_flag, senseRate_flag);
    }
    no_sensor()
    {
//        llOwnerSay("No flag Sensed.");
    }
    sensor(integer total_number)
    {
        if (total_number >= food_number)
        {
//            llOwnerSay("There is no food.");
            llDie();
        }
        else
        {
//            llOwnerSay((string)total_number + "food was take.");
            NewScale.x = MyScale.x * (float)(food_number - total_number)/(float)(food_number);
            NewScale.y = MyScale.y * (float)(food_number - total_number)/(float)(food_number);
            NewScale.z = MyScale.z * (float)(food_number - total_number)/(float)(food_number);
            llSetScale(NewScale);
        }
    }
}