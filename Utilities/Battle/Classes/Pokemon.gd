extends Object

class_name Pokemon # This is used for pokemon that is "active/saved". Not for recording base stats.

# The name of the pokemon. Can be used for nicknames.
var name

# Pokedex ID#
var ID

# The pokemon's type. If only one type use type1
var type1
var type2

var current_hp : int

# The pokemon's stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp : int
var attack : int
var defense : int
var sp_attack : int
var sp_defense : int
var speed : int

# The pokemon's level
var level : int

# The pokemon's total experience
var experience : int

# The pokemon's nature
var nature

# The pokemon's public and hidden abilities
var ability
var hidden_ability

# The pokemon's major ailment
var major_ailment

# The pokemon's Individual Values
var iv_hp : int
var iv_attack : int
var iv_defense : int
var iv_sp_attack : int
var iv_sp_defense : int
var iv_speed : int

# The pokemon's Effort Values
var ev_hp = 0
var ev_attack = 0
var ev_defense = 0
var ev_sp_attack = 0
var ev_sp_defense = 0
var ev_speed = 0

# The pokemon's held Item
var item

# The pokemon's Move set
var move_1 : Move
var move_2 : Move
var move_3 : Move
var move_4 : Move

# The pokemon's gender
var gender
enum {MALE, FEMALE, GENDERLESS}

# Is the pokemon a shiny
var is_shiny = false

# Weight in kg
var weight

func generate_IV():
	iv_hp = Global.rng.randi_range(0,31)
	iv_attack = Global.rng.randi_range(0,31)
	iv_defense = Global.rng.randi_range(0,31)
	iv_sp_attack = Global.rng.randi_range(0,31)
	iv_sp_defense = Global.rng.randi_range(0,31)
	iv_speed = Global.rng.randi_range(0,31)
	pass
func exp_erratic(_level : int) -> int:
	var xp : int = 0
	if _level <= 50:
		xp = int( pow(_level, 3) * (100 - _level) / 50)
	elif 50 < _level && _level <= 68:
		xp = int( pow(_level, 3) * (150 - _level) / 100 )
	elif 68 < _level && _level <= 98:
		xp = int( pow(_level, 3) * ( (1911 - 10 * _level) / 3) / 500)
	elif 98 < _level && _level <= 100:
		xp = int( pow(_level, 3) * (160 - _level) / 100)
	return xp
func exp_fast(_level : int) -> int:
	var xp : int = 0
	xp = int ( 4 * pow(_level, 3) / 5 )
	return xp
func exp_medium_fast(_level : int) -> int:
	var xp : int = 0
	xp = int( pow(_level, 3 ) )
	return xp
func exp_medium_slow(_level : int) -> int: # may need to use loop up table
	var xp : int = 0
	xp = int( (6/5) * pow(_level, 3) - (15 - pow(_level, 2)) + (100 * _level) - 140 )
	return xp
func exp_slow(_level : int) -> int:
	var xp : int = 0
	xp = int( 5 * pow(_level, 3) / 4 )
	return xp
func exp_fluctuating(_level : int) -> int:
	var xp : int = 0
	if _level <= 15:
		xp = int( pow(_level, 3) * ( (((_level + 1) / 3) + 24) / 50  ) )
	elif 15 < _level && _level <= 36:
		xp = int( pow(_level, 3) * ( (_level + 14) / 50))
	elif 36 < _level && _level <= 100:
		xp = int( pow(_level, 3) * ( ((_level / 2) + 32) / 50 ) )
	return xp
func generate_nature():
	nature = Global.rng.randi_range(0,24)
func generate_gender(male_ratio : float):
	if gender == GENDERLESS:
		return
	if Global.rng.randf_range(0.0, 100.0) <= male_ratio:
		gender = MALE
	else:
		gender = FEMALE

func update_stats() -> LevelUpChanges: # Needs to be called every time a stat changes!
	var changes = LevelUpChanges.new()
	changes.hp_change = hp
	changes.attack_change = attack
	changes.defense_change = defense
	changes.spAtk_change = sp_attack
	changes.spDef_change = sp_defense
	changes.speed_change = speed

	var data = registry.new().get_pokemon_class(ID)
	attack = int( int ((2 * data.attack + iv_attack + ev_attack) * level / 100 + 5 ) * Nature.get_stat_multiplier(nature, Nature.stat_types.ATTACK))
	defense = int( int ((2 * data.defense + iv_defense + ev_defense) * level / 100 + 5 ) * Nature.get_stat_multiplier(nature, Nature.stat_types.DEFENSE))
	sp_attack = int( int ((2 * data.sp_attack + iv_sp_attack + ev_sp_attack) * level / 100 + 5 ) * Nature.get_stat_multiplier(nature, Nature.stat_types.SP_ATTACK))
	sp_defense = int( int ((2 * data.sp_defense + iv_sp_defense + ev_sp_defense) * level / 100 + 5 ) * Nature.get_stat_multiplier(nature, Nature.stat_types.SP_DEFENSE))
	speed = int( int ((2 * data.speed + iv_speed + ev_speed) * level / 100 + 5 ) * Nature.get_stat_multiplier(nature, Nature.stat_types.SPEED))
	hp = int ( (2 * data.hp + iv_hp + ev_hp) * level / 100 + level + 10 )
	
	changes.hp_change = hp - changes.hp_change
	changes.attack_change = attack - changes.attack_change
	changes.defense_change = defense - changes.defense_change
	changes.spAtk_change = sp_attack - changes.spAtk_change
	changes.spDef_change = sp_defense - changes.spDef_change
	changes.speed_change = speed - changes.speed_change

	# Additional changes for evolution if applicable
	type1 = data.type1
	type2 = data.type2

	# Add hp
	current_hp += changes.hp_change
	return changes

