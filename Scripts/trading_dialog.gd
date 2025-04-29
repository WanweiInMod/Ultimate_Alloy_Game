extends CanvasLayer


# 初始化
func _ready():

	# TODO 条目初始生成

	# TODO 展示对话框
	
	pass 


# TODO 对应页面解锁判断，连接阶段升级信号
func levelup_unlock():

	pass


# TODO GUI条目与字典条目绑定
func catalogue_binding():

	pass


# TODO 扣除资源执行，需要接信号
func resource_recoverer():

	pass


# TODO 增加对应资源执行，需连接信号
func resource_giver():

	pass


# TODO 按钮关闭窗口
func _on_exit_button_pressed():
	self.queue_free()
	pass

# 流程：处理初始生成 - 展示 - 各个条目的修改功能 - 关闭窗口




