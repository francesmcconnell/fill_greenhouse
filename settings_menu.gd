class_name SettingsMenu
extends Control

@onready var exit_settings_window = $MarginContainer/VBoxContainer/ExitSettingsWindow as Button

signal exit_settings_menu


func _ready():
	exit_settings_window.button_down.connect(on_exit_settings_window_pressed)
	set_process(false)
	
	
func on_exit_settings_window_pressed() -> void:
	exit_settings_menu.emit()
	set_process(false)
