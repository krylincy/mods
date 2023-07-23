local Widget = require "widgets/widget"

local Doydoypet = Class(function(self, inst)
	Widget._ctor(self, "DoydoypetWidget")

	self.numdoydoyspetsFemale = 0
	self.numdoydoyspetsMale = 0
end)

function Doydoypet:ChangeCounterFemale(value)
	print("ChangeCounterFemale ", value)
    self.numdoydoyspetsFemale = self.numdoydoyspetsFemale + value
	if self.numdoydoyspetsFemale < 0 then self.numdoydoyspetsFemale = 0 end
end

function Doydoypet:ChangeCounterMale(value)
	print("ChangeCounterMale ", value)
    self.numdoydoyspetsMale = self.numdoydoyspetsMale + value
	if self.numdoydoyspetsMale < 0 then self.numdoydoyspetsMale = 0 end
end

function Doydoypet:GetNumber(typ)
	if typ == "female" then
		return self.numdoydoyspetsFemale
	elseif typ == "male" then
		return self.numdoydoyspetsMale
	else
		return self.numdoydoyspetsFemale + self.numdoydoyspetsMale
	end	
end

function Doydoypet:OnSave()
	local data = {}
	data.numdoydoyspetsFemale = self.numdoydoyspetsFemale
	data.numdoydoyspetsMale = self.numdoydoyspetsMale
	return data
end

function Doydoypet:OnLoad(data)
	if data then
		self.numdoydoyspetsFemale = data.numdoydoyspetsFemale
		self.numdoydoyspetsMale = data.numdoydoyspetsMale
	end
end

return Doydoypet