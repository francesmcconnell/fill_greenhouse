class_name MainMenu
extends Control


@onready var settings = $MarginContainer/HBoxContainer/VBoxContainer/Settings as Button
@onready var settings_menu = $SettingsMenu as SettingsMenu
@onready var margin_container = $MarginContainer as MarginContainer

func _ready():
	handle_connecting_signals()

func on_settings_pressed() -> void:
	margin_container.visible = false
	settings_menu.set_process(true)
	settings_menu.visible = true


func on_exit_settings_menu() -> void:
	margin_container.visible = true
	settings_menu.visible = (false)


func handle_connecting_signals() -> void:
	settings.button_down.connect(on_settings_pressed)
	settings_menu.exit_settings_menu.connect(on_exit_settings_menu)
