/obj/machinery/plantgenes
	name = "plant DNA manipulator"
	desc = "An advanced device designed to manipulate plant genetic makeup."
	icon = 'icons/obj/hydroponics/equipment.dmi'
	pass_flags = PASSTABLE
	icon_state = "dnamod"
	density = TRUE
	anchored = TRUE

	var/obj/item/seeds/seed
	var/obj/item/disk/plantgene/disk

	var/list/core_genes = list()
	var/list/reagent_genes = list()
	var/list/trait_genes = list()

	var/datum/plant_gene/target
	var/seeds_for_core = 5

/obj/machinery/plantgenes/Initialize(mapload)
	. = ..()
	component_parts = list()
	component_parts += new /obj/item/circuitboard/plantgenes(null)
	component_parts += new /obj/item/stack/sheet/glass(null)
	component_parts += new /obj/item/stock_parts/scanning_module(null)
	component_parts += new /obj/item/stock_parts/micro_laser(null)
	component_parts += new /obj/item/stock_parts/manipulator(null)
	RefreshParts()

/obj/machinery/plantgenes/seedvault/Initialize(mapload)
	. = ..()
	component_parts = list()
	component_parts += new /obj/item/circuitboard/plantgenes/vault(null)
	component_parts += new /obj/item/stack/sheet/glass(null)
	component_parts += new /obj/item/stock_parts/scanning_module(null)
	component_parts += new /obj/item/stock_parts/micro_laser(null)
	component_parts += new /obj/item/stock_parts/manipulator(null)
	RefreshParts()

/obj/machinery/plantgenes/Destroy()
	core_genes.Cut()
	reagent_genes.Cut()
	trait_genes.Cut()
	target = null
	QDEL_NULL(seed)
	QDEL_NULL(disk)
	return ..()

/obj/machinery/plantgenes/RefreshParts()
	var/total_rating = 0
	for(var/obj/item/stock_parts/S in component_parts)
		total_rating += S.rating

	for(var/obj/item/circuitboard/plantgenes/vaultcheck in component_parts)
		if(istype(vaultcheck, /obj/item/circuitboard/plantgenes/vault)) // TRAIT_DUMB BOTANY TUTS
			total_rating = 12

	switch(clamp(total_rating, 1, 12))
		if(1 to 3)
			seeds_for_core = 5
		if(4 to 6)
			seeds_for_core = 4
		if(7 to 9)
			seeds_for_core = 3
		if(10 to 11)
			seeds_for_core = 2
		else
			seeds_for_core = 1

/obj/machinery/plantgenes/update_icon_state()
	if((stat & (BROKEN|NOPOWER)))
		icon_state = "dnamod-off"
	else
		icon_state = "dnamod"

/obj/machinery/plantgenes/update_overlays()
	. = ..()
	if(seed)
		. += "dnamod-dna"
	if(panel_open)
		. += "dnamod-open"

/obj/machinery/plantgenes/attackby(obj/item/I, mob/user, params)
	if(default_deconstruction_screwdriver(user, "dnamod", "dnamod", I))
		update_icon(UPDATE_OVERLAYS)
		return
	if(exchange_parts(user, I))
		return
	if(default_deconstruction_crowbar(user, I))
		return
	if(isrobot(user))
		return

	if(istype(I, /obj/item/seeds))
		add_seed(I, user)
	else if(istype(I, /obj/item/disk/plantgene))
		add_disk(I, user)
	else
		return ..()

/obj/machinery/plantgenes/proc/add_seed(obj/item/seeds/new_seed, mob/user)
	if(seed)
		to_chat(user, "<span class='warning'>A sample is already loaded into the machine!</span>")
		return
	if(!user.drop_item())
		return
	insert_seed(new_seed)
	to_chat(user, "<span class='notice'>You add [new_seed] to the machine.</span>")
	ui_interact(user)

/obj/machinery/plantgenes/proc/add_disk(obj/item/disk/plantgene/new_disk, mob/user)
	if(disk)
		to_chat(user, "<span class='warning'>A data disk is already loaded into the machine!</span>")
		return
	if(!user.drop_item())
		return
	disk = new_disk
	disk.forceMove(src)
	to_chat(user, "<span class='notice'>You add [new_disk] to the machine.</span>")
	ui_interact(user)

