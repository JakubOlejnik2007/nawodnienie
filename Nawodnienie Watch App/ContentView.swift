import SwiftUI

struct ContentView: View {
    @AppStorage("waterML") private var waterML = 0
    @AppStorage("goalML") private var goalML = 2000

    private let quickAmounts = [150, 250, 350]

    private var progress: Double {
        min(Double(waterML) / Double(max(goalML, 1)), 1.0)
    }

    private var remaining: Int {
        max(goalML - waterML, 0)
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 10) {
                    ZStack {
                        Circle()
                            .stroke(.blue.opacity(0.18), lineWidth: 12)

                        Circle()
                            .trim(from: 0, to: progress)
                            .stroke(.blue, style: StrokeStyle(lineWidth: 12, lineCap: .round))
                            .rotationEffect(.degrees(-90))
                            .animation(.easeInOut, value: progress)

                        VStack(spacing: 0) {
                            Text("\(waterML)")
                                .font(.system(size: 25, weight: .bold, design: .rounded))
                            Text("ml")
                                .font(.caption2)
                                .foregroundStyle(.secondary)
                        }
                    }
                    .frame(width: 125, height: 125)
                    .padding(.top, 4)

                    Text("Cel: \(goalML) ml")
                        .font(.caption)
                        .foregroundStyle(.secondary)

                    if remaining > 0 {
                        Text("Pozostało \(remaining) ml")
                            .font(.headline)
                    } else {
                        Label("Cel osiągnięty!", systemImage: "checkmark.circle.fill")
                            .font(.headline)
                            .foregroundStyle(.green)
                    }

                    VStack(spacing: 6) {
                        ForEach(quickAmounts, id: \.self) { amount in
                            Button {
                                addWater(amount)
                            } label: {
                                Label("+\(amount) ml", systemImage: "drop.fill")
                                    .frame(maxWidth: .infinity)
                            }
                            .buttonStyle(.borderedProminent)
                            .tint(.blue)
                        }
                    }

                    Button {
                        waterML = 0
                    } label: {
                        Label("Wyzeruj", systemImage: "arrow.counterclockwise")
                    }
                    .buttonStyle(.bordered)
                    .tint(.secondary)
                }
                .padding(.horizontal, 8)
                .padding(.bottom, 8)
            }
            .navigationTitle("Nawodnienie")
        }
    }

    private func addWater(_ amount: Int) {
        waterML += amount
    }
}

#Preview {
    ContentView()
}
