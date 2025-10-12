using Godot;
using System;

public partial class GameManager : Node
{
    // 
    [Signal] public delegate void UpdateInfoEventHandler();
    
    public void OnProduce(string itemType, int quantity)
    {
        GlobalData.AddItem(itemType, quantity);
        GD.Print($"Producing {quantity} of {itemType}");
        EmitSignal(SignalName.UpdateInfo);
    }
}
