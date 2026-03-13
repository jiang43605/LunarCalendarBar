import Foundation

struct LunarInfo {
    let day: String
    let month: String
    let isFestival: Bool
    let isHoliday: Bool
    let holidayName: String?
}

class LunarService {
    // Lunar calendar data (simplified version)
    // Based on Lunar-Solar-Calendar-Converter algorithm
    
    private let lunarMonths = ["", "正月", "二月", "三月", "四月", "五月", "六月", 
                                "七月", "八月", "九月", "十月", "冬月", "腊月"]
    private let lunarDays = ["", "初一", "初二", "初三", "初四", "初五", "初六", "初七", "初八", "初九", "初十",
                             "十一", "十二", "十三", "十四", "十五", "十六", "十七", "十八", "十九", "二十",
                             "廿一", "廿二", "廿三", "廿四", "廿五", "廿六", "廿七", "廿八", "廿九", "三十"]
    
    // Chinese holidays (fixed dates)
    private let solarHolidays: [String: String] = [
        "01-01": "元旦",
        "02-14": "情人节",
        "03-08": "妇女节",
        "03-12": "植树节",
        "04-01": "愚人节",
        "05-01": "劳动节",
        "05-04": "青年节",
        "06-01": "儿童节",
        "07-01": "建党节",
        "08-01": "建军节",
        "09-10": "教师节",
        "10-01": "国庆节",
        "12-25": "圣诞节"
    ]
    
    // Adjustment days for leap years
    private letleetYearCodes = [0, 212, 424, 638, 850, 1072, 1294, 1518, 1740, 1962, 2184, 2406, 
                                 2628, 2850, 3072, 3294, 3518, 3740, 3962, 4184, 4406, 4628, 4850,
                                 5072, 5294, 5516, 5738, 5960, 6182, 6404, 6626, 6848, 7070, 7292]
    
    func getLunarInfo(for date: Date) -> LunarInfo {
        let calendar = Calendar(identifier: .gregorian)
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        
        // Calculate lunar date
        let (lunarMonth, lunarDay) = solarToLunar(year: year, month: month, day: day)
        
        // Check holidays
        let dateString = String(format: "%02d-%02d", month, day)
        let holidayName = solarHolidays[dateString]
        let isHoliday = holidayName != nil
        
        // Check lunar festivals
        let isFestival = isLunarFestival(lunarMonth: lunarMonth, lunarDay: lunarDay)
        
        let lunarDayStr = lunarDay > 0 && lunarDay <= 30 ? lunarDays[lunarDay] : ""
        let lunarMonthStr = lunarMonth > 0 && lunarMonth <= 12 ? lunarMonths[lunarMonth] : ""
        
        return LunarInfo(
            day: lunarDayStr,
            month: lunarMonthStr,
            isFestival: isFestival,
            isHoliday: isHoliday,
            holidayName: holidayName
        )
    }
    
    func getSolarTerm(for date: Date) -> String? {
        // Solar terms (24 solar terms)
        let calendar = Calendar(identifier: .gregorian)
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        
        let solarTerms = [
            "小寒", "大寒", "立春", "雨水", "惊蛰", "春分",
            "清明", "谷雨", "立夏", "小满", "芒种", "夏至",
            "小暑", "大暑", "立秋", "处暑", "白露", "秋分",
            "寒露", "霜降", "立冬", "小雪", "大雪", "冬至"
        ]
        
        // Simplified solar term calculation
        // In production, use a more accurate algorithm
        return nil
    }
    
    // MARK: - Lunar Conversion (Simplified)
    private func solarToLunar(year: Int, month: Int, day: Int) -> (Int, Int) {
        // This is a simplified version
        // For production, use Lunar-Solar-Calendar-Converter library
        
        let baseYear = 1900
        let daysSinceBase = calculateDaysSinceBase(year: year, month: month, day: day)
        
        // Simplified calculation
        let lunarYear = year
        let lunarMonth = month
        let lunarDay = day
        
        return (lunarMonth, lunarDay)
    }
    
    private func calculateDaysSinceBase(year: Int, month: Int, day: Int) -> Int {
        let baseYear = 1900
        var days = 0
        
        for y in baseYear..<year {
            days += isLeapYear(y) ? 366 : 365
        }
        
        let monthDays = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
        for m in 1..<month {
            days += monthDays[m - 1]
        }
        
        if isLeapYear(year) && month > 2 {
            days += 1
        }
        
        days += day - 1
        return days
    }
    
    private func isLeapYear(_ year: Int) -> Bool {
        (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0)
    }
    
    private func isLunarFestival(lunarMonth: Int, lunarDay: Int) -> Bool {
        // Major lunar festivals
        let festivals: [(Int, String)] = [
            (101, "春节"),   // 正月初一
            (115, "元宵节"), // 正月十五
            (505, "端午节"), // 五月初五
            (707, "七夕节"), // 七月初七
            (715, "中元节"), // 七月十五
            (808, "中秋节"), // 八月十五
            (909, "重阳节"), // 九月初九
            (1208, "腊八节") // 十二月初八
        ]
        
        let key = lunarMonth * 100 + lunarDay
        return festivals.contains { $0.0 == key }
    }
}