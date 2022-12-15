//
//  Created by HoangNM
//

import Foundation
/// Make money string from number formatter
/// ```
/// Usage:
///
/// let string = NumberFormatterBuilder(value: 10)
///    .setPercentSuffix()
///    .setPositivePrefix("+")
///    .setMinimumFractionDigits(2)
///    .build()
///
/// print(string)
/// // ======> "+10.00%"
///
/// /// let string = NumberFormatterBuilder(value: 10)
///    .setSuffix(" USD")
///    .setPositivePrefix("+")
///    .build()
///
/// print(string)
/// // ======> "+10 USD"
///
///  Make money to type defalut
///
///  let stringMoney = NumberFormatterBuilder(value: 10.2345).makeMoneyDefaultFormatter()
///
///  print(stringMoney)
///  // ======> "$10.23"
///
/// ```

open class NumberFormatterBuilder {
    private var value: Double?
    private let formatter = NumberFormatter()
    private var isRemovePrefixWhenZeroValue = true
    // MARK: - Init
    public init(value: Double?) {
        self.value = value
        setupDefaultFormatter()
    }
    
    public init(value: String?) {
        if let value = value,
           value != "-" {
            self.value = getDoubleValue(value)
        } else {
            self.value = nil
        }
        setupDefaultFormatter()
    }
    
    public init(value: Int?) {
        if let value = value {
            self.value = Double(value)
        } else {
            self.value = nil
        }
        setupDefaultFormatter()
    }
    // MARK: - Default
    private func setupDefaultFormatter() {
        formatter.groupingSeparator = ","
        formatter.groupingSize = 3
        formatter.locale = Locale(identifier: "en_US")
        formatter.usesGroupingSeparator = true
        formatter.decimalSeparator = "."
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 3
        formatter.minimumFractionDigits = 0
    }
    
    open func build() -> String {
        if let value = value {
            if isRemovePrefixWhenZeroValue && value == 0 {
                formatter.positivePrefix = ""
            }
            return formatter.string(from: value as NSNumber) ?? ""
        } else {
            return "-"
        }
    }
    
    open func getDoubleValue(_ string: String?) -> Double {
        return Double((string ?? "").replacingOccurrences(of: "[^-^.^0-9]", with: "", options: .regularExpression, range: nil)) ?? 0
    }
    
    open func usesGroupingSeparator(_ value: Bool) -> NumberFormatterBuilder {
        self.formatter.usesGroupingSeparator = value
        return self
    }
    
    open func setGroupingSeparator(_ value: String) -> NumberFormatterBuilder {
        self.formatter.groupingSeparator = value
        return self
    }
    
    open func setGroupingSize(_ value: Int) -> NumberFormatterBuilder {
        self.formatter.groupingSize = value
        return self
    }
    
    open func setNumberStyle(_ value: NumberFormatter.Style) -> NumberFormatterBuilder {
        self.formatter.numberStyle = value
        return self
    }
    
    open func setPercentSuffix() -> NumberFormatterBuilder {
        self.formatter.negativeSuffix = "%"
        self.formatter.positiveSuffix = "%"
        return self
    }
    
    open func setSuffix(_ suffix: String) -> NumberFormatterBuilder {
        self.formatter.negativeSuffix = suffix
        self.formatter.positiveSuffix = suffix
        return self
    }
    
    open func setPrefix(_ prefix: String) -> NumberFormatterBuilder {
        self.formatter.positivePrefix = prefix
        self.formatter.negativePrefix = prefix + "-"
        return self
    }
    
    open func setMaximumFractionDigits(_ value: Int) -> NumberFormatterBuilder {
        self.formatter.maximumFractionDigits = value
        return self
    }
    
    open func setMinimumFractionDigits(_ value: Int) -> NumberFormatterBuilder {
        self.formatter.minimumFractionDigits = value
        return self
    }
    
    open func setPositivePrefix(_ value: String) -> NumberFormatterBuilder {
        self.formatter.positivePrefix = value
        return self
    }
    
    open func setRoundingMode(_ value: NumberFormatter.RoundingMode) -> NumberFormatterBuilder {
        self.formatter.roundingMode = value
        return self
    }
    
    open func setBaseFormatingForPercent() -> NumberFormatterBuilder {
        return self.setPercentSuffix().setMaximumFractionDigits(2)
    }
}
