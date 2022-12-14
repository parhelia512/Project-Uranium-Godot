extends Node2D

#Checks if the OS is android or ios, and if it is it makes the window unable to be resized and keeps the aspec ratio
func _ready() -> void:
	var force_touchscreen_controls = false
	var custom_window_size = null

	var args = OS.get_cmdline_args()
	var index = 0
	for argument in args:
		if argument.find("-force_touchscreen_controls") > -1:
			force_touchscreen_controls = true
			continue

		# Set game window size
		if argument.find("-set_window_size") > -1: # Will only work checked Desktop OSes
			var size_str = args[index+1]
			var height = 512
			var width = 384
			var x_pos = size_str.find("x")
			var width_str = size_str.substr(0, x_pos)
			var height_str = size_str.substr(x_pos)
			custom_window_size = Vector2(int(width_str), int(height_str))
			continue
		index += 1


	if OS.get_name() == "Android" || OS.get_name() == "iOS" || force_touchscreen_controls:
		Global.isMobile = true
		OS.window_resizable = false
		get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_VIEWPORT, SceneTree.STRETCH_ASPECT_KEEP_HEIGHT, DisplayServer.window_get_size())
		
		#Sets up the mobile controls
		get_tree().change_scene_to_file("res://Utilities/MobileControls.tscn")
	
	#If the above is false sets the window to be resizeable, and loads the intro scene
	else:
		Global.isMobile = false
		DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_RESIZE_DISABLED, false)
		get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_VIEWPORT, SceneTree.STRETCH_ASPECT_KEEP, Vector2(512, 384))
		if custom_window_size != null:
			print("setting custom window size: " + str(custom_window_size))
			OS.window_size = custom_window_size
		get_tree().change_scene_to_file("res://IntroScenes/Intro.tscn")
