local CAPY_DLC, IsDLCEnabled = GLOBAL.CAPY_DLC, GLOBAL.IsDLCEnabled
local DLC002 = IsDLCEnabled(CAPY_DLC)

local unpack, Vector3, GetPlayer, GetWorld = table.unpack or GLOBAL.unpack, GLOBAL.Vector3,GLOBAL.GetPlayer, GLOBAL.GetWorld

--local KEY_CTRL = GLOBAL.KEY_CTRL

--local SEARCH_RADIUS, SNAP, ALIGN, EPSILON = 20, 0.5, 0.1, 0.001
local SEARCH_RADIUS, SNAP, ALIGN, EPSILON = 10, 1, 0.1, 0.001

local function OnlyPrefab(prefab)
	return function(inst)
		return inst.prefab == prefab
	end
end

local function PrefabMatch(pattern)
	return function(inst)
		return inst.prefab:match(pattern) ~= nil
	end
end

local function PrefabStatus(prefab, status)
	return function(inst)
		local inspectable = inst.components.inspectable
		return inst.prefab == prefab and inspectable and inspectable:GetStatus() == status
	end
end

local SNAP_INFO = {
	-- Check function, placer, deployable/recipe
	--{OnlyPrefab('seeds'), 'seeds_placer', 'plant_normal'},
	{OnlyPrefab('plant_normal'), 'seeds_placer', 'seeds'},
	{OnlyPrefab('plant_normal'), 'carrot_seeds_placer', 'carrot_seeds'},
	{OnlyPrefab('plant_normal'), 'corn_seeds_placer', 'corn_seeds'},
	{OnlyPrefab('plant_normal'), 'radish_seeds_placer', 'radish_seeds'},
	{OnlyPrefab('plant_normal'), 'asparagus_seeds_placer', 'asparagus_seeds'},
	{OnlyPrefab('plant_normal'), 'aloe_seeds_placer', 'aloe_seeds'},
	{OnlyPrefab('plant_normal'), 'pumpkin_seeds_placer', 'pumpkin_seeds'},
	{OnlyPrefab('plant_normal'), 'eggplant_seeds_placer', 'eggplant_seeds'},
	{OnlyPrefab('plant_normal'), 'durian_seeds_placer', 'durian_seeds'},
	{OnlyPrefab('plant_normal'), 'pomegranate_seeds_placer', 'pomegranate_seeds'},
	{OnlyPrefab('plant_normal'), 'dragonfruit_seeds_placer', 'dragonfruit_seeds'},
	{OnlyPrefab('plant_normal'), 'watermelon_seeds_placer', 'watermelon_seeds'},
	{OnlyPrefab('plant_normal'), 'sweet_potato_seeds_placer', 'sweet_potato_seeds'},
	{OnlyPrefab('berrybush'), 'dug_berrybush_placer', 'dug_berrybush'},
	{OnlyPrefab('berrybush2'), 'dug_berrybush2_placer', 'dug_berrybush2'},
	{OnlyPrefab('sapling'), 'dug_sapling_placer', 'dug_sapling'},
	{OnlyPrefab('grass'), 'dug_grass_placer', 'dug_grass'},
	{OnlyPrefab('marsh_bush'), 'dug_marsh_bush_placer', 'dug_marsh_bush'},
	{OnlyPrefab('bambootree'), 'dug_bambootree_placer', 'dug_bambootree'},
	{OnlyPrefab('nettle'), 'dug_nettle_placer', 'dug_nettle'},
	{OnlyPrefab('bush_vine'), 'dug_bush_vine_placer', 'dug_bush_vine'},
	{OnlyPrefab('coffeebush'), 'dug_coffeebush_placer', 'dug_coffeebush'},
	
	{OnlyPrefab('reeds'), 'dug_reeds_placer', 'dug_reeds'},
	{OnlyPrefab('mushrooms'), 'dug_red_mushroom_placer', 'dug_red_mushroom'},
	{OnlyPrefab('mushrooms'), 'dug_green_mushroom_placer', 'dug_green_mushroom'},
	{OnlyPrefab('mushrooms'), 'dug_blue_mushroom_placer', 'dug_blue_mushroom'},
	{OnlyPrefab('red_mushroom'), 'dug_red_mushroom_placer', 'dug_red_mushroom'},
	{OnlyPrefab('green_mushroom'), 'dug_green_mushroom_placer', 'dug_green_mushroom'},
	{OnlyPrefab('blue_mushroom'), 'dug_blue_mushroom_placer', 'dug_blue_mushroom'},
	{OnlyPrefab('algae_bush'), 'dug_lichen_placer', 'dug_lichen'},
	{OnlyPrefab('flower_cave'), 'dug_flower_cave_single_placer', 'dug_flower_cave_single'},
	{OnlyPrefab('flower_cave_double'), 'dug_flower_cave_double_placer', 'dug_flower_cave_double'},
	{OnlyPrefab('flower_cave_triple'), 'dug_flower_cave_triple_placer', 'dug_flower_cave_triple'},
	{OnlyPrefab('cave_banana_tree'), 'dug_cave_banana_tree_placer', 'dug_cave_banana_tree'},
	{OnlyPrefab('cactus'), 'dug_cactus_placer', 'dug_cactus'},
	{OnlyPrefab('seed_grass'), 'dug_seed_grass_placer', 'dug_seed_grass'},

	{PrefabMatch('^.+_farmplot$'), 'farmplot_placer'},
	{OnlyPrefab('slow_farmplot'), 'slow_farmplot_placer', 'slow_farmplot'},
	{OnlyPrefab('fast_farmplot'), 'fast_farmplot_placer', 'fast_farmplot'},
	{OnlyPrefab('ashfarmplot'), 'ashfarmplot_placer', 'ashfarmplot'},
	{OnlyPrefab('birdcage'), 'birdcage_placer', 'birdcage'},
	{OnlyPrefab('beebox'), 'beebox_placer', 'beebox'},
	{OnlyPrefab('icebox'), 'icebox_placer', 'icebox'},
	{OnlyPrefab('lightning_rod'), 'lightning_rod_placer', 'lightning_rod'},
	{OnlyPrefab('pighouse'), 'pighouse_placer', 'pighouse'},
	{OnlyPrefab('rabbithouse'), 'rabbithouse_placer', 'rabbithouse'},
	{OnlyPrefab('cookpot'), 'cookpot_placer', 'cookpot'},
	{OnlyPrefab('treasurechest'), 'treasurechest_placer', 'treasurechest'},
	{OnlyPrefab('meatrack'), 'meatrack_placer', 'meatrack'},
	{OnlyPrefab('firesuppressor'), 'firesuppressor_placer', 'firesuppressor'},
	{OnlyPrefab('pottedfern'), 'pottedfern_placer', 'pottedfern'},
	{OnlyPrefab('dragonflychest'), 'dragonflychest_placer', 'dragonflychest'},
	{OnlyPrefab('wildborehouse'), 'wildborehouse_placer', 'wildborehouse'},
	{OnlyPrefab('primeapebarrel'), 'primeapebarrel_placer', 'primeapebarrel'},
	{OnlyPrefab('dragoonden'), 'dragoonden_placer', 'dragoonden'},

	{PrefabStatus('pinecone', 'PLANTED'), 'pinecone_placer', 'pinecone'},
	{PrefabStatus('acorn', 'PLANTED'), 'acorn_placer', 'acorn'},
	{PrefabStatus('coconut', 'PLANTED'), 'coconut_placer', 'coconut'},
	{PrefabStatus('teatree', 'PLANTED'), 'teatree_placer', 'teatree'},
	{PrefabStatus('teatree_nut', 'PLANTED'), 'teatree_nut_placer', 'teatree_nut'},
	{PrefabStatus('tubertree', 'PLANTED'), 'tubertree_placer', 'tubertree'},
	{PrefabStatus('clawpalmtree', 'PLANTED'), 'clawpalmtree_placer', 'clawpalmtree'},
	{PrefabStatus('rainforesttree', 'PLANTED'), 'rainforesttreee_placer', 'rainforesttree'},
	{PrefabStatus('jungletree', 'PLANTED'), 'jungletree_placer', 'jungletree'},
	{PrefabStatus('jungletreeseed', 'PLANTED'), 'jungletreeseed_placer', 'jungletreeseed'},
	{PrefabStatus('palmtree', 'PLANTED'), 'palmtree_placer', 'palmtree'},

	--{OnlyPrefab('flower'), 'butterfly_placer', 'butterfly'},
}

