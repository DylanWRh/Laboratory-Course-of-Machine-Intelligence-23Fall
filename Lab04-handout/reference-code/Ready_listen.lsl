
default
{
    state_entry()
    {
        llListen(0, "", llGetOwner(), "ready");
    }
    on_rez(integer param)
    {
        llResetScript();
    }
    listen(integer channel, string name, key id, string message )
    {
        llSetObjectName("death");
        llSetColor(<1.0, 1.0, 1.0>, ALL_SIDES);
    }
}