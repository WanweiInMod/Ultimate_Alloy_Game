using Godot;
using System;
using System.Collections.Generic;
using System.Collections.Generic;

public partial class GlobalStorage : Node
{
    [Signal] public delegate void StorageUpdatedEventHandler(StringName resType, float value);

    // 将 Dictionary 的键类型改为 StringName，与方法参数保持一致
    public Dictionary<StringName, float> Storage = new()
    {
        { "Stone", 0 },
        { "Copper", 0 }
    };

    public Dictionary<StringName, int> Facilities = new()
    {
        { "Furnace", 0 }
    };

    public void SetStorage(StringName resType, float value)
    {
        if (Storage.ContainsKey(resType))
        {
            Storage[resType] = value;
            EmitSignal(SignalName.StorageUpdated, resType, value);
        }
        else
        {
            GD.PrintErr($"Resource type '{resType}' does not exist.");
        }
    }

    public float GetStorage(StringName resType)
    {
        if (Storage.ContainsKey(resType))
        {
            return Storage[resType];
        }
        
        GD.PrintErr($"Resource type '{resType}' does not exist.");
        return 0;
    }

    public bool TryGetStorage(StringName resType, out float value)
    {
        return Storage.TryGetValue(resType, out value);
    }

    public void AddStorage(StringName resType, float value)
    {
        if (Storage.ContainsKey(resType))
        {
            Storage[resType] += value;
            EmitSignal(SignalName.StorageUpdated, resType, value);
        }
        else
        {
            GD.PrintErr($"Resource type '{resType}' does not exist.");
        }
    }

    public void NewStorage(StringName resType, float value = 0)
    {
        if (!Storage.ContainsKey(resType))
        {
            Storage[resType] = value;
            EmitSignal(SignalName.StorageUpdated, resType, value);
        }
        else
        {
            GD.PrintErr($"Resource type '{resType}' already exists.");
        }
    }
}

