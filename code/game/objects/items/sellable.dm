/obj/item/sellable/salvage
	name = "Salvage"
	desc = "A tonne of salvage looted from bad mapping practices. Who spawned the base type? Report this on the github."
	force = 5
	throwforce = 5
	icon = 'icons/obj/objects.dmi'
	icon_state = "barrel"
	throw_speed = 1
	throw_range = 4
	hitsound = 'sound/items/salvagepickup.ogg'
	pickup_sound = 'sound/items/salvagepickup.ogg'
	drop_sound = 'sound/items/salvagedrop.ogg'
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/sellable/salvage/examine(mob/user)
	. = ..()
	. += "<span class='notice'>You can bring this back to Cargo to sell to Central Command onboard the 'NTV Arion' Supply shuttle.</span>"

/// Ruin Salvage, misc loot gained from looking around ruins.

/obj/item/sellable/salvage/ruin
	name = "Salvage"
	desc = "A tonne of salvage recovered from an abandoned ruin. Who spawned the base type? Report this on the github."

/obj/item/sellable/salvage/ruin/pirate
	name = "Rum Keg"
	desc = "A highly valued keg of aged space rum. Limited edition and sure to be a collector's item."

/obj/item/sellable/salvage/ruin/russian
	name = "Armaments Cache"
	desc = "A crate of old disused Belastrav ballistic firearms clearly long past their usability. This crate would make good scrap metal for shuttle construction."

/obj/item/sellable/salvage/ruin/syndicate
	name = "Salvage"
	desc = "A tonne of salvage recovered from an abandoned ruin. Who spawned the base type? Report this on the github."

/obj/item/sellable/salvage/ruin/tsf
	name = "TSF"
	desc = "A tonne of salvage recovered from an abandoned ruin. Who spawned the base type? Report this on the github."

/obj/item/sellable/salvage/ruin/nanotrasen
	name = "Lost Research Notes"
	desc = "A collection of research notes penned by old Nanotrasen scientists from decades past, technology lost in time- until you found them. It is a mystery what technology Central Command will push if they could just get their hands on these notes."

/obj/item/sellable/salvage/ruin/carp
	name = "Space Dragon Scales"
	desc = "A tonne of salvage recovered from an abandoned ruin. Who spawned the base type? Report this on the github."

/obj/item/sellable/salvage/ruin/pirate
	name = "Salvage"
	desc = "A tonne of salvage recovered from an abandoned ruin. Who spawned the base type? Report this on the github."


/// Loot salvage, gained from fighting space simplemobs.

/obj/item/sellable/salvage/loot
	name = "Salvage"
	desc = "A tonne of salvage looted from a fallen foe. Who spawned the base type? Report this on the github."

/obj/item/sellable/salvage/loot/pirate
	name = "Stolen Jewellery"
	desc = "A collection of stolen jewellery, fashioned from pilfered bluespace crystals and gems. Rumour has it, local pirates have been known to use these accessories to avoid capture."

/obj/item/sellable/salvage/loot/russian
	name = "SIOSP Manual"
	desc = "A small red manual, written in Neo-Russkyia, detailing the manifesto of Malfoy Ames, father of The Cygni Rebellion. Central Command may wish to share this with their allies in the Trans-Solar Federation."

/obj/item/sellable/salvage/loot/syndicate
	name = "Syndicate Intel"
	desc = "A folder detailing Syndicate plans to infiltrate and sabotage operations in the Epsilon Eridani sector. Central Command may find use of this to aid them in counter-intelligence."
