local Widget = require "widgets/widget"
local Image = require "widgets/image"
local Text = require "widgets/text"

local doydoypetWidget = Class(Widget, function(self, owner)
	Widget._ctor(self, "doydoypetWidget")
  
    self.owner = owner
    self.width = 100
    self.height = 100
    
    self:SetClickable(false)
    self:SetScale(1, 1, 1)
    
    self.bgimage = self:AddChild(Image())
    self.bgimage:SetTexture("images/doydoypetwidget.xml", "doydoypetwidget.tex")
    self.bgimage:ScaleToSize(self.width, self.height)
    self.bgimage:SetTint(1.0, 1.0, 1.0, 1.0)
    self.bgimage:SetBlendMode(1)
    
    self.label = self:AddChild(Text("stint-ucr", 30))
    self.label:SetPosition(3.0, -5.0, 0.0)
    self.label:SetHAlign(ANCHOR_MIDDLE)
end)

function doydoypetWidget:UpdateText()
    if GetWorld().components and GetWorld().components.doydoypet then
        local numberAll = GetWorld().components.doydoypet:GetNumber()
        local numberFemale = GetWorld().components.doydoypet:GetNumber("female")
        local femalePercent = 0
        
        if numberFemale > 0 then
            femalePercent = math.floor(100 * numberFemale / numberAll)
        end
        
        self.label:SetString(numberAll.." | "..numberFemale.."\n♀ "..femalePercent.."%")
    else
        print('GetWorld().components.doydoypet not found, show 0')
        self.label:SetString(0)
    end

end

return doydoypetWidget