
// /datum/recipe/grill

/datum/recipe/grill/bacon
	items = list(
		/obj/item/food/raw_bacon,
	)
	result = /obj/item/food/bacon

/datum/recipe/grill/telebacon
	items = list(
		/obj/item/food/meat,
		/obj/item/assembly/signaler
	)
	result = /obj/item/food/telebacon


/datum/recipe/grill/syntitelebacon
	items = list(
		/obj/item/food/meat/syntiflesh,
		/obj/item/assembly/signaler
	)
	result = /obj/item/food/telebacon

/datum/recipe/grill/friedegg
	reagents = list("sodiumchloride" = 1, "blackpepper" = 1)
	items = list(
		/obj/item/food/egg
	)
	result = /obj/item/food/friedegg

/datum/recipe/grill/birdsteak
	reagents = list("sodiumchloride" = 1, "blackpepper" = 1)
	items = list(
		/obj/item/food/meat/chicken
	)
	result = /obj/item/food/meatsteak/chicken

/datum/recipe/grill/meatsteak
	reagents = list("sodiumchloride" = 1, "blackpepper" = 1)
	items = list(
		/obj/item/food/meat
	)
	result = /obj/item/food/meatsteak

/datum/recipe/grill/salmonsteak
	reagents = list("sodiumchloride" = 1, "blackpepper" = 1)
	items = list(
		/obj/item/food/salmonmeat
	)
	result = /obj/item/food/salmonsteak

/datum/recipe/grill/syntisteak
	reagents = list("sodiumchloride" = 1, "blackpepper" = 1)
	items = list(
		/obj/item/food/meat/syntiflesh
	)
	result = /obj/item/food/meatsteak

/datum/recipe/grill/waffles
	reagents = list("sugar" = 10)
	items = list(
		/obj/item/food/dough,
		/obj/item/food/dough
	)
	result = /obj/item/food/waffles

/datum/recipe/grill/rofflewaffles
	reagents = list("psilocybin" = 5, "sugar" = 10)
	items = list(
		/obj/item/food/dough,
		/obj/item/food/dough
	)
	result = /obj/item/food/rofflewaffles

/datum/recipe/grill/grilledcheese
	items = list(
		/obj/item/food/sliced/bread,
		/obj/item/food/sliced/bread,
		/obj/item/food/sliced/cheesewedge
	)
	result = /obj/item/food/grilledcheese

/datum/recipe/grill/sausage
	items = list(
		/obj/item/food/meatball,
		/obj/item/food/cutlet
	)
	result = /obj/item/food/sausage

/datum/recipe/grill/fishfingers
	reagents = list("flour" = 10)
	items = list(
		/obj/item/food/egg,
		/obj/item/food/carpmeat
	)
	result = /obj/item/food/fishfingers

/datum/recipe/grill/fishfingers/make_food(obj/container)
	var/obj/item/food/fishfingers/being_cooked = ..()
	being_cooked.reagents.del_reagent("egg")
	being_cooked.reagents.del_reagent("carpotoxin")
	return being_cooked

/datum/recipe/grill/cutlet
	items = list(
		/obj/item/food/rawcutlet
	)
	result = /obj/item/food/cutlet

/datum/recipe/grill/omelette
	items = list(
		/obj/item/food/egg,
		/obj/item/food/egg,
		/obj/item/food/sliced/cheesewedge,
		/obj/item/food/sliced/cheesewedge
	)
	result = /obj/item/food/omelette

/datum/recipe/grill/wingfangchu
	reagents = list("soysauce" = 5)
	items = list(
		/obj/item/food/monstermeat/xenomeat
	)
	result = /obj/item/food/wingfangchu

/datum/recipe/grill/human/kebab
	items = list(
		/obj/item/stack/rods,
		/obj/item/food/meat/human,
		/obj/item/food/meat/human
	)
	result = /obj/item/food/human/kebab

/datum/recipe/grill/syntikebab
	items = list(
		/obj/item/stack/rods,
		/obj/item/food/meat/syntiflesh,
		/obj/item/food/meat/syntiflesh
	)
	result = /obj/item/food/syntikebab

/datum/recipe/grill/meatkeb	// Do not put this above the other meat kebab variants or it will override them.
	items = list(
		/obj/item/stack/rods,
		/obj/item/food/meat,
		/obj/item/food/meat
	)
	result = /obj/item/food/meatkebab

/datum/recipe/grill/tofukebab
	items = list(
		/obj/item/stack/rods,
		/obj/item/food/tofu,
		/obj/item/food/tofu
	)
	result = /obj/item/food/tofukebab

/datum/recipe/grill/picoss_kebab
	reagents = list("vinegar" = 5)
	items = list(
		/obj/item/food/carpmeat,
		/obj/item/food/carpmeat,
		/obj/item/food/grown/onion,
		/obj/item/food/grown/chili,
		/obj/item/stack/rods
	)
	result = /obj/item/food/picoss_kebab

/datum/recipe/grill/picoss_kebab/make_food(obj/container)
	var/obj/item/food/picoss_kebab/being_cooked = ..()
	being_cooked.reagents.del_reagent("carpotoxin")
	return being_cooked

/datum/recipe/grill/sushi_Tamago
	reagents = list("sake" = 5)
	items = list(
		/obj/item/food/egg,
		/obj/item/food/boiledrice,
		/obj/item/stack/seaweed
	)
<<<<<<< HEAD
	result = /obj/item/food/sliced/sushi_tamago
=======
	result = /obj/item/food/sushi_Tamago
>>>>>>> 9ceda37a45c065c791d79be916749c10c3f554cb

