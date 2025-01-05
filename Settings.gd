# Settings.gd
extends Node

# Enum to define control schemes
enum ControlScheme {
	AD_KEYS,
	ARROW_KEYS,
	MOUSE_FOLLOW
}

# Default control scheme
var current_control_scheme: ControlScheme = ControlScheme.AD_KEYS

func _ready():
	load_settings()

# Function to set the control scheme
func set_control_scheme(scheme: ControlScheme):
	current_control_scheme = scheme
	save_settings()

# Function to get the current control scheme
func get_control_scheme() -> ControlScheme:
	return current_control_scheme

# Save settings to a ConfigFile
func save_settings():
	var config = ConfigFile.new()
	config.set_value("Controls", "control_scheme", current_control_scheme)
	var error = config.save("user://settings.cfg")
	if error != OK:
		print("Error saving settings: ", error)

# Load settings from a ConfigFile
func load_settings():
	var config = ConfigFile.new()
	var error = config.load("user://settings.cfg")
	if error == OK:
		current_control_scheme = config.get_value("Controls", "control_scheme", ControlScheme.AD_KEYS)
	else:
		print("No existing settings found, using defaults.")



