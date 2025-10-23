using Godot;
using System;
using System.Collections.Generic;
using Ult_Alloy_250221.Scripts.Class;

public partial class GlobalData : Node
{
    // —————— 配置文件处理 ——————
    private readonly DataLoader _dataLoader = new();
    public override void _Ready()
    {
        var data = _dataLoader.LoadData
            (DataLoader.DataTypes.Level,DataLoader.Levels.Main);
        DataBuildUp(data);
    }

    // 数据字典
    private static readonly Dictionary<string,Item> Inventory = new();
    private static readonly Dictionary<string, Facility> Facilities = new();
    
    // —————— 全局数据构建函数 ——————
    private static void DataBuildUp(Dictionary<string, List<object>> data)
    {
        foreach (var (key, list) in data)
        {
            switch (key)
            {
                case "item":
                    BuildItems(list);
                    break;
                case "facilities":
                    BuildFacility(list);
                    break;
            }
            GD.Print($"Build up {key} has complete");
        }
    }

    // 物品字典构建
    private static void BuildItems(List<object> items)
    {
        foreach (var item in items)
        {
            if (item is not Dictionary<string, object> dict) { continue; }
            
            var itemKey = dict["key"].ToString();
            if (string.IsNullOrEmpty(itemKey)) { continue; }

            var newItem = new Item()
            {
                Key = itemKey,
                Name = dict["name"].ToString(),
                Description = dict["description"].ToString(),
                Sort = Item.ParseSort(dict["sort"].ToString())
            };
            Inventory[itemKey] = newItem;
        }
    }
    
    // 设施字典构建
    private static void BuildFacility(List<object> facilities)
    {
        foreach (var facility in facilities)
        {
            if (facility is not Dictionary<string, object> dict) { return; }
            
            var facilityKey = dict["key"].ToString();
            if (string.IsNullOrEmpty(facilityKey)) { return; }

            var newFacility = new Facility()
            {
                Key = facilityKey,
                Name = dict["name"].ToString(),
                Description = dict["description"].ToString(),
                Type = Facility.ParseType(dict["type"].ToString()),
                BaseSpeed = float.TryParse
                    (dict["speed"].ToString(), out var speed) ? 
                    speed : 0f
            };
            Facilities[facilityKey] = newFacility;
        }
    }

    // —————— 游戏内资源管理函数 ——————
    
    // 更新资源字典
    public static void AddItem(string itemKey, int amount)
    {
        if (!Inventory.TryGetValue("item." + itemKey, out var item))
        {
            GD.PrintErr($"No such item {itemKey} in inventory");
            return;
        }
        item.Amount += amount;
        GD.Print($"{itemKey} has" + (amount >= 0 ? "add " : "reduce ") + amount);
    }

    public static float GetItem(string itemKey)
    {
        if (Inventory.TryGetValue("item." + itemKey, out var item)) { return item.Amount; }
        GD.PrintErr($"No such item {itemKey} in inventory");
        return 0;
    }

    // 更新设施字典
    public static void UpdFacility(string key)
    {
        
    }

}
