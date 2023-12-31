extends Node2D

var coin_count: int = 0:
	set(val):
		coin_count = val
		$CoinCount/RichTextLabel.text = str(coin_count)

var glow: float:
	set(val):
		$Glow/UI_ProgressBarHorizontal.progress = val
	get:
		return $Glow/UI_ProgressBarHorizontal.progress

var health_count: int:
	set(val):
		$Health.health_count = val
	get:
		return $Health.health_count
