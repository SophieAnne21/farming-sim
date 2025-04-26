extends Node


func _ready():
	print("✅ Global.gd ready. Scene tree is active.")

var key = "SimpleSaveLoad"
var player_position: Vector2 = Vector2(0, 0)
var player_name: String = "Check the Mirror"
var last_scene: String = "res://farm.tscn"
var spawn_from: String = ""


# === Selected Customization ===
var selected_skin: String = ""
var selected_eyes: String = ""
var selected_hair: String = ""
var selected_fullbody: String = "none"
var selected_shirt: String = ""
var selected_pants: String = ""
var selected_shoes: String = ""
var selected_acc: String = ""

# === Color Selections ===
var selected_skin_color: Color = Color(1, 1, 1)
var selected_eyes_color: Color = Color(1, 1, 1)
var selected_hair_color: Color = Color(1, 1, 1)
var selected_fullbody_color: Color = Color(1, 1, 1)
var selected_shirt_color: Color = Color(1, 1, 1)
var selected_pants_color: Color = Color(1, 1, 1)
var selected_shoes_color: Color = Color(1, 1, 1)
var selected_acc_color: Color = Color(1, 1, 1)

# === Pastel Color Options ===
var skin_color_options = [
	Color(1.0, 0.88, 0.79),  # light peach
	Color(0.96, 0.80, 0.69), # soft beige
	Color(0.82, 0.65, 0.50), # gentle tan
	Color(0.60, 0.42, 0.33), # muted brown
	Color(0.42, 0.30, 0.22), # warm brown
	Color(0.30, 0.22, 0.17)  # deep brown
]

var hair_color_options = [
	Color(0.95, 0.80, 0.87), # pastel pink
	Color(0.80, 0.88, 1.0),  # baby blue
	Color(0.85, 1.0, 0.85),  # mint
	Color(1.0, 0.92, 0.74),  # peach blonde
	Color(0.95, 0.95, 0.95), # soft white
	Color(0.70, 0.60, 0.80),  # lavender
	Color(0.1, 0.1, 0.1) # soft black
]

var eyes_color_options = [
	Color(0.1, 0.4, 0.8),   # vibrant blue
	Color(0.2, 0.7, 0.2),   # natural green
	Color(0.6, 0.3, 0.1),   # warm brown
	Color(0.3, 0.3, 0.3),   # dark gray
	Color(0.7, 0.6, 0.4),   # hazel
	Color(0.2, 0.2, 0.5),   # deep indigo
	Color(0.9, 0.6, 0.2),   # amber
	Color(0.6, 0.5, 0.7),   # gray violet
	Color(0.4, 0.2, 0.6),   # plum
	Color(0.8, 0.5, 0.4)    # copper rose
]

var shirt_color_options = [
	Color(1.0, 0.85, 0.85),  # rose pink
	Color(0.80, 1.0, 0.80),  # pastel green
	Color(0.90, 0.90, 1.0),  # periwinkle
	Color(1.0, 0.95, 0.80),  # cream
	Color(0.95, 0.90, 0.98), # blush lavender
	Color(0.85, 0.90, 0.95),  # soft blue
	Color(0.1, 0.1, 0.1)     # soft black
]

var pants_color_options = [
	Color(0.85, 0.55, 0.40),  # warm terracotta
	Color(0.40, 0.70, 0.50),  # rich sage
	Color(0.55, 0.45, 0.70),  # deep lavender
	Color(0.35, 0.65, 0.65),  # teal-gray
	Color(0.65, 0.45, 0.35),  # baked clay
	Color(0.45, 0.60, 0.80),   # denim blue
	Color(0.1, 0.1, 0.1)      # soft black
]

var shoes_color_options = [
	Color(0.95, 0.80, 0.85),  # pastel rose
	Color(0.80, 0.90, 1.0),  # baby blue
	Color(0.90, 1.0, 0.90),  # mint
	Color(1.0, 0.95, 0.85),  # warm cream
	Color(0.95, 0.88, 0.95), # pink lavender
	Color(0.88, 0.88, 0.95),  # periwinkle blue
	Color(0.1, 0.1, 0.1)     # soft black
]

var acc_color_options = [
	Color(0.95, 0.60, 0.90),  # vivid orchid
	Color(0.45, 0.85, 0.75),  # aqua teal
	Color(1.0, 0.60, 0.70),   # bright candy pink
	Color(1.0, 1.0, 0.85),    # glowing pearl
	Color(0.70, 0.55, 1.0),   # electric violet
	Color(1.0, 0.85, 0.4),     # golden peach
	Color(0.1, 0.1, 0.1)      # soft black
]

