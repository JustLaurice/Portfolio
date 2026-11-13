extends Panel

# Dictionary of panel containers
@onready var panels: Dictionary = {
	"Godot": $"../Projects/VBoxContainer/GodotContainer",
	"Unity": $"../Projects/VBoxContainer/UnityContainer",
	"Unreal": $"../Projects/VBoxContainer/UnrealContainer",
	"Web": $"../Projects/VBoxContainer/WebContainer"
}

# Dictionary of grid containers
@onready var grids: Dictionary = {
	"Godot": $"../Projects/VBoxContainer/GodotContainer/GridGodot",
	"Unity": $"../Projects/VBoxContainer/UnityContainer/GridUnity",
	"Unreal": $"../Projects/VBoxContainer/UnrealContainer/GridUnreal",
	"Web": $"../Projects/VBoxContainer/WebContainer/GridWeb"
}

# Reference to the Projects ScrollContainer and VBoxContainer
@onready var projects_scroll: ScrollContainer = $"../Projects"
@onready var vbox_container: VBoxContainer = $"../Projects/VBoxContainer"
@onready var click_effect: AudioStreamPlayer = $"../Click"
@onready var hover_effect: AudioStreamPlayer = $"../Hover"

# Signals to communicate with Inventory script
signal filter_changed(genre: String)
signal show_all_requested()

func _ready() -> void:
	for panel_name in panels.keys():
		if not panels[panel_name]:
			push_error("Panel not found: ", panel_name)
		if not grids[panel_name]:
			push_error("Grid not found: ", panel_name)

# Panel management
func show_all_panels() -> void:
	# Since we no longer hide them, this just ensures they are visible
	for panel in panels.values():
		if panel:
			panel.visible = true

func hide_empty_panels() -> void:
	# Hiding is disabled per your request. 
	# This function is kept empty so it doesn't break other scripts that might call it.
	pass

# New function to move a container to the top without hiding others
func move_to_top(panel_name: String) -> void:
	if panels.has(panel_name) and panels[panel_name]:
		var target_panel = panels[panel_name]
		vbox_container.move_child(target_panel, 0)

func toggle_panel(panel_name: String) -> void:
	# Changed from toggle visibility to move to top
	move_to_top(panel_name)

func get_grid(panel_name: String) -> GridContainer:
	return grids.get(panel_name, null)

func get_all_grids() -> Dictionary:
	return grids

func get_all_panels() -> Dictionary:
	return panels

# Genre button handlers
func _on_tower_defense_button_pressed() -> void:
	_on_genre_button_pressed("TowerDefense")

func _on_ai_behaviour_button_pressed() -> void:
	_on_genre_button_pressed("AIBehaviour")

func _on_vfx_button_pressed() -> void:
	_on_genre_button_pressed("VFX")

func _on_web_page_button_pressed() -> void:
	_on_genre_button_pressed("WebPage")

func _on_2d_fighting_button_pressed() -> void:
	_on_genre_button_pressed("2DFighting")

func _on_3d_puzzle_button_pressed() -> void:
	_on_genre_button_pressed("3DPuzzle")

func _on_3d_rpg_button_pressed() -> void:
	_on_genre_button_pressed("3DRPG")

func _on_life_sim_button_pressed() -> void:
	_on_genre_button_pressed("LifeSim")

func _on_adventure_pressed() -> void:
	_on_genre_button_pressed("Adventure")

func _on_genre_button_pressed(genre: String) -> void:
	click_effect.play()
	
	match genre:
		"WebPage":
			move_to_top("Godot")
		"WebPage":
			move_to_top("Web")
		"2DFighting", "LifeSim", "Adventure":
			move_to_top("Unity")
		"TowerDefense", "3DPuzzle", "3DRPG", "Adventure":
			move_to_top("Unreal")
	filter_changed.emit(genre)

func _on_store_button_pressed() -> void:
	click_effect.play()

func _on_show_all_button_pressed() -> void:
	click_effect.play()
	show_all_requested.emit()

# Panel toggle handlers (Now moving to top instead of hiding)
func _on_godot_toggle_pressed() -> void:
	click_effect.play()
	move_to_top("Godot")

func _on_unity_toggle_pressed() -> void:
	click_effect.play()
	move_to_top("Unity")

func _on_unreal_toggle_pressed() -> void:
	click_effect.play()
	move_to_top("Unreal")

func _on_web_toggle_pressed() -> void:
	click_effect.play()
	move_to_top("Web")

func _on_mouse_entered() -> void:
	hover_effect.play()