/obj/machinery/plantgenes/attack_hand(mob/user)
	if(..())
		return
	ui_interact(user)

/obj/machinery/plantgenes/attack_ghost(mob/user)
	ui_interact(user)

/obj/machinery/plantgenes/ui_state(mob/user)
	return GLOB.default_state

/obj/machinery/plantgenes/ui_interact(mob/user, datum/tgui/ui = null)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "GeneModder", name)
		ui.open()

/obj/machinery/plantgenes/ui_data(mob/user)
	var/list/data = list()

	data["has_seed"] = seed ? TRUE : FALSE
	data["has_disk"] = disk ? TRUE : FALSE

	data["core_genes"] = list()
	data["reagent_genes"] = list()
	data["trait_genes"] = list()

	data["has_reagent"] = FALSE
	data["has_trait"] = FALSE

	data["seed"] = list()

	if(seed)
		data["seed"] = list(
			"image" = "[icon2base64(icon(initial(seed.icon), initial(seed.icon_state), SOUTH, 1))]",
			"name" = seed.name,
			"variant" = seed.variant
		)

		for(var/datum/plant_gene/core/c_gene in core_genes)
			var/list/seed_info = list(
				"name" = c_gene.get_name(),
				"id" = c_gene.UID(),
				"is_type" = disk && istype(disk.gene, c_gene)
			)
			data["core_genes"] += list(seed_info)
			// there will always be core genes, if there isnt, something has gone very wrong

		for(var/datum/plant_gene/reagent/r_gene in reagent_genes)
			var/list/seed_info = list(
				"name" = r_gene.get_name(),
				"id" = r_gene.UID()
			)
			data["reagent_genes"] += list(seed_info)
			data["has_reagent"] = TRUE

		for(var/datum/plant_gene/trait/t_gene in trait_genes)
			var/list/seed_info = list(
				"name" = t_gene.get_name(),
				"id" = t_gene.UID()
			)
			data["trait_genes"] += list(seed_info)
			data["has_trait"] = TRUE

	data["disk"] = list()

	if(disk)
		var/disk_name = "Empty Disk"
		if(disk.gene || disk.is_core)
			disk_name = disk.ui_name
		if(disk.read_only)
			disk_name = "[disk_name] (Read Only)"
		var/can_insert = FALSE
		if(seed)
			can_insert = disk.gene?.can_add(seed)
		data["disk"] = list(
			"name" = disk_name,
			"can_insert" = can_insert,
			"can_extract" = !disk.read_only,
			"is_core" = disk?.is_core && (disk.seeds_needed <= disk.seeds_scanned)
		)

	data["modal"] = ui_modal_data(src)

	return data

/obj/machinery/plantgenes/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	if(..())
		return

	. = TRUE

	// we dont care what we get from modal act, as long as its not null because we only have boolean modals
	if(ui_modal_act(src, action, params))
		return

	var/mob/user = ui.user

	target = seed?.get_gene(params["id"])

	switch(action)
		if("eject_seed")
			if(seed)
				seed.forceMove(loc)
				user.put_in_hands(seed)
				seed = null
				update_genes()
				update_icon(UPDATE_OVERLAYS)
			else
				var/obj/item/I = user.get_active_hand()
				if(istype(I, /obj/item/seeds))
					add_seed(I, user)

		if("eject_disk")
			if(disk)
				disk.forceMove(loc)
				user.put_in_hands(disk)
				disk = null
				update_genes()
			else
				var/obj/item/I = user.get_active_hand()
				if(istype(I, /obj/item/disk/plantgene))
					add_disk(I, user)

		if("variant_name")
			seed.variant_prompt(user, src)
			// uses the default byond prompt, but it works

		if("extract_core")
			var/dat = "Are you sure you want to extract all core genes from the [seed]? The sample will be destroyed in process!"
			var/prev_seeds = 0
			if(disk.is_core && disk.core_matches(seed))
				prev_seeds = disk.seeds_scanned
			if(seeds_for_core > prev_seeds + 1)
				var/remaining = seeds_for_core - prev_seeds - 1
				dat += " This device needs [seeds_for_core] samples to produce a usable core gene disk. You will need [remaining] more samples with identical core genes."

			ui_modal_boolean(src, action, dat, yes_text = "Extract", no_text = "Cancel", delegate = PROC_REF(gene_extract_core))

		if("replace_core")
			ui_modal_boolean(src, action, "Are you sure you want to replace ALL core genes of the [seed]?" , yes_text = "Replace", no_text = "Cancel", delegate = PROC_REF(gene_replace_core))

		if("extract")
			ui_modal_boolean(src, action, "Are you sure you want to extract [target.get_name()] gene from the [seed]? The sample will be destroyed in process!", yes_text = "Extract", no_text = "Cancel", delegate = PROC_REF(gene_extract))

		if("remove")
			ui_modal_boolean(src, action, "Are you sure you want to remove [target.get_name()] gene from the [seed]" , yes_text = "Remove", no_text = "Cancel", delegate = PROC_REF(gene_remove))

		if("insert")
			if(!disk.is_core && disk.gene.can_add(seed))
				seed.genes += disk.gene.Copy()
				if(istype(disk.gene, /datum/plant_gene/reagent))
					seed.reagents_from_genes()
				update_genes()
				repaint_seed()
				// this doesnt need a modal, its easy enough to just remove the inserted gene


