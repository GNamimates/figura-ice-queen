
animations.player.run:play()

require"player"
local playerStats=require"lib.stats"
local Spring=require"lib.spring"

local sprYvel = Spring.new{f=2,z=0.2,r=0}
local sprBrot = Spring.new{f=2,z=0.2,r=0}

UP=vec(0,1,0)


local domeMesh=models.player.Base.Dome.Sphere:getVertices("textures.dome")
local domePos={}
local domeStrength={}
for i, v in ipairs(domeMesh) do
   local pos = v:getPos()
   domePos[i] = pos
   domeStrength[i] = (1 - pos.y / 19)
end


events.ENTITY_INIT:register(function ()
   sprBrot.pos = player:getBodyYaw()
end)


events.TICK:register(function () playerStats.tick() end)


local ltime=client:getSystemTime()
events.RENDER:register(function (dt, ctx)
	if ctx ~= "RENDER" then return end
	local time=client:getSystemTime()
	local df=(time - ltime) / 1000
	if df < (1/100) then return end -- limit to 60fps
	ltime=time
	
   local stats = playerStats.frame(dt)
   Spring.update(df)
	
   -- Skirt
   sprYvel.target = math.clamp(stats.vel.y,-0.4,0.5) * -4
   sprBrot.target = stats.brot
	
   for i, v in ipairs(domeMesh) do
      local pos,strength=domePos[i],domeStrength[i] * 6
		v:setPos(vectors.rotateAroundAxis((stats.brot-sprBrot.pos)*strength / 6, pos.x_z, UP) * (1+(sprYvel.pos * strength*0.05)) + pos._y_ + vec(0,sprYvel.pos * strength,0))
	end
   
	animations.player.run:setSpeed(stats.vel.z * 6)
end)