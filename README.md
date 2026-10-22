# Ciudad Libre — Android Open-World Prototype

An original Android-friendly open-world action game concept inspired by sandbox crime games. This project is not GTA 6 and does not use GTA characters, maps, logos, music, or other proprietary assets.

## Prototype goals
- A compact fictional city district designed for mobile performance.
- Third-person player movement and a follow camera.
- Drivable vehicles with touch controls.
- Mission markers, simple objectives, and pursuit mechanics.
- Mobile-first interface and scalable quality settings.
- Original art, names, story, and audio.

## Recommended engine
**Godot 4.x** is the recommended starting point for an Android-first prototype. Configure Godot's Android export setup to build an APK. This repository currently contains the design and implementation plan, not a compiled APK.

## Suggested project layout
```
CiudadLibre/
  project.godot
  scenes/Main.tscn
  scenes/CityBlock.tscn
  scenes/Player.tscn
  scenes/Vehicle.tscn
  scripts/player_controller.gd
  scripts/mobile_controls.gd
  scripts/vehicle_controller.gd
  scripts/mission_manager.gd
  scripts/wanted_system.gd
  docs/GAME_DESIGN.md
  docs/IMPLEMENTATION_PLAN.md
```

## Milestones
1. Bootable Android shell, main menu, pause and settings.
2. Walkable city block, third-person camera and touch controls.
3. Enterable vehicle and arcade driving.
4. One complete timed delivery mission and rewards.
5. Wanted meter and basic pursuit/search behavior.
6. On-device performance testing, save/load and Android export.

## Status
Planning/prototype foundation only. No playable build or APK is included yet. The goal is to build and test a small polished slice first rather than claim to recreate a full AAA game in one pass.
