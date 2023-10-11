/datum/team/revolution
	name = "Revolution"
	antag_datum_type = /datum/antagonist/rev
	var/max_headrevs = REVOLUTION_MAX_HEADREVS // adminbus is possible

/datum/team/revolution/New()
	..()
	update_team_objectives()
	SSshuttle.registerHostileEnvironment(src)

/datum/team/revolution/Destroy(force, ...)
	SSticker.mode.rev_team = null
	SSshuttle.clearHostileEnvironment(src)
	return ..()


/datum/team/revolution/get_target_excludes()
	return ..() + get_targetted_head_minds()


/datum/team/revolution/remove_member(datum/mind/member)
	. = ..()
	var/datum/antagonist/rev/revolting = member.has_antag_datum(/datum/antagonist/rev) // maybe this should be get_antag_datum_from_member(member)
	if(!QDELETED(revolting))
		member.remove_antag_datum(/datum/antagonist/rev)

/datum/team/revolution/admin_add_objective(mob/user)
	sanitize_objectives()
	. = ..()
	if(sanitize_objectives())
		message_admins("[key_name_admin(user)] added a mutiny objective to the team '[name]', and no target was found, removing.")
		log_admin("[key_name_admin(user)] added a mutiny objective to the team '[name]', and no target was found, removing.")

/datum/team/revolution/on_round_end()
	return // for now... show nothing. Add this in when revs is added to midround/dynamic. Not showing it currently because its dependent on rev gamemode

/datum/team/revolution/proc/update_team_objectives()
	var/list/heads = SSticker.mode.get_all_heads() - get_targetted_head_minds()

	for(var/datum/mind/head_mind in heads)
		var/datum/objective/mutiny/rev_obj = new
		rev_obj.target = head_mind
		rev_obj.explanation_text = "Assassinate or exile [head_mind.name], the [head_mind.assigned_role]."
		add_team_objective(rev_obj)
	sanitize_objectives()

/datum/team/revolution/proc/get_targetted_head_minds()
	. = list()
	for(var/datum/objective/mutiny/O in objective_holder.get_objectives())
		. |= O.target

/datum/team/revolution/proc/sanitize_objectives()
	for(var/datum/objective/mutiny/O in objective_holder.get_objectives())
		if(!O.target) // revs shouldnt have free objectives
			remove_team_objective(O)
			. = TRUE

/datum/team/revolution/proc/check_all_victory()
	update_team_objectives()
	check_rev_victory()
	check_heads_victory()

/datum/team/revolution/proc/check_rev_victory()
	for(var/datum/objective/mutiny/objective in objective_holder.get_objectives())
		if(!(objective.check_completion()))
			return FALSE

	SSshuttle.clearHostileEnvironment(src) // revs can take the shuttle too if they want

	log_admin("Revolutionary win conditions met. All command, security, and legal jobs are now closed.")
	message_admins("The revolutionaries have won! All command, security, and legal jobs have been closed. You can change this with the \"Free Job Slot\" verb.")
	// HOP can still technically alter some roles, but Nanotrasen wouldn't send heads/sec under threat to the station after revs win
	var/banned_departments = DEP_FLAG_COMMAND | DEP_FLAG_SECURITY | DEP_FLAG_LEGAL
	for(var/datum/job/job in SSjobs.occupations)
		if(!(job.job_department_flags & banned_departments))
			continue
		job.total_positions = 0
		job.job_banned_gamemode = TRUE
	return TRUE

/datum/team/revolution/proc/check_heads_victory()
	for(var/datum/mind/rev_mind in SSticker.mode.head_revolutionaries)
		if(!ishuman(rev_mind?.current))
			continue
		if(rev_mind.current.stat == DEAD)
			continue
		var/turf/T = get_turf(rev_mind.current)
		if(!T || !is_station_level(T.z))
			continue
		return FALSE // there is still a headrev left alive!

	SSshuttle.clearHostileEnvironment(src)
	return TRUE

/**	Calculate how many headrevs are needed, given a certain amount of sec/heads.
 * 		How many Headrevs given security + command (excluding the clamp)
 * 									Security
 *		  		0	1	2	3	4	5	6	7	8	9	10	11	12	13	14	15	16
 *		 		------------------------------------------------------------------
 *			0 | -3	-2	-2	-2	-1	-1	-1	0	0	0	1	1	1	2	2	2	3
 *			1 | -2	-1	-1	-1	0	0	0	1	1	1	2	2	2	3	3	3	4
 *			2 | -1	0	0	0	1	1	1	2	2	2	3	3	3	4	4	4	5
 * Command	3 | 0	1	1	1	2	2	2	3	3	3	4	4	4	5	5	5	6
 *			4 | 1	2	2	2	3	3	3	4	4	4	5	5	5	6	6	6	7
 *			5 | 2	3	3	3	4	4	4	5	5	5	6	6	6	7	7	7	8
 *			6 | 3	4	4	4	5	5	5	6	6	6	7	7	7	8	8	8	9
 *			7 | 4	5	5	5	6	6	6	7	7	7	8	8	8	9	9	9	10
 */

