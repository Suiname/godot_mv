extends Node

static var total_award_amount: int

signal on_award_received

func give_award(amount: int) -> void:
	total_award_amount += amount
	print("Total award amount: ", total_award_amount)

	on_award_received.emit(total_award_amount)