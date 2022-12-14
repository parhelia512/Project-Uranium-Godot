extends Object

# The name of the pokemon
var name = "Birbie"

# Pokedex ID#
var ID = 9

# The pokemon's type. If only one type use type1
var type1 = Type.NORMAL
var type2 = Type.FLYING

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 50
var attack = 36
var defense = 30
var sp_attack = 55
var sp_defense = 50
var speed = 43

# The pokemon's public and hidden abilities
var ability
var hidden_ability

# The pokemon's Effort Value Yeild
var ev_yield_hp = 0
var ev_yield_attack = 0
var ev_yield_defense = 0
var ev_yield_sp_attack = 1
var ev_yield_sp_defense = 0
var ev_yield_speed = 0

# The pokemon's base experience yield when defeated
var exp_yield : int = 53

# The pokemon's leveling rate
var leveling_rate = MEDIUM_SLOW
enum {SLOW, MEDIUM_SLOW, MEDIUM_FAST, FAST, ERRATIC, FLUCTUATING}

# The pokemon's gender ratio male percentage.
var male_ratio = 50

# The pokemon's evolution level
var evolution_level = 17

# The pokemon's evolution ID
var evolution_ID = 10

# The pokemon's catch rate
var catch_rate = 255

# Weight in kg
var weight = 1.6

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Gust"),
	MoveSet.new(1, "Flash"),
	MoveSet.new(4, "Growl"),
	MoveSet.new(8, "Quick Attack"),
	MoveSet.new(11, "Sing"),
	MoveSet.new(15, "Air Cutter"),
	MoveSet.new(18, "Roost"),
	MoveSet.new(20, "Feather Dance"),
	MoveSet.new(22, "Scary Face"),
	MoveSet.new(25, "Mirror Shot"),
	MoveSet.new(28, "Swift"),
	MoveSet.new(30, "Defog"),
	MoveSet.new(33, "Air Slash"),
	MoveSet.new(36, "Teeter Dance"),
	MoveSet.new(39, "Hyper Voice"),
	MoveSet.new(43, "Mirror Coat"),
	MoveSet.new(46, "Flash Cannon"),
	MoveSet.new(50, "Hurricane")
]
