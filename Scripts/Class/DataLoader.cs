using System;
using System.Collections.Generic;
using System.Text.Json;
using Godot;

namespace Ult_Alloy_250221.Scripts.Class;

public class DataLoader
{
    // 数据类型枚举
    public enum DataTypes
    {
        Global,
        Level,
        Lang,
    }
    // 语言类型枚举
    public enum Languages
    {
        En,
        ZhCn,
    }
    // 关卡枚举
    public enum Levels
    {
        Main,
    }
    
    // —————— 路径属性设置 ——————
    private const string DataPathRoot = "res://Data";
    private readonly Dictionary<DataTypes, string> _dataPaths = new()
    {
        { DataTypes.Global , DataPathRoot + "/Global.json"},
        { DataTypes.Level ,DataPathRoot + "/Level" },
        { DataTypes.Lang ,DataPathRoot + "/Lang" }
    };
    private readonly Dictionary<Levels, string> _dataFile = new()
    {
        { Levels.Main ,"/Main.json" },
    };

    private readonly Dictionary<Languages, string> _langPaths = new()
    {
        { Languages.ZhCn ,"/zh_CN"},
        { Languages.En , "/en"},
    };
    

    public Dictionary<string, List<object>> LoadData(DataTypes type, Levels level)
    {
        var targetPath = _dataPaths[type] + _dataFile[level];
        var targetData = Processer(Loader(targetPath));
        return targetData;
    }

    public void LoadGlobal()
    {
        var dataPath = _dataPaths[DataTypes.Global];
        var globalData = Processer(Loader(dataPath));
    }

    private static Dictionary<string, List<object>> Loader(string dataPath)
    {
        if (!ResourceLoader.Exists(dataPath))
        {
            GD.PrintErr($"Data file not found at {dataPath}");
            return new Dictionary<string, List<object>>();
        }

        var file = FileAccess.Open(dataPath, FileAccess.ModeFlags.Read);
        if (file == null)
        {
            GD.PrintErr("Failed to open data file.");
            return new Dictionary<string, List<object>>();
        }

        var jsonString = file.GetAsText();
        file.Close();
        try
        {
            var data = JsonSerializer.Deserialize<Dictionary<string, List<object>>>(jsonString);
            GD.Print("Level data loaded successfully.");
            return data;
        }
        catch (Exception e)
        {
            GD.PrintErr($"Failed to parse JSON: {e.Message}");
            return new Dictionary<string, List<object>>();
        }
    }

    private static Dictionary<string, List<object>> Processer(Dictionary<string, List<object>> loadData)
    {
        Dictionary<string, List<object>> processedData = new();
        foreach (var (key,list) in loadData)
        {
            List<object> processedList = []; 
            foreach (var o in list)
            {
                if (o is not JsonElement element) { continue; }

                var json = element.GetRawText();
                var newObj = JsonSerializer.Deserialize<Dictionary<string, object>>(json);
                
                processedList.Add(newObj);
                processedData[key] = processedList;
            }
        }
        return processedData;
    }
}