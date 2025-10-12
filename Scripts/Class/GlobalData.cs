using Godot;
using System;
using System.Collections.Generic;

public partial class GlobalData : Node
{
    // 资源数据
    public static Dictionary<string, int> Items = new Dictionary<string, int>()
    {
        { "stone", 0 },
        { "copper", 0 },
        { "iron", 0 },
        { "silver", 0 },
        { "gold", 0 },
        { "cash", 0 },
    };
    
    // 设施数据
    public static Dictionary<string, int> Facilities = new Dictionary<string, int>()
    {
        { "furnace", 0 },
        { "miner", 0 },
    };
    
    // —————— 资源管理函数 ——————
    public static void AddItem(string _itemName, int _amount)
    {
        if (Items.ContainsKey(_itemName))
        {
            Items[_itemName] += _amount;
        }
        else
        {
            Items.Add(_itemName, _amount);
        }

        GD.Print($"{_amount} of {_itemName} added to inventory.");
    }

    public static int GetItem(string _itemName)
    {
        if (Items.ContainsKey(_itemName))
        {
            return Items[_itemName];
        }
        else
        {
            GD.PrintErr($"Item {_itemName} not found in inventory.");
            return 0;
        }
    }

}