local function GenerateLookups(infos)
	local placers = {}
	local deployables_or_recipes = {}
	for _, v in ipairs(infos) do
		local checker, placer, deployable = unpack(v)
		placers[placer] = checker
		if deployable then deployables_or_recipes[deployable] = checker end
	end
	return placers, deployables_or_recipes
end


local PLACER_SNAPS, DEPLOYABLE_RECIPE_SNAPS = GenerateLookups(SNAP_INFO)

local function Align(v, step)
	return (v + step/2) - (v % step)
end

local function DistanceAxis(axis, a, b)
	return math.abs(a[axis] - b[axis])
end

local OtherAxis = {x = 'z', z = 'x'}

local function NearestAtAxis(axis, entities, base)
	local target, d = nil, math.huge
	local oaxis = OtherAxis[axis]
	for _, e in ipairs(entities) do
		if DistanceAxis(axis, e:GetPosition(), base) < SNAP then
			local newd = DistanceAxis(oaxis, e:GetPosition(), base)
			if not target or d > newd then
				target, d = e, newd
			end
		end
	end
	return target
end

local function SnapAxis(axis, entities, position)
	local t = NearestAtAxis(axis, entities, position)
	if not t then
		return nil, Align(position[axis], ALIGN)
	end
	return t, t:GetPosition()[axis]
