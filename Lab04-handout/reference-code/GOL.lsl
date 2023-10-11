// www.lsleditor.org  by Alphons van der Heijden (SL: Alphons Jano)

float senseRange = 1.45;
float senseArc = PI;
integer length;

default
{
	state_entry()
	{
		llListen(0, "", llGetOwner(), "start");
	}
	on_rez(integer param)
	{
		llResetScript();
	}
	listen(integer channel, string name, key id, string message )
	{
		string object;
		object = llGetObjectName();
		length = llStringLength(object);
		if (length == 4)
		{
			state LIVE;
		}
		else
		{
			state DEATH;
		}
	}
}

state LIVE
{
	state_entry()
	{
		llSensor("live", NULL_KEY, (PASSIVE|ACTIVE), senseRange, senseArc);
	}
	no_sensor()
	{
		llSleep(1.0);
		llSetObjectName("death");
		llSetColor(<1.0, 1.0, 1.0>, ALL_SIDES);
		llResetScript();

	}
	sensor(integer total_number)
	{
		if (total_number <2 || total_number >3)
		{
			llSleep(1.0);
			llSetObjectName("death");
			llSetColor(<1.0, 1.0, 1.0>, ALL_SIDES);
			llResetScript();
		}
		else
		{
			llResetScript();
		}
	}
	state_exit()
	{
		llResetScript();
	}
}

state DEATH
{
	state_entry()
	{
		llSensor("live", NULL_KEY, (PASSIVE|ACTIVE), senseRange, senseArc);
	}

	sensor(integer total_number)
	{
		if (total_number == 3)
		{
			llSleep(1.0);
			llSetObjectName("live");
			llSetColor(<0.0, 1.0, 0.0>, ALL_SIDES);
			llResetScript();
		}
		else
		{
			llResetScript();
		}
	}
	no_sensor()
	{
		llResetScript();
	}
	state_exit()
	{
		llResetScript();
	}
}