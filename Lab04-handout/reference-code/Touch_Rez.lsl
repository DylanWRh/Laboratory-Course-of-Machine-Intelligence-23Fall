// www.lsleditor.org  by Alphons van der Heijden (SL: Alphons Jano)

string objectName = "box";

integer side = 5;
integer i;
integer j;
float time = 1.0;

default
{
	touch_start(integer total_number)
	{
		for (i = 1; i < side; i++)
		{
			for (j = 1; j < side; j++)
			{
				vector offset = <(float)i, (float)j, 0.0>;
				llRezObject(objectName, llGetPos()+ offset, ZERO_VECTOR, ZERO_ROTATION, 0);
				llSleep(time);
			}
		}
	}
}