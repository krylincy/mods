local TimeService = {}

TimeService.TimeToString = function(time)
	time = math.floor(time)
	local minutes = math.floor(time / 60)
	local seconds = time - (minutes * 60)
	
	if minutes == 0 then
		time = seconds.."s"
	else
		if seconds <= 9 then
			seconds = "0"..seconds
		end
		time = minutes.."m "..seconds
	end

    return time
end

return TimeService