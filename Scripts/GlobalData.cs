using Godot;
using System;
using System.Collections.Generic;
using System.Text.Json;

public partial class GlobalData : Node
{
    // 资源数据
    public static Dictionary<string, int> Items = new Dictionary<string, int>();
    
    // 设施数据
    public static Dictionary<string, int> Facilities = new Dictionary<string, int>();


    public override void _Ready()
    {
        LoadDataFromJson();
    }
    
    // —————— 配置文件读取函数 ——————
    private void LoadDataFromJson()
    {
        using var file = FileAccess.Open("res://Data/Level/Main.json", FileAccess.ModeFlags.Read);
    }

    // —————— 资源管理函数 ——————
    public static void AddItem(string _itemName, int _amount)
    {
        if (Items.ContainsKey(_itemName))
        {
            Items[_itemName] += _amount;
        }
        else
        {
            GD.PrintErr($"Item {_itemName} not found in inventory.");
            return;
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
