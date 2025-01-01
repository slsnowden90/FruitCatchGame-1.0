extends Control

var s = Global.final_score
var counters = Global.fruit_counters

func _ready() -> void:
	$FinalScoreLabel.text = "Score: %d" % Global.final_score
	$FruitStatsLabel.text = "Apples: %d\nRaspberries: %d" % [
		Global.fruit_counters["apple"],
		Global.fruit_counters["raspberry"]
	]

func _on_quit_button_pressed():
	pass # Replace with function body.


func _on_restart_button_pressed():
	get_tree().change_scene_to_file("res://Main.tscn")
