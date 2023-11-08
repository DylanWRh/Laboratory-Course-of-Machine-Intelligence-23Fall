
default
{
    state_entry()
    {
        llListen(0, "", llGetOwner(), "die");
    }
    listen( integer channel, string name, key id, string message )
    {
//        llOwnerSay("Bye");
        llDie();
    }
}