
-- A weighted average list of prizes, the bigger the number, the more likely it is.
-- It's based off altar_prototyper.lua
local LOOT = {
    -- Best Loot List.
    GOOD = {
        slot_goldy = 1,
        slot_10dubloons = 1,
        slot_honeypot = 1,
        slot_warrior1 = 1,
        slot_warrior2 = 1,
        slot_warrior3 = 1,
        slot_warrior4 = 1,
        slot_scientist = 1,
        slot_walker = 1,
        slot_gemmy = 1,
        slot_bestgem = 1,
        slot_lifegiver = 1,
        slot_chilledamulet = 1,
        slot_icestaff = 1,
        slot_firestaff = 1,
        slot_coolasice = 1,
        slot_gunpowder = 1,
        slot_firedart = 1,
        slot_sleepdart = 1,
        slot_blowdart = 1,
        slot_speargun = 1,
        slot_coconades = 1,
        slot_obsidian = 1,
        slot_thuleciteclub = 1,
        slot_ultimatewarrior = 1,
        slot_goldenaxe = 1,
        staydry = 1,
        cooloff = 1,
        birders = 1,
        gears =1,
        slot_seafoodsurprise = 1,
        slot_fisherman = 1,
        slot_camper = 1,
        slot_spiderboon = 1,
        slot_dapper = 1,
        slot_speed = 1,
        slot_tailor = 5,
    },
    
    -- OK Loot - Food and Resrouces 
    OK = {
        slot_anotherspin = 5,
        firestarter = 5,
        geologist = 5,
        cutgrassbunch = 5,
        logbunch = 5,
        twigsbunch = 5,
        slot_torched = 5,
        slot_jelly = 5,
        slot_handyman = 5,
        slot_poop = 5,
        slot_berry = 5,
        slot_limpets = 5,
        slot_bushy = 5,
        slot_bamboozled = 5,
        slot_grassy = 5,
        slot_prettyflowers = 5,
        slot_witchcraft = 5,
        slot_bugexpert = 5,
        slot_flinty = 5,
        slot_fibre = 5,
        slot_drumstick = 5,
        slot_ropey = 5,
        slot_jerky = 5,
        slot_coconutty = 5,
        slot_bonesharded = 5,
    },
    
    -- Bad Prizes List.
    BAD = {
        slot_monkeysurprise = 1,
    },
}

-- weighted_random_choice for bad, ok, good prize lists.
local PRIZE_VALUES = {
    bad = 1,
    ok = 8,
    good = 5,
}

local PRIZE_VALUES_NONDUBLOON = {
    bad = 1,
    ok = 8,
    good = 5,
}

-- Actions to perform for the spawns.
local ACTIONS = {
    -- Prizes based of TreasureLoot table in map/treasurehunt.lua
    -- treasure = <the name in the TreasureLoot table>
    -- overrides all other things

    firestarter = { treasure = "firestarter", },
    geologist = { treasure = "geologist", },
    cutgrassbunch = { treasure = "3cutgrass", },
    logbunch = { treasure = "3logs", },
    twigsbunch = { treasure = "3twigs", },
    slot_torched = { treasure = "slot_torched", },
    slot_jelly = { treasure = "slot_jelly", },
    slot_handyman = { treasure = "slot_handyman", },
    slot_poop = { treasure = "slot_poop", },
    slot_berry = { treasure = "slot_berry", },
    slot_limpets = { treasure = "slot_limpets", },
    slot_seafoodsurprise = { treasure = "slot_seafoodsurprise", },
    slot_bushy = { treasure = "slot_bushy", },
    slot_bamboozled = { treasure = "slot_bamboozled", },
    slot_grassy = { treasure = "slot_grassy", },
    slot_prettyflowers = { treasure = "slot_prettyflowers", },
    slot_witchcraft = { treasure = "slot_witchcraft", },
    slot_bugexpert = { treasure = "slot_bugexpert", },
    slot_flinty = { treasure = "slot_flinty", },
    slot_fibre = { treasure = "slot_fibre", },
    slot_drumstick = { treasure = "slot_drumstick", },
    slot_fisherman = { treasure = "slot_fisherman", },
    slot_dapper = { treasure = "slot_dapper", },
    slot_speed = { treasure = "slot_speed", },

    slot_anotherspin = { treasure = "slot_anotherspin", },
    slot_goldy = { treasure = "slot_goldy", },
    slot_honeypot = { treasure = "slot_honeypot", },
    slot_warrior1 = { treasure = "slot_warrior1", },
    slot_warrior2 = { treasure = "slot_warrior2", },
    slot_warrior3 = { treasure = "slot_warrior3", },
    slot_warrior4 = { treasure = "slot_warrior4", },
    slot_scientist = { treasure = "slot_scientist", },
    slot_walker = { treasure = "slot_walker", },
    slot_gemmy = { treasure = "slot_gemmy", },
    slot_bestgem = { treasure = "slot_bestgem", },
    slot_lifegiver = { treasure = "slot_lifegiver", },
    slot_chilledamulet = { treasure = "slot_chilledamulet", },
    slot_icestaff = { treasure = "slot_icestaff", },
    slot_firestaff = { treasure = "slot_firestaff", },
    slot_coolasice = { treasure = "slot_coolasice", },
    slot_gunpowder = { treasure = "slot_gunpowder", },
    slot_firedart = { treasure = "slot_firedart", },
    slot_sleepdart = { treasure = "slot_sleepdart", },
    slot_blowdart = { treasure = "slot_blowdart", },
    slot_speargun = { treasure = "slot_speargun", },
    slot_coconades = { treasure = "slot_coconades", },
    slot_obsidian = { treasure = "slot_obsidian", },
    slot_thuleciteclub = { treasure = "slot_thuleciteclub", },
    slot_ultimatewarrior = { treasure = "slot_ultimatewarrior", },
    slot_goldenaxe = { treasure = "slot_goldenaxe", },
    staydry = { treasure = "staydry", },
    cooloff = { treasure = "cooloff", },
    birders = { treasure = "birders", },
    slot_monkeyball = { treasure = "slot_monkeyball", },

    slot_bonesharded = { treasure = "slot_bonesharded", },
    slot_jerky = { treasure = "slot_jerky", },
    slot_coconutty = { treasure = "slot_coconutty", },
    slot_camper = { treasure = "slot_camper", },
    slot_ropey = { treasure = "slot_ropey", },
    slot_tailor = { treasure = "slot_tailor", },
    slot_spiderboon = { treasure = "slot_spiderboon", },
    slot_3dubloons = { treasure = "3dubloons", },
    slot_10dubloons = { treasure = "10dubloons", },
    
    slot_spiderattack = { treasure = "slot_spiderattack", },
    slot_mosquitoattack = { treasure = "slot_mosquitoattack", },
    slot_snakeattack = { treasure = "slot_snakeattack", },
    slot_monkeysurprise = { treasure = "slot_monkeysurprise", },
    slot_poisonsnakes = { treasure = "slot_poisonsnakes", },
    slot_hounds = { treasure = "slot_hounds", },
}

return {
    LOOT          = LOOT,
    PRIZE_VALUES  = PRIZE_VALUES,
    PRIZE_VALUES_NONDUBLOON = PRIZE_VALUES_NONDUBLOON,
    ACTIONS       = ACTIONS,
}