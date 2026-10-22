# Implementation Plan — Godot 4.x

This repository currently contains design documents only. Use this checklist to create the first playable slice.

## Draft scene tree
```
Main (Node3D)
├── WorldEnvironment
├── City (Node3D)
├── Player (CharacterBody3D)
│   ├── CollisionShape3D
│   ├── VisualRoot
│   └── CameraPivot
│       └── SpringArm3D
│           └── Camera3D
├── MissionManager (Node)
└── MobileHUD (CanvasLayer)
    ├── MoveStick
    ├── CameraTouchArea
    ├── InteractButton
    ├── ActionButton
    └── PauseButton
```

## Task checklist
- [ ] Create Godot project; configure landscape and mobile renderer.
- [ ] Graybox one city block with simple meshes and collision.
- [ ] Implement player walk/run/jump using CharacterBody3D.
- [ ] Add touch joystick and camera drag; expose sensitivity settings.
- [ ] Create one vehicle scene and arcade driving behavior.
- [ ] Add enter/exit interaction range and switch control mode.
- [ ] Implement mission states: idle, active, success, failure.
- [ ] Add a checkpoint route and timer.
- [ ] Add wanted meter and simple patrol search behavior.
- [ ] Add local save data and settings persistence.
- [ ] Run on a physical Android device; profile performance and fix crashes.
- [ ] Configure app identity, signing, and APK/AAB export.

## Engineering notes
- Keep player, vehicle, missions, wanted system, and save data decoupled from HUD node names.
- Use signals for mission state and UI updates.
- Validate saved data and provide safe defaults.
- Avoid expensive reflections, dense traffic, huge textures, and lots of dynamic lights early.
- Do not claim the game is ready to install until an APK has been built and tested.
