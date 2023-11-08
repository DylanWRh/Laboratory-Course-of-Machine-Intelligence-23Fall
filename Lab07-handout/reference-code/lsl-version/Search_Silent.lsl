// www.lsleditor.org  by Alphons van der Heijden (SL: Alphons Jano)

vector HomePosition = ZERO_VECTOR;
vector FoodPosition = ZERO_VECTOR;
vector MyPosition = ZERO_VECTOR;
vector PhePosition = ZERO_VECTOR;
vector CenterPosition = ZERO_VECTOR;

rotation MyRotation = ZERO_ROTATION;

float ready_time = 2.3;
float step = 1.0;
float step_time = 1.0;
float min_dis = 1.0;

float random_move_angle = 45.0;

string object_one = "Phe";
string object_two = "flag";

float senseRange_Food = 10.0;
float senseArc_Food = PI;
float senseRate_Food = 1.7;

float senseRange_Phe = 8.0;
float senseArc_Phe = PI_BY_TWO;
float senseRate_Phe = 1.7;

random_move()
{
    vector vec = ZERO_VECTOR;
    float angle;
    MyRotation = llGetRot();
    vec = llRot2Euler(MyRotation);
    angle = vec.z * RAD_TO_DEG;
    angle += llFrand(random_move_angle*2.0) - random_move_angle;
    vec = <0.0, 0.0, angle> * DEG_TO_RAD;
    MyRotation = llEuler2Rot (vec);
    llSetRot (MyRotation);
    MyPosition = llGetPos();
    angle *= DEG_TO_RAD;
    MyPosition.x += step * llCos(angle);
    MyPosition.y += step * llSin(angle);
    llSetPos(MyPosition);
}

turn_back()
{
    vector vec = ZERO_VECTOR;
    MyRotation = llGetRot();
    vec = llRot2Euler(MyRotation);
    vec.z += PI;
    MyRotation = llEuler2Rot(vec);
    llSetRot(MyRotation);
}
    

default
{
    state_entry()
    {
        llSensor("Home", NULL_KEY, (PASSIVE|ACTIVE), 96.0, PI);
    }
    sensor(integer total_number)
    {
//        llOwnerSay("----------------");
//        llOwnerSay("Home Sensed.");
        HomePosition = llDetectedPos(0);
//        llOwnerSay("Home is "+(string)HomePosition);
        llSleep(ready_time);
//        llOwnerSay("I am ready.");
        state SEARCH_FOOD;
    }
}

state SEARCH_FOOD
{
    state_entry()
    {
//        llOwnerSay("I am searching for food.");
        llSensorRepeat("Food", NULL_KEY, (PASSIVE|ACTIVE), senseRange_Food, senseArc_Food, senseRate_Food);
    }
    no_sensor()
    {
//        llOwnerSay("No Food Sensed.");
        state SEARCH_PHE;
    }
    sensor(integer total_number)
    {
        integer i;
        for (i = 0; i < total_number; i++)
        {
//            llOwnerSay("Food Sensed.");
            FoodPosition = llDetectedPos(i);
            MyPosition = llGetPos();
            state MOVE_TO_FOOD;
        }
    }
}

state SEARCH_PHE
{
    state_entry()
    {
//        llOwnerSay("I am searching for Phe.");
        llSensorRepeat("Phe", NULL_KEY, (PASSIVE|ACTIVE), senseRange_Phe, senseArc_Phe, senseRate_Phe);
    }
    no_sensor()
    {
//        llOwnerSay("No Phe Sensed.");
        MyPosition = llGetPos();
        random_move();
        state SEARCH_FOOD;
    }
    sensor(integer total_number)
    {
//        llOwnerSay((string)total_number + " Phe Sensed.");
        integer j;
        for (j = 0; j<total_number; j++)
        {
            PhePosition = llDetectedPos(j);
            CenterPosition.x += PhePosition.x;
            CenterPosition.y += PhePosition.y;
        }
        CenterPosition.x /= (float)total_number;
        CenterPosition.y /= (float)total_number;
        MyPosition = llGetPos();
        float x = CenterPosition.x - MyPosition.x;
        float y = CenterPosition.y - MyPosition.y;
        float z = llSqrt(x*x + y*y);
        float angle = llAtan2(x, y);
        MyRotation = llEuler2Rot(<0.0, 0.0, angle>);
        llSetRot(MyRotation);
        MyPosition.x += step*x/z;
        MyPosition.y += step*y/z;
        llSetPos(MyPosition);
        CenterPosition = <0.0, 0.0, 0.0>;
        state SEARCH_FOOD;
    }
}

state MOVE_TO_FOOD
{
    state_entry()
    {
        float distance = llVecDist(MyPosition, FoodPosition);
        float x = FoodPosition.x - MyPosition.x;
        float y = FoodPosition.y - MyPosition.y;
        float z = llSqrt(x*x + y*y);
        float angle = llAtan2(x, y);
        MyRotation = llEuler2Rot(<0.0, 0.0, angle>);
        angle = angle/PI*180.0;
//        llOwnerSay("Food angle is "+(string)angle);
        llSetRot(MyRotation);
        while(distance > min_dis)
        {
            llSleep(step_time);
//            state RE_SEARCH;
            x = FoodPosition.x - MyPosition.x;
            y = FoodPosition.y - MyPosition.y;
            z = llSqrt(x*x + y*y);
            MyPosition.x += step*x/z;
            MyPosition.y += step*y/z;
            llSetPos(MyPosition);
            distance = llVecDist(MyPosition, FoodPosition);
            if (distance < 1.0)
            {
                llRezObject(object_two, FoodPosition, ZERO_VECTOR, ZERO_ROTATION, 1);
//                llOwnerSay("flag rezed.");
                state BACK_HOME;
            }
        }
    }
}

state BACK_HOME
{
    state_entry()
    {
//        llOwnerSay("I am back to home.");
        MyPosition = llGetPos();
        float distance = llVecDist(MyPosition, HomePosition);
        float x = HomePosition.x - MyPosition.x;
        float y = HomePosition.y - MyPosition.y;
        float z = llSqrt(x*x + y*y);
        float angle = llAtan2(x, y);
        MyRotation = llEuler2Rot(<0.0, 0.0, angle>);
        angle = angle/PI*180.0;
//        llOwnerSay("Home angle is "+(string)angle);
        llSetRot(MyRotation);
        while(distance > min_dis)
        {
            llSleep(step_time);
            llRezObject(object_one, llGetPos(), ZERO_VECTOR, ZERO_ROTATION, 1);
            x = HomePosition.x - MyPosition.x;
            y = HomePosition.y - MyPosition.y;
            z = llSqrt(x*x + y*y);
            MyPosition.x += step*x/z;
            MyPosition.y += step*y/z;
            llSetPos(MyPosition);
            MyPosition = llGetPos();
            distance = llVecDist(MyPosition, HomePosition);
        }
//        llOwnerSay("I am back.");
        turn_back();
        state SEARCH_FOOD;
    }
}