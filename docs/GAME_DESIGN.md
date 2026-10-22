# Ciudad Libre — Game Design Document

## High concept
A third-person open-world action sandbox set in **Puerto Aurora**, a fictional coastal metropolis. The player works as an independent courier and mechanic, earning credits, exploring districts, and choosing how to approach jobs. Characters, architecture, vehicles, dialogue, story, and audio will be original.

## Mobile-first vertical slice
**Goal:** a small, replayable demo that runs well on mid-range Android devices.

### World
- One compact neighborhood: boulevard, industrial yard, market street, garage, and waterfront.
- Recognizable landmarks and simple streaming boundaries.
- Daylight lighting first; day/night and weather can be added later.
- A small pool of low-cost traffic vehicles.

### Player
- Third-person walking, jogging, sprinting, jumping, and interaction.
- Follow camera with wall collision avoidance.
- Touch controls: left virtual stick; right-side camera drag; context button to interact or enter vehicles.
- Controller support is a later milestone.

### Vehicles
- Enter and exit parked cars.
- Accelerate, brake/reverse, steer, and handbrake.
- Arcade handling tuned for touchscreens.
- Vehicle camera and recovery button if stuck.
- Cosmetic damage only until the core loop is stable.

### First mission: The Late Delivery
1. Meet a mechanic at the garage.
2. Enter an original compact car.
3. Drive to the market checkpoint before the timer expires.
4. Avoid obstacles and optional patrol attention.
5. Return for a credit reward and debrief.

### Wanted / pursuit system
- Prototype wanted level from 0 to 3 stars.
- Game events or mission triggers raise attention.
- Patrol vehicles search the player's last known area.
- Wanted level gradually falls after the player stays out of sight.
- Keep this stylized and fictional.

### Progression
- Earn credits by completing missions.
- Purchase cosmetic vehicle colors and unlock jobs.
- Save progress locally; no account needed for the first demo.

## Technical direction
- Engine: Godot 4.x, GDScript.
- Orientation: landscape.
- Renderer: Godot Mobile; use low-cost materials and lighting.
- Controls: thumb-sized on-screen stick and buttons, with sensitivity settings.
- Initial performance target: stable 30 FPS on a mid-range Android baseline.
- Persistence: local versioned save data with safe defaults for missing or malformed values.

## Milestones
1. **Bootable shell:** main menu, settings, pause, landscape orientation.
2. **Walking slice:** graybox level, third-person controller, collision, touch UI.
3. **Vehicle slice:** enter/exit, handling, camera, recovery.
4. **Mission loop:** marker, objective text, timer, result screen, reward.
5. **Pursuit slice:** attention meter, patrol search, cooldown.
6. **Optimization:** profile on physical Android devices and fix bottlenecks.
7. **Export:** signed APK/AAB after device testing and correct package metadata.

## Acceptance criteria for first playable build
- Starts on Android without crashing.
- Movement and driving work with touch.
- The first mission can be completed and grants a reward.
- Pause and settings are usable on a phone.
- Save/load survives restarts.
- No GTA branding or copied assets.
- The project is labelled as a prototype, not a full AAA release.

## Scope guardrails
A mobile project cannot realistically reproduce the full scope, asset density, and production value of GTA 6 in one pass. Build a small playable slice, test it on devices, and expand deliberately.
