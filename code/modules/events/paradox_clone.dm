/datum/event/paradox_clone
	var/spawncount

/datum/event/paradox_clone/setup()
	spawncount = (round(TGS_CLIENT_COUNT / 25)) // 100 players for 4 paradox clones.

/datum/event/paradox_clone/proc/abort()
	var/datum/event_container/EC = SSevents.event_containers[EVENT_LEVEL_MODERATE]
	EC.next_event_time = world.time + (60 * 10)

/datum/event/paradox_clone/start()
	INVOKE_ASYNC(src, PROC_REF(wrapped_start))

/datum/event/paradox_clone/proc/wrapped_start()
	if(!spawncount) //if lower than 25 playas...
		abort()
		return

	var/count = spawncount
	var/wait_time = 20 SECONDS
	var/mob/living/carbon/human/chosen
	var/s_z = level_name_to_num(MAIN_STATION)
	var/list/possible_chosen = list()

	for(var/mob/living/carbon/human/H in world)
		if(H.z == s_z && H.mind && H.key && H.stat == CONSCIOUS && !locate(/area/station/public/sleep) in get_turf(H) && H.mind.assigned_role != null && !is_paradox_clone(H))
			possible_chosen += H

	if(!length(possible_chosen))
		message_admins("No suitable humans for Paradox Clone event!")
		abort()
		return

	while(count)
		count--
		chosen = pick_n_take(possible_chosen)

		var/list/candidates = SSghost_spawns.poll_candidates("Do you want to play as a paradox clone of [chosen.real_name], the [chosen.mind.assigned_role]?", ROLE_PARADOX_CLONE, TRUE, wait_time, source = chosen)

		var/list/possible_spawns = list()
		for(var/area/station/S in world)
			if(S.valid_territory)
				possible_spawns += S

		var/turf/T = pick(possible_spawns)

		var/mob/lucky_one = pick_n_take(candidates)
		var/mob/camera/paradox/P = new /mob/camera/paradox(T)
		addtimer(CALLBACK(P, TYPE_PROC_REF(/mob/camera/paradox, expire)), 40 SECONDS, TIMER_STOPPABLE)
		addtimer(CALLBACK(P, TYPE_PROC_REF(/mob/camera/paradox, warning)), 30 SECONDS, TIMER_STOPPABLE)
		P.orig = chosen
		P.key = lucky_one.key
		SEND_SOUND(P, sound('sound/ambience/antag/paradox_camera_alert.ogg'))
		do_sparks(rand(1,2), FALSE, P)
		sleep(wait_time + 0.2 SECONDS)