/obj/machinery/plantgenes/proc/gene_remove()
	if(istype(target, /datum/plant_gene/core))
		return
	seed.genes -= target
	if(istype(target, /datum/plant_gene/reagent))
		seed.reagents_from_genes()
	repaint_seed()
	update_genes()
	target = null

/obj/machinery/plantgenes/proc/gene_extract()
	if(!disk || disk.read_only)
		return
	disk.is_core = FALSE
	disk.core_genes = list()
	disk.gene = target.Copy()

	disk.update_name()
	QDEL_NULL(seed)
	update_icon(UPDATE_OVERLAYS)
	update_genes()
	target = null

/obj/machinery/plantgenes/proc/gene_extract_core()
	if(!disk || disk.read_only)
		return
	disk.seeds_needed = seeds_for_core
	if(disk.core_matches(seed))
		disk.seeds_scanned += 1
	else
		disk.seeds_scanned = 1
		disk.is_core = TRUE
		disk.gene = null
		disk.core_genes = list()
		for(var/datum/plant_gene/core/gene in core_genes)
			var/datum/plant_gene/core/C = gene.Copy()
			disk.core_genes += C

	disk.update_name()
	QDEL_NULL(seed)
	update_icon(UPDATE_OVERLAYS)
	update_genes()
	target = null

/obj/machinery/plantgenes/proc/gene_replace_core()
	if(!disk?.is_core)
		return
	if(disk.seeds_scanned < disk.seeds_needed)
		return
	for(var/datum/plant_gene/gene in seed.genes)
		if(istype(gene, /datum/plant_gene/core))
			seed.genes -= gene
	for(var/datum/plant_gene/core/gene in disk.core_genes)
		var/datum/plant_gene/core/C = gene.Copy()
		seed.genes += C
		C.apply_stat(seed)
	repaint_seed()
	update_genes()
	target = null

/obj/machinery/plantgenes/proc/insert_seed(obj/item/seeds/S)
	if(!istype(S) || seed)
		return
	S.forceMove(src)
	seed = S
	update_genes()
	update_icon(UPDATE_OVERLAYS)

/obj/machinery/plantgenes/proc/update_genes()
	core_genes = list()
	reagent_genes = list()
	trait_genes = list()

	if(seed)
		var/gene_paths = list(
			/datum/plant_gene/core/potency,
			/datum/plant_gene/core/yield,
			/datum/plant_gene/core/production,
			/datum/plant_gene/core/endurance,
			/datum/plant_gene/core/lifespan,
			/datum/plant_gene/core/weed_rate,
			/datum/plant_gene/core/weed_chance
			)
		for(var/a in gene_paths)
			core_genes += seed.get_gene(a)

		for(var/datum/plant_gene/reagent/G in seed.genes)
			reagent_genes += G
		for(var/datum/plant_gene/trait/G in seed.genes)
			trait_genes += G

/obj/machinery/plantgenes/proc/repaint_seed()
	if(!seed)
		return
	if(copytext(seed.name, 1, 13) == "experimental")
		return // Already modded name and icon
	seed.name = "experimental " + seed.name
	seed.icon_state = "seed-x"

/*
 *  Plant DNA disk
 */

