import SwiftUI

struct CalendarHeaderView: View {
    @ObservedObject var viewModel: CalendarViewModel
    @State private var showYearPicker = false
    
    private let months = ["一月", "二月", "三月", "四月", "五月", "六月", 
                          "七月", "八月", "九月", "十月", "十一月", "十二月"]
    
    var body: some View {
        HStack {
            // Year Button
            Button(action: { showYearPicker.toggle() }) {
                HStack(spacing: 4) {
                    Text("\(viewModel.currentYear)")
                        .font(.system(size: 16, weight: .semibold))
                    Image(systemName: "chevron.down")
                        .font(.system(size: 10))
                }
                .foregroundStyle(.primary)
            }
            .buttonStyle(.plain)
            .popover(isPresented: $showYearPicker) {
                YearPickerView(viewModel: viewModel, isPresented: $showYearPicker)
            }
            
            Spacer()
            
            // Month Display
            Text(months[viewModel.currentMonth])
                .font(.system(size: 16, weight: .semibold))
            
            Spacer()
            
            // Navigation Buttons
            HStack(spacing: 12) {
                Button(action: viewModel.goToPreviousMonth) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 14, weight: .medium))
                }
                .buttonStyle(.plain)
                
                Button(action: viewModel.goToNextMonth) {
                    Image(systemName: "chevron.right")
                        .font(.system(size: 14, weight: .medium))
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
    }
}

// MARK: - Year Picker
struct YearPickerView: View {
    @ObservedObject var viewModel: CalendarViewModel
    @Binding var isPresented: Bool
    
    private let years = Array((2020...2050).reversed())
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            HStack {
                Text("选择年份")
                    .font(.headline)
                Spacer()
                Button("今天") {
                    viewModel.goToToday()
                    isPresented = false
                }
                .buttonStyle(.plain)
                .foregroundStyle(.blue)
            }
            .padding()
            
            Divider()
            
            // Year Grid
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 5), spacing: 8) {
                ForEach(years, id: \.self) { year in
                    Button(action: {
                        viewModel.selectYear(year)
                        isPresented = false
                    }) {
                        Text("\(year)")
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 8)
                            .background(
                                RoundedRectangle(cornerRadius: 6)
                                    .fill(viewModel.currentYear == year ? Color.blue.opacity(0.2) : Color.clear)
                            )
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding()
        }
        .frame(width: 280, height: 320)
    }
}

// MARK: - Preview
#Preview {
    CalendarHeaderView(viewModel: CalendarViewModel())
}