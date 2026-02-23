extends Node2D

@export_subgroup("Nodes")
@export var LabelDamage: Label
@export var LabelCost: Label
@export var LabelHealth: Label

@export_subgroup("Settings")
@export var stats: CardStats

func _ready() -> void:
	if stats == null:
		stats = CardStats.new()
	_update_stats_local()

func update_stats(_stats: CardStats) -> void:
	stats = _stats
	LabelDamage.text = str(_stats.damage)
	LabelCost.text = str(_stats.cost)
	LabelHealth.text = str(_stats.health)

func _update_stats_local() -> void:
	update_stats(stats)
