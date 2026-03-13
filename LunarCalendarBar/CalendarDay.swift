import Foundation

struct CalendarDay: Hashable {
    let date: Date
    let solarDay: Int
    let lunarDay: String
    let lunarMonth: String
    let isLunarFestival: Bool
    let isHoliday: Bool
    let holidayName: String?
    let isCurrentMonth: Bool
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(date)
    }
    
    static func == (lhs: CalendarDay, rhs: CalendarDay) -> Bool {
        lhs.date == rhs.date
    }
}