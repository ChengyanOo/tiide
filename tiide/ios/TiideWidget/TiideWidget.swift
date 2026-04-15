import WidgetKit
import SwiftUI
import AppIntents

struct TiideEntry: TimelineEntry {
    let date: Date
    let activeSessionId: String?
    let startedAt: Date?
    let plannedMin: Int
}

struct Provider: TimelineProvider {
    private let appGroup = "group.com.tiide.tiide"

    func placeholder(in context: Context) -> TiideEntry {
        TiideEntry(date: Date(), activeSessionId: nil, startedAt: nil, plannedMin: 15)
    }

    func getSnapshot(in context: Context, completion: @escaping (TiideEntry) -> Void) {
        completion(readEntry())
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<TiideEntry>) -> Void) {
        let entry = readEntry()
        let next = Date().addingTimeInterval(60)
        completion(Timeline(entries: [entry], policy: .after(next)))
    }

    private func readEntry() -> TiideEntry {
        let d = UserDefaults(suiteName: appGroup)
        let id = d?.string(forKey: "tiide.activeSessionId")
        let startedRaw = d?.string(forKey: "tiide.startedAt")
        let planned = d?.integer(forKey: "tiide.plannedMin") ?? 15
        let started = startedRaw.flatMap { ISO8601DateFormatter().date(from: $0) }
        return TiideEntry(date: Date(), activeSessionId: id, startedAt: started, plannedMin: planned)
    }
}

struct StartSessionIntent: AppIntent {
    static var title: LocalizedStringResource = "Start Distress Session"
    static var description = IntentDescription("Start a 15-minute tiide session.")
    static var openAppWhenRun: Bool = false

    func perform() async throws -> some IntentResult {
        if let url = URL(string: "tiide://session/start") {
            await MainActor.run {
                #if canImport(UIKit)
                UIApplication.shared.open(url)
                #endif
            }
        }
        return .result()
    }
}

struct TiideWidgetView: View {
    var entry: Provider.Entry

    var body: some View {
        ZStack {
            Color.black
            VStack(spacing: 8) {
                Text("tiide").font(.caption).foregroundColor(.gray)
                if entry.activeSessionId != nil {
                    Text("active").font(.headline).foregroundColor(.green)
                } else {
                    Button(intent: StartSessionIntent()) {
                        Text("START")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.black)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(Color.green)
                            .clipShape(Capsule())
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }
}

struct TiideWidget: Widget {
    let kind: String = "TiideWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            TiideWidgetView(entry: entry)
        }
        .configurationDisplayName("tiide")
        .description("Start a distress session from the lock screen.")
        .supportedFamilies([.systemSmall, .accessoryCircular, .accessoryRectangular])
    }
}