/datum/team/revolution/proc/need_another_headrev(clamp_at = 0) // yes, zero. Not false.
	var/head_revolutionaries = length(SSticker.mode.head_revolutionaries)
	var/heads = length(SSticker.mode.get_all_heads())
	var/sec = length(SSticker.mode.get_all_sec())
	if(head_revolutionaries >= max_headrevs)
		return FALSE
	var/sec_diminish = (8 - sec) / 3 // 2 seccies = 2, 5 seccies = 1, 8 seccies = 0

	var/potential = round(heads - sec_diminish) // more sec, increases. more heads, increases
	var/how_many_more_headrevs = clamp(potential, clamp_at, max_headrevs - head_revolutionaries)

	return how_many_more_headrevs

/datum/team/revolution/proc/process_promotion(promotion_type = REVOLUTION_PROMOTION_OPTIONAL)
	if(!need_another_headrev(0) || promotion_type != REVOLUTION_PROMOTION_AT_LEAST_ONE || length(SSticker.mode.head_revolutionaries) > 1)
		// We check the graph to see if we need a headrev
		// If this is called from when a headrev is cryoing and, we must promote or the revolution will die
		// This is called before they are officially removed from SSticker.mode.head_revolutionaries, so we want to make sure we get a new head before things go bad.
		return
	var/list/datum/mind/non_heads = members - SSticker.mode.head_revolutionaries
	if(!length(non_heads))
		return
	for(var/datum/mind/khrushchev in shuffle_inplace(non_heads))
		if(!is_viable_head(khrushchev))
			continue
		// shuffled so its random, we can just pick here and now
		var/datum/antagonist/rev/rev = khrushchev.has_antag_datum(/datum/antagonist/rev)
		rev.promote()
		return // return is needed to break the loop, otherwise we'd get a helluva lot of headrevs

/datum/team/revolution/proc/is_viable_head(datum/mind/rev_mind)
	if(!rev_mind.current || !rev_mind.current.client)
		return FALSE
	if(!ishuman(rev_mind.current))
		return FALSE
	if(rev_mind.current.incapacitated() || HAS_TRAIT(rev_mind.current, TRAIT_HANDS_BLOCKED)) // todo for someone else, make sure the rev heads on ON STATION
		return FALSE
	return TRUE

//////////////////////////////////////////////////////////////////////////////
//Deals with announcing headrevs converting a certain percentage of crew.
//////////////////////////////////////////////////////////////////////////////

/datum/team/revolution/proc/rev_threshold_check()
	var/list/living_players = get_living_players(exclude_nonhuman = TRUE, exclude_offstation = TRUE)
	var/players = length(living_players)
	var/revolutionaries = get_revolutionaries() // Don't count the Head Revolutionaries, todo.
	if(players >= REV_POPULATION_THRESHOLD)
		// Highpop
		reaction_percent = REV_REACTION_HIGH
		spark_number = round(REV_SPARK_HIGH * (players - revolutionaries))
		reacton_number = round(REV_REACTION_HIGH * (players - revolutionaries))
	else
		// Lowpop
		reaction_percent = REV_REACTION_LOW
		spark_number = round(REV_SPARK_LOW * (players - revolutionaries))
		reaction_number = round(REV_REACTION_LOW * (players - revolutionaries))

/datum/team/revolution/proc/get_revs(separate = FALSE)
	var/revolutionaries = 0
	for(var/I in revolutionaries)
		var/datum/mind/M = I
		if(ishuman(M.current) && !M.current.has_status_effect(STATUS_EFFECT_SUMMONEDGHOST))
			revolutionaries++
	if(separate)
		return list(revolutionaries)
	else
		return revolutionaries

/datum/team/revolution/proc/check_revolution_size()
	var/rev_players = get_revs()

	if(rev_reacton)
		if(rev_players < reaction_number / 2)
		return

	if((rev_players >= reaction_number) && !rev_spark)
		rev_spark()
		return

	if( >= reaction_number)
		rev_reaction()

/datum/team/revolution/proc/rev()
	rev_reaction = TRUE
	for(var/datum/mind/M in revolutionaries)
		if(!ishuman(M.current))
			continue
		SEND_SOUND(M.current, sound('sound/hallucinations/i_see_you2.ogg'))
		to_chat(M.current, "<span class='.revendanger'The spark of revolution has been lit onboard the [station_name()]. Reactionary forces may soon become aware.</span>")
		addtimer(CALLBACK(src, PROC_REF(rise), M.current), 20 SECONDS)


/datum/team/revolution/proc/rev_reaction()
	rev_reaction = TRUE
	for(var/datum/mind/M in revolutionaries)
		if(!ishuman(M.current))
			continue
		SEND_SOUND(M.current, sound('sound/effects/revascendalert.ogg'))
		to_chat(M.current, "<span class='.revendanger'>The time has come, workers of the station unite! You have nothing to lose but your chains!</span>")
		addtimer(CALLBACK(src, PROC_REF(ascend), M.current), 20 SECONDS)
	GLOB.major_announcement.Announce(GLOB.major_announcement.Announce("We've recently detected signs of unrest and potential revolution onboard the [station_name()]. This message is a call to action for all employees. It's time to choose Nanotrasen - all employees onboard the [station_name()] are to be mindshielded at once. Failure to comply with this directive is not an option. Non-compliance may result violation of the terms of your contract.", "Central Command Human Resources", 'sound/AI/commandreport.ogg'))