end

local GREED, ZERO = {.25,.75,.25, 0}, {0,0,0,0}

local function SetAddColor(inst,color)

	if inst then
		inst.AnimState:SetAddColour(unpack({.74,.25,.25, 0}))
		--inst.AnimState:SetAddColour(unpack(color))
	end
end

local function UpdateColors(inst, xtarget, ztarget)

	if not inst.colored then
		inst.colored = {}
	end

	SetAddColor(inst.colored.x, ZERO)
	inst.colored.x = xtarget
	SetAddColor(inst.colored.x, GREED)

	SetAddColor(inst.colored.z, ZERO)
	inst.colored.z = ztarget
	SetAddColor(inst.colored.z, GREED)
end

local function RemoveColors(inst)

	if inst.colored then
		SetAddColor(inst.colored.x, ZERO)
		SetAddColor(inst.colored.z, ZERO)
		inst.colored = nil
	end
end

local function FindEntities(position, radius, fn)
	local entities = {}
	local x, y, z = position:Get()
	local nears = GLOBAL.TheSim:FindEntities(x, y, z, radius)
	for _, v in ipairs(nears) do
		if fn(v) then entities[#entities+1] = v end
	end
	return entities
end

local function DifferentSign(a, b)
	return (a < 0 and b > 0) or (a > 0 and b < 0)
end

local function EvenSpaceAxis(axis, entities, position, middle)
	local oaxis = OtherAxis[axis]
	local diff = position[axis] - middle[axis]
	if math.abs(diff) < EPSILON then
		return nil,  Align(position[axis], ALIGN)
	end

	local t, lastd = nil, math.huge
	for _, v in ipairs(entities) do
		local vpos = v:GetPosition()
		if math.abs(vpos[oaxis] - middle[oaxis]) < EPSILON then
			local d = vpos[axis] - middle[axis]
			local distdiff = math.abs(diff + d)
			if distdiff < lastd
			and DifferentSign(diff, d)
			and distdiff < SNAP then
				t, lastd = v, distdiff
			end
		end
	end
	if not t then
		return nil,  Align(position[axis], ALIGN)
	end
	return t, 2*middle[axis] - t:GetPosition()[axis]
end

local function Snap(position, can_snap)
	if not can_snap or not position then return false end
	local entities = FindEntities(position, SEARCH_RADIUS, can_snap)
	local xt, x  = SnapAxis('x', entities, position)
	local zt, z = SnapAxis('z', entities, position)

	if xt ~= nil and zt == nil then
		zt, z = EvenSpaceAxis('z', entities, position, xt:GetPosition())
	elseif xt == nil and zt ~= nil then
		xt, x = EvenSpaceAxis('x', entities, position, zt:GetPosition())
	end

	return true, Vector3(x, position.y, z), xt, zt
end

local function SnapWithColorFX(placer, position, can_snap)
	local ok, to, xt, zt = Snap(position, can_snap)
	UpdateColors(placer, xt, zt)
	return ok, to
end


-- Patched version of Placer:OnUpdate with respect of self.selected_pos
local function DLC001PlacerOnUpdate(self, _)
	local can_snap = PLACER_SNAPS[self.inst.prefab]
	if not GLOBAL.TheInput:ControllerAttached() then
		local pt = self.selected_pos or GLOBAL.TheInput:GetWorldPosition()
		local ok, to = SnapWithColorFX(self, pt, can_snap)
		if ok then
			pt = to
		elseif self.snap_to_tile and GetWorld().Map then
			pt = Vector3(GetWorld().Map:GetTileCenterPoint(pt:Get()))
		elseif self.snap_to_meters then
			pt = Vector3(math.floor(pt.x)+.5, 0, math.floor(pt.z)+.5)
		end
		self.inst.Transform:SetPosition(pt:Get())
	else
		local p = Vector3(GetPlayer().entity:LocalToWorldSpace(1,0,0))
		local ok, to = SnapWithColorFX(self, p, can_snap)
		if ok then
			self.inst.Transform:SetPosition(to:Get())
		elseif self.snap_to_tile and GetWorld().Map then
			--Using an offset in this causes a bug in the terraformer functionality while using a controller.
			local pt = Vector3(GetPlayer().entity:LocalToWorldSpace(0,0,0))
			pt = Vector3(GetWorld().Map:GetTileCenterPoint(pt:Get()))
			self.inst.Transform:SetPosition(pt:Get())
		elseif self.snap_to_meters then
			local pt = Vector3(GetPlayer().entity:LocalToWorldSpace(1,0,0))
			pt = Vector3(math.floor(pt.x)+.5, 0, math.floor(pt.z)+.5)
			self.inst.Transform:SetPosition(pt:Get())
		else
			if self.inst.parent == nil then
				GetPlayer():AddChild(self.inst)
				self.inst.Transform:SetPosition(1,0,0)
			end
		end
	end

	self.can_build = true
	if self.testfn then
		self.can_build = self.testfn(Vector3(self.inst.Transform:GetWorldPosition()))
	end

	--self.inst.AnimState:SetMultColour(0,0,0,.5)

	local color = self.can_build and Vector3(.25,.75,.25) or Vector3(.75,.25,.25)
	self.inst.AnimState:SetAddColour(color.x, color.y, color.z ,0)

end


local function DLC002PlacerOnUpdateOLD(self, _)
	local can_snap = PLACER_SNAPS[self.inst.prefab]
	if not GLOBAL.TheInput:ControllerAttached() then
		local pt = self.selected_pos or GLOBAL.TheInput:GetWorldPosition()
		local ok, to = SnapWithColorFX(self, pt, can_snap)
		if ok then
			pt = to
		elseif self.snap_to_tile and GetWorld().Map then
			pt = Vector3(GetWorld().Map:GetTileCenterPoint(pt:Get()))
		elseif self.snap_to_meters then
			pt = Vector3(math.floor(pt.x)+.5, 0, math.floor(pt.z)+.5)
		elseif self.snap_to_flood and GetWorld().Flooding then
			local center = Vector3(GetWorld().Flooding:GetTileCenterPoint(pt:Get()))
			pt.x = center.x
			pt.y = center.y
			pt.z = center.z
		end
		self.inst.Transform:SetPosition(pt:Get())
	else
		local offset = 1
		if self.recipe then
			if self.recipe.distance then
				offset = self.recipe.distance - 1
				offset = math.max(offset, 1)
			end
		elseif self.invobject then
			if self.invobject.components.deployable and self.invobject.components.deployable.deploydistance then
				offset = self.invobject.components.deployable.deploydistance
			end
		end

		local p = Vector3(GetPlayer().entity:LocalToWorldSpace(offset,0,0))
		local ok, to = SnapWithColorFX(self, p, can_snap)
		if ok then
			self.inst.Transform:SetPosition(to:Get())
		elseif self.snap_to_tile and GetWorld().Map then
			--Using an offset in this causes a bug in the terraformer functionality while using a controller.
			local pt = Vector3(GetPlayer().entity:LocalToWorldSpace(0,0,0))
			pt = Vector3(GetWorld().Map:GetTileCenterPoint(pt:Get()))
			self.inst.Transform:SetPosition(pt:Get())
		elseif self.snap_to_meters then
			local pt = Vector3(GetPlayer().entity:LocalToWorldSpace(offset,0,0))
			pt = Vector3(math.floor(pt.x)+.5, 0, math.floor(pt.z)+.5)
			self.inst.Transform:SetPosition(pt:Get())
		elseif self.snap_to_flood then
			local pt = Vector3(GetPlayer().entity:LocalToWorldSpace(offset,0,0))
			local center = Vector3(GetWorld().Flooding:GetTileCenterPoint(pt:Get()))
			pt.x = center.x
			pt.y = center.y
			pt.z = center.z
			self.inst.Transform:SetPosition(pt:Get())
		elseif self.onground then
				--V2C: this will keep ground orientation accurate and smooth,
				--     but unfortunately position will be choppy compared to parenting
					self.inst.Transform:SetPosition(GLOBAL.ThePlayer.entity:LocalToWorldSpace(1, 0, 0))
		else
			if self.inst.parent == nil then
				GetPlayer():AddChild(self.inst)
				self.inst.Transform:SetPosition(offset,0,0)
			end
		end
	end

	if self.fixedcameraoffset then
					local rot = GLOBAL.TheCamera:GetHeading()
				 self.inst.Transform:SetRotation(-rot+self.fixedcameraoffset) -- rotate against the camera
		end

	self.can_build = true
	if self.testfn then
		self.can_build = self.testfn(Vector3(self.inst.Transform:GetWorldPosition()))
	end

	--self.inst.AnimState:SetMultColour(0,0,0,.5)

	local pt = self.selected_pos or GLOBAL.TheInput:GetWorldPosition()
	local ground = GetWorld()
		local tile = GLOBAL.GROUND.GRASS
		if ground and ground.Map then
				tile = ground.Map:GetTileAtPoint(pt:Get())
		end

		local onground = not ground.Map:IsWater(tile)

	if (not self.can_build and self.hide_on_invalid) or (self.hide_on_ground and onground) then
		self.inst:Hide()
	else
		self.inst:Show()
		local color = self.can_build and Vector3(.25,.75,.25) or Vector3(.75,.25,.25)
		self.inst.AnimState:SetAddColour(color.x, color.y, color.z ,0)
	end

end

local function DLC003PlacerOnUpdate(self, _)
	local function findFloodGridNum(num)
		-- the flood grid is is the center of a 2x2 tile pattern. So 1,3,5,7..
		if math.mod(num, 2) == 0 then
			num = num +1
		end
		return num
	end

	local can_snap = PLACER_SNAPS[self.inst.prefab]
	if not GLOBAL.TheInput:ControllerAttached() then
		local pt = self.selected_pos or GLOBAL.TheInput:GetWorldPosition()
		local ok, to = SnapWithColorFX(self, pt, can_snap)
		if ok then
			pt = to
		elseif self.snap_to_tile and GetWorld().Map then
			pt = Vector3(GetWorld().Map:GetTileCenterPoint(pt:Get()))
		elseif self.snap_to_meters then
			pt = Vector3(math.floor(pt.x)+.5, 0, math.floor(pt.z)+.5)
		elseif self.snap_to_flood then
			pt.x = findFloodGridNum(math.floor(pt.x))
			pt.z = findFloodGridNum(math.floor(pt.z))	
		end
		self.inst.Transform:SetPosition(pt:Get())
	else
		local offset = self:getOffset()

		local p = Vector3(GetPlayer().entity:LocalToWorldSpace(offset,0,0))
		local ok, to = SnapWithColorFX(self, p, can_snap)
		
		if ok then
			self.inst.Transform:SetPosition(to:Get())
		elseif self.snap_to_tile and GetWorld().Map then
			--Using an offset in this causes a bug in the terraformer functionality while using a controller.
			local pt = Vector3(GetPlayer().entity:LocalToWorldSpace(0, 0, 0))
			pt = Vector3(GetWorld().Map:GetTileCenterPoint(pt:Get()))
			self.inst.Transform:SetPosition(pt:Get())
		elseif self.snap_to_meters then
			local pt = Vector3(GetPlayer().entity:LocalToWorldSpace(offset, 0, 0))
			pt = Vector3(math.floor(pt.x)+.5, 0, math.floor(pt.z)+.5)
			self.inst.Transform:SetPosition(pt:Get())
		elseif self.snap_to_flood then
			local pt = Vector3(GetPlayer().entity:LocalToWorldSpace(offset, 0, 0))
			pt.x = findFloodGridNum(math.floor(pt.x))	
			pt.z = findFloodGridNum(math.floor(pt.z))
			self.inst.Transform:SetPosition(pt:Get())
		elseif self.onground then
		 --V2C: this will keep ground orientation accurate and smooth,
        --     but unfortunately position will be choppy compared to parenting
        	self.inst.Transform:SetPosition(ThePlayer.entity:LocalToWorldSpace(1, 0, 0))
		else
			if self.inst.parent == nil then
				GetPlayer():AddChild(self.inst)
				self.inst.Transform:SetPosition(offset,0,0)
			end
		end
	end

	if self.fixedcameraoffset then
       	local rot = GLOBAL.TheCamera:GetHeading()
        self.inst.Transform:SetRotation(-rot+self.fixedcameraoffset) -- rotate against the camera
        for i, v in ipairs(self.linked) do
            v.Transform:SetRotation(rot)
        end         
    end
	
	self.can_build = true

	if self.placeTestFn then
		local inputPt = GLOBAL.Input:GetWorldPosition()

		if GLOBAL.TheInput:ControllerAttached() then
			local offset = self:getOffset()
			inputPt =  Vector3(GetPlayer().entity:LocalToWorldSpace(offset, 0, 0))
		end

		local pt = self.selected_pos or inputPt	
	
		self.can_build = self.placeTestFn(self.inst, pt)
		self.targetPos = self.inst:GetPosition()
	end
	
	
	if self.testfn and self.can_build then
		self.can_build = self.testfn(Vector3(self.inst.Transform:GetWorldPosition()))	
	end

	local pt = self.selected_pos or GLOBAL.Input:GetWorldPosition()
	local ground = GetWorld()
	local tile = GLOBAL.GROUND.GRASS
	if ground and ground.Map then
			tile = ground.Map:GetTileAtPoint(pt:Get())
	end

	local onground = not ground.Map:IsWater(tile)

	if (not self.can_build and self.hide_on_invalid) or (self.hide_on_ground and onground) or ( self.invobject and self.invobject.components.deployable.onlydeploybyplantkin and not GetPlayer():HasTag("plantkin") ) then
		self.inst:Hide()
	else
		self.inst:Show()
		local color = self.can_build and Vector3(.25, .75, .25) or Vector3(.75, .25, .25)		
		self.inst.AnimState:SetAddColour(color.x, color.y, color.z, 1)
	end
end


AddComponentPostInit("placer", function(placer)
	placer.OnUpdate = DLC003PlacerOnUpdate
	placer.inst:ListenForEvent("onremove", function()
		RemoveColors(placer)
	end)
end)

AddComponentPostInit("builder", function(builder)
	local CanBuildAtPoint = builder.CanBuildAtPoint

	function builder:CanBuildAtPoint(pt, recipe)
		local ok, to = Snap(pt, DEPLOYABLE_RECIPE_SNAPS[recipe.name])
		if ok then pt = to end
		return CanBuildAtPoint(self, pt, recipe)
	end

	local MakeRecipe = builder.MakeRecipe
	function builder:MakeRecipe(recipe, pt, ...)
		local ok, to = Snap(pt, DEPLOYABLE_RECIPE_SNAPS[recipe.name])
		if ok then pt = to end
		return MakeRecipe(self, recipe, pt, ...)
	end
end)

AddComponentPostInit("deployable", function(deployable)
	local CanDeploy, Deploy = deployable.CanDeploy, deployable.Deploy
	function deployable:CanDeploy(pt)
		local ok, to = Snap(pt, DEPLOYABLE_RECIPE_SNAPS[self.inst.prefab])
		if ok then pt = to end
		return CanDeploy(self, pt)
	end

	function deployable:Deploy(pt, deployer)
		local ok, to = Snap(pt, DEPLOYABLE_RECIPE_SNAPS[self.inst.prefab])
		if ok then pt = to end
		return Deploy(self, pt, deployer)
	end
end)
