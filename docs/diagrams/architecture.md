# System Architecture

## High-level

```mermaid
flowchart TB
    subgraph OS["Device OS"]
        LSW["Lockscreen Widget<br/>(iOS WidgetKit / Android Glance)"]
        BT["iOS Back-Tap / Android QS Tile"]
        NOTIF["Local Notifications"]
        HK["HealthKit / Health Connect"]
        GEO["CoreLocation / FusedLocation"]
    end

    subgraph FLUTTER["Flutter App"]
        UI["UI Layer<br/>(features/*)"]
        VM["State (Riverpod)"]
        REPO["Repositories<br/>SessionRepo · BiometricRepo · GeoRepo"]
        SVC["Services<br/>NotificationSvc · WidgetBridge<br/>HealthSvc · LocationSvc · TimerSvc"]
        DB[("Drift + SQLCipher")]
    end

    subgraph NATIVE["Native Bridges"]
        INTENT["App Intents (iOS)"]
        FGS["Foreground Service (Android)"]
        WB["home_widget channel"]
    end

    LSW --> INTENT
    BT --> INTENT
    INTENT --> WB
    LSW -.Android.-> WB
    WB --> SVC
    SVC <--> NATIVE
    SVC --> NOTIF
    SVC --> HK
    SVC --> GEO
    UI --> VM --> REPO --> DB
    REPO <--> SVC
    FGS --> SVC
```

## Layered View

```mermaid
flowchart LR
    UI[features/] --> STATE[Riverpod providers]
    STATE --> REPO[repositories]
    REPO --> DB[(Drift DB)]
    REPO --> SVC[platform services]
    SVC --> OS[(OS APIs)]
```

## Module Map

```
lib/
├── app/          bootstrap, router
├── core/         theme, result types
├── data/
│   ├── db/       drift schema + DAOs
│   ├── repo/     Session/Biometric/Geo
│   └── services/ Notification/Widget/Health/Location/Timer
├── features/
│   ├── session/  start · active · end
│   ├── dashboard/history · charts · triggers
│   ├── tag/      picker · retro-edit
│   └── settings/ perms · sync · export
└── shared/       widgets, utils
```
