# Ciudad Libre — Android Open-World Prototype

**Ciudad Libre** is an original, mobile-first third-person city sandbox concept inspired by open-world action games. It is not GTA 6 and contains no GTA characters, maps, branding, music, or copied proprietary assets.

## Current contents
- A Godot 4 project shell configured for the mobile renderer and landscape layout.
- A procedural low-poly city block built from primitive meshes.
- Third-person character movement.
- A simple arcade car you can enter, drive, and exit.
- Touchscreen direction buttons, camera drag, and PC keyboard/mouse controls.
- One checkpoint mission with a credit reward.

## Open the project
1. Install Godot 4.x on a computer.
2. Download or clone this repository and open the folder containing `project.godot`.
3. Press Play to run `scenes/Main.tscn`.
4. On PC, use **WASD** to move, **E** to enter/exit the car, and hold the right mouse button while dragging to look around.
5. On a touchscreen, use the arrow buttons to move/drive, drag the screen to look around, and tap the action button near the car to enter or exit.
6. Drive or walk to the glowing blue marker to complete the first mission.

## Android build
Configure Android export templates, SDK/JDK paths, package name, app icon, and signing in Godot before exporting an APK. Test on a real device and profile performance before distributing.

## Status and limitations
This is an early playable-prototype code foundation, not an AAA-scale game. The code has been added to the repository but has **not been built, tested in Godot, or exported to an APK in this session**. The city, character, car, and mission use simple procedural shapes and should be replaced or expanded with original, optimized assets over time.
