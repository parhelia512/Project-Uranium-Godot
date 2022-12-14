extends Node
@onready var NuclearPlantMusic = preload("res://Audio/BGM/PU-Nuclear Plant.ogg")
@onready var SpecialPokeMusic = preload("res://Audio/BGM/PU-Specialpoke.ogg")
@onready var AlarmMusic = preload("res://Audio/BGS/Emergency Civil Defense Alarm [Air Raid Siren].ogg")
@onready var EnteringDoor = preload("res://Audio/SE/Entering Door.wav")
@onready var ExitingDoor = preload("res://Audio/SE/Exit Door.WAV")
@onready var EarthQuakeSound = preload("res://Audio/SE/131-Earth03.ogg") 

@onready var EmotionSound = preload("res://Audio/SE/SE_EM.wav")
@onready var ExplosionSound = preload("res://Audio/SE/049-Explosion02.ogg") # Do not loop
@onready var EmotionIcon = preload("res://Graphics/Animations/029-Emotion01.png")

var lastAnimationPos = 0.0
var lastAnimation = null
var TrainerName = ""
var dialogue_pos

func _ready():
	$AnimationPlayer.play("Story")
	TrainerName = Global.TrainerName

	DialogueSystem.connect("dialogue_start",Callable(self,"pause"))
	DialogueSystem.connect("dialogue_end",Callable(self,"resume"))
	DialogueSystem.set_dialogue_sequence("CUTSCENE_INTRO_D")
	pass

func _exit_tree():
	DialogueSystem.disconnect("dialogue_start",Callable(self,"pause"))
	DialogueSystem.disconnect("dialogue_end",Callable(self,"resume"))

func dialogue_set_bottom():
	DialogueSystem.set_box_position(DialogueSystem.BOTTOM)
	pass

func dialogue_set_middle():
	DialogueSystem.set_box_position(DialogueSystem.MIDDLE)
	pass

func dialogue_set_top():
	DialogueSystem.set_box_position(DialogueSystem.TOP)
	pass

func dialogue(show_arrow = true, point_arrow = null):
	DialogueSystem.set_show_arrow(show_arrow)
	DialogueSystem.set_point_to(point_arrow)
	DialogueSystem.next_dialogue()
	pass

func dialogue_with_arrow(position, show_arrow = true):
	dialogue(show_arrow, position)
	pass

func dialogue_lucille(show_arrow = true):
	dialogue_with_arrow($Lucille.position, show_arrow)
	pass

func dialogue_cam(show_arrow = true):
	dialogue_with_arrow($Node3D.to_global($Node3D/Cam.position), show_arrow)
	pass

func dialogue_scientist(show_arrow = true):
	dialogue_with_arrow($Node3D.to_global($Node3D/Scientist2.position), show_arrow)
	pass

func final():
	change_scene_to_file("res://Game.tscn")
	pass

func earth_shake():
	$Camera2D/AnimationPlayer.play("Shake")
	$AudioStreamPlayer3.stream = EarthQuakeSound
	$AudioStreamPlayer3.play()
	pass

func shake_end():
	$Node3D/Scientist1/AlertEM.visible = true
	$Node3D/Scientist2/AlertEM.visible = true
	$Node3D/Scientist3/AlertEM.visible = true
	$Node3D/Cam/AlertEM2.visible = true
	$Lucille/AlertEM.visible = true
	$AudioStreamPlayer.stop()
	$AudioStreamPlayer.stream = SpecialPokeMusic
	$AudioStreamPlayer.play()
	$AudioStreamPlayer2.stop()
	$AudioStreamPlayer2.stream = AlarmMusic
	$AudioStreamPlayer2.play()
	$AudioStreamPlayer3.stop()
	$AudioStreamPlayer3.stream = EmotionSound
	$AudioStreamPlayer3.play()
	pass

func flash_red_alert():
	$RedAlert/AnimationPlayer.play("Flashing")
	pass

func end_EM():
	$Node3D/Scientist1/AlertEM.visible = false
	$Node3D/Scientist2/AlertEM.visible = false
	$Node3D/Scientist3/AlertEM.visible = false
	$Node3D/Cam/AlertEM2.visible = false
	$Lucille/AlertEM.visible = false
	pass

func scientist_move_1():
	$Node3D/Scientist1/AnimationPlayer.play("WalkRight")
	$Node3D/Scientist3/AnimationPlayer.play("WalkLeft")
	pass

func scientist_move_2():
	$Node3D/Scientist1/AnimationPlayer.play("WalkAhead")
	$Node3D/Scientist3/AnimationPlayer.play("WalkForward")
	pass

func scientist_move_3():
	$Node3D/Scientist1/AnimationPlayer.stop()
	$Node3D/Scientist1.frame = 12
	$Node3D/Scientist3/AnimationPlayer.stop()
	$Node3D/Scientist3.frame = 12
	pass

func scientist_move_4():
	$Node3D/Scientist1/AnimationPlayer.stop()
	$Node3D/Scientist2/AnimationPlayer.stop()
	$Node3D/Scientist3/AnimationPlayer.stop()
	$Node3D/Scientist1/AnimationPlayer.play("WalkRight")
	$Node3D/Scientist2/AnimationPlayer.play("WalkAhead")
	$Node3D/Scientist3/AnimationPlayer.play("WalkLeft")
	pass

func scientist_move_5():
	$Node3D/Scientist1/AnimationPlayer.stop()
	$Node3D/Scientist1/AnimationPlayer.play("WalkAhead")
	pass

func scientist_move_6():
	$Node3D/Scientist3/AnimationPlayer.stop()
	$Node3D/Scientist3/AnimationPlayer.play("WalkAhead")
	pass

func open_door_sound():
	$AudioStreamPlayer2.stream = EnteringDoor
	$AudioStreamPlayer2.play()
	pass

func exit_door_sound():
	$AudioStreamPlayer3.stop()
	$AudioStreamPlayer3.stream = ExitingDoor
	$AudioStreamPlayer3.play()
	pass

func stop_lucille_ani():
	$Lucille/AnimationPlayer.stop()
	pass

func lucille_walk_forward():
	$Lucille/AnimationPlayer.stop()
	$Lucille/AnimationPlayer.play('WalkForward')
	pass

func lucille_walk_right():
	$Lucille/AnimationPlayer.stop()
	$Lucille/AnimationPlayer.play("WalkRight")
	pass

func lucille_walk_left():
	$Lucille/AnimationPlayer.stop()
	$Lucille/AnimationPlayer.play("WalkLeft")
	pass

func cam_walk_left():
	$Node3D/Cam/AnimationPlayer.stop()
	$Node3D/Cam/AnimationPlayer.play("WalkLeft")
	pass

func cam_move_2():
	$Node3D/Cam/AnimationPlayer.stop()
	$Node3D/Cam/AnimationPlayer.play("WalkAhead")
	pass

func cam_move_3():
	$Node3D/Cam/AnimationPlayer.stop()
	$Node3D/Cam/AnimationPlayer.play("WalkLeft")
	pass

func cam_move_4():
	$Node3D/Cam/AnimationPlayer.stop()
	$Node3D/Cam/AnimationPlayer.play("WalkAhead")
	pass

func cam_move_5():
	$Node3D/Cam/AnimationPlayer.stop()
	$Node3D/Cam.frame = 12
	pass

func cam_move_6():
	$Node3D/Cam/AnimationPlayer.stop()
	$Node3D/Cam.frame = 0
	pass

func explosion():
	$RedAlert/AnimationPlayer.stop()
	$RedAlert/AnimationPlayer.play("Explosion")
	$AudioStreamPlayer.stop()
	$AudioStreamPlayer2.stop()
	$AudioStreamPlayer3.stop()
	
	ExplosionSound.loop = false
	$AudioStreamPlayer3.stream = ExplosionSound
	$AudioStreamPlayer3.play()
	pass

func pause():
	lastAnimationPos = $AnimationPlayer.current_animation_position
	lastAnimation = $AnimationPlayer.current_animation
	$AnimationPlayer.stop(false)
	#print("Paused")
	pass

func resume():
	$AnimationPlayer.play(lastAnimation)
	$AnimationPlayer.seek(lastAnimationPos)
	#print("Resumed")
	pass

func play_nuclear_plant_music():
	$AudioStreamPlayer.stream = NuclearPlantMusic
	$AudioStreamPlayer.play()
	pass

func change_scene_to_file(scene):
	if Global.isMobile:
		get_parent().newScene(scene)
	else:
		get_tree().change_scene_to_file(scene)
	pass
