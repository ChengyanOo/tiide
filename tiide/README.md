# tiide

> "Make your effort seen."

Distress/craving session timer. Sprint 1 MVP — manual start, stop, tag, review.

See [design docs](../docs/design.md).

## Requirements
- Flutter stable (>= 3.41)
- Dart 3.x

## Run
```sh
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run
```

Drift uses codegen — rerun build_runner after schema changes:
```sh
dart run build_runner watch --delete-conflicting-outputs
```

## Analyze
```sh
flutter analyze
```

## Structure
```
lib/
├── app/          bootstrap (router, providers)
├── core/         theme tokens
├── data/
│   ├── db/       drift schema
│   └── repo/     SessionRepo
└── features/
    ├── home/     start button
    ├── session/  active timer · history
    └── tag/      picker sheet
```

## Sprint 1 scope
- Manual start → 15-min progress bar → stop → tag → saved.
- History list with tags.
- Drift-backed local persistence (sqlite). SQLCipher wiring lands in a later sprint.
