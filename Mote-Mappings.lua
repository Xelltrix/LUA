-------------------------------------------------------------------------------------------------------------------
-- Mappings, lists and sets to describe game relationships that aren't easily determinable otherwise.
-------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------
-- Elemental mappings for element relationships and certain types of spells and gear.
-------------------------------------------------------------------------------------------------------------------

	-- Basic elements
	elements = {}

	elements.list = 
	S{
		'Light','Dark','Fire','Ice','Wind','Earth','Lightning','Water'
	}

	elements.weak_to = 
	{
		['Light']='Dark', ['Dark']='Light', ['Fire']='Ice', ['Ice']='Wind', ['Wind']='Earth', ['Earth']='Lightning',
		['Lightning']='Water', ['Water']='Fire'
	}

	elements.strong_to = 
	{	
		['Light']='Dark', ['Dark']='Light', ['Fire']='Water', ['Ice']='Fire', ['Wind']='Ice', ['Earth']='Wind',
		['Lightning']='Earth', ['Water']='Lightning'
	}

	storms = 
	S{
		"Aurorastorm", "Voidstorm", "Firestorm", "Sandstorm", "Rainstorm", "Windstorm", "Hailstorm", "Thunderstorm",
		"Aurorastorm II", "Voidstorm II", "Firestorm II", "Sandstorm II", "Rainstorm II", "Windstorm II", "Hailstorm II", "Thunderstorm II"
	}

	elements.storm_of = 
	{
		['Light']="Aurorastorm", ['Dark']="Voidstorm", ['Fire']="Firestorm", ['Earth']="Sandstorm",
		['Water']="Rainstorm", ['Wind']="Windstorm", ['Ice']="Hailstorm", ['Lightning']="Thunderstorm",
		['Light']="Aurorastorm II", ['Dark']="Voidstorm II", ['Fire']="Firestorm II", ['Earth']="Sandstorm II",
		['Water']="Rainstorm II", ['Wind']="Windstorm II", ['Ice']="Hailstorm II", ['Lightning']="Thunderstorm II"
	}

	spirits = 
	S{
		"LightSpirit", "DarkSpirit", "FireSpirit", "EarthSpirit", "WaterSpirit", "AirSpirit", "IceSpirit", "ThunderSpirit"
	}

	avatars = 
	S{
		"Carbuncle", "Fenrir", "Diabolos", "Ifrit", "Titan", "Leviathan", "Garuda", "Shiva", "Ramuh", "Odin", "Alexander", "Cait Sith", "Atomos", "Siren"
	}

	elements.spirit_of = 
	{
		['Light']="Light Spirit", ['Dark']="Dark Spirit", ['Fire']="Fire Spirit", ['Earth']="Earth Spirit",
		['Water']="Water Spirit", ['Wind']="Air Spirit", ['Ice']="Ice Spirit", ['Lightning']="Thunder Spirit"
	}

	runes = 
	S{
		'Lux', 'Tenebrae', 'Ignis', 'Gelus', 'Flabra', 'Tellus', 'Sulpor', 'Unda'
	}

	elements.rune_of = 
	{
		['Light']='Lux', ['Dark']='Tenebrae', ['Fire']='Ignis', ['Ice']='Gelus', ['Wind']='Flabra',
		['Earth']='Tellus', ['Lightning']='Sulpor', ['Water']='Unda'
	}
	
	
	magical_ws = 
	S{
		"Gust Slash", "Cyclone", "Energy Steal", "Energy Drain", "Aeolian Edge",
		"Burning Blade", "Red Lotus Blade", "Shining Blade", "Seraph Blade", "Sanguine Blade",
		"Frostbite", "Freezebite", "Herculean Slash",
		"Cloudsplitter", "Primal Rend",
		"Dark Harevest", "Shadow of Death", "Infernal Scythe",
		"Thunder Thrust", "Raiden Thrust",
		"Blade: Teki", "Blade: To", "Blade: Chi", "Blade: Ei", "Blade: Yu",
		"Tachi: Goten", "Tachi: Kagero", "Tachi: Jinpu", "Tachi: Koki",
		"Shining Strike", "Seraph Strike", "Flash Nova",
		"Rock Crusher", "Earth Crusher", "Starburst", "Sunburst", "Cataclysm", "Vidohunir", "Garland of Bliss", "Omniscience",
		"Flaming Arrow",
		"Hot Shot", "Wildfire", "Trueflight", "Leaden Salute"
	}
	



-------------------------------------------------------------------------------------------------------------------
-- Blood Pact Mappings
-------------------------------------------------------------------------------------------------------------------
	blood_pacts = {}
	
	blood_pacts.bp_Buffs =
	S{
		'Shining Ruby','Glittering Ruby','Soothing Ruby',
		'Frost Armor','Crystal Blessing',
		'Hastega','Fleet Wind','Hastega II',
		'Earthen Armor',
		'Rolling Thunder','Lightning Armor',
		'Soothing Current',
		'Crimson Howl','Inferno Howl',
		'Ecliptic Growl','Ecliptic Howl','Heavenward Howl',
		'Noctoshield','Dream Shroud',
		'Perfect Defense',
		'Katabatic Blades',"Wind's Blessing"
	}
	
	blood_pacts.bp_Boons =
	S{
		'Pacifying Ruby',
		'Aerial Armor',
		'Earthen Ward',
		"Altana's Favor",'Raise II','Reraise II',
		'Chinook'
	}

	blood_pacts.bp_Heals =
	S{
		'Healing Ruby','Healing Ruby II',
		'Whispering Wind',
		'Spring Water'
	}

	blood_pacts.bp_Debuffs =
	S{
		'Sleepga','Diamond Storm',
		'Shock Squall',
		'Slowga','Tidal Roar',
		'Eerie Eye',
		'Lunar Cry','Lunar Roar',
		'Ultimate Terror','Pavor Nocturnus',
		'Mewing Lullaby',
		'Lunatic Voice','Bitter Elegy'
	}

	blood_pacts.bp_Physical =
	S{
		'Double Slap','Rush',
		'Predator Claws',
		'Chaotic Strike','Volt Strike',
		'Regal Scratch','Regal Gash',
		'Eclipse Bite',
		'Hysteric Assault'
	}
	
	blood_pacts.bp_PhysicalTP =
	S{
		'Poison Nails',
		'Axe Kick',
		'Claw',
		'Rock Throw','Rock Buster','Megalith Throw','Mountain Buster','Crag Throw',
		'Shock Strike',
		'Barracude Dive','Tail Whip','Spinning Dive',
		'Double Punch','Punch',
		'Moonlit Charge','Crescent Fang',
		'Camisado','Blindside',
		'Welt','Roundhouse'
	}

	blood_pacts.bp_Magical =
	S{
		'Searing Light','Holy Mist',
		'Diamond Dust',
		'Aerial Blast',
		'Earthen Fury',
		'Judgment Bolt',
		'Tidal Wave',
		'Inferno',
		'Howling Moon',
		'Ruinous Omen','Somnolence','Nightmare','Nether Blast','Night Terror',
		'Sonic Buffet'
	}

	blood_pacts.bp_MagicalTP =
	S{
		'Meteorite',
		'Blizard II','Blizzard IV',
		'Aero II','Aero IV',
		'Stone II','Stone IV',
		'Thunder II','Thunderspark','Thunder IV',
		'Water II','Water IV',
		'Fire II','Fire IV','Conflag Strike',
		'Level ? Holy',
		'Lunar Bay', 'Impact',
		'Zantetsuken',
		'Tornado II'
	}
	
	blood_pacts.bp_Merit =
	S{
		'Heavenly Strike',
		'Wind Blade',
		'Geocrush',
		'Thunderstorm',
		'Grand Fall',
		'Meteor Strike',
	}

	blood_pacts.bp_Hybrid =
	S{
		'Burning Strike','Flaming Crush'
	}

-------------------------------------------------------------------------------------------------------------------
-- Spell mappings allow defining a general category or description that each of sets of related
-- spells all fall under.
-------------------------------------------------------------------------------------------------------- -----------

spell_maps = {
    ---- Healing Spells
	['Cure']='Cures',['Cure II']='Cures',['Cure III']='Cures',['Cure IV']='Cures',['Cure V']='Cures',['Cure VI']='Cures',
	['Full Cure']='Cures',
	['Cura']='Curas',['Cura II']='Curas',['Cura III']='Curas',
    ['Curaga']='Curagas',['Curaga II']='Curagas',['Curaga III']='Curagas',['Curaga IV']='Curagas',['Curaga V']='Curagas',
	
    ---- Status Effect Removal	
	['Poisona']='StatusRemoval',['Paralyna']='StatusRemoval',['Silena']='StatusRemoval',['Blindna']='StatusRemoval',
	['Cursna']='StatusRemoval',['Stona']='StatusRemoval',['Viruna']='StatusRemoval',['Erase']='StatusRemoval',
	
	--- Raise
	['Raise']='Raises',['Raise II']='Raises',['Raise III']='Raises',['Arise']='Raises',
	
    ---- Reraise
	['Reraise']='Raises',['Reraise II']='Raises',['Reraise III']='Raises',['Reraise IV']='Raises',
	
    ---- Barspells	
	['Barfire']='BarElement',['Barstone']='BarElement',['Barwater']='BarElement',['Baraero']='BarElement',
	['Barblizzard']='BarElement',['Barthunder']='BarElement',
    ['Barfira']='BarElement',['Barstonra']='BarElement',['Barwatera']='BarElement',['Baraera']='BarElement',
	['Barblizzara']='BarElement',['Barthundra']='BarElement',
	['Barsleepra']='BarStatus',['Barpoisonra']='BarStatus',['Barparalyzra']='BarStatus',['Barblindra']='BarStatus',
	['Barsilencera']='BarStatus',['Barpetra']='BarStatus',['Barvira']='BarStatus',['Baramnesra']='BarStatus',
	['Barsleep']='BarStatus',['Barpoison']='BarStatus',['Barparalyze']='BarStatus',['Barblind']='BarStatus',
	['Barsilence']='BarStatus',['Barpetrify']='BarStatus',['Barvirus']='BarStatus',['Baramnesia']='BarStatus',
	
	---- Boost/Gain
	['Boost-STR']='BoostStat',['Boost-DEX']='BoostStat',['Boost-VIT']='BoostStat',['Boost-AGI']='BoostStat',
	['Boost-INT']='BoostStat',['Boost-MND']='BoostStat',['Boost-CHR']='BoostStat',
    ['Gain-STR']='GainStat',['Gain-DEX']='GainStat',['Gain-VIT']='GainStat',['Gain-AGI']='GainStat',
	['Gain-INT']='GainStat',['Gain-MND']='GainStat',['Gain-CHR']='GainStat',
	
	---- Enhancement	
	['Enfire']='Enhancement',['Enfire II']='Enhancement',['Enblizzard']='Enhancement',['Enblizzard II']='Enhancement',
	['Enaero']='Enhancement',['Enaero II']='Enhancement',
	['Enstone']='Enhancement',['Enstone II']='Enhancement',['Enthunder']='Enhancement',['Enthunder II']='Enhancement',
	['Enwater']='Enhancement',['Enwater II']='Enhancement',
	['Temper']='Enhancement',['Temper II']='Enhancement', ['Phalanx']='Enhancement',['Phalanx II']='Enhancement',
	
    ---- Protection
	['Protect']='Protection',['Protect II']='Protection',['Protect III']='Protection',['Protect IV']='Protection',['Protect V']='Protection',
    ['Shell']='Protection',['Shell II']='Protection',['Shell III']='Protection',['Shell IV']='Protection',['Shell V']='Protection',
    ['Protectra']='Protection',['Protectra II']='Protection',['Protectra III']='Protection',['Protectra IV']='Protection',['Protectra V']='Protection',
    ['Shellra']='Protection',['Shellra II']='Protection',['Shellra III']='Protection',['Shellra IV']='Protection',['Shellra V']='Protection',
	
    ---- Regen & Refresh	
	['Regen']='Regen',['Regen II']='Regen',['Regen III']='Regen',['Regen IV']='Regen',['Regen V']='Regen',
    ['Refresh']='Refresh',['Refresh II']='Refresh',['Refresh III']='Refresh',['Battery Charge']='Refresh',
	
	--- Statless Buffs
	['Sneak']='Statless',['Invisible']='Statless',['Deodorize']='Statless',['Blink']='Statless',
	['Haste']='Statless',['Haste II']='Statless',['Adloquium']='Statless',['Animus Augeo']='Statless',['Animus Minuo']='Statless',
	
	--- Storms
	['Firestorm II']='Storm',['Hailstorm II']='Storm',['Windstorm II']='Storm',['Sandstorm II']='Storm',['Thunderstorm II']='Storm',
	['Rainstorm II']='Storm',['Aurorastorm II']='Storm',['Voidstorm II']='Storm',
	['Firestorm']='Storm',['Hailstorm']='Storm',['Windstorm']='Storm',['Sandstorm']='Storm',['Thunderstorm']='Storm',
	['Rainstorm']='Storm',['Aurorastorm']='Storm',['Voidstorm']='Storm',
	
    ---- Teleport
	['Teleport-Holla']='Teleport',['Teleport-Dem']='Teleport',['Teleport-Mea']='Teleport',['Teleport-Altep']='Teleport',['Teleport-Yhoat']='Teleport',
    ['Teleport-Vahzl']='Teleport',['Recall-Pashh']='Teleport',['Recall-Meriph']='Teleport',['Recall-Jugner']='Teleport',
	['Retrace']='Teleport',['Warp']='Teleport',['Warp II']='Teleport',['Escape']='Teleport',['Tractor']='Teleport',
	
    --- Helices
	['Pyrohelix II']='Helix',['Cryohelix II']='Helix',['Anemohelix II']='Helix',['Geohelix II']='Helix',['Ionohelix II']='Helix',
	['Hydrohelix II']='Helix',['Luminohelix II']='Helix',['Noctohelix II']='Helix',
	['Pyrohelix']='Helix',['Cryohelix']='Helix',['Anemohelix']='Helix',['Geohelix']='Helix',['Ionohelix']='Helix',
	['Hydrohelix']='Helix',['Luminohelix']='Helix',['Noctohelix']='Helix',
	
	--- Dark Nukes
	['Kaustra']='Darkness',['Noctohelix']='Darkness',['Noctohelix II']='Darkness',['Comet']='Darkness',['Impact']='Darkness',['Death']='Darkness',
	
	--- Light Nukes
	['Luminohelix']='Brightness',['Luminohelix II']='Brightness',['Holy']='Brightness',['Holy II']='Brightness',
	['Banish']='Brightness',['Banish II']='Brightness',['Banish III']='Brightness',['Banishga']='Brightness',['Banishga II']='Brightness',
	
	--- Geomancer Nukes
	['Fira']='GeoNukes',['Fira II']='GeoNukes',['Fira III']='GeoNukes', ['Blizzara']='GeoNukes',['Blizzara II']='GeoNukes',['Blizzara III']='GeoNukes',
	['Aera']='GeoNukes',['Aera II']='GeoNukes',['Aera III']='GeoNukes', ['Stonera']='GeoNukes',['Stonera II']='GeoNukes',['Stonera III']='GeoNukes',
	['Thundara']='GeoNukes',['Thundara II']='GeoNukes',['Thundara III']='GeoNukes', ['Watera']='GeoNukes',['Watera II']='GeoNukes',['Watera III']='GeoNukes',
	
	--- Weak Nukes
	['Stone']='MDMG',['Water']='MDMG',['Aero']='MDMG',['Fire']='MDMG',['Blizzard']='MDMG',['Thunder']='MDMG',
	['Stone II']='MDMG',['Water II']='MDMG',['Aero II']='MDMG',['Fire II']='MDMG',['Blizzard II']='MDMG',['Thunder II']='MDMG',
	['Stonega']='MDMG',['Waterga']='MDMG',['Aeroga']='MDMG',['Firaga']='MDMG',['Blizzaga']='MDMG',['Thundaga']='MDMG',
	['Pyrohelix II']='MDMG',['Cryohelix II']='MDMG',['Anemohelix II']='MDMG',['Geohelix II']='MDMG',['Ionohelix II']='MDMG',
	['Hydrohelix II']='MDMG',['Luminohelix II']='MDMG',['Noctohelix II']='MDMG',
	['Pyrohelix']='MDMG',['Cryohelix']='MDMG',['Anemohelix']='MDMG',['Geohelix']='MDMG',['Ionohelix']='MDMG',
	['Hydrohelix']='MDMG',['Luminohelix']='MDMG',['Noctohelix']='MDMG',
	
    --- Elemental Debuffs
	['Burn']='ElementalDebuff',['Frost']='ElementalDebuff',['Choke']='ElementalDebuff',['Rasp']='ElementalDebuff',
	['Shock']='ElementalDebuff',['Drown']='ElementalDebuff',
	
	---Enfeebles
	['Sleep']='Static',['Sleep II']='Static',['Sleepga']='Static',['Sleepga II']='Static',['Break']='Static',['Breakga']='Static',['Bind']='Static',
	['Gravity']='Static',['Gravity II']='Static',['Silence']='Static',['Poison']='Static',['Poisonga']='Static',
	
	--- Leeching Spells
	['Drain']='Sap',['Drain II']='Sap',['Drain III']='Sap',['Aspir']='Sap',['Aspir II']='Sap',['Aspir III']='Sap',
	['Absorb-Str']='Absorb',['Absorb-Dex']='Absorb',['Absorb-Vit']='Absorb',['Absorb-Agi']='Absorb',['Absorb-Int']='Absorb',
	['Absorb-Mnd']='Absorb',['Absorb-Chr']='Absorb',['Absorb-Acc']='Absorb',
	
	----  ~**~=~*     SONGS    ~**~=~*     SONGS    ~**~=~*     SONGS    ~**~=~*     SONGS    ~**~=~*     SONGS    ~**~=~*     SONGS    
	['Valor Minuet']='Minuet',['Valor Minuet II']='Minuet',['Valor Minuet III']='Minuet',['Valor Minuet IV']='Minuet',['Valor Minuet V']='Minuet',
    ["Knight's Minne"]='Minne',["Knight's Minne II"]='Minne',["Knight's Minne III"]='Minne', ["Knight's Minne IV"]='Minne',["Knight's Minne V"]='Minne',
    ['Advancing March']='March',['Victory March']='March',
    ['Sword Madrigal']='Madrigal',['Blade Madrigal']='Madrigal',
    ["Hunter's Prelude"]='Prelude',["Archer's Prelude"]='Prelude',
    ['Sheepfoe Mambo']='Mambo',['Dragonfoe Mambo']='Mambo',
    ['Raptor Mazurka']='Mazurka',['Chocobo Mazurka']='Mazurka',
    ['Sinewy Etude']='Etude',['Dextrous Etude']='Etude',['Vivacious Etude']='Etude',['Quick Etude']='Etude',
	['Learned Etude']='Etude',['Spirited Etude']='Etude',['Enchanting Etude']='Etude',
    ['Herculean Etude']='Etude',['Uncanny Etude']='Etude',['Vital Etude']='Etude',['Swift Etude']='Etude',
	['Sage Etude']='Etude',['Logical Etude']='Etude',['Bewitching Etude']='Etude',
    ["Mage's Ballad"]='Ballad',["Mage's Ballad II"]='Ballad',["Mage's Ballad III"]='Ballad',
    ["Army's Paeon"]='Paeon',["Army's Paeon II"]='Paeon',["Army's Paeon III"]='Paeon',["Army's Paeon IV"]='Paeon',
	["Army's Paeon V"]='Paeon',["Army's Paeon VI"]='Paeon',
    ['Fire Carol']='Carol',['Ice Carol']='Carol',['Wind Carol']='Carol',['Earth Carol']='Carol',['Lightning Carol']='Carol',
	['Water Carol']='Carol',['Light Carol']='Carol',['Dark Carol']='Carol',
    ['Fire Carol II']='Carol',['Ice Carol II']='Carol',['Wind Carol II']='Carol',['Earth Carol II']='Carol',['Lightning Carol II']='Carol',
	['Water Carol II']='Carol',['Light Carol II']='Carol',['Dark Carol II']='Carol',
    ['Foe Lullaby']='Lullaby',['Foe Lullaby II']='Lullaby',['Horde Lullaby']='Lullaby',['Horde Lullaby II']='Lullaby',
    ['Fire Threnody']='Threnody',['Ice Threnody']='Threnody',['Wind Threnody']='Threnody',['Earth Threnody']='Threnody',
	['Lightning Threnody']='Threnody',	['Water Threnody']='Threnody',['Light Threnody']='Threnody',['Dark Threnody']='Threnody',
    ['Battlefield Elegy']='Elegy',['Carnage Elegy']='Elegy',
    ['Foe Requiem']='Requiem',['Foe Requiem II']='Requiem',['Foe Requiem III']='Requiem',['Foe Requiem IV']='Requiem',
	['Foe Requiem V']='Requiem',['Foe Requiem VI']='Requiem',['Foe Requiem VII']='Requiem',
	
    ---- Ninjutsu 
	['Utsusemi: Ichi']='Utsusemi',['Utsusemi: Ni']='Utsusemi', ['Utsusemi: San']='Utsusemi',
    ['Katon: Ichi'] = 'ElementalNinjutsu',['Suiton: Ichi'] = 'ElementalNinjutsu',['Raiton: Ichi'] = 'ElementalNinjutsu',
    ['Doton: Ichi'] = 'ElementalNinjutsu',['Huton: Ichi'] = 'ElementalNinjutsu',['Hyoton: Ichi'] = 'ElementalNinjutsu',
    ['Katon: Ni'] = 'ElementalNinjutsu',['Suiton: Ni'] = 'ElementalNinjutsu',['Raiton: Ni'] = 'ElementalNinjutsu',
    ['Doton: Ni'] = 'ElementalNinjutsu',['Huton: Ni'] = 'ElementalNinjutsu',['Hyoton: Ni'] = 'ElementalNinjutsu',
    ['Katon: San'] = 'ElementalNinjutsu',['Suiton: San'] = 'ElementalNinjutsu',['Raiton: San'] = 'ElementalNinjutsu',
    ['Doton: San'] = 'ElementalNinjutsu',['Huton: San'] = 'ElementalNinjutsu',['Hyoton: San'] = 'ElementalNinjutsu',

	--- Runes
	['Lux']='Rune',['Tenebrae']='Rune',['Ignis']='Rune',['Gelus']='Rune',['Flabra']='Rune',['Tellus']='Rune',['Sulpor']='Rune',['Unda']='Rune',
	
	--- Maneuvers
	['Fire Maneuver']='Maneuver',['Ice Maneuver']='Maneuver',['Wind Maneuver']='Maneuver',['Earth Maneuver']='Maneuver',
	['Thunder Maneuver']='Maneuver',['Water Maneuver']='Maneuver',['Light Maneuver']='Maneuver',['Dark Maneuver']='Maneuver',
	
	----  ~**~=~*     BLUE MAGIC    ~**~=~*     BLUE MAGIC    ~**~=~*     BLUE MAGIC    ~**~=~*     BLUE MAGIC    ~**~=~*     BLUE MAGIC    ~**~=~*     BLUE MAGIC  
	
	--- Heals
	['Pollen']='Cures',['Wild Carrot']='Cures',['Magic Fruit']='Cures',['Plenilune Embrace']='Cures',['Restoral']='Cures',['Healing Breeze']='Cures',['White Wind']='Cures',
	
	--- Buffs
	['Cocoon']='Buffs',['Refueling']='Buffs',['Feather Barrier']='Buffs',['Memento Mori']='Buffs',['Zephyr Mantle']='Buffs',['Warm-Up']='Buffs',['Amplification']='Buffs',
	['Regeneration']='Buffs',['Saline Coat']='Buffs',['Reactor Cool']='Buffs',['Plasma Charge']='Buffs',['Animating Wail']='Buffs',['Magic Barrier']='Buffs',
	['Occultation']='Buffs',['Barrier Tusk']='Buffs',['O. Counterstance']='Buffs',['Harden Shell']='Buffs',['Pyric Bulwark']='Buffs',['Nat. Meditation']='Buffs',
	['Carcharian Verve']='Buffs',['Erratic Flutter']='Buffs',['Mighty Guard']='Buffs',['Triumphant Roar']='Buffs',
	
	--- Skill-Based
	['Metallic Body']='BlueSkin',['Diamondhide']='BlueSkin',
	
	--- Additional Effects
	['Sprout Smack']='AddEffect',['Head Butt']='AddEffect',['Pinecone Bomb']='AddEffect',['Terror Touch']='AddEffect',['Spiral Spin']='AddEffect',
	['Seedspray']='AddEffect',['Frypan']='Physical',['Tail Slap']='AddEffect',['Sub-zero Smash']='AddEffect',['Whirl of Rage']='Physical',
	['Benthic Typhoon']='AddEffect',['Sudden Lunge']='AddEffect',['Barbed Crescent']='AddEffect',['Sweeping Gouge']='AddEffect',
	['Saurian Slide']='AddEffect',['Tourbillion']='AddEffect',['Bilgestorm']='AddEffect',
	
	--- Physical Damage
	['Foot Kick']='Physical',['Power Attack']='Physical',['Wild Oats']='Physical',['Queasyshroom']='Physical',['Battle Dance']='Physical',['Feather Storm']='Physical',
	['Helldive']='Physical',['Bludgeon']='Physical',['Claw Cyclone']='Physical',['Screwdriver']='Physical',['Grand Slam']='Physical',['Smite of Rage']='Physical',
	['Jet Stream']='Physical',['Uppercut']='Physical',['Mandibular Bite']='Physical',['Sickle Slash']='Physical',['Death Scissors']='Physical',
	['Dimensional Death']='Physical',['Body Slam']='Physical',['Spinal Cleave']='Physical',['Frenetic Rip']='Physical',['Hydro Shot']='Physical',
	['Hysteric Barrage']='Physical',['Asuran Claws']='Physical',['Cannonball']='Physical',['Disseverment']='Physical',['Ram Charge']='Physical',
	['Vertical Cleave']='Physical',['Final Sting']='Physical',['Goblin Rush']='Physical',['Vanity Dive']='Physical',['Quad. Continuum']='Physical',
	['Delta Thrust']='Physical',['Heavy Strike']='Physical',['Quadrastrike']='Physical',['Amorphic Spikes']='Physical',['Bloodrake']='Physical',
	['Paralyzing Triad']='Physical',['Glutinous Dart']='Physical',['Thrashing Assault']='Physical',['Sinker Drill']='Physical',
	
	--- Magical Damage
	['Sandspin']='Magical',['Cursed Sphere']='Magical',['Blastbomb']='Magical',['Bomb Toss']='Magical',['Mysterious Light']='Magical',['Blitzstrahl']='Magical',
	['Ice Break']='Magical',['Self-Destruct']='Magical',['Maelstrom']='Magical',['1000 Needles']='Magical',['Corrosive Ooze']='Magical',['Firespit']='Magical',
	['Regurgitation']='Magical',['Mind Blast']='Magical',['Acrid Stream']='Magical',['Leafstorm']='Magical',['Blazing Bound']='Magical',['Thermal Pulse']='Magical',
	['Charged Whisker']='Magical',['Water Bomb']='Magical',['Thunderbolt']='Magical',['Gates of Hades']='Magical',['Droning Whirlwind']='Magical',
	['Tempestuous Upheaval']='Magical',['Rending Deluge']='Magical',['Embalming Earth']='Magical',['Nectarous Deluge']='Magical',['Foul Waters']='Magical',
	['Subduction']='Magical',['Uproot']='Magical',['Crashing Thunder']='Magical',['Polar Roar']='Magical',['Molting Plumage']='Magical',['Searing Tempest']='Magical',
	['Spectral Floe']='Magical',['Scouring Spate']='Magical',['Anvil Lightning']='Magical',['Silent Storm']='Magical',['Entomb']='Magical',
	
	--- Dark Magic Damage
	['Death Ray']='Darkness',['Eyes On Me']='Darkness',['Evryone. Grudge']='Darkness',['Dark Orb']='Darkness',['Palling Salvo']='Darkness',['Tenebral Crush']='Darkness',
	
	--- Light Magic Damage
	['Magic Hammer']='Brightness',['Retinal Glare']='Brightness',['Rail Cannon']='Brightness',['Diffusion Ray']='Brightness',['Blinding Fulgor']='Brightness',
	
	--- Draining 
	['Blood Drain']='BlueDrain',['Digest']='BlueDrain',['MP Drainkiss']='BlueDrain',['Blood Saber']='BlueDrain',['Atra. Libations']='BlueDrain',
	
	--- Breath
	['Poison Breath']='Breath',['Magnetite Cloud']='Breath',['Hecatomb Wave']='Breath',['Radiant Breath']='Breath',['Flying Hip Press']='Breath',['Bad Breath']='Breath', 
	['Frost Breath']='Breath',['Heat Breath']='Breath',['Vapor Spray']='Breath',['Thunder Breath']='Breath',['Wind Breath']='Breath',
	
	--- Debuffs
	['Filamented Hold']='Debuffs',['Cimicine Discharge']='Debuffs',['Demoralizing Roar']='Debuffs',['Venom Shell']='Debuffs',
	['Light of Penance']='Debuffs',	['Sandspray']='Debuffs', ['Auroral Drape']='Debuffs',['Frightful Roar']='Debuffs',['Enervation']='Debuffs',
	['Infrasonics']='Debuffs',	['Lowing']='Debuffs',['Cold Wave']='Debuffs',['Awful Eye']='Debuffs',['Sheep Song']='Debuffs',['Soporific']='Debuffs',
	['Yawn']='Debuffs',['Dream Flower']='Debuffs',['Chaotic Eye']='Debuffs',['Sound Blast']='Debuffs',['Blank Gaze']='Debuffs',
	['Stinking Gas']='Debuffs',['Geist Wall']='Debuffs',['Jettatura']='Debuffs',['Feather Tickle']='Debuffs',['Temporal Shift']='Debuffs',
	['Reaving Wind']='Debuffs',['Mortal Ray']='Debuffs',['Absolute Terror']='Debuffs',['Blistering Roar']='Debuffs',['Voracious Trunk']='Debuffs'
}

-------------------------------------------------------------------------------------------------------------------
-- Tables to specify general area groupings.  Creates the 'areas' table to be referenced in job files.
-- Zone names provided by world.area/world.zone are currently in all-caps, so defining the same way here.
-------------------------------------------------------------------------------------------------------------------

areas = {}

-- City areas for town gear and behavior.
areas.Cities = 
S{
    "Ru'Lude Gardens", "Upper Jeuno", "Lower Jeuno", "Port Jeuno",
    "Port Windurst",  "Windurst Waters", "Windurst Woods", "Windurst Walls", "Heavens Tower", "Windurst Waters [S]",
    "Port San d'Oria", "Northern San d'Oria", "Southern San d'Oria", "Southern San d'Oria [S]",
    "Port Bastok", "Bastok Markets", "Bastok Mines", "Metalworks", "Bastok Markets [S]",
    "Selbina",
    "Mhaura",
    "Norg",
    "Kazham",
	"Rabao",
	"Tavnazian Safehold", "Sealion's Den",
    "Aht Urhgan Whitegate",
	"Nashmau"
}

areas.Adoulin =
S{
    "Eastern Adoulin", "Western Adoulin",
}

