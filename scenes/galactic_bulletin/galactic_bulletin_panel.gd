extends PanelContainer

@onready var day_label = %DayLabel
@onready var main_article_title = %MainArticleTitle
@onready var main_article = %MainArticle
@onready var second_article = %SecondArticle
@onready var third_article = %ThirdArticle


func _ready() -> void:
	day_label.text = "Day " + str(DayManager.current_day.number)
	
	main_article_title.text = DayManager.current_day.main_title
	main_article.text = DayManager.current_day.main_article
	second_article.text = DayManager.current_day.second_article
	third_article.text = DayManager.current_day.third_article
