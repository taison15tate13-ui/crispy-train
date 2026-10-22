extends Node3D

# Ciudad Libre is an original, small-scope sandbox prototype. All visible objects
# are generated from primitive meshes so the project can start without external assets.

var held: Dictionary = {
	"forward": false,
	"back": false,
	"left": false,
	"right": false
}

var player: CharacterBody3D
var car: Node3D
var camera: Camera3D
var hud: Control
var status_label: Label
var action_button: Button
var mission_marker: MeshInstance3D

var driving := false
var car_speed := 0.0
var camera_yaw := 0.0
var camera_pitch := 0.18
var mouse_look := false
var mission_complete := false
var credits := 0
var mission_position := Vector3(0.0, 0.12, -42.0)


func _ready() -> void:
	_build_environment()
	_build_city()
	_build_player()
	_build_car()
	_build_mission()
	_build_camera()
	_build_hud()
	_update_hud()


func _build_environment() -> void:
	var world_environment := WorldEnvironment.new()
	var environment := Environment.new()
	environment.background_mode = Environment.BG_COLOR
	environment.background_color = Color(0.43, 0.67, 0.83)
	environment.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
	environment.ambient_light_color = Color(0.72, 0.79, 0.86)
	environment.ambient_light_energy = 0.8
	world_environment.environment = environment
	add_child(world_environment)

	var sun := DirectionalLight3D.new()
	sun.rotation_degrees = Vector3(-48.0, -32.0, 0.0)
	sun.light_energy = 1.15
	add_child(sun)

	var ground := StaticBody3D.new()
	ground.name = "Ground"
	var ground_shape := CollisionShape3D.new()
	var box_shape := BoxShape3D.new()
	box_shape.size = Vector3(180.0, 1.0, 180.0)
	ground_shape.shape = box_shape
	ground_shape.position.y = -0.5
	ground.add_child(ground_shape)

	var ground_mesh := MeshInstance3D.new()
	var ground_box := BoxMesh.new()
	ground_box.size = Vector3(180.0, 1.0, 180.0)
	ground_mesh.mesh = ground_box
	ground_mesh.position.y = -0.5
	ground_mesh.material_override = _material(Color(0.24, 0.34, 0.29))
	ground.add_child(ground_mesh)
	add_child(ground)

	_add_flat_block(Vector3(0.0, 0.015, -8.0), Vector3(8.0, 0.03, 150.0), Color(0.12, 0.14, 0.16))
	_add_flat_block(Vector3(-8.0, 0.025, -8.0), Vector3(1.2, 0.05, 150.0), Color(0.58, 0.57, 0.50))
	_add_flat_block(Vector3(8.0, 0.025, -8.0), Vector3(1.2, 0.05, 150.0), Color(0.58, 0.57, 0.50))


func _build_city() -> void:
	_add_building(-13.0, -4.0, 8.0, 10.0, 13.0, Color(0.61, 0.39, 0.31))
	_add_building(13.0, -3.0, 8.0, 11.0, 15.0, Color(0.53, 0.57, 0.62))
	_add_building(-14.0, -20.0, 9.0, 12.0, 18.0, Color(0.70, 0.59, 0.40))
	_add_building(14.0, -21.0, 9.0, 10.0, 14.0, Color(0.47, 0.58, 0.51))
	_add_building(-13.0, -38.0, 8.0, 12.0, 17.0, Color(0.64, 0.47, 0.41))
	_add_building(13.0, -39.0, 8.0, 11.0, 13.0, Color(0.51, 0.53, 0.65))
	_add_building(-14.0, 17.0, 9.0, 12.0, 15.0, Color(0.58, 0.55, 0.44))
	_add_building(14.0, 17.0, 9.0, 11.0, 12.0, Color(0.46, 0.58, 0.61))


