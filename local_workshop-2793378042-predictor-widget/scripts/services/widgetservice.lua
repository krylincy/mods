local Image = require "widgets/image"
local Text = require "widgets/text"
local WidgetService = {}

WidgetService.CreateWidget = function(self, owner, icon)
	self.owner = owner
	self.width = 100
	self.height = 100
	
	self:SetClickable(false)
	self:SetScale(1, 1, 1)
	
	self.bgimage = self:AddChild(Image())
	self.bgimage:SetTexture("images/"..icon.."widget.xml", icon.."widget.tex")
	self.bgimage:ScaleToSize(self.width, self.height)
	self.bgimage:SetTint(1.0, 1.0, 1.0, 1.0)
	self.bgimage:SetBlendMode(1)
	
	self.label = self:AddChild(Text("stint-ucr", 20))
	self.label:SetPosition(3.0, -5.0, 0.0)
	self.label:SetHAlign(ANCHOR_MIDDLE)
end

WidgetService.ChangeIcon = function(self, icon)
	self.bgimage:SetTexture("images/"..icon.."widget.xml", icon.."widget.tex")
end

WidgetService.ChangeLabel = function(self, label)
	self.label:SetString(label)
end

return WidgetService