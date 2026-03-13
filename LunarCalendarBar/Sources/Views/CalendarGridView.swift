import SwiftUI

struct CalendarGridView: View {
    @ObservedObject var viewModel: CalendarViewModel
    
    private let columns = Array(repeating: GridItem(.flexible(), spacing: 4), count: 7)
    private let weekdays = ["日", "一", "二", "三", "四", "五", "六"]
    
    var body: some View {
        VStack(spacing: 8) {
            // Weekday Header
            HStack(spacing: 4) {
                ForEach(weekdays, id: \.self) { day in
                    Text(day)
                        .font(.system(size: 12, weight: .medium))
                        .foregroundStyle(.secondary)
                        .frame(maxWidth: .infinity)
                }
            }
            
            // Days Grid
            LazyVGrid(columns: columns, spacing: 4) {
                ForEach(viewModel.daysInMonth, id: \.self) { day in
                    if let day = day {
                        DayCell(
                            day: day,
                            isToday: viewModel.isToday(day.date),
                            isCurrentMonth: day.isCurrentMonth
                        )
                    } else {
                        Color.clear
                            .frame(height: 36)
                    }
                }
            }
        }
    }
}

// MARK: - Day Cell
struct DayCell: View {
    let day: CalendarDay
    let isToday: Bool
    let isCurrentMonth: Bool
    
    var body: some View {
        VStack(spacing: 2) {
            // Solar Date
            Text("\(day.solarDay)")
                .font(.system(size: 14, weight: isToday ? .bold : .regular))
                .foregroundStyle(isCurrentMonth ? (isToday ? .white : .primary) : .secondary)
                .frame(width: 32, height: 32)
                .background(
                    Circle()
                        .fill(backgroundColor)
                )
            
            // Lunar Date
            if isCurrentMonth && day.lunarDay != "" {
                Text(day.lunarDay)
                    .font(.system(size: 9))
                    .foregroundStyle(lunarColor)
            }
        }
        .frame(height: 44)
    }
    
    private var backgroundColor: Color {
        if isToday {
            return .blue
        }
        return .clear
    }
    
    private var lunarColor: Color {
        if day.isHoliday || day.isLunarFestival {
            return .red
        }
        return .secondary
    }
}

// MARK: - Preview
#Preview {
    CalendarGridView(viewModel: CalendarViewModel())
        .frame(width: 360)
}