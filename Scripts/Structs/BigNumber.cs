using Godot;
using System;
using System.Collections.Generic; // 列表/数组库（作有需时用）

/// <summary>
/// 一个用于表示和进行超大数字运算的结构体
/// 使用尾数和指数 (M * 10^E).
/// </summary>
public readonly struct BigNumber
{
    // --- 常量 ---
    public static readonly BigNumber Zero = new BigNumber(0.0, 0);
    public static readonly BigNumber One = new BigNumber(1.0, 0);
    public static readonly BigNumber Ten = new BigNumber(1.0, 1);

    private const double MantissaEqualityTolerance = 1e-9;
    private static readonly string[] CommonSuffixes = {
        "", "K", "M", "B", "T",
        "Qa", "Qi", "Sx", "Sp", "Oc",
        "No", "Dc", "UDc", "DDc", "TDc",
        "QaDc", "QiDc", "SxDc", "SpDc", "OcDc",
        "NoDc", "Vg", "UVg", "DVg", "TVg",
        "QaVg", "QiVg", "SxVg", "SpVg", "OcVg",
        "NoVg", "Tg", "UTg", "DTg", "TTg"
    };

    // --- 属性 ---
    public double Mantissa { get; }
    public int Exponent { get; }

    // --- 构造函数 ---
    public BigNumber(double mantissa = 0.0, int exponent = 0)
    {
        Mantissa = mantissa;
        Exponent = exponent;
        if (Mantissa != 0.0)
        {
            Normalize(ref this);
        }
    }

    // 确保尾数位于 [1.0， 10.0) 或 (-10.0， -1.0] 中，并相应地调整指数
    private static void Normalize(ref BigNumber number)
    {
        if (number.Mantissa == 0.0)
        {
            // 确保始终一致地表示零
            number = new BigNumber(0.0, 0);
            return;
        }

        double mantissa = number.Mantissa;
        int exponent = number.Exponent;
        int sign = Math.Sign(mantissa);
        double absMantissa = Math.Abs(mantissa);

        while (absMantissa >= 10.0)
        {
            absMantissa /= 10.0;
            exponent++;
        }

        while (absMantissa < 1.0 && absMantissa > 0.0)
        {
            absMantissa *= 10.0;
            exponent--;
        }

        number = new BigNumber(sign * absMantissa, exponent);
    }


    // --- 比较函数 ---
    public bool Equals(BigNumber other)
    {
        if (Exponent != other.Exponent)
            return false;
        return Math.Abs(Mantissa - other.Mantissa) < MantissaEqualityTolerance;
    }

    public bool GreaterThan(BigNumber other)
    {
        if (Exponent > other.Exponent)
            return true;
        if (Exponent < other.Exponent)
            return false;
        return Mantissa > other.Mantissa;
    }

    public bool LessThan(BigNumber other)
    {
        if (Exponent < other.Exponent)
            return true;
        if (Exponent > other.Exponent)
            return false;
        return Mantissa < other.Mantissa;
    }

    public bool GreaterThanOrEqual(BigNumber other) => GreaterThan(other) || Equals(other);
    public bool LessThanOrEqual(BigNumber other) => LessThan(other) || Equals(other);

    // --- 四则运算函数 ---

    public BigNumber Add(BigNumber other)
    {
        if (Mantissa == 0.0) return other;
        if (other.Mantissa == 0.0) return this;

        int expDiff = Exponent - other.Exponent;

        // 如果一个数字比另一个数字小得多，则忽略不计
        // 308 大约是双精度的最大安全整数位数
        if (expDiff > 308) return this;
        if (expDiff < -308) return other;

        double newMantissa;
        int newExponent;

        if (expDiff >= 0)
        {
            newMantissa = Mantissa + (other.Mantissa / Math.Pow(10.0, expDiff));
            newExponent = Exponent;
        }
        else // 其他项的指数更大
        {
            newMantissa = other.Mantissa + (Mantissa / Math.Pow(10.0, -expDiff));
            newExponent = other.Exponent;
        }

        var result = new BigNumber(newMantissa, newExponent);
        Normalize(ref result); // Normalize the result
        return result;
    }

    public BigNumber Subtract(BigNumber other)
    {
        if (other.Mantissa == 0.0) return this;
        var negatedOther = other.Multiply(new BigNumber(-1.0, 0));
        return Add(negatedOther);
    }

    public BigNumber Multiply(BigNumber other)
    {
        if (Mantissa == 0.0 || other.Mantissa == 0.0)
            return Zero;

        double newMantissa = Mantissa * other.Mantissa;
        int newExponent = Exponent + other.Exponent;

        var result = new BigNumber(newMantissa, newExponent);
        Normalize(ref result); // Normalize the result
        return result;
    }

    public BigNumber Divide(BigNumber other)
    {
        if (other.Mantissa == 0.0)
        {
            GD.PrintErr("Division by zero in BigNumber");
            return Zero; // Or handle error as appropriate
        }

        double newMantissa = Mantissa / other.Mantissa;
        int newExponent = Exponent - other.Exponent;

        var result = new BigNumber(newMantissa, newExponent);
        Normalize(ref result); // Normalize the result
        return result;
    }

    // --- 功能函数与格式化函数 ---

    // 将数字格式化为科学计数法字符串，例如“3.50e12”
    public string ToScientificString(int decimalPlaces = 2)
    {
        if (Mantissa == 0.0) return "0";
        string format = "F" + decimalPlaces;
        return $"{Mantissa.ToString(format)}e{Exponent}";
    }   


    // 使用常用后缀（K、M、B 等）格式化数字
    // 如果后缀用完，则强制采用科学记数法表示
    public string ToFormattedString(int maxLength = 10)
    {
        if (Mantissa == 0.0) return "0";

        int index = (int)Math.Floor((double)Exponent / 3.0);
        int remainderExp = Exponent % 3;

        if (index < 0)
        {
            index = 0;
            remainderExp = Exponent;
        }

        if (index >= CommonSuffixes.Length)
        {
            return ToScientificString(2);
        }

        double displayMantissa = Mantissa;
        for (int i = 0; i < remainderExp; i++)
        {
            displayMantissa *= 10.0;
        }

        string suffix = CommonSuffixes[index];
        string formattedNumber;

        if (Math.Abs(displayMantissa) >= 1000)
        {
            formattedNumber = $"{Math.Round(displayMantissa):F0}{suffix}";
        }
        else if (Math.Abs(displayMantissa) >= 100)
        {
            formattedNumber = $"{displayMantissa:F1}{suffix}";
        }
        else
        {
            formattedNumber = $"{displayMantissa:F2}{suffix}";
        }

        if (formattedNumber.Length > maxLength)
        {
            formattedNumber = $"{displayMantissa:F2}{suffix}";
            if (formattedNumber.Length > maxLength)
            {
                return ToScientificString(2);
            }
        }

        return formattedNumber;
    }

    // 将当前 BigNumber 转换为其工程计数法的函数
    private BigNumber ToEngineeringForm()
    {
        if (Mantissa == 0.0) return Zero;

        int adjustedExponent = Exponent;
        double adjustedMantissa = Mantissa;

        // 计算指数与 3 的倍数相差的数值有多大
        int remainder = adjustedExponent % 3;
        if (remainder != 0)
        {
            if (remainder > 0)
            {
                // 需要将指数减去余数，增加尾数
                for (int i = 0; i < remainder; i++)
                {
                    adjustedMantissa *= 10;
                }
                adjustedExponent -= remainder;
            }
            else // 余数 < 0
            {
                // 需要增加绝对指数（余数），减少尾数
                for (int i = 0; i < Math.Abs(remainder); i++)
                {
                    adjustedMantissa /= 10;
                }
                adjustedExponent -= remainder; // 减去负数加它
            }
        }

        var result = new BigNumber(adjustedMantissa, adjustedExponent);
        Normalize(ref result); // 调整后确保格式统一
        return result;
    }

    // 以工程计数法格式化数字（指数是 3 的倍数）
    public string ToEngineeringString(int decimalPlaces = 2)
    {
        if (Mantissa == 0.0) return "0";

        BigNumber engForm = ToEngineeringForm();
        string format = "F" + decimalPlaces;
        return engForm.Mantissa.ToString(format) + "e" + engForm.Exponent;
    }

    // 首先使用默认后缀，后缀用完则使用工程计数法
    public string ToMixedEngineeringString(int maxSuffixIndex = -1, int decimalPlaces = 2)
    {
        if (Mantissa == 0.0) return "0";

        if (maxSuffixIndex == -1) maxSuffixIndex = CommonSuffixes.Length - 1;

        int index = (int)Math.Floor((double)Exponent / 3.0);

        // 检查是否可以使用标准后缀
        if (index >= 0 && index <= maxSuffixIndex && index < CommonSuffixes.Length)
        {
            int remainderExp = Exponent % 3;
            double displayMantissa = Mantissa;
            for (int i = 0; i < remainderExp; i++)
            {
                displayMantissa *= 10.0;
            }

            string suffix = CommonSuffixes[index];
            return string.Format("{0:F" + decimalPlaces + "}{1}", displayMantissa, suffix);

        }

        // 如果后缀不适用或不可用，则使用工程计数法
        return ToEngineeringString(decimalPlaces);
    }

    // --- 静态辅助函数 ---
    public static BigNumber FromFloat(double value) => new BigNumber(value, 0);
    public static BigNumber FromInt(long value) => new BigNumber((double)value, 0);
    public static BigNumber FromParts(double mantissa, int exponent) => new BigNumber(mantissa, exponent);
}





