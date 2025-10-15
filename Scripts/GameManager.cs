using Godot;
using System;

public partial class GameManager : Node
{
    // 
    [Signal] public delegate void UpdateInfoEventHandler();

    private void OnActivate(string target)
    {
        switch (target)
        {
            case "mine":
                StoneProduced();
                break;
            case "furnace":
                StoneExpend();
                break;
            default:
                GD.PrintErr("UNKNOWN ACTIVATION");
                break;
        }
    }

    private void StoneProduced()
    {
        GlobalData.AddItem("stone",1);
        EmitSignalUpdateInfo();
        GD.Print("Stone has added");
    }

    private void StoneExpend()
    {
        GlobalData.AddItem("stone",-1);
        EmitSignalUpdateInfo();
        GD.Print("Stone has added");
    }
}