# === Asset Collections ===
var skin_collection = {
	"white": preload("res://Cute_Fantasy/Player/characters/char1.png"),
	"dark white": preload("res://Cute_Fantasy/Player/characters/char2.png"),
	"olive": preload("res://Cute_Fantasy/Player/characters/char3.png"),
	"dark olive": preload("res://Cute_Fantasy/Player/characters/char4.png"),
	"light brown": preload("res://Cute_Fantasy/Player/characters/char5.png"),
	"medium brown": preload("res://Cute_Fantasy/Player/characters/char6.png"),
	"darkest brown": preload("res://Cute_Fantasy/Player/characters/char7.png"),
	"black": preload("res://Cute_Fantasy/Player/characters/char8.png")
}

var hair_collection = {
	"none": null,
	"short bob": preload("res://Cute_Fantasy/Player/hair/bob .png"),
	"braids": preload("res://Cute_Fantasy/Player/hair/braids.png"),
	"buzzcut": preload("res://Cute_Fantasy/Player/hair/buzzcut.png"),
	"curly": preload("res://Cute_Fantasy/Player/hair/curly.png"),
	"emo": preload("res://Cute_Fantasy/Player/hair/emo.png"),
	"extra long": preload("res://Cute_Fantasy/Player/hair/extra_long.png"),
	"extra long skirt cut": preload("res://Cute_Fantasy/Player/hair/extra_long_skirt.png"),
	"french curl": preload("res://Cute_Fantasy/Player/hair/french_curl.png"),
	"gentleman cut": preload("res://Cute_Fantasy/Player/hair/gentleman.png"),
	"straight and long": preload("res://Cute_Fantasy/Player/hair/long_straight .png"),
	"long and straight skirt cut": preload("res://Cute_Fantasy/Player/hair/long_straight_skirt.png"),
	"midiwave": preload("res://Cute_Fantasy/Player/hair/midiwave.png"),
	"ponytail": preload("res://Cute_Fantasy/Player/hair/ponytail .png"),
	"spacebuns": preload("res://Cute_Fantasy/Player/hair/spacebuns.png"),
	"wavy": preload("res://Cute_Fantasy/Player/hair/wavy.png")
}

var full_body_collection = {
	"none": null,
	"clown": preload("res://Cute_Fantasy/Player/clothes/clown.png"),
	"dress": preload("res://Cute_Fantasy/Player/clothes/dress .png"),
	"overalls": preload("res://Cute_Fantasy/Player/clothes/overalls.png"),
	"pumpkin": preload("res://Cute_Fantasy/Player/clothes/pumpkin.png"),
	"spooky": preload("res://Cute_Fantasy/Player/clothes/spooky .png"),
	"witch": preload("res://Cute_Fantasy/Player/clothes/witch.png")
}

var shirt_collection = {
	"basic": preload("res://Cute_Fantasy/Player/clothes/basic.png"),
	"floral": preload("res://Cute_Fantasy/Player/clothes/floral.png"),
	"spaghetti": preload("res://Cute_Fantasy/Player/clothes/spaghetti.png"),
	"sailor": preload("res://Cute_Fantasy/Player/clothes/sailor.png"),
	"sailor_bow": preload("res://Cute_Fantasy/Player/clothes/sailor_bow.png"),
	"skull": preload("res://Cute_Fantasy/Player/clothes/skull.png"),
	"sporty": preload("res://Cute_Fantasy/Player/clothes/sporty.png"),
	"stripe": preload("res://Cute_Fantasy/Player/clothes/stripe.png"),
	"suit": preload("res://Cute_Fantasy/Player/clothes/suit.png")
}

var pants_collection = {
	"pants": preload("res://Cute_Fantasy/Player/clothes/pants.png"),
	"pants_suit": preload("res://Cute_Fantasy/Player/clothes/pants_suit.png"),
	"skirt": preload("res://Cute_Fantasy/Player/clothes/skirt.png")
}

var face_collection = {
	"blush": preload("res://Cute_Fantasy/Player/eyes/blush_all.png"),
	"eyes": preload("res://Cute_Fantasy/Player/eyes/eyes.png"),
	"lipstick": preload("res://Cute_Fantasy/Player/eyes/lipstick .png")
}

var shoes_collection = {
	"shoes": preload("res://Cute_Fantasy/Player/clothes/shoes.png")
}

var acc_collection = {
	"none": null,
	"Emerald earrings": preload("res://Cute_Fantasy/Player/acc/earring_emerald.png"),
	"Silver emerald earrings": preload("res://Cute_Fantasy/Player/acc/earring_emerald_silver.png"),
	"Red earrings": preload("res://Cute_Fantasy/Player/acc/earring_red.png"),
	"Red and silverearring": preload("res://Cute_Fantasy/Player/acc/earring_red_silver.png"),
	"Cowboy hat": preload("res://Cute_Fantasy/Player/acc/hat_cowboy.png"),
	"Lucky hat": preload("res://Cute_Fantasy/Player/acc/hat_lucky.png"),
	"Pumpkin hat": preload("res://Cute_Fantasy/Player/acc/hat_pumpkin.png"),
	"Purple pumpkin hat": preload("res://Cute_Fantasy/Player/acc/hat_pumpkin_purple.png"),
	"Witch hat": preload("res://Cute_Fantasy/Player/acc/hat_witch.png"),
	"Blue clown mask": preload("res://Cute_Fantasy/Player/acc/mask_clown_blue.png"),
	"Red clown mask": preload("res://Cute_Fantasy/Player/acc/mask_clown_red.png"),
	"Spooky": preload("res://Cute_Fantasy/Player/acc/mask_spooky.png")
}

