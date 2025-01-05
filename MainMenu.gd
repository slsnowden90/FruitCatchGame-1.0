extends Control

func _ready() -> void:
	# Optionally, set up any text or do initial animations here
	pass

func _on_QuitButton_pressed() -> void:
	get_tree().quit()

func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://Main.tscn")

func _on_options_button_pressed():
	get_tree().change_scene_to_file("res://SettingsMenu.tscn")
