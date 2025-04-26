extends CharacterBody2D

# UI control nodes (popups)
var inventory_panel: Control
var pause_menu     : Control

# Visual nodes
@onready var visual_node      : Node2D          = $Skeleton
@onready var body_sprite      : Sprite2D        = $Skeleton/body
@onready var hair             : Sprite2D        = $Skeleton/hair
@onready var eyes             : Sprite2D        = $Skeleton/eyes
@onready var shirt            : Sprite2D        = $Skeleton/shirt
@onready var pants            : Sprite2D        = $Skeleton/pants
@onready var shoes            : Sprite2D        = $Skeleton/shoes
@onready var accessories      : Sprite2D        = $Skeleton/accessories
@onready var name_label       : Label           = $Name_Label
@onready var animated_sprite  : AnimationPlayer = $AnimationPlayer

@export var speed              : float   = 100.0
@export var bridge_tilemap     : TileMap
@export var bridge_y_threshold : float   = 100.0

var direction: String = "down"

func _ready():
	print("✅ Player.gd ready. Global position before:", Global.player_position)
	print("✅ Player.gd ready. Scene:", get_tree().current_scene)

	var root = get_tree().get_current_scene()

	# Inventory panel lookup
	inventory_panel = root.get_node_or_null("$UI")
	if inventory_panel == null:
		inventory_panel = root.get_node_or_null("UI")
	if inventory_panel == null:
		push_warning("[Player] Inventory panel not found; skipping checks.")

	# Pause menu lookup
	pause_menu = root.get_node_or_null("PauseMenu")
	if pause_menu == null:
		pause_menu = root.get_node_or_null("PauseMenu")
	if pause_menu == null:
		push_warning("[Player] Pause menu not found; skipping checks.")

	# Wait one frame so all other _ready() calls finish
	await get_tree().process_frame

	# ─── SPAWN LOGIC ────────────────────────────────────────────────────────────
	var spawn_point: Marker2D = null
	match Global.spawn_from:
		"fromTown":
			spawn_point = root.get_node_or_null("SpawnPoints/SpawnFromTown") as Marker2D
		"fromFarmhouse":
			spawn_point = root.get_node_or_null("SpawnPoints/SpawnFromFarmhouse") as Marker2D
		"newGame":
			spawn_point = root.get_node_or_null("SpawnPoints/NewSpawn") as Marker2D
		_:
			spawn_point = null

	if spawn_point != null and is_instance_valid(spawn_point):
		var target = spawn_point.global_position
		global_position = target
		Global.player_position = target      # ← persist it!
		Global.save_game()                   # ← write it out
		print("🌀 Spawned at marker:", spawn_point.name)
	else:
		global_position = Global.player_position
		print("📍 Loaded saved player position:", global_position)


	# Clear for next time
	Global.spawn_from = ""

	initialize_player()
	print("✅ Player final position:", global_position)
	print("✅ Global player_position after ready:", Global.player_position)

func _physics_process(_delta: float) -> void:
	if inventory_panel != null and pause_menu != null and (inventory_panel.visible or pause_menu.visible):
		velocity = Vector2.ZERO
	else:
		var input_dir = Vector2(
			Input.get_action_strength("right") - Input.get_action_strength("left"),
			Input.get_action_strength("down")  - Input.get_action_strength("up")
		)
		if input_dir != Vector2.ZERO:
			input_dir = input_dir.normalized()
			velocity = input_dir * speed
			_update_run_animation(input_dir)
			if abs(input_dir.x) > abs(input_dir.y):
				if input_dir.x > 0:
					direction = "right"
				else:
					direction = "left"
			else:
				if input_dir.y > 0:
					direction = "down"
				else:
					direction = "up"
		else:
			velocity = Vector2.ZERO
			_play_idle_animation()

	move_and_slide()

func _update_run_animation(input_dir: Vector2) -> void:
	if abs(input_dir.x) > abs(input_dir.y):
		animated_sprite.play("run_side")
		if input_dir.x < 0:
			visual_node.scale.x = -1
		else:
			visual_node.scale.x = 1
	else:
		if input_dir.y < 0:
			animated_sprite.play("run_back")
		else:
			animated_sprite.play("run_front")

func _play_idle_animation() -> void:
	match direction:
		"up":
			animated_sprite.play("idle_back")
		"down":
			animated_sprite.play("idle_front")
		"left":
			animated_sprite.play("idle_side")
			visual_node.scale.x = -1
		"right":
			animated_sprite.play("idle_side")
			visual_node.scale.x = 1

func initialize_player() -> void:
	body_sprite.texture  = Global.skin_collection.get(Global.selected_skin, Global.skin_collection["white"])
	hair.texture         = Global.hair_collection.get(Global.selected_hair, Global.hair_collection["buzzcut"])
	eyes.texture         = Global.face_collection.get(Global.selected_eyes, Global.face_collection["eyes"])
	shirt.texture        = Global.shirt_collection.get(Global.selected_shirt, Global.shirt_collection["basic"])
	pants.texture        = Global.pants_collection.get(Global.selected_pants, Global.pants_collection["pants"])
	shoes.texture        = Global.shoes_collection.get(Global.selected_shoes, Global.shoes_collection["shoes"])
	accessories.texture  = Global.acc_collection.get(Global.selected_acc, null)

	body_sprite.modulate = Global.selected_skin_color
	hair.modulate        = Global.selected_hair_color
	eyes.modulate        = Global.selected_eyes_color
	shirt.modulate       = Global.selected_shirt_color
	pants.modulate       = Global.selected_pants_color
	shoes.modulate       = Global.selected_shoes_color
	accessories.modulate = Global.selected_acc_color

	if name_label != null:
		if Global.player_name != "":
			name_label.text = Global.player_name
		else:
			name_label.text = "Check the mirror"
