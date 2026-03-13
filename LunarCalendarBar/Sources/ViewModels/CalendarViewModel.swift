import Foundation
import SwiftUI
import Combine

class CalendarViewModel: ObservableObject {
    @Published var currentYear: Int
    @Published var currentMonth: Int
    @Published var daysInMonth: [CalendarDay?] = []
    
    private let calendar = Calendar.current
    private let lunarService = LunarService()
    
    init() {
        let now = Date()
        self.currentYear = calendar.component(.year, from: now)
        self.currentMonth = calendar.component(.month, from: now)
        generateDaysForMonth()
    }
    
    // MARK: - Navigation
    func goToPreviousMonth() {
        if currentMonth == 1 {
            currentMonth = 12
            currentYear -= 1
        } else {
            currentMonth -= 1
        }
        withAnimation(.easeInOut(duration: 0.25)) {
            generateDaysForMonth()
        }
    }
    
    func goToNextMonth() {
        if currentMonth == 12 {
            currentMonth = 1
            currentYear += 1
        } else {
            currentMonth += 1
        }
        withAnimation(.easeInOut(duration: 0.25)) {
            generateDaysForMonth()
        }
    }
    
    func goToToday() {
        let now = Date()
        currentYear = calendar.component(.year, from: now)
        currentMonth = calendar.component(.month, from: now)
        withAnimation(.easeInOut(duration: 0.25)) {
            generateDaysForMonth()
        }
    }
    
    func selectYear(_ year: Int) {
        currentYear = year
        withAnimation(.easeInOut(duration: 0.25)) {
            generateDaysForMonth()
        }
    }
    
    // MARK: - Date Helpers
    func isToday(_ date: Date) -> Bool {
        calendar.isDateInToday(date)
    }
    
    // MARK: - Generate Days
    private func generateDaysForMonth() {
        var days: [CalendarDay?] = []
        
        // Get first day of month
        var components = DateComponents()
        components.year = currentYear
        components.month = currentMonth
        components.day = 1
        
        guard let firstDay = calendar.date(from: components),
              let range = calendar.range(of: .day, in: .month, for: firstDay) else {
            daysInMonth = []
            return
        }
        
        // Get weekday of first day (0 = Sunday)
        let firstWeekday = calendar.component(.weekday, from: firstDay)
        let leadingEmptyDays = firstWeekday - 1
        
        // Add empty cells for leading days
        for _ in 0..<leadingEmptyDays {
            days.append(nil)
        }
        
        // Add days of month
        for day in range {
            components.day = day
            if let date = calendar.date(from: components) {
                let lunarInfo = lunarService.getLunarInfo(for: date)
                let solarTerm = lunarService.getSolarTerm(for: date)
                
                let calendarDay = CalendarDay(
                    date: date,
                    solarDay: day,
                    lunarDay: lunarInfo.day,
                    lunarMonth: lunarInfo.month,
                    isLunarFestival: lunarInfo.isFestival,
                    isHoliday: lunarInfo.isHoliday || solarTerm != nil,
                    holidayName: lunarInfo.holidayName ?? solarTerm,
                    isCurrentMonth: true
                )
                days.append(calendarDay)
            }
        }
        
        // Fill remaining cells to complete the grid (6 rows)
        while days.count < 42 {
            days.append(nil)
        }
        
        daysInMonth = days
    }
}