/obj/item/disk/plantgene
	name = "plant data disk"
	desc = "A disk for storing plant genetic data."
	icon_state = "datadisk_hydro"
	materials = list(MAT_METAL=30, MAT_GLASS=10)
	var/ui_name = "Empty Disk"
	var/is_core = FALSE
	var/read_only = 0 //Well, it's still a floppy disk

	// For non-core genes
	var/datum/plant_gene/gene

	// For core genes
	var/list/core_genes = list()
	var/seeds_scanned = 0
	var/seeds_needed = 5

/obj/item/disk/plantgene/New()
	..()
	update_icon(UPDATE_OVERLAYS)

/obj/item/disk/plantgene/Destroy()
	QDEL_NULL(gene)
	return ..()

/obj/item/disk/plantgene/attackby(obj/item/W, mob/user, params)
	..()
	if(is_pen(W))
		rename_interactive(user, W)

/obj/item/disk/plantgene/update_name()
	. = ..()
	if(HAS_TRAIT(src, TRAIT_CMAGGED))
		name = "nuclear authentication disk"
		ui_name = "nuclear authentication disk?"
		return
	if(!is_core && gene)
		name = "[gene.get_name()] (plant data disk)"
		ui_name = "[gene.get_name()]"
	else if(is_core)
		name = ""
		if(seeds_scanned < seeds_needed)
			name +=  "[round(seeds_scanned/seeds_needed*100,1)]% of "
		name += "Core genes "
		ui_name = "Core "
		for(var/i in 1 to length(core_genes))
			if(i > 1)
				name += "/"
				ui_name += "/"
			name += "[core_genes[i].value]"
			ui_name += "[core_genes[i].value]"

		name += " (plant data disk)"

		if(seeds_scanned < seeds_needed)
			ui_name +=  " ([round(seeds_scanned/seeds_needed*100,1)]%)"
	else
		name = "plant data disk"
		ui_name = "Empty Disk"

/obj/item/disk/plantgene/proc/core_matches(obj/item/seeds/seed)
	if(!is_core)
		return FALSE
	for(var/datum/plant_gene/core/gene in core_genes)
		if(gene.value != seed.get_gene(gene.type).value)
			return FALSE
	return TRUE

/obj/item/disk/plantgene/update_desc()
	. = ..()
	if(HAS_TRAIT(src, TRAIT_CMAGGED))
		desc = "Better keep this safe."
		return

	desc = "A disk for storing plant genetic data."

/obj/item/disk/plantgene/update_icon_state()
	. = ..()
	if(HAS_TRAIT(src, TRAIT_CMAGGED))
		icon_state = "nucleardisk"
		return

	icon_state = "datadisk_hydro"

/obj/item/disk/plantgene/update_overlays()
	. = ..()
	if(HAS_TRAIT(src, TRAIT_CMAGGED))
		return

	. += "datadisk_gene"

/obj/item/disk/plantgene/attack_self(mob/user)
	if(HAS_TRAIT(src, TRAIT_CMAGGED))
		return
	read_only = !read_only
	to_chat(user, "<span class='notice'>You flip the write-protect tab to [read_only ? "protected" : "unprotected"].</span>")

/obj/item/disk/plantgene/cmag_act(mob/user)
	if(!HAS_TRAIT(src, TRAIT_CMAGGED))
		to_chat(user, "<span class='warning'>The bananium ooze flips a couple bits on the plant disk's display, making it look just like the..!</span>")
		ADD_TRAIT(src, TRAIT_CMAGGED, CLOWN_EMAG)
		update_appearance(UPDATE_NAME|UPDATE_DESC|UPDATE_ICON)
		playsound(src, "sparks", 75, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)

/obj/item/disk/plantgene/uncmag()
	update_appearance(UPDATE_NAME|UPDATE_DESC|UPDATE_ICON)

/obj/item/disk/plantgene/examine(mob/user)
	. = ..()
	if(!HAS_TRAIT(src, TRAIT_CMAGGED))
		. += "The write-protect tab is set to [read_only ? "protected" : "unprotected"]."
		return
	if((user.mind.assigned_role == "Captain" || user.mind.special_role == SPECIAL_ROLE_NUKEOPS) && (user.Adjacent(src)))
		. += "<span class='warning'>... Wait. This isn't the nuclear authentication disk! It's a clever forgery!</span>"
