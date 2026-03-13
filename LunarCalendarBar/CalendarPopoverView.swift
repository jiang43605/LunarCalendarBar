import SwiftUI

struct CalendarPopoverView: View {
    @StateObject private var viewModel = CalendarViewModel()
    @State private var animate = false
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            CalendarHeaderView(viewModel: viewModel)
            
            Divider()
                .opacity(0.3)
            
            // Calendar Grid
            CalendarGridView(viewModel: viewModel)
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
        }
        .frame(width: 360, height: 420)
        .background {
            // macOS 26 glassmorphism style
            if #available(macOS 26.0, *) {
                GlassBackgroundEffect()
            } else {
                VisualEffectView(material: .popover, blendingMode: .behindWindow)
            }
        }
    }
}

// MARK: - Glass Background (macOS 26+)
@available(macOS 26.0, *)
struct GlassBackgroundEffect: View {
    var body: some View {
        Text("")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.ultraThinMaterial)
    }
}

// MARK: - Visual Effect View (fallback for older versions)
struct VisualEffectView: NSViewRepresentable {
    let material: NSVisualEffectView.Material
    let blendingMode: NSVisualEffectView.BlendingMode
    
    func makeNSView(context: Context) -> NSVisualEffectView {
        let view = NSVisualEffectView()
        view.material = material
        view.blendingMode = blendingMode
        view.state = .active
        return view
    }
    
    func updateNSView(_ nsView: NSVisualEffectView, context: Context) {
        nsView.material = material
        nsView.blendingMode = blendingMode
    }
}

// MARK: - Preview
#Preview {
    CalendarPopoverView()
}