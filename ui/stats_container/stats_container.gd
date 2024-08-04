extends VBoxContainer

@onready var packages_counter_label: Label = %PackagesCounterLabel
@onready var strikes_counter_label: Label = %StrikesCounterLabel


func _ready() -> void:
	Globals.stats_changed.connect(_on_stats_changed)


func _on_stats_changed() -> void:
	packages_counter_label.text = str(Globals.packages_current_count) + "/" + str(Globals.packages_count)
	strikes_counter_label.text = str(Globals.strikes_current_count) + "/" + str(Globals.strikes_count)

