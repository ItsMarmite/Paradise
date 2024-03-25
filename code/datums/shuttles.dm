/datum/map_template/shuttle
	name = "Base Shuttle Template"
	var/prefix = "_maps/map_files/shuttles/"
	var/suffix
	var/port_id
	var/shuttle_id

	var/description
	var/admin_notes

/datum/map_template/shuttle/New()
	if(port_id && suffix)
		shuttle_id = "[port_id]_[suffix]"
		mappath = "[prefix][shuttle_id].dmm"
	. = ..()

/datum/map_template/shuttle/emergency
	port_id = "emergency"
	name = "Base Shuttle Template (Emergency)"

/datum/map_template/shuttle/cargo
	port_id = "cargo"
	name = "Base Shuttle Template (Cargo)"

/datum/map_template/shuttle/ferry
	port_id = "ferry"
	name = "Base Shuttle Template (Ferry)"

/datum/map_template/shuttle/admin
	port_id = "admin"
	name = "Base Shuttle Template (Admin)"



// Shuttles start here:

/datum/map_template/shuttle/emergency/bar
	suffix = "bar"
	name = "Emergency Escape Bar"
	description = "Features include a bathroom, a quality lounge for the heads, and a \
		small gambling table."


/datum/map_template/shuttle/emergency/cyb
	suffix = "cyb"
	name = "Emergency shuttle (Cyberiad)"

/datum/map_template/shuttle/emergency/dept
	suffix = "dept"
	name = "Emergency shuttle (department)"
	description = "Features include: areas for each department, and a small bar."
	admin_notes = "Designed to reduce chaos. Each dept requires dept access."

/datum/map_template/shuttle/emergency/military
	suffix = "mil"
	name = "Emergency shuttle (military)"
	description = "Troop transport with point defense turrets."
	admin_notes = "Designed to ensure a safe evacuation during xeno outbreaks."


/datum/map_template/shuttle/emergency/clown
	suffix = "clown"
	name = "Snappop(tm)"
	description = "Hey kids and grownups! Are you bored of DULL and TEDIOUS \
		shuttle journeys after you're evacuating for probably BORING reasons. \
		Well then order the Snappop(tm) today! We've got fun activities for \
		everyone, an all access cockpit, and no boring security brig! Boo! \
		Play dress up with your friends! Collect all the bedsheets before \
		your neighbour does! Check if the AI is watching you with our patent \
		pending \"Peeping Tom AI Multitool Detector\" or PEEEEEETUR for \
		short. Have a fun ride!"
	admin_notes = "Brig is replaced by anchored greentext book surrounded by \
		lavaland chasms, stationside door has been removed to prevent \
		accidental dropping."

/datum/map_template/shuttle/emergency/cramped
	suffix = "cramped"
	name = "Secure Transport Vessel 5 (STV5)"
	description = "Well, looks like Centcomm only had this ship in the area, \
		they probably weren't expecting you to need evac for a while. \
		Probably best if you don't rifle around in whatever equipment they \
		were transporting. I hope you're friendly with your coworkers, \
		because there is very little space in this thing.\n\
		\n\
		Contains contraband armory guns, maintenance loot, and abandoned \
		crates!"
	admin_notes = "Due to origin as a solo piloted secure vessel, has an \
		active GPS onboard labeled STV5."

/datum/map_template/shuttle/emergency/meta
	suffix = "meta"
	name = "Emergency shuttle (Metastation)"

/datum/map_template/shuttle/emergency/narnar
	suffix = "narnar"
	name = "Shuttle 667"
	description = "Looks like this shuttle may have wandered into the \
		darkness between the stars on route to the station. Let's not think \
		too hard about where all the bodies came from."
	admin_notes = "Contains inactive \
		constructs. Put players in constructs if you want them to move. \
		Cloning pods in 'medbay' area are showcases and nonfunctional."

/datum/map_template/shuttle/emergency/old
	suffix = "old"
	name = "Retired Station shuttle."
	description = "An older model of the station shuttle."

/datum/map_template/shuttle/emergency/jungle
	suffix = "jungle"
	name = "Emergency shuttle JUNG-13"
	description = "You can hear screeching and hissing as this shuttle docks."

/datum/map_template/shuttle/emergency/raven
	suffix = "raven"
	name = "CentCom Raven Cruiser"
	description = "The CentCom Raven Cruiser is a former high-risk salvage vessel, now repurposed into an emergency escape shuttle. \
	Once first to the scene to pick through warzones for valuable remains, it now serves as an excellent escape option for stations under heavy fire from outside forces. \
	This escape shuttle boasts shields and numerous anti-personnel turrets guarding its perimeter to fend off meteors and enemy boarding attempts."
	admin_notes = "Comes with turrets that will target simple mobs."

/datum/map_template/shuttle/emergency/hubris
	suffix = "hubris"
	name = "STV Hubris"
	description = "The Syndicate Transport Vessel Hubris is a recently hijacked Nanotrasen vessel that has been retrofitted as a weapon. \
	There lay no greater irony than the tools of Nanotrasen burning and writhing within their precious 'plasma'."
	admin_notes = "If you force this shuttle, expect mass shuttle grief. You have been warned."
/datum/map_template/shuttle/ferry/base
	suffix = "base"
	name = "transport ferry"
	description = "Standard issue Box/Metastation Centcom ferry."

/datum/map_template/shuttle/ferry/meat
	suffix = "meat"
	name = "\"meat\" ferry"
	description = "Ahoy! We got all kinds o' meat aft here. Meat from plant \
		people, people who be dark, not in a racist way, just they're dark \
		black. Oh and lizard meat too,mighty popular that is. Definitely \
		100% fresh, just ask this guy here. *person on meatspike moans* See? \
		Definitely high quality meat, nothin' wrong with it, nothin' added, \
		definitely no zombifyin' reagents!"
	admin_notes = "Meat currently contains no zombifying reagents, people on \
		meatspike must be spawned in."

/datum/map_template/shuttle/admin/hospital
	suffix = "hospital"
	name = "NHV Asclepius"
	description = "Nanostrasen Hospital ship, for medical assistance during disasters."

/datum/map_template/shuttle/admin/admin
	suffix = "admin"
	name = "NTV Argos"
	description = "Default Admin ship. An older ship used for special operations."

/datum/map_template/shuttle/admin/armory
	suffix = "armory"
	name = "NRV Sparta"
	description = "Armory Shuttle, with plenty of guns to hand out and some general supplies."

/datum/map_template/shuttle/admin/skipjack
	suffix = "skipjack"
	name = "Vox Skipjack"
	description = "Vox skipjack ship."