#func set_basic_pokemon_by_level(id : int, lv : int): # Sets a level n version of the pokemon by its ID and sets. Its IV values will be generated here.
#	var data = registry.new().get_pokemon_class(id)
#	ID = id
#	name = data.name
#	type1 = data.type1
#	type2 = data.type2
#	level = lv
#	weight = data.weight
#	generate_IV()
#	generate_nature() # For now random but should be determined by something else
#	generate_gender(data.male_ratio)
#	major_ailment = null
#
#	# Set experience points
#	match data.leveling_rate:
#		data.SLOW:
#			experience = exp_slow(lv)
#		data.MEDIUM_SLOW:
#			experience = exp_medium_slow(lv)
#		data.MEDIUM_FAST:
#			experience = exp_medium_fast(lv)
#		data.FAST:
#			experience = exp_fast(lv)
#		data.ERRATIC:
#			experience = exp_erratic(lv)
#		data.FLUCTUATING:
#			experience = exp_fluctuating(lv)
#
#	# Set stats
#	update_stats()
#	current_hp = hp
#	# Set move set
#	var moveset = []
#	for move in data.moveset:
#		if move.level <= level:
#			moveset.push_back(move.move)
#	var count = moveset.size()
#	if count > 4:
#		count = 4
#	for i in range(count):
#		match i:
#			0: 
#				move_1 = MoveDataBase.get_move_by_name(moveset.pop_front())
#			1: 
#				move_2 = MoveDataBase.get_move_by_name(moveset.pop_front())
#			2: 
#				move_3 = MoveDataBase.get_move_by_name(moveset.pop_front())
#			3: 
#				move_4 = MoveDataBase.get_move_by_name(moveset.pop_front())

func get_cry() -> String:
	return "res://Audio/SE/" + str("%03d" % ID) + "Cry.wav"
#func get_battle_foe_sprite() -> Sprite2D:
#	var sprite = Sprite2D.new()
#	var tex : Texture2D
#	if is_shiny:
#		tex = load("res://Graphics/Battlers/" + str("%03d" % ID) + "s.png") as Texture2D
#	else:
#		tex = load("res://Graphics/Battlers/" + str("%03d" % ID) + ".png") as Texture2D
#
#	if tex == null:
#		# Try loading with .PNG instead of .png
#		if is_shiny:
#			tex = load("res://Graphics/Battlers/" + str("%03d" % ID) + "s.PNG") as Texture2D
#		else:
#			tex = load("res://Graphics/Battlers/" + str("%03d" % ID) + ".PNG") as Texture2D
#
#	sprite.texture = tex
#	if sprite.texture.get_width() != 80:
#		var frames = sprite.texture.get_width() / 80
#		sprite.hframes = frames
#		var tween = Tween.new()
#		tween.interpolate_property(sprite, "frame", 0, frames, 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
#		tween.repeat = true
#		tween.start()
#
#	sprite.name = "Sprite2D"
#	sprite.material = ShaderMaterial.new()
#	#var effect = load("res://Graphics/Pictures/StatUp.png")
#	#effect.set_flags(Texture2D.FLAG_REPEAT)
#	sprite.material.gdshader = load("res://Utilities/Battle/StatChange.gdshader")
#	#sprite.material.set_shader_parameter("effect", effect)
#	sprite.material.set_shader_parameter("effect_weight", 0.0)
#	return sprite
#func get_battle_player_sprite() -> Sprite2D:
#	var sprite = Sprite2D.new()
#	var tex : Texture2D
#	if is_shiny:
#		tex = load("res://Graphics/Battlers/" + str("%03d" % ID) + "bs.png") as Texture2D
#	else:
#		tex = load("res://Graphics/Battlers/" + str("%03d" % ID) + "b.png") as Texture2D
#	sprite.texture = tex
#	sprite.name = "Sprite2D"
#	sprite.material = ShaderMaterial.new()
#	#var effect = load("res://Graphics/Pictures/StatUp.png")
#	#effect.set_flags(Texture2D.FLAG_REPEAT)
#	sprite.material.gdshader = load("res://Utilities/Battle/StatChange.gdshader")
#	#sprite.material.set_shader_parameter("effect", effect)
#	sprite.material.set_shader_parameter("effect_weight", 0.0)
#	return sprite

