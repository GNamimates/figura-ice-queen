local stats={}

local lvel,vel=vec(0,0,0),vec(0,0,0)
local laccel,accel=vec(0,0,0),vec(0,0,0)
local lbrot,brot=0,0
local lrot,rot=vec(0,0), vec(0,0)

function stats.tick()
	lrot=rot;rot=player:getRot()
   lbrot=brot;brot=player:getBodyYaw()
	lvel=vel vel=vectors.rotateAroundAxis(brot,player:getVelocity(),UP)
	laccel=accel accel=(vel - lvel)
end

function stats.frame(dt)
	local tvel=math.lerp(lvel or vel, vel, dt)
	local trot=math.lerp(lrot or rot, rot, dt)
	local tbrot=math.lerp(lbrot, brot, dt)
	local taccel=math.lerp(laccel or accel, accel, dt)
	
	return {vel=tvel,rot=trot,brot=tbrot,accel=taccel}
end

return stats