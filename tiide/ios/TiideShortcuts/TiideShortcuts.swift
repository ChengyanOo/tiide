import AppIntents

struct TiideShortcutsProvider: AppShortcutsProvider {
    static var appShortcuts: [AppShortcut] {
        AppShortcut(
            intent: StartSessionIntent(),
            phrases: [
                "Start Distress Session in \(.applicationName)",
                "Start a tiide session"
            ],
            shortTitle: "Start Session",
            systemImageName: "waveform.path"
        )
    }
}
