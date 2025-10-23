using Godot;
using System;

public partial class GameManager : Node
{
    // —————— 关卡基础事件 ——————
    [Signal] public delegate void UpdateInfoEventHandler();

    // 按钮触发事件
    private void OnActivate(string target)
    {
        switch (target)
        {
            case "mine":
                ProduceItem("stone");
                break;
            case "furnace":
                SpendItem("stone");
                FacilityUpd("furnace");
                break;
            default:
                GD.PrintErr("UNKNOWN ACTIVATION");
                break;
        }
    }

    // —————— 资源生产/消耗函数 ——————
    private void ProduceItem(string target)
    {
        int produceAmount = 1;
        GlobalData.AddItem(target, produceAmount);
        EmitSignalUpdateInfo();
        GD.Print($"{target} has added");
    }

    private void SpendItem(string target)
    {
        int costAmount = -10;
        var itemStored = GlobalData.GetItem("stone");
        if (itemStored < int.Abs(costAmount))
        {
            GD.Print($"Did not have enough {target}");
            return;
        }
        GlobalData.AddItem("stone",costAmount);
        EmitSignalUpdateInfo();
        GD.Print("Stone has spent");
    }

    // —————— 设施更新函数 ——————
    private void FacilityUpd(string target)
    {
        
    }
}
