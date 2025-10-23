using System.Collections.Generic;

namespace Ult_Alloy_250221.Scripts.Class;

// 数据基类
public class BaseData
{
    public string Key { get; init; }
    public string Name { get; set; }
    public string Description { get; set; }
}

// 物品库存类
public class Item : BaseData
{
    public enum Sorts
    {
        Resource,
        Module,
        Treasure
    }
    public Sorts Sort { get; init; }
    public float Amount { get; set; } = 0;

    public override string ToString()
    {
        return Sort is Sorts.Treasure ? 
            $"{Key}, accurate: {Amount}" 
            : $"{Key}, amount: {Amount}";
    }

    public static Sorts ParseSort(string sort)
    {
        return sort?.ToLower() switch
        {
            "resource" => Sorts.Resource,
            "module" => Sorts.Module,
            "treasure" => Sorts.Treasure,
            _ => Sorts.Resource
        };
    }
}

// 设施类
public class Facility : BaseData
{
    public enum Types
    {
        Count,
        Level,
    }
    public Types Type { get; init; }
    public float BaseSpeed { get; set; } = 0f ;
    public Dictionary<string, int> Costs { get; set; }
    public int Count { get; set; }
    public override string ToString()
    {
        return Type is Types.Count ? 
            $"{Key}, count: {Count}" 
            : $"{Key}, level: {Count}";
    }

    public static Types ParseType(string type)
    {
        return type?.ToLower() switch
        {
            "count" => Types.Count,
            "level" => Types.Level,
            _ => Types.Count
        };
    }
}

// 交易项类
public class Trade : BaseData
{
    public Dictionary<string,int> Orders { get; set; }
    public Dictionary<string,int> Rewards { get; set; }
}

// 研究项类
public class Research : BaseData
{
    public Dictionary<string,int> Costs { get; set; }
    public Dictionary<string,int> Effects { get; set; }
}

// 行动项类
public class Operation : BaseData
{
    public Dictionary<string,int> Costs { get; set; }
    public Dictionary<string,int> Effects { get; set; }
    public int CoolDown { get; set; }
}

// 成就项类
public class Achievement : BaseData
{
    public enum Ranges
    {
        Global,
        Level,
    }
    public Ranges Range { get; set; }
    public Dictionary<string,int> Targets { get; set; }
    public Dictionary<string,int> Effects { get; set; }
}