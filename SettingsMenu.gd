# SettingsMenu.gd
extends Control

func _ready():
	# Initialize the OptionButton with current settings
	var scheme = Settings.get_control_scheme()
	var option = 0
	match scheme:
		Settings.ControlScheme.AD_KEYS:
			option = 0
		Settings.ControlScheme.ARROW_KEYS:
			option = 1
		Settings.ControlScheme.MOUSE_FOLLOW:
			option = 2
	$VBoxContainer/ControlSchemeOption.select(option)
	print("Current Control Scheme: ", Settings.get_control_scheme())

# Connect the Apply and Cancel buttons


func _on_apply_button_pressed():
	var selected_option = $VBoxContainer/ControlSchemeOption.get_selected()
	var selected_scheme = Settings.ControlScheme.AD_KEYS  # Default
	match selected_option:
		0:
			selected_scheme = Settings.ControlScheme.AD_KEYS
		1:
			selected_scheme = Settings.ControlScheme.ARROW_KEYS
		2:
			selected_scheme = Settings.ControlScheme.MOUSE_FOLLOW
	Settings.set_control_scheme(selected_scheme)


func _on_cancel_button_pressed():
	get_tree().change_scene_to_file("res://MainMenu.tscn")
