// www.lsleditor.org  by Alphons van der Heijden (SL: Alphons Jano)

float time = 200.0;

default
{
    state_entry()
    {
        llSetTimerEvent(time);
    }

    timer()
    {
        llOwnerSay("Bye.");
        llDie();
    }

}