# === Fallback setup for a new game ===
func set_defaults():
	print("Setting default name to: Check the Mirror")
	player_name = "Check the Mirror"
	selected_skin = "white"
	selected_hair = "buzzcut"
	selected_eyes = "eyes"
	selected_fullbody = "none"
	selected_shirt = "basic"
	selected_pants = "pants"
	selected_shoes = "shoes"
	selected_acc = "none"
	selected_skin_color = Color(1, 1, 1)
	selected_hair_color = Color(1, 1, 1)
	selected_eyes_color = Color(1, 1, 1)
	selected_fullbody_color = Color(1, 1, 1)
	selected_shirt_color = Color(1, 1, 1)
	selected_pants_color = Color(1, 1, 1)
	selected_shoes_color = Color(1, 1, 1)
	selected_acc_color = Color(1, 1, 1)

# === SAVE GAME ===
func save_game() -> void:
	if typeof(player_name) != TYPE_STRING:
		print("🚨 Invalid player name during save! Got:", player_name)
		player_name = "Check the Mirror"

	var config = ConfigFile.new()
	config.set_value("Player", "position", player_position)
	config.set_value("State", "last_scene", last_scene)
	config.set_value("Player", "name", player_name)
	config.set_value("Player", "skin", selected_skin)
	config.set_value("Player", "eyes", selected_eyes)
	config.set_value("Player", "hair", selected_hair)
	config.set_value("Player", "fullbody", selected_fullbody)
	config.set_value("Player", "shirt", selected_shirt)
	config.set_value("Player", "pants", selected_pants)
	config.set_value("Player", "shoes", selected_shoes)
	config.set_value("Player", "accessory", selected_acc)

	config.set_value("Colors", "skin", selected_skin_color.to_html())
	config.set_value("Colors", "eyes", selected_eyes_color.to_html())
	config.set_value("Colors", "hair", selected_hair_color.to_html())
	config.set_value("Colors", "fullbody", selected_fullbody_color.to_html())
	config.set_value("Colors", "shirt", selected_shirt_color.to_html())
	config.set_value("Colors", "pants", selected_pants_color.to_html())
	config.set_value("Colors", "shoes", selected_shoes_color.to_html())
	config.set_value("Colors", "accessory", selected_acc_color.to_html())

	var result := config.save_encrypted_pass("user://settings.cfg", key)
	if result == OK:
		print("💾 Game saved successfully!")
	else:
		print("❌ Save failed with error code:", result)

# === LOAD GAME ===
func load_game() -> bool:
	var config = ConfigFile.new()
	var result := config.load_encrypted_pass("user://settings.cfg", key)

	if result != OK:
		print("📭 No save file found or failed to load.")
		return false

	# Check if the position key exists and print raw data
	if config.has_section_key("Player", "position"):
		var saved_position = config.get_value("Player", "position")
		print("🔎 DEBUG: Raw position data type:", typeof(saved_position), "value:", saved_position)
		player_position = saved_position
		print("📍 Loaded player position:", player_position)
	else:
		print("⚠️ Position key not found in save file!")

	# ✅ This will now only run if the file loaded successfully:
	last_scene = config.get_value("State", "last_scene", "res://farm.tscn")

	player_name = config.get_value("Player", "name", "Check the Mirror")
	selected_skin = config.get_value("Player", "skin", "")
	selected_eyes = config.get_value("Player", "eyes", "")
	selected_hair = config.get_value("Player", "hair", "")
	selected_fullbody = config.get_value("Player", "fullbody", "none")
	selected_shirt = config.get_value("Player", "shirt", "")
	selected_pants = config.get_value("Player", "pants", "")
	selected_shoes = config.get_value("Player", "shoes", "")
	selected_acc = config.get_value("Player", "accessory", "")

	selected_skin_color = Color(config.get_value("Colors", "skin", "#ffffff"))
	selected_eyes_color = Color(config.get_value("Colors", "eyes", "#ffffff"))
	selected_hair_color = Color(config.get_value("Colors", "hair", "#ffffff"))
	selected_fullbody_color = Color(config.get_value("Colors", "fullbody", "#ffffff"))
	selected_shirt_color = Color(config.get_value("Colors", "shirt", "#ffffff"))
	selected_pants_color = Color(config.get_value("Colors", "pants", "#ffffff"))
	selected_shoes_color = Color(config.get_value("Colors", "shoes", "#ffffff"))
	selected_acc_color = Color(config.get_value("Colors", "accessory", "#ffffff"))

	print("📂 Loaded player name:", player_name)
	return true
