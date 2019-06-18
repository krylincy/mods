GLOBAL.ACTIONS.FF_GOODBYE = {
	id = "FF_GOODBYE",
    priority = 1,
    strfn = nil,
    testfn = nil,
    instant = false,
    rmb = true,
    distance = 3,
}

GLOBAL.ACTIONS.FF_GOODBYE.fn = function(act)
    print("stop following")
    act.target.components.follower.StopFollowing()
    return true
end
