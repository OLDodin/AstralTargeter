function getAstroDistanceToTarget(targetId)
	local shipID = unit.GetTransport( avatar.GetId() )
	if not shipID then return nil end
	if shipID == targetId then return "my" end
	local objPos = nil 
	if object.IsTransport(targetId) then
		objPos = transport.GetPosition(targetId)
	else
		objPos = object.GetPos(targetId)
	end
	if not objPos then return nil end
	local avPos = transport.GetPosition(shipID)
	local res = ((objPos.posX-avPos.posX)^2+(objPos.posY-avPos.posY)^2+(objPos.posZ-avPos.posZ)^2)^0.5
	res = math.ceil(res)
	local deltaZ = math.floor(objPos.posZ-avPos.posZ + 0.5)
	if deltaZ > -1 and deltaZ < 1 then
		deltaZ = 0
	end
	return res, deltaZ
end

function getAstroAngleToTarget(targetId)
	local shipID = unit.GetTransport( avatar.GetId() )
	if not shipID then return nil end
	if shipID == targetId then return nil end
	local objPos = nil 
	if isExist(targetId) then
		if object.IsTransport(targetId) then
			objPos = transport.GetPosition(targetId)
		else
			objPos = object.GetPos(targetId)
		end
	end
	if not objPos then return nil end
	local myPos = transport.GetPosition(shipID)
	return math.floor(math.atan2(objPos.posY-myPos.posY, objPos.posX-myPos.posX)*100+0.5)/100 - transport.GetDirection(shipID)
end

function getDistanceToTarget(targetId)
	local projectedInfo = object.GetProjectedInfo( targetId )	
	local res = projectedInfo and projectedInfo.playerDistance or nil
	
	if not projectedInfo then
		local objPos = object.GetPos(targetId)
		if not objPos then return nil end
		local avPos=avatar.GetPos()
		res = ((objPos.posX-avPos.posX)^2+(objPos.posY-avPos.posY)^2+(objPos.posZ-avPos.posZ)^2)^0.5
	end

	if res then 
		res = math.ceil(res)
	end
	return res
end

function getAngleToTarget(targetId)
	local t=isExist(targetId) and object.GetPos(targetId)
	if not t then return nil end
	local p=avatar.GetPos()
	return math.floor(math.atan2(t.posY-p.posY, t.posX-p.posX)*100+0.5)/100 - avatar.GetDir()
end

function isExist(targetId)
	if targetId then
		return object.IsExist(targetId)
	end
	return false
end