func _add_flat_block(block_position: Vector3, block_size: Vector3, color: Color) -> void:
	var mesh_instance := MeshInstance3D.new()
	var box := BoxMesh.new()
	box.size = block_size
	mesh_instance.mesh = box
	mesh_instance.position = block_position
	mesh_instance.material_override = _material(color)
	add_child(mesh_instance)


func _add_building(x: float, z: float, width: float, depth: float, height: float, color: Color) -> void:
	var building := StaticBody3D.new()
	building.name = "CityBuilding"
	building.position = Vector3(x, height * 0.5, z)

	var collision := CollisionShape3D.new()
	var shape := BoxShape3D.new()
	shape.size = Vector3(width, height, depth)
	collision.shape = shape
	building.add_child(collision)

	var mesh_instance := MeshInstance3D.new()
	var box := BoxMesh.new()
	box.size = Vector3(width, height, depth)
	mesh_instance.mesh = box
	mesh_instance.material_override = _material(color)
	building.add_child(mesh_instance)

	# Simple light-colored strips suggest windows without external textures.
	var window_strip := MeshInstance3D.new()
	var strip := BoxMesh.new()
	strip.size = Vector3(width * 0.78, 0.16, 0.08)
	window_strip.mesh = strip
	window_strip.position = Vector3(0.0, height * 0.58, -depth * 0.5 - 0.045)
	window_strip.material_override = _material(Color(0.35, 0.72, 0.79))
	building.add_child(window_strip)

	add_child(building)


func _build_player() -> void:
	player = CharacterBody3D.new()
	player.name = "Player"
	player.position = Vector3(0.0, 0.0, 5.0)
	player.floor_snap_length = 0.25

	var collision := CollisionShape3D.new()
	var capsule := CapsuleShape3D.new()
	capsule.radius = 0.42
	capsule.height = 1.8
	collision.shape = capsule
	collision.position.y = 0.9
	player.add_child(collision)

	var visual := MeshInstance3D.new()
	var capsule_mesh := CapsuleMesh.new()
	capsule_mesh.radius = 0.42
	capsule_mesh.height = 1.8
	visual.mesh = capsule_mesh
	visual.position.y = 0.9
	visual.material_override = _material(Color(0.16, 0.75, 0.93))
	player.add_child(visual)
	add_child(player)


func _build_car() -> void:
	car = Node3D.new()
	car.name = "OriginalCompactCar"
	car.position = Vector3(2.5, 0.0, 3.0)
	add_child(car)

	var body := MeshInstance3D.new()
	var body_mesh := BoxMesh.new()
	body_mesh.size = Vector3(2.0, 0.7, 3.6)
	body.mesh = body_mesh
	body.position.y = 0.78
	body.material_override = _material(Color(0.82, 0.24, 0.16))
	car.add_child(body)

	var roof := MeshInstance3D.new()
	var roof_mesh := BoxMesh.new()
	roof_mesh.size = Vector3(1.48, 0.56, 1.8)
	roof.mesh = roof_mesh
	roof.position = Vector3(0.0, 1.35, -0.1)
	roof.material_override = _material(Color(0.15, 0.22, 0.28))
	car.add_child(roof)

	var wheel_mesh := CylinderMesh.new()
	wheel_mesh.top_radius = 0.32
	wheel_mesh.bottom_radius = 0.32
	wheel_mesh.height = 0.22
	wheel_mesh.radial_segments = 12
	for x_side in [-1.0, 1.0]:
		for z_side in [-1.0, 1.0]:
			var wheel := MeshInstance3D.new()
			wheel.mesh = wheel_mesh
			wheel.position = Vector3(x_side * 1.0, 0.34, z_side * 1.12)
			wheel.rotation_degrees.z = 90.0
			wheel.material_override = _material(Color(0.07, 0.08, 0.09))
			car.add_child(wheel)


func _build_mission() -> void:
	mission_marker = MeshInstance3D.new()
	mission_marker.name = "MissionCheckpoint"
	var marker_mesh := CylinderMesh.new()
	marker_mesh.top_radius = 1.65
	marker_mesh.bottom_radius = 1.65
	marker_mesh.height = 0.12
	marker_mesh.radial_segments = 32
	mission_marker.mesh = marker_mesh
	mission_marker.position = mission_position
	mission_marker.material_override = _material(Color(0.05, 0.78, 1.0), true)
	add_child(mission_marker)


func _build_camera() -> void:
	camera = Camera3D.new()
	camera.name = "FollowCamera"
	camera.current = true
	camera.fov = 72.0
	add_child(camera)
	camera.global_position = Vector3(0.0, 4.0, 12.0)
	camera.look_at(player.global_position + Vector3(0.0, 1.0, 0.0), Vector3.UP)


func _build_hud() -> void:
	var canvas := CanvasLayer.new()
	canvas.name = "MobileHUD"
	add_child(canvas)

	hud = Control.new()
	hud.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	hud.mouse_filter = Control.MOUSE_FILTER_PASS
	canvas.add_child(hud)

	status_label = Label.new()
	status_label.position = Vector2(22.0, 18.0)
	status_label.size = Vector2(680.0, 94.0)
	status_label.add_theme_font_size_override("font_size", 22)
	status_label.add_theme_color_override("font_color", Color(1.0, 1.0, 1.0))
	hud.add_child(status_label)

	var viewport_size := get_viewport().get_visible_rect().size
	var width := viewport_size.x
	var height := viewport_size.y
	var button_size := Vector2(60.0, 58.0)

	_make_hold_button("▲", "forward", Vector2(84.0, height - 236.0), button_size)
	_make_hold_button("◀", "left", Vector2(20.0, height - 172.0), button_size)
	_make_hold_button("▼", "back", Vector2(84.0, height - 108.0), button_size)
	_make_hold_button("▶", "right", Vector2(148.0, height - 172.0), button_size)

	action_button = Button.new()
	action_button.text = "USAR"
	action_button.position = Vector2(width - 182.0, height - 118.0)
	action_button.size = Vector2(160.0, 72.0)
	action_button.add_theme_font_size_override("font_size", 22)
	action_button.focus_mode = Control.FOCUS_NONE
	action_button.pressed.connect(_interact)
	hud.add_child(action_button)

	var help_label := Label.new()
	help_label.text = "Arrastra para mirar\nPC: WASD + E / clic derecho"
	help_label.position = Vector2(width - 310.0, 20.0)
	help_label.size = Vector2(285.0, 58.0)
	help_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
	help_label.add_theme_font_size_override("font_size", 16)
	help_label.add_theme_color_override("font_color", Color(1.0, 1.0, 1.0, 0.9))
	hud.add_child(help_label)


func _make_hold_button(label_text: String, direction: String, button_position: Vector2, button_size: Vector2) -> void:
	var button := Button.new()
	button.text = label_text
	button.position = button_position
	button.size = button_size
	button.add_theme_font_size_override("font_size", 24)
	button.focus_mode = Control.FOCUS_NONE
	button.button_down.connect(func() -> void:
		held[direction] = true
	)
	button.button_up.connect(func() -> void:
		held[direction] = false
	)
	hud.add_child(button)


func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.pressed and not event.echo and event.keycode == KEY_E:
			_interact()
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT:
		mouse_look = event.pressed
	if event is InputEventMouseMotion and mouse_look:
		camera_yaw -= event.relative.x * 0.006
		camera_pitch = clampf(camera_pitch - event.relative.y * 0.0025, 0.03, 0.55)
	if event is InputEventScreenDrag:
		camera_yaw -= event.relative.x * 0.005
		camera_pitch = clampf(camera_pitch - event.relative.y * 0.002, 0.03, 0.55)


func _physics_process(delta: float) -> void:
	_update_controls(delta)
	_update_camera(delta)
	_check_mission()
	_update_hud()


func _axis(positive: String, negative: String, positive_key: Key, negative_key: Key) -> float:
	var is_positive: bool = bool(held.get(positive, false)) or Input.is_key_pressed(positive_key)
	var is_negative: bool = bool(held.get(negative, false)) or Input.is_key_pressed(negative_key)
	return (1.0 if is_positive else 0.0) - (1.0 if is_negative else 0.0)


func _update_controls(delta: float) -> void:
	var forward_axis := _axis("forward", "back", KEY_W, KEY_S)
	var side_axis := _axis("right", "left", KEY_D, KEY_A)

	if driving:
		if absf(forward_axis) > 0.01:
			car_speed = clampf(car_speed + forward_axis * 12.0 * delta, -7.0, 15.0)
		else:
			car_speed = move_toward(car_speed, 0.0, 3.2 * delta)
		if absf(car_speed) > 0.1:
			car.rotation.y += side_axis * delta * 1.45 * (1.0 if car_speed >= 0.0 else -1.0)
		car.global_position += -car.global_transform.basis.z * car_speed * delta
		car.global_position.y = 0.0
		return

	var forward := Vector3(sin(camera_yaw), 0.0, -cos(camera_yaw))
	var right := Vector3(cos(camera_yaw), 0.0, sin(camera_yaw))
	var direction := (forward * forward_axis + right * side_axis).normalized()

	if player.is_on_floor():
		if player.velocity.y < 0.0:
			player.velocity.y = -0.5
	else:
		player.velocity.y -= 22.0 * delta

	player.velocity.x = direction.x * 5.5
	player.velocity.z = direction.z * 5.5
	if direction.length_squared() > 0.01:
		player.rotation.y = atan2(-direction.x, -direction.z)
	player.move_and_slide()


func _update_camera(delta: float) -> void:
	var focus_position: Vector3
	if driving:
		focus_position = car.global_position + Vector3(0.0, 1.0, 0.0)
	else:
		focus_position = player.global_position + Vector3(0.0, 1.0, 0.0)

	var distance := 7.0
	var vertical := 2.2 + camera_pitch * 4.0
	var offset := Vector3(sin(camera_yaw) * distance, vertical, cos(camera_yaw) * distance)
	camera.global_position = camera.global_position.lerp(focus_position + offset, minf(1.0, delta * 6.0))
	camera.look_at(focus_position, Vector3.UP)


func _interact() -> void:
	if driving:
		driving = false
		player.visible = true
		player.global_position = car.global_position + car.global_transform.basis.x * 2.0
		player.velocity = Vector3.ZERO
		return

	if player.global_position.distance_to(car.global_position) <= 3.8:
		driving = true
		player.visible = false
	else:
		# The HUD explains how to reach the vehicle; no state changes are needed.
		pass


func _check_mission() -> void:
	if mission_complete:
		return
	var active_position := car.global_position if driving else player.global_position
	if active_position.distance_to(mission_position) < 2.7:
		mission_complete = true
		credits += 100
		mission_marker.visible = false


func _update_hud() -> void:
	if status_label == null:
		return

	var active_position := car.global_position if driving else player.global_position
	var distance_to_goal := active_position.distance_to(mission_position)
	if mission_complete:
		status_label.text = "CIUDAD LIBRE — PROTOTIPO\nMISIÓN COMPLETADA  |  +100 CRÉDITOS  |  Total: %d" % credits
	else:
		status_label.text = "CIUDAD LIBRE — PROTOTIPO\nLlega al aro azul: %.0f m  |  Créditos: %d" % [distance_to_goal, credits]

	if driving:
		action_button.text = "SALIR DEL COCHE"
	elif player.global_position.distance_to(car.global_position) <= 3.8:
		action_button.text = "CONDUCIR"
	else:
		action_button.text = "USAR"


func _material(color: Color, glowing: bool = false) -> StandardMaterial3D:
	var material := StandardMaterial3D.new()
	material.albedo_color = color
	if glowing:
		material.emission_enabled = true
		material.emission = color
		material.emission_energy_multiplier = 1.6
	return material
