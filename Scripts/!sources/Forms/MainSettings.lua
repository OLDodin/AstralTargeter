local m_template = nil



function CreateMainBtn()
	m_template = getChild(mainForm, "Template")
	setTemplateWidget(m_template)
		
	local button=createWidget(mainForm, "ATButton", "Button", WIDGET_ALIGN_LOW, WIDGET_ALIGN_LOW, 30, 25, 350, 120)
	setText(button, "AT")
	DnD.Init(button, button, true)
end