#func get_exp_bar_percent() -> float:
#	var result : float = 0.0
#	var poke_class = registry.new().get_pokemon_class(ID)
#	var base : int
#	var top : int
#	match poke_class.leveling_rate:
#		poke_class.SLOW:
#			base = exp_slow(level)
#			top = exp_slow(level + 1)
#		poke_class.MEDIUM_SLOW:
#			base = exp_medium_slow(level)
#			top = exp_medium_slow(level + 1)
#		poke_class.MEDIUM_FAST:
#			base = exp_medium_fast(level)
#			top = exp_medium_fast(level + 1)
#		poke_class.FAST:
#			base = exp_fast(level)
#			top = exp_fast(level + 1)
#		poke_class.ERRATIC:
#			base = exp_erratic(level)
#			top = exp_erratic(level + 1)
#		poke_class.FLUCTUATING:
#			base = exp_fluctuating(level)
#			top = exp_fluctuating(level + 1)
#	var range_total = top - base
#	var in_range = experience - base
#	result = float(in_range) / float(range_total)
#
#	if result > 1.0 && result < 0.0:
#		print("Pokemon.gd ERROR: exp bar result percentage is out of range.")
#	return result

func add_ev(defeated_poke : Pokemon):
	var poke_class = registry.new().get_pokemon_class(defeated_poke.ID)
	if ev_hp < 255:
		ev_hp += poke_class.ev_yield_hp
	if ev_attack < 255:
		ev_attack += poke_class.ev_yield_attack
	if ev_defense < 255:
		ev_defense += poke_class.ev_yield_defense
	if ev_sp_attack < 255:
		ev_sp_attack += poke_class.ev_yield_sp_attack
	if ev_sp_defense < 255:
		ev_sp_defense += poke_class.ev_yield_sp_defense
	if ev_speed < 255:
		ev_sp_attack += poke_class.ev_yield_speed
	# Limit to 255:

	if ev_hp > 255:
		ev_hp = 255
	if ev_defense > 255:
		ev_defense = 255
	if ev_attack > 255:
		ev_attack = 255
	if ev_sp_attack > 255:
		ev_sp_attack = 255
	if ev_sp_defense > 255:
		ev_sp_defense = 255
	if ev_speed > 255:
		ev_speed = 255
	update_stats()
func get_exp_yield() -> int:
	return int (registry.new().get_pokemon_class(ID).exp_yield )
func get_icon_texture() -> Texture2D:
	var texture : Texture2D
	if is_shiny:
		texture = load("res://Graphics/Icons/icon" + str("%03d" % ID) + "s.png") as Texture2D
	else:
		texture = load("res://Graphics/Icons/icon" + str("%03d" % ID) + ".png") as Texture2D
	return texture
func heal(): # Restores HP and move PPs to max and removes all ailments.
	current_hp = hp
	major_ailment = null
	if move_1 != null:
		move_1.remaining_pp = move_1.total_pp
	if move_2 != null:
		move_2.remaining_pp = move_2.total_pp
	if move_3 != null:
		move_3.remaining_pp = move_3.total_pp
	if move_4 != null:
		move_4.remaining_pp = move_4.total_pp
#func get_level_up_times() -> int: # Returns how many levels the pokemon should level up too based checked current experience. Does not apply the levels!
#	var levelUpTimes = 0
#	var lv = level
#	var data = registry.new().get_pokemon_class(ID)
#
#	var leveled = false
#	while !leveled:
#		lv += 1
#		if experience >= get_exp_by_level(lv):
#			levelUpTimes += 1
#		else:
#			leveled = true
#	return levelUpTimes

#func get_exp_by_level(lv) -> int:
#	var data = registry.new().get_pokemon_class(ID)
#	var value = 0
#	match data.leveling_rate:
#			data.SLOW:
#				value = exp_slow(lv)
#			data.MEDIUM_SLOW:
#				value = exp_medium_slow(lv)
#			data.MEDIUM_FAST:
#				value = exp_medium_fast(lv)
#			data.FAST:
#				value = exp_fast(lv)
#			data.ERRATIC:
#				value = exp_erratic(lv)
#			data.FLUCTUATING:
#				value = exp_fluctuating(lv)
#	print("Exp for level," + str(lv) + "is : " + str(value))
#	return value

func get_moves():
	var moves = []
	if move_1 != null:
		moves.append(move_1)
	if move_2 != null:
		moves.append(move_2)
	if move_3 != null:
		moves.append(move_3)
	if move_4 != null:
		moves.append(move_4)
	return moves
								
