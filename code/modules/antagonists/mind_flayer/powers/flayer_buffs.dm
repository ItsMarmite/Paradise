// This is a file with all the powers that buff or heal a mindflayer in some way

/obj/effect/proc_holder/spell/flayer/self/rejuv
	name = "Rejuvenate"
	desc = "Add me!"
	power_type = FLAYER_INNATE_POWER

/obj/effect/proc_holder/spell/flayer/self/rejuv/cast(list/targets, mob/user)
	to_chat(user, "<span class='notice'>We begin to heal rapidly.</span>")
	var/mob/living/caster = user
	caster.apply_status_effect(STATUS_EFFECT_FLAYER_REJUV)

/obj/effect/proc_holder/spell/flayer/self/adaptive_coating
	name = "Adaptive Coating"
	desc = "We temporarily increase the elasticity of our armor by a factor of 100, allowing us to deflect projectiles."
	power_type = FLAYER_PURCHASABLE_POWER
	base_cooldown = 30 SECONDS //33% uptime
	category = CATEGORY_DESTROYER

/obj/effect/proc_holder/spell/flayer/self/adaptive_coating/cast(list/targets, mob/user)
	ADD_TRAIT(user, TRAIT_DEFLECTS_PROJECTILES, UID())
	addtimer(CALLBACK(src, PROC_REF(end_effect), user), 10 SECONDS)

/obj/effect/proc_holder/spell/flayer/self/adaptive_coating/proc/end_effect(mob/user)
	REMOVE_TRAIT(user, TRAIT_DEFLECTS_PROJECTILES, UID())
