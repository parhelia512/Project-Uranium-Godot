extends Object

# The name of the pokemon
var name = "Tricwe"

# Pokedex ID#
var ID = 63

# The pokemon's type. If only one type use type1
var type1 = Type.BUG
var type2

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 40
var attack = 65
var defense = 35
var sp_attack = 30
var sp_defense = 30
var speed = 65

# The pokemon's public and hidden abilities
var ability
var hidden_ability

# The pokemon's Effort Value Yeild
var ev_yield_hp = 0
var ev_yield_attack = 1
var ev_yield_defense = 0
var ev_yield_sp_attack = 0
var ev_yield_sp_defense = 0
var ev_yield_speed = 0

# The pokemon's base experience yield when defeated
var exp_yield : int = 53

# The pokemon's leveling rate
var leveling_rate = MEDIUM_FAST
enum {SLOW, MEDIUM_SLOW, MEDIUM_FAST, FAST, ERRATIC, FLUCTUATING}

# The pokemon's gender ratio male percentage.
var male_ratio = 87.5

# The pokemon's evolution level
var evolution_level = 22

# The pokemon's evolution ID
var evolution_ID = 64#,190

# The pokemon's catch rate
var catch_rate = 255

# Weight in kg
var weight = 2.5

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Poison Sting"),
	MoveSet.new(1, "String Shot"),
	MoveSet.new(6, "Leech Life"),
	MoveSet.new(11, "Thunder Shock"),
	MoveSet.new(17, "Thunder Wave"),
	MoveSet.new(22, "Wild Charge"),
	MoveSet.new(30, "Twineedle"),
	MoveSet.new(37, "Tail Glow"),
	MoveSet.new(45, "Discharge"),
	MoveSet.new(53, "Signal Beam")
]
