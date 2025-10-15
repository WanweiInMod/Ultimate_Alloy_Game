using Godot;
using System;
using System.Collections.Generic;
using System.Text.Json;

public partial class GlobalData : Node
{
    // 资源数据
    private static Dictionary<string, int> _items = new Dictionary<string, int>()
    {
        {"stone",0},
        {"cash",0},
        {"copper",0},
        {"iron",0},
        {"silver",0},
        {"gold",0}
    };
    
    // 设施数据
    private static Dictionary<string, int> Facilities = new Dictionary<string, int>()
    {
        {"furnace",0},
        {"miner",0}
    };

    // —————— 资源管理函数 ——————
    public static void AddItem(string itemName, int amount)
    {
        if (_items.ContainsKey(itemName))
        {
            _items[itemName] += amount;
            GD.Print($"{amount.ToString()} {itemName} added.");
        }
        else
        {
            GD.PrintErr($"Item {itemName} not found in inventory.");
            return;
        }

        GD.Print($"{amount} of {itemName} added to inventory.");
    }

    public static int GetItem(string itemName)
    {
        if (_items.ContainsKey(itemName))
        {
            return _items[itemName];
        }
        else
        {
            GD.PrintErr($"Item {itemName} not found in inventory.");
            return 0;
        }
    }

}