/datum/recipe/grill/sushi_Unagi
	reagents = list("sake" = 5)
	items = list(
		/obj/item/fish/electric_eel,
		/obj/item/food/boiledrice,
		/obj/item/stack/seaweed
	)
	result = /obj/item/food/sushi_Unagi

/datum/recipe/grill/sushi_Ebi
	items = list(
		/obj/item/food/boiledrice,
		/obj/item/food/boiled_shrimp,
		/obj/item/stack/seaweed
	)
<<<<<<< HEAD
	result = /obj/item/food/sliced/sushi_ebi
=======
	result = /obj/item/food/sushi_Ebi
>>>>>>> 9ceda37a45c065c791d79be916749c10c3f554cb

/datum/recipe/grill/sushi_Ikura
	items = list(
		/obj/item/food/boiledrice,
		/obj/item/fish_eggs/salmon,
		/obj/item/stack/seaweed
	)
<<<<<<< HEAD
	result = /obj/item/food/sliced/sushi_ikura
=======
	result = /obj/item/food/sushi_Ikura
>>>>>>> 9ceda37a45c065c791d79be916749c10c3f554cb

/datum/recipe/grill/sushi_Inari
	items = list(
		/obj/item/food/boiledrice,
		/obj/item/food/fried_tofu,
		/obj/item/stack/seaweed
	)
<<<<<<< HEAD
	result = /obj/item/food/sliced/sushi_inari
=======
	result = /obj/item/food/sushi_Inari
>>>>>>> 9ceda37a45c065c791d79be916749c10c3f554cb

/datum/recipe/grill/sushi_Sake
	items = list(
		/obj/item/food/boiledrice,
		/obj/item/food/salmonmeat,
		/obj/item/stack/seaweed
	)
<<<<<<< HEAD
	result = /obj/item/food/sliced/sushi_sake
=======
	result = /obj/item/food/sushi_Sake
>>>>>>> 9ceda37a45c065c791d79be916749c10c3f554cb

/datum/recipe/grill/sushi_SmokedSalmon
	items = list(
		/obj/item/food/boiledrice,
		/obj/item/food/salmonsteak,
		/obj/item/stack/seaweed
	)
<<<<<<< HEAD
	result = /obj/item/food/sliced/sushi_smoked_salmon
=======
	result = /obj/item/food/sushi_SmokedSalmon
>>>>>>> 9ceda37a45c065c791d79be916749c10c3f554cb

/datum/recipe/grill/sushi_Masago
	items = list(
		/obj/item/food/boiledrice,
		/obj/item/fish_eggs/goldfish,
		/obj/item/stack/seaweed
	)
<<<<<<< HEAD
	result = /obj/item/food/sliced/sushi_masago
=======
	result = /obj/item/food/sushi_Masago
>>>>>>> 9ceda37a45c065c791d79be916749c10c3f554cb

/datum/recipe/grill/sushi_Tobiko
	items = list(
		/obj/item/food/boiledrice,
		/obj/item/fish_eggs/shark,
		/obj/item/stack/seaweed
	)
<<<<<<< HEAD
	result = /obj/item/food/sliced/sushi_tobiko
=======
	result = /obj/item/food/sushi_Tobiko
>>>>>>> 9ceda37a45c065c791d79be916749c10c3f554cb

/datum/recipe/grill/sushi_TobikoEgg
	items = list(
<<<<<<< HEAD
		/obj/item/food/sliced/sushi_tobiko,
		/obj/item/food/egg,
		/obj/item/stack/seaweed
	)
	result = /obj/item/food/sliced/sushi_tobiko_egg
=======
		/obj/item/food/sushi_Tobiko,
		/obj/item/food/egg,
		/obj/item/stack/seaweed
	)
	result = /obj/item/food/sushi_TobikoEgg
>>>>>>> 9ceda37a45c065c791d79be916749c10c3f554cb

/datum/recipe/grill/sushi_Tai
	items = list(
		/obj/item/food/boiledrice,
		/obj/item/food/catfishmeat,
		/obj/item/stack/seaweed
	)
<<<<<<< HEAD
	result = /obj/item/food/sliced/sushi_tai
=======
	result = /obj/item/food/sushi_Tai
>>>>>>> 9ceda37a45c065c791d79be916749c10c3f554cb

/datum/recipe/grill/goliath
	items = list(/obj/item/food/monstermeat/goliath)
	result = /obj/item/food/goliath_steak

/datum/recipe/grill/shrimp_skewer
	items = list(
		/obj/item/food/shrimp,
		/obj/item/food/shrimp,
		/obj/item/food/shrimp,
		/obj/item/food/shrimp,
		/obj/item/stack/rods
	)
	result = /obj/item/food/shrimp_skewer

/datum/recipe/grill/fish_skewer
	reagents = list("flour" = 10)
	items = list(
		/obj/item/food/salmonmeat,
		/obj/item/food/salmonmeat,
		/obj/item/stack/rods
	)
	result = /obj/item/food/fish_skewer

/datum/recipe/grill/pancake
	items = list(
		/obj/item/food/cookiedough
	)
	result = /obj/item/food/pancake

/datum/recipe/grill/berry_pancake
	items = list(
		/obj/item/food/cookiedough,
		/obj/item/food/grown/berries
	)
	result = /obj/item/food/pancake/berry_pancake

/datum/recipe/grill/choc_chip_pancake
	items = list(
		/obj/item/food/cookiedough,
		/obj/item/food/choc_pile
	)
	result = /obj/item/food/pancake/choc_chip_pancake

/datum/recipe/grill/bbqribs
	reagents = list("bbqsauce" = 5)
	items = list(
		/obj/item/food/meat,
		/obj/item/food/meat
	)
	result = /obj/item/food/bbqribs
