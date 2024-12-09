local stats={}

local lvel,vel=vec(0,0,0),vec(0,0,0)
local laccel,accel=vec(0,0,0),vec(0,0,0)
local lbrot,brot=0,0
local lrot,rot=vec(0,0,0), vec(0,0,0)

function stats.tick()
	rot=player:getRot()lrot=rot
	brot=player:getBodyYaw()lbrot=brot
	vel=vectors.rotateAroundAxis(brot,player:getVelocity(),UP)
	accel=(vel - lvel)laccel=accel lvel=vel
end

function stats.frame(dt)
	local tvel=math.lerp(lvel, vel, dt)
	local trot=math.lerp(lrot, rot, dt)
	local tbrot=math.lerp(lbrot, brot, dt)
	local taccel=math.lerp(laccel, accel, dt)
	
	return {vel=tvel,rot=trot,brot=tbrot,accel=taccel}
end

return stats