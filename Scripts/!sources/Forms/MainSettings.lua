
function CreateMainBtn()
	setTemplateWidget("common")
		
	local button=createWidget(mainForm, "ATButton", "Button", WIDGET_ALIGN_LOW, WIDGET_ALIGN_LOW, 32, 32, 350, 120)
	setText(button, "AT")
	DnD.Init(button, button, true)
end