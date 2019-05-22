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
    ['Water']="Rainstorm", ['Wind']="Windstorm", ['Ice']="Hailstorm", ['Lightning']="Thunderstorm",['Light']="Aurorastorm II",
	['Dark']="Voidstorm II", ['Fire']="Firestorm II", ['Earth']="Sandstorm II", ['Water']="Rainstorm II", ['Wind']="Windstorm II",
	['Ice']="Hailstorm II", ['Lightning']="Thunderstorm II"
}

spirits = 
S{
	"LightSpirit", "DarkSpirit", "FireSpirit", "EarthSpirit", "WaterSpirit", "AirSpirit", "IceSpirit", "ThunderSpirit"
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


-- Elements for skillchain names
skillchain_elements = {}
skillchain_elements.Light = S{'Light','Fire','Wind','Lightning'}
skillchain_elements.Darkness = S{'Dark','Ice','Earth','Water'}
skillchain_elements.Fusion = S{'Light','Fire'}
skillchain_elements.Fragmentation = S{'Wind','Lightning'}
skillchain_elements.Distortion = S{'Ice','Water'}
skillchain_elements.Gravitation = S{'Dark','Earth'}
skillchain_elements.Transfixion = S{'Light'}
skillchain_elements.Compression = S{'Dark'}
skillchain_elements.Liquification = S{'Fire'}
skillchain_elements.Induration = S{'Ice'}
skillchain_elements.Detonation = S{'Wind'}
skillchain_elements.Scission = S{'Earth'}
skillchain_elements.Impaction = S{'Lightning'}
skillchain_elements.Reverberation = S{'Water'}


-------------------------------------------------------------------------------------------------------------------
-- Mappings for weaponskills
-------------------------------------------------------------------------------------------------------------------

-- REM weapons and their corresponding weaponskills
data = {}

data.weaponskills = {}

data.weaponskills.relic = 
{
    ["Spharai"] = "Final Heaven",
    ["Mandau"] = "Mercy Stroke",
    ["Excalibur"] = "Knights of Round",
    ["Ragnarok"] = "Scourge",
    ["Guttler"] = "Onslaught",
    ["Bravura"] = "Metatron Torment",
    ["Apocalypse"] = "Catastrophe",
    ["Gungnir"] = "Gierskogul",
    ["Kikoku"] = "Blade: Metsu",
    ["Amanomurakumo"] = "Tachi: Kaiten",
    ["Mjollnir"] = "Randgrith",
    ["Claustrum"] = "Gates of Tartarus",
    ["Annihilator"] = "Coronach",
    ["Yoichinoyumi"] = "Namas Arrow"
}

data.weaponskills.mythic = 
{
    ["Conqueror"] = "King's Justice",
    ["Glanzfaust"] = "Ascetic's Fury",
    ["Yagrush"] = "Mystic Boon",
    ["Laevateinn"] = "Vidohunir",
    ["Murgleis"] = "Death Blossom",
    ["Vajra"] = "Mandalic Stab",
    ["Burtgang"] = "Atonement",
    ["Liberator"] = "Insurgency",
    ["Aymur"] = "Primal Rend",
    ["Carnwenhan"] = "Mordant Rime",
    ["Gastraphetes"] = "Trueflight",
    ["Kogarasumaru"] = "Tachi: Rana",
    ["Nagi"] = "Blade: Kamu",
    ["Ryunohige"] = "Drakesbane",
    ["Nirvana"] = "Garland of Bliss",
    ["Tizona"] = "Expiacion",
    ["Death Penalty"] = "Leaden Salute",
    ["Kenkonken"] = "Stringing Pummel",
    ["Terpsichore"] = "Pyrrhic Kleos",
    ["Tupsimati"] = "Omniscience",
    ["Idris"] = "Exudation",
    ["Epeolatry"] = "Dimidiation"
}

data.weaponskills.empyrean = 
{
    ["Verethragna"] = "Victory Smite",
    ["Twashtar"] = "Rudra's Storm",
    ["Almace"] = "Chant du Cygne",
    ["Caladbolg"] = "Torcleaver",
    ["Farsha"] = "Cloudsplitter",
    ["Ukonvasara"] = "Ukko's Fury",
    ["Redemption"] = "Quietus",
    ["Rhongomiant"] = "Camlann's Torment",
    ["Kannagi"] = "Blade: Hi",
    ["Masamune"] = "Tachi: Fudo",
    ["Gambanteinn"] = "Dagann",
    ["Hvergelmir"] = "Myrkr",
    ["Gandiva"] = "Jishnu's Radiance",
    ["Armageddon"] = "Wildfire"
}

-- Weaponskills that can be used at range.
data.weaponskills.ranged = 
S{
	"Flaming Arrow", "Piercing Arrow", "Dulling Arrow", "Sidewinder", "Arching Arrow",
    "Empyreal Arrow", "Refulgent Arrow", "Apex Arrow", "Namas Arrow", "Jishnu's Radiance",
    "Hot Shot", "Split Shot", "Sniper Shot", "Slug Shot", "Heavy Shot", "Detonator", "Last Stand",
    "Coronach", "Trueflight", "Leaden Salute", "Wildfire",
    "Myrkr"
}

ranged_weaponskills = data.weaponskills.ranged

-------------------------------------------------------------------------------------------------------------------
-- Spell mappings allow defining a general category or description that each of sets of related
-- spells all fall under.
-------------------------------------------------------------------------------------------------------- -----------

spell_maps = {
    ---- Healing Spells
	['Cure']='Cures',['Cure II']='Cures',['Cure III']='Cures',['Cure IV']='Cures',['Cure V']='Cures',['Cure VI']='Cures', ['Full Cure']='Cures',
	['Cura']='Curagas',['Cura II']='Curagas',['Cura III']='Curagas',
    ['Curaga']='Curagas',['Curaga II']='Curagas',['Curaga III']='Curagas',['Curaga IV']='Curagas',['Curaga V']='Curagas',
    ---- Status Effect Removal	
	['Poisona']='StatusRemoval',['Paralyna']='StatusRemoval',['Silena']='StatusRemoval',['Blindna']='StatusRemoval',['Cursna']='StatusRemoval',
    ['Stona']='StatusRemoval',['Viruna']='StatusRemoval',['Erase']='StatusRemoval',
	--- Raise
	['Raise']='Raise',['Raise II']='Raise',['Raise III']='Raise',['Arise']='Raise',
    ---- Reraise
	['Reraise']='Reraise',['Reraise II']='Reraise',['Reraise III']='Reraise',['Reraise IV']='Reraise',
    ---- Barspells	
	['Barfire']='BarElement',['Barstone']='BarElement',['Barwater']='BarElement',['Baraero']='BarElement',['Barblizzard']='BarElement',['Barthunder']='BarElement',
    ['Barfira']='BarElement',['Barstonra']='BarElement',['Barwatera']='BarElement',['Baraera']='BarElement',['Barblizzara']='BarElement',['Barthundra']='BarElement',
	['Barsleepra']='BarStatus',['Barpoisonra']='BarStatus',['Barparalyzra']='BarStatus',['Barblindra']='BarStatus',['Barsilencera']='BarStatus',
	['Barpetra']='BarStatus',['Barvira']='BarStatus',['Baramnesra']='BarStatus',
	['Barsleep']='BarStatus',['Barpoison']='BarStatus',['Barparalyze']='BarStatus',['Barblind']='BarStatus',['Barsilence']='BarStatus',
	['Barpetrify']='BarStatus',['Barvirus']='BarStatus',['Baramnesia']='BarStatus',
	---- Boost/Gain
	['Boost-STR']='BoostStat',['Boost-DEX']='BoostStat',['Boost-VIT']='BoostStat',['Boost-AGI']='BoostStat',
	['Boost-INT']='BoostStat',['Boost-MND']='BoostStat',['Boost-CHR']='BoostStat',
    ['Gain-STR']='GainStat',['Gain-DEX']='GainStat',['Gain-VIT']='GainStat',['Gain-AGI']='GainStat',
	['Gain-INT']='GainStat',['Gain-MND']='GainStat',['Gain-CHR']='GainStat',
	---- Enspells	
	['Enfire']='Enspells',['Enfire II']='Enspells',['Enblizzard']='Enspells',['Enblizzard II']='Enspells',['Enaero']='Enspells',['Enaero II']='Enspells',
	['Enstone']='Enspells',['Enstone II']='Enspells',['Enthunder']='Enspells',['Enthunder II']='Enspells',['Enwater']='Enspells',['Enwater II']='Enspells',
	['Temper']='Enspells',['Temper II']='Enspells',
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
	['Retrace']='Teleport',['Warp']='Teleport',['Warp II']='Teleport',['Escape']='Teleport',
    --- Divine Nukes
	['Banish']='DivineNuke',['Banish II']='DivineNuke',['Banish III']='DivineNuke',['Banishga']='DivineNuke',['Banishga II']='DivineNuke',
	['Holy']='DivineNuke',['Holy II']='DivineNuke',
    --- Helices
	['Pyrohelix II']='Helix',['Cryohelix II']='Helix',['Anemohelix II']='Helix',['Geohelix II']='Helix',['Ionohelix II']='Helix',
	['Hydrohelix II']='Helix',['Luminohelix II']='Helix',['Noctohelix II']='Helix',
	['Pyrohelix']='Helix',['Cryohelix']='Helix',['Anemohelix']='Helix',['Geohelix']='Helix',['Ionohelix']='Helix',
	['Hydrohelix']='Helix',['Luminohelix']='Helix',['Noctohelix']='Helix',
	--- Geomancer Nukes
	['Fira']='GeoNukes',['Fira II']='GeoNukes',['Fira III']='GeoNukes', ['Blizzara']='GeoNukes',['Blizzara II']='GeoNukes',['Blizzara III']='GeoNukes',
	['Aera']='GeoNukes',['Aera II']='GeoNukes',['Aera III']='GeoNukes', ['Stonera']='GeoNukes',['Stonera II']='GeoNukes',['Stonera III']='GeoNukes',
	['Thundara']='GeoNukes',['Thundara II']='GeoNukes',['Thundara III']='GeoNukes', ['Watera']='GeoNukes',['Watera II']='GeoNukes',['Watera III']='GeoNukes',
    --- Elemental Debuffs
	['Burn']='ElementalDebuff',['Frost']='ElementalDebuff',['Choke']='ElementalDebuff',['Rasp']='ElementalDebuff',['Shock']='ElementalDebuff',['Drown']='ElementalDebuff',
	---Enfeebles
	['Sleep']='Static',['Sleep II']='Static',['Sleepga']='Static',['Sleepga II']='Static',['Break']='Static',['Breakga']='Static',['Bind']='Static',
	['Gravity']='Static',['Gravity II']='Static',['Silence']='Static',
	['Distract II']='ESkill',['Distract III']='ESkill',['Frazzle II']='ESkill',['Frazzle III']='ESkill',['Poison II']='ESkill',
	--- Leeching Spells
	['Drain']='Sap',['Drain II']='Sap',['Drain III']='Sap',['Aspir']='Sap',['Aspir II']='Sap',['Aspir III']='Sap',
	['Absorb-Str']='Absorb',['Absorb-Dex']='Absorb',['Absorb-Vit']='Absorb',['Absorb-Agi']='Absorb',['Absorb-Int']='Absorb',['Absorb-Mnd']='Absorb',['Absorb-Chr']='Absorb',
    ['Absorb-Acc']='Absorb',
    ---- Songs
	['Valor Minuet']='Minuet',['Valor Minuet II']='Minuet',['Valor Minuet III']='Minuet',['Valor Minuet IV']='Minuet',['Valor Minuet V']='Minuet',
    ["Knight's Minne"]='Minne',["Knight's Minne II"]='Minne',["Knight's Minne III"]='Minne',["Knight's Minne IV"]='Minne',["Knight's Minne V"]='Minne',
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
    ["Army's Paeon"]='Paeon',["Army's Paeon II"]='Paeon',["Army's Paeon III"]='Paeon',["Army's Paeon IV"]='Paeon',["Army's Paeon V"]='Paeon',["Army's Paeon VI"]='Paeon',
    ['Fire Carol']='Carol',['Ice Carol']='Carol',['Wind Carol']='Carol',['Earth Carol']='Carol',['Lightning Carol']='Carol',
	['Water Carol']='Carol',['Light Carol']='Carol',['Dark Carol']='Carol',
    ['Fire Carol II']='Carol',['Ice Carol II']='Carol',['Wind Carol II']='Carol',['Earth Carol II']='Carol',['Lightning Carol II']='Carol',
	['Water Carol II']='Carol',['Light Carol II']='Carol',['Dark Carol II']='Carol',
    ['Foe Lullaby']='Lullaby',['Foe Lullaby II']='Lullaby',['Horde Lullaby']='Lullaby',['Horde Lullaby II']='Lullaby',
    ['Fire Threnody']='Threnody',['Ice Threnody']='Threnody',['Wind Threnody']='Threnody',['Earth Threnody']='Threnody',['Lightning Threnody']='Threnody',
	['Water Threnody']='Threnody',['Light Threnody']='Threnody',['Dark Threnody']='Threnody',
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
	['Fire Maneuver']='Maneuver',['Ice Maneuver']='Maneuver',['Wind Maneuver']='Maneuver',['Earth Maneuver']='Maneuver',['Thunder Maneuver']='Maneuver',
	['Water Maneuver']='Maneuver',['Light Maneuver']='Maneuver',['Dark Maneuver']='Maneuver',
	
	----  ~**~=~*     BLUE MAGIC    ~**~=~*     BLUE MAGIC    ~**~=~*     BLUE MAGIC    ~**~=~*     BLUE MAGIC    ~**~=~*     BLUE MAGIC    ~**~=~*     BLUE MAGIC    
	--- Heals
	['Pollen']='Cures',['Wild Carrot']='Cures',['Magic Fruit']='Cures',['Plenilune Embrace']='Cures',['Restoral']='Cures',['Healing Breeze']='Cures',['White Wind']='Cures',
	--- Buffs
	['Cocoon']='Buffs',['Refueling']='Buffs',['Feather Barrier']='Buffs',['Memento Mori']='Buffs',['Zephyr Mantle']='Buffs',['Warm-Up']='Buffs',['Amplification']='Buffs',
	['Regeneration']='Buffs',['Saline Coat']='Buffs',['Reactor Cool']='Buffs',['Plasma Charge']='Buffs',['Animating Wail']='Buffs',['Magic Barrier']='Buffs',
	['Barrier Tusk']='Buffs',['O. Counterstance']='Buffs',['Harden Shell']='Buffs',['Pyric Bulwark']='Buffs',['Nat. Meditation']='Buffs',['Carcharian Verve']='Buffs',
	['Erratic Flutter']='Buffs',['Mighty Guard']='Buffs',['Triumphant Roar']='Buffs',
	--- Skill-Based
	['Metallic Body']='BlueSkill',['Diamondhide']='BlueSkill',['Magic Barrier']='BlueSkill',['Occultation']='BlueSkill',
	--- Additional Effects
	['Sprout Smack']='AddEffect',['Head Butt']='AddEffect',['Pinecone Bomb']='AddEffect',['Terror Touch']='AddEffect',['Spiral Spin']='AddEffect',
	['Seedspray']='AddEffect',['Frypan']='AddEffect',['Tail Slap']='AddEffect',['Sub-zero Smash']='AddEffect',['Whirl of Rage']='AddEffect',
	['Benthic Typhoon']='AddEffect',['Sudden Lunge']='AddEffect',['Barbed Crescent']='AddEffect',['Sweeping Gouge']='AddEffect',
	['Saurian Slide']='AddEffect',['Tourbillion']='AddEffect',['Bilgestorm']='AddEffect',
	--- Physical Damage
	['Foot Kick']='Physical',['Power Attack']='Physical',['Wild Oats']='Physical',['Queasyshroom']='Physical',['Battle Dance']='Physical',
	['Helldive']='Physical',['Bludgeon']='Physical',['Claw Cyclone']='Physical',['Screwdriver']='Physical',['Grand Slam']='Physical',['Smite of Rage']='Physical',
	['Jet Stream']='Physical',['Uppercut']='Physical',['Mandibular Bite']='Physical',['Sickle Slash']='Physical',['Death Scissors']='Physical',
	['Dimensional Death']='Physical',['Body Slam']='Physical',['Spinal Cleave']='Physical',['Frenetic Rip']='Physical',['Hydro Shot']='Physical',
	['Hysteric Barrage']='Physical',['Asuran Claws']='Physical',['Cannonball']='Physical',['Disseverment']='Physical',['Ram Charge']='Physical',
	['Vertical Cleave']='Physical',['Final Sting']='Physical',['Goblin Rush']='Physical',['Vanity Dive']='Physical',['Quad. Continuum']='Physical',
	['Delta Thrust']='Physical',['Heavy Strike']='Physical',['Quadrastrike']='Physical',['Amorphic Spikes']='Physical',['Bloodrake']='Physical',
	['Paralyzing Triad']='Physical',['Glutinous Dart']='Physical',['Thrashing Assault']='Physical',['Sinker Drill']='Physical',['Feather Storm']='Physical',
	--- Magical Damage
	['Sandspin']='Magical',['Cursed Sphere']='Magical',['Blastbomb']='Magical',['Bomb Toss']='Magical',['Mysterious Light']='Magical',['Blitzstrahl']='Magical',
	['Ice Break']='Magical',['Self-Destruct']='Magical',['Maelstrom']='Magical',['1000 Needles']='Magical',['Corrosive Ooze']='Magical',['Firespit']='Magical',
	['Regurgitation']='Magical',['Mind Blast']='Magical',['Acrid Stream']='Magical',['Leafstorm']='Magical',['Blazing Bound']='Magical',['Thermal Pulse']='Magical',
	['Charged Whisker']='Magical',['Water Bomb']='Magical',['Thunderbolt']='Magical',['Gates of Hades']='Magical',['Droning Whirlwind']='Magical',
	['Tempestuous Upheaval']='Magical',['Rending Deluge']='Magical',['Embalming Earth']='Magical',['Nectarous Deluge']='Magical',['Foul Waters']='Magical',
	['Subduction']='Magical',['Uproot']='Magical',['Crashing Thunder']='Magical',['Polar Roar']='Magical',['Molting Plumage']='Magical',['Searing Tempest']='Magical',
	['Spectral Floe']='Magical',['Scouring Spate']='Magical',['Anvil Lightning']='Magical',['Silent Storm']='Magical',['Entomb']='Magical',
	--- Dark Magic Damage
	['Death Ray']='DarkBlue',['Eyes On Me']='DarkBlue',['Evryone. Grudge']='DarkBlue',['Dark Orb']='DarkBlue',['Palling Salvo']='DarkBlue',['Tenebral Crush']='DarkBlue',
	--- Light Magic Damage
	['Magic Hammer']='LightBlue',['Retinal Glare']='LightBlue',['Rail Cannon']='LightBlue',['Diffusion Ray']='LightBlue',['Blinding Fulgor']='LightBlue',
	--- Draining 
	['Blood Drain']='BlueDrain',['Digest']='BlueDrain',['MP Drainkiss']='BlueDrain',['Blood Saber']='BlueDrain',['Atra. Libations']='BlueDrain',
	--- Breath
	['Poison Breath']='Breath',['Magnetite Cloud']='Breath',['Hecatomb Wave']='Breath',['Radiant Breath']='Breath',['Flying Hip Press']='Breath',['Bad Breath']='Breath', 
	['Frost Breath']='Breath',['Heat Breath']='Breath',['Vapor Spray']='Breath',['Thunder Breath']='Breath',['Wind Breath']='Breath',
	--- Debuffs
	['Filamented Hold']='Debuffs',['Cimicine Discharge']='Debuffs',['Demoralizing Roar']='Debuffs',['Venom Shell']='Debuffs',['Light of Penance']='Debuffs',
	['Sandspray']='Debuffs', ['Auroral Drape']='Debuffs',['Frightful Roar']='Debuffs',['Enervation']='Debuffs',['Infrasonics']='Debuffs',['Lowing']='Debuffs',
	['Cold Wave']='Debuffs',['Awful Eye']='Debuffs',['Sheep Song']='Debuffs',['Soporific']='Debuffs',['Yawn']='Debuffs',['Dream Flower']='Debuffs',['Chaotic Eye']='Debuffs',
	['Sound Blast']='Debuffs',['Blank Gaze']='Debuffs',['Stinking Gas']='Debuffs',['Geist Wall']='Debuffs',['Jettatura']='Debuffs',['Feather Tickle']='Debuffs',
	['Temporal Shift']='Debuffs',['Reaving Wind']='Debuffs',['Mortal Ray']='Debuffs',['Absolute Terror']='Debuffs',['Blistering Roar']='Debuffs',['Voracious Trunk']='Debuffs'
}

-------------------------------------------------------------------------------------------------------------------
-- Tables to specify general area groupings.  Creates the 'areas' table to be referenced in job files.
-- Zone names provided by world.area/world.zone are currently in all-caps, so defining the same way here.
-------------------------------------------------------------------------------------------------------------------

areas = {}

-- City areas for town gear and behavior.
areas.Cities = 
S{
    "Ru'Lude Gardens",
    "Upper Jeuno",
    "Lower Jeuno",
    "Port Jeuno",
    "Port Windurst",
    "Windurst Waters",
    "Windurst Woods",
    "Windurst Walls",
    "Heavens Tower",
    "Port San d'Oria",
    "Northern San d'Oria",
    "Southern San d'Oria",
    "Port Bastok",
    "Bastok Markets",
    "Bastok Mines",
    "Metalworks",
    "Aht Urhgan Whitegate",
    "Tavnazian Safehold",
    "Nashmau",
    "Selbina",
    "Mhaura",
    "Norg",
    "Kazham",
	"Sealion's Den"
}

areas.Adoulin =
S{
    "Eastern Adoulin",
    "Western Adoulin",
}