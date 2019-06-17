-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

--[[
		Custom commands:

		Shorthand versions for each strategem type that uses the version appropriate for
		the current Arts.

										Light Arts				Dark Arts

		gs c scholar cost				Penury					Parsimony
		gs c scholar speed				Celerity				Alacrity
		gs c scholar aoe				Accession				Manifestation
		gs c scholar power				Rapture					Ebullience
		gs c scholar duration			Perpetuance
		gs c scholar accuracy			Altruism				Focalization
		gs c scholar enmity				Tranquility				Equanimity
		gs c scholar skillchain									Immanence
		gs c scholar addendum			Addendum: White			Addendum: Black
--]]

-- Initialization function for this job file.
function get_sets()
	mote_include_version = 2
	-- Load and initialize the include file.
	include('Mote-Include.lua')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
	state.Buff['Sublimation: Activated'] = buffactive['Sublimation: Activated'] or false
	update_active_strategems()
	state.HelixMode = M{['description']='Helix Mode', 'Lughs', 'Bookworm'}
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	-- Options: Override default values state.
	state.CastingMode:options('Normal','ConserveMP','MACC')
	state.OffenseMode:options('Normal','Refresh','DD')
	state.PhysicalDefenseMode:options('PDT','PDT2')
	state.MagicalDefenseMode:options('MDT','MEVA')
	state.IdleMode:options('Normal','Sublimation','ZendikMAB')
	
	send_command('bind ^q gs c cycle CastingMode')
	send_command('bind ^f11 gs c cycle MagicalDefenseMode')
	send_command('bind ^g input /recast Stratagems <me>')
	send_command('bind ^e input /ja Ebullience <me>')
	send_command('bind ^i input /ja Immanence <me>')
	send_command('bind ^a input /ja Alacrity <me>')
	send_command('bind ^k input /ma Klimaform <me>')
	send_command('bind ^h input /ma Haste <me>')
	send_command('bind ^, input /ma Blink <me>')
	send_command('bind ^. input /ma Stoneskin <me>')
	send_command('bind ^/ input /ma Phalanx <me>')
	send_command('bind ^c input /ma "Cure IV" <me>')
	send_command('bind ^d input /ma Diaga <t>')
	send_command('bind ^s input /ma "Sleep II" <t>')
	send_command('bind ^t input /ma "Thunderstorm II" <me>')
	send_command('bind ^y input /ma "Hailstorm II" <me>')
	send_command('bind ^o input /ws Omniscience <t>')
	send_command('bind ^m input /ws Myrkr <me>')
	send_command('bind ^b input /ma "Water II" <t>')
	send_command('bind ^n input /ma "Thunder II" <t>')
	send_command('bind ^- input /ma Stun <t>')
	send_command('bind !p input /ja Perpetuance <me>')
	send_command('bind !t input /ma "Firestorm II" <me>')
	send_command('bind !y input /ma "Windstorm II" <me>')
	send_command('bind !r input /ma "Regen V" <me>')
	send_command('bind !a input /ma Aquaveil <me>')
	send_command('bind !n input /ma "Blizzard II" <t>')
	send_command('bind !f input /ma "Fire II" <t>')
	send_command('bind !, input /item "Panacea" <me>')
	send_command('bind !. input /item Remedy <me>')
	send_command('bind !/ input /item "Holy Water" <me>')
	send_command('bind !q gs c toggle MagicBurst')
	send_command('bind !l input /ma "Utsusemi: Ichi" <me>')
	send_command('bind !; input /ma "Utsusemi: Ni" <me>')
	send_command('bind @q gs c cycle HelixMode')

	state.MagicBurst = M(false, 'Magic Burst')
				   
	info.addendumNukes = info.high_nukes
	target_distance = 14
	gear.MovementFeet = {name="Gendewitha Galoshes +1"}
    gear.DayFeet = "Gendewitha Galoshes +1"
    gear.NightFeet = "Hippomenes Socks +1"
    
    select_movement_feet()
	   
end

function user_unload()
	send_command('unbind ^`')
end

-- Define sets and vars used by this job file.
function init_gear_sets()
	gear.NukingHead= {name="Merlinic Hood", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','Magic burst dmg.+3%','INT+8','Mag. Acc.+15','"Mag.Atk.Bns."+10',}}
	gear.IdleHead= {name="Merlinic Hood", augments={'MND+4','"Fast Cast"+1','"Refresh"+2',}}
	gear.IdleHands = {name="Merlinic Dastanas", augments={'Pet: Mag. Acc.+27','Potency of "Cure" effect received+1%','"Refresh"+1','Mag. Acc.+9 "Mag.Atk.Bns."+9',}}	
	gear.IdleLegs = {name="Merlinic Shalwar", augments={'INT+9','Chance of successful block +1','"Refresh"+2','Mag. Acc.+5 "Mag.Atk.Bns."+5',}}
	gear.MBLegs = {name="Merlinic Shalwar", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','Magic burst dmg.+11%','MND+6','Mag. Acc.+13','"Mag.Atk.Bns."+2',}}
	gear.HelixCape = {name="Bookworm's Cape", augments={'INT+4','MND+2','Helix eff. dur. +20',}}
	gear.RegenCape = {name="Bookworm's Cape", augments={'INT+1','MND+3','Helix eff. dur. +18','"Regen" potency+10',}}
	gear.RegenBody = {name="Telchine Chasuble", augments={'Pet: "Mag.Atk.Bns."+18','"Conserve MP"+3','"Regen" potency+3',}}
	gear.RegenLegs = {name="Telchine Braconi", augments={'Rng.Atk.+7','"Fast Cast"+4','"Regen" potency+3',}}
	gear.RegenFeet = {name="Telchine Pigaches", augments={'Evasion+14','"Conserve MP"+4','"Regen" potency+3',}}
	gear.PetRegenBody = {name="Telchine Chasuble", augments={'Mag. Evasion+19','Pet: "Regen"+3','Enh. Mag. eff. dur. +10',}}
	gear.PetRegenLegs = {name="Telchine Braconi", augments={'Mag. Evasion+24','Pet: "Regen"+3',}}
	gear.CuringHat = {name="Gende. Caubeen +1", augments={'Phys. dmg. taken -3%','"Cure" potency +6%',}}
	gear.CuringHands = {name="Telchine Gloves", augments={'Evasion+20','"Cure" potency +7%','Enh. Mag. eff. dur. +10',}}
	gear.CuringCape = {name="Lugh's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Cure" potency +10%','Mag. Evasion+15',}}
	gear.CMPHead = {name="Telchine Cap", augments={'Accuracy+12 Attack+12','Potency of "Cure" effect received+6%','Enh. Mag. eff. dur. +10',}}
	gear.CMPHands = {name="Telchine Gloves", augments={'Evasion+17','Potency of "Cure" effect received+7%','INT+7 MND+7',}}
	gear.CMPLegs = {name="Telchine Braconi", augments={'DEF+15','Potency of "Cure" effect received+7%','Enh. Mag. eff. dur. +10',}}
	gear.CMPFeet = {name="Telchine Pigaches", augments={'DEF+7','Potency of "Cure" effect received+7%','Enh. Mag. eff. dur. +10',}}
	gear.DrainBody = {name="Merlinic Jubbah", augments={'Mag. Acc.+14 "Mag.Atk.Bns."+14','"Drain" and "Aspir" potency +10','Mag. Acc.+14','"Mag.Atk.Bns."+5',}}
	gear.DrainHands = {name="Merlinic Dastanas", augments={'Mag. Acc.+25','"Drain" and "Aspir" potency +10','INT+6',}}
	gear.DrainLegs = {name="Merlinic Shalwar", augments={'Mag. Acc.+30','"Drain" and "Aspir" potency +9','CHR+14',}}
	gear.DrainFeet = {name="Merlinic Crackows", augments={'Mag. Acc.+28','"Drain" and "Aspir" potency +10','MND+1',}}
	gear.VanyaENFBody = {name="Vanya Robe", augments={'MND+10','Spell interruption rate down +15%','"Conserve MP"+6',}}	
	gear.ENFHands = {name="Chironic Gloves", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','"Cure" potency +1%','CHR+6','Mag. Acc.+13','"Mag.Atk.Bns."+5',}}
	gear.INTENFLegs = {name="Chironic Hose", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','"Fast Cast"+2','Mag. Acc.+14','"Mag.Atk.Bns."+3',}}
	gear.MNDENFLegs = {name="Chironic Hose", augments={'Mag. Acc.+30','"Conserve MP"+4','MND+12','"Mag.Atk.Bns."+4',}}
	gear.FCHead = {name="Merlinic Hood", augments={'Mag. Acc.+2','"Fast Cast"+6','"Mag.Atk.Bns."+30',}}
	gear.FCBody = {name="Merlinic Jubbah", augments={'Mag. Acc.+21','"Fast Cast"+7','"Mag.Atk.Bns."+5',}}
	gear.FCFeet = {name="Merlinic Crackows", augments={'"Mag.Atk.Bns."+18','"Fast Cast"+7','DEX+2','Mag. Acc.+1',}}
	gear.DTBody = {name="Merlinic Jubbah", augments={'"Mag.Atk.Bns."+16','Damage taken-3%','CHR+2'}}
	gear.DTHead = {name="Merlinic Hood", augments={'Pet: Attack+17 Pet: Rng.Atk.+17','CHR+5','Damage taken-5%','Accuracy+6 Attack+6',}}
	gear.MACCBody = {name="Merlinic Jubbah", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','Mag. crit. hit dmg. +2%','MND+1','Mag. Acc.+11','"Mag.Atk.Bns."+15',}}
	gear.MACCMBBody = {name="Merlinic Jubbah", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','Magic burst dmg.+7%','Mag. Acc.+15',}}
	gear.PhalanxClub = { name="Gada", augments={'Accuracy+3','Mag. Acc.+9 "Mag.Atk.Bns."+9','Phalanx +3',}}
	gear.PhalanxHead = { name="Merlinic Hood", augments={'Sklchn.dmg.+1%','Attack+6','Phalanx +4','Accuracy+11 Attack+11',}}
	gear.PhalanxBody = { name="Merlinic Jubbah", augments={'Pet: STR+3','VIT+8','Phalanx +4','Accuracy+4 Attack+4','Mag. Acc.+11 "Mag.Atk.Bns."+11',}}	
	gear.PhalanxFeet = {name="Merlinic Crackows", augments={'Enmity-2','Attack+18','Phalanx +5',}}
	gear.PhalanxLegs = {name="Merlinic Shalwar", augments={'System: 1 ID: 1793 Val: 8','STR+1','Phalanx +3','Accuracy+10 Attack+10',}}
	gear.PhalanxHands = {name="Merlinic Dastanas", augments={'INT+9','Pet: DEX+14','Phalanx +4',}}
	gear.THHead = {name="Merlinic Hood", augments={'Pet: VIT+2','INT+5','"Treasure Hunter"+1','Accuracy+11 Attack+11','Mag. Acc.+12 "Mag.Atk.Bns."+12',}}
	gear.THHands = {name="Merlinic Dastanas", augments={'"Cure" potency +9%','Phys. dmg. taken -1%','"Treasure Hunter"+2','Accuracy+18 Attack+18','Mag. Acc.+12 "Mag.Atk.Bns."+12',}}
	gear.NukeCape = {name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Phys. dmg. taken-10%',}}
	gear.FCCape = {name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Fast Cast"+10','Damage taken-5%',}}
	gear.MNDFCCape = {name="Lugh's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10',}}
	gear.MNDWSCape = {name="Lugh's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Weapon skill damage +10%',}}
	gear.CursnaHead = {name="Vanya Hood", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}}
	gear.CursnaBody = {name="Vanya Robe", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}}
	gear.CursnaLegs = {name="Vanya Slops", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}}	
	gear.DDCape = {name="Lugh's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}}
	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	sets.Enmity = {head=gear.DTHead,neck="Unmoving Collar +1",ammo="Sapience Orb",
		left_ear="Trux Earring",right_ear="Cryptic Earring",
		body="Vrikodara Jupon",hands=gear.THHands,left_ring="Pernicious Ring",right_ring="Petrov Ring",
		back=gear.NukeCape,waist="Goading Belt",legs="Artsieq Hose",feet="Gendewitha Galoshes +1"}
		
	-- Obi --
	sets['Lightning'] = {waist="Hachirin-no-Obi"}
	sets['Ice'] = {waist="Hachirin-no-Obi"}
	sets['Water'] = {waist="Hachirin-no-Obi"}
	sets['Fire'] = {waist="Hachirin-no-Obi"}
	sets['Earth'] = {waist="Hachirin-no-Obi"}
	sets['Wind'] = {waist="Hachirin-no-Obi"}
	sets['Light'] = {waist="Hachirin-no-Obi",back="Twilight Cape"}
	sets['Dark'] = {waist="Hachirin-no-Obi"}

	gear.default.obi_waist = "Refoccilation Stone"
	gear.default.obi_back = gear.NukeCape

	-- Precast sets to enhance JAs

	sets.precast.JA['Tabula Rasa'] = {ammo="Psilomene",
		head="Amalric Coif +1",neck="Dualism Collar +1",left_ear="Etiolation Earring",right_ear="Influx Earring",
		body="Weather. Robe +1",hands="Otomi Gloves",left_ring="Mephitas's Ring +1",right_ring="Mephitas's Ring",
		back="Pahtli Cape",waist="Shinjutsu-no-obi +1",legs="Pedagogy Pants +3",feet="Psycloth Boots"}
	
	sets.precast.JA.Lunge = {ammo="Pemphredo Tathlum",
		head=gear.NukingHead,neck="Mizu. Kubikazari",left_ear="Barkaro. Earring",right_ear="Regal Earring",
		body="Amalric Doublet +1",hands="Amalric Gages +1",left_ring="Locus Ring",right_ring="Mujin Band",
		back=gear.NukeCape,waist="Hachirin-no-Obi",legs="Amalric Slops +1",feet="Amalric Nails +1",}

	-- Weaponskills --

	sets.precast.WS['Omniscience'] = {ammo="Pemphredo Tathlum",
		head="Pixie Hairpin +1",neck="Fotia Gorget",left_ear="Barkaro. Earring",right_ear="Regal Earring",
		body="Amalric Doublet +1",hands="Amalric Gages +1",left_ring="Archon Ring",right_ring="Shiva Ring +1",
		back=gear.MNDWSCape,waist="Fotia Belt",legs="Amalric Slops +1",feet="Amalric Nails +1",}	
	
	sets.precast.WS['Cataclysm'] = sets.precast.WS['Omniscience']
	sets.precast.WS['Starburst'] = sets.precast.WS['Omniscience']
	sets.precast.WS['Sunburst'] = sets.precast.WS['Omniscience']
	sets.precast.WS['Shining Strike'] = sets.precast.WS['Omniscience']
	sets.precast.WS['Seraph Strike'] = sets.precast.WS['Omniscience']
	sets.precast.WS['Flash Nova'] = sets.precast.WS['Omniscience']
	
	sets.precast.WS['Myrkr'] = {ammo="Psilomene",
		head="Amalric Coif +1",neck="Dualism Collar +1",left_ear="Etiolation Earring",right_ear="Influx Earring",
		body="Weather. Robe +1",hands="Otomi Gloves",left_ring="Mephitas's Ring +1",right_ring="Mephitas's Ring",
		back="Pahtli Cape",waist="Shinjutsu-no-obi +1",legs="Amalric Slops +1",feet="Psycloth Boots"}
	sets.precast.WS['Starlight'] = sets.precast.WS['Myrkr']
	sets.precast.WS['Moonlight'] = sets.precast.WS['Myrkr']		

	sets.precast.WS['Shattersoul'] ={ammo="Hasty Pinion +1",
		head="Jhakri Coronal +2",neck="Fotia Gorget",left_ear="Digni. Earring",right_ear="Telos Earring",
		body="Jhakri Robe +2",hands="Jhakri Cuffs +2",left_ring="Chirich Ring +1",right_ring="Chirich Ring +1",
		back=gear.DDCape,waist="Fotia Belt",legs="Jhakri Slops +2",feet="Jhakri Pigaches +2"}

	sets.precast.WS['Shell Crusher'] = sets.precast.WS['Shattersoul']
	sets.precast.WS['Retribution'] = sets.precast.WS['Shattersoul']
	sets.precast.WS['Heavy Swing'] = sets.precast.WS['Shattersoul']
	sets.precast.WS['Full Swing'] = sets.precast.WS['Shattersoul']
	sets.precast.WS['Brainshaker'] = sets.precast.WS['Shattersoul']
	sets.precast.WS['Skullbreaker'] = sets.precast.WS['Shattersoul']
	sets.precast.WS['True Strike'] = sets.precast.WS['Shattersoul']
	sets.precast.WS['Black Halo'] = sets.precast.WS['Shattersoul']
	sets.precast.WS['Realmrazer'] = sets.precast.WS['Shattersoul']
	sets.precast.WS['Judgement'] = sets.precast.WS['Shattersoul']

	sets.precast.WS['Spirit Taker'] = {ammo="Pemphredo Tathlum",
		head=gear.NukingHead,neck="Fotia Gorget",left_ear="Barkaro. Earring",right_ear="Regal Earring",
		body="Amalric Doublet +1",hands="Amalric Gages +1",left_ring="Shiva Ring +1",right_ring="Shiva Ring +1",
		back=gear.MNDWSCape,waist="Fotia Belt",legs="Amalric Slops +1",feet="Amalric Nails +1",}
	
	sets.precast.WS['Rock Crusher'] = sets.precast.WS['Spirit Taker']	
	sets.precast.WS['Earth Crusher'] = sets.precast.WS['Spirit Taker']	

	-- Fast cast sets for spells

	sets.precast.FC = {ammo="Impatiens",
		head=gear.FCHead,neck="Orunmila's Torque",left_ear="Enchanter Earring +1",right_ear="Loquac. Earring",
		body=gear.FCBody,hands="Gende. Gages +1",left_ring="Weather. Ring +1",right_ring="Lebeche Ring",
		back=gear.FCCape,waist="Witful Belt",legs="Psycloth Lappas",feet=gear.FCFeet}
		
	sets.precast.FC.Arts = set_combine(sets.precast.FC, {feet="Acad. Loafers +3",})	

	sets.precast.FC.Cure = {ammo="Impatiens",
		head=gear.FCHead,neck="Orunmila's Torque",left_ear="Enchanter Earring +1",right_ear="Loquac. Earring",
		body="Zendik Robe",hands="Gende. Gages +1",left_ring="Weather. Ring +1",right_ring="Kishar Ring",
		back=gear.FCCape,waist="Witful Belt",legs="Doyen Pants",feet=gear.FCFeet}

	sets.precast.CureWithLightWeather = sets.precast.FC.Cure
	
	sets.precast.FC.Curaga = sets.precast.FC.Cure

	sets.precast.FC.Impact = {ammo="Impatiens",
		head=empty,neck="Orunmila's Torque",left_ear="Enchanter Earring +1",right_ear="Loquac. Earring",
		body="Twilight Cloak",hands="Gende. Gages +1",left_ring="Weather. Ring +1",right_ring="Lebeche Ring",
		back=gear.FCCape,waist="Witful Belt",legs="Psycloth Lappas",feet="Acad. Loafers +3"}		
	
	sets.precast.FC.Stun = {ammo="Hasty Pinion +1",
		head=gear.NukingHead,neck="Voltsurge Torque",left_ear="Enchanter Earring +1",right_ear="Regal Earring",
		body="Zendik Robe", hands=gear.ENFHands,left_ring="Weather. Ring +1",right_ring="Kishar Ring",
		back=gear.FCCape,waist="Eschan Stone",legs=gear.INTENFLegs,feet="Pedagogy Loafers +1"}		

	-- Midcast Sets

	sets.midcast.FastRecast = {ammo="Sapience Orb",
		head=gear.FCHead,neck="Orunmila's Torque",left_ear="Enchanter Earring +1",right_ear="Loquac. Earring",
		body="Zendik Robe",hands="Gende. Gages +1",left_ring="Weather. Ring +1",right_ring="Kishar Ring",
		back=gear.FCCape,waist="Witful Belt",legs="Psycloth Lappas",feet=gear.FCFeet}

	sets.midcast.Cure = {main="Chatoyant Staff",ammo="Hasty Pinion +1", 
		head="Kaykaus Mitra +1",neck="Incanter's Torque",left_ear="Gifted Earring",right_ear="Loquac. Earring",
		body="Kaykaus Bliaut +1",hands="Kaykaus Cuffs +1",left_ring="Haoma's Ring",right_ring="Haoma's Ring",
		back="Tempered Cape",waist="Witful Belt",legs="Kaykaus Tights +1",feet="Kaykaus Boots +1"}

	sets.midcast.Cure.ConserveMP = {ammo="Hasty Pinion +1", 
		head=gear.CMPHead,neck="Incanter's Torque",left_ear="Enchanter Earring +1",right_ear="Mendi. Earring",
		body="Kaykaus Bliaut +1",hands=gear.CMPHands,left_ring="Haoma's Ring",right_ring="Lebeche Ring",
		back=gear.CuringCape,waist="Gishdubar Sash",legs=gear.CMPLegs,feet="Kaykaus Boots +1"}						  

	sets.midcast.CureWithLightWeather = {main="Chatoyant Staff",ammo="Hasty Pinion +1",
		head=gear.CuringHat,neck="Incanter's Torque",left_ear="Gifted Earring",right_ear="Loquac. Earring",
		body="Kaykaus Bliaut +1",hands="Kaykaus Cuffs +1",left_ring="Haoma's Ring",right_ring="Haoma's Ring",
		back="Twilight Cape",waist="Hachirin-no-Obi",legs=gear.MNDENFLegs,feet="Kaykaus Boots +1"}
	
	sets.midcast.CureWithLightWeather.ConserveMP = {ammo="Hasty Pinion +1",
		head=gear.CMPHead,neck="Phalaina Locket",left_ear="Enchanter Earring +1",right_ear="Mendi. Earring",
		body="Kaykaus Bliaut +1",hands=gear.CMPHands,left_ring="Haoma's Ring",right_ring="Lebeche Ring",
		back="Twilight Cape",waist="Hachirin-no-Obi",legs=gear.CMPLegs,feet="Kaykaus Boots +1"}	
		
	sets.midcast.Cure.Hybrid = sets.midcast.Cure.ConserveMP
	sets.midcast.CureWithLightWeather.Hybrid = sets.midcast.CureWithLightWeather.ConserveMP	
	sets.midcast.Cure.MACC = sets.midcast.Cure.ConserveMP
	sets.midcast.CureWithLightWeather.MACC = sets.midcast.CureWithLightWeather.ConserveMP	

	sets.midcast.Curaga = sets.midcast.Cure
	
	sets.midcast.Regen = {main="Bolelabunga",sub="Genmei Shield",ammo="Pemphredo Tathlum", 
		head="Arbatel Bonnet +1",neck="Orunmila's Torque",left_ear="Gifted Earring",right_ear="Calamitous Earring",
		body=gear.PetRegenBody,hands=gear.CuringHands,left_ring="Weather. Ring +1",right_ring="Kishar Ring",
		back=gear.FCCape,waist="Witful Belt",legs=gear.CMPLegs,feet=gear.CMPFeet}
	 
	sets.midcast.Regen.ConserveMP = {main="Musa",sub="Enki Strap",ammo="Pemphredo Tathlum",
		head="Arbatel Bonnet +1",neck="Orunmila's Torque",left_ear="Gifted Earring",right_ear="Calamitous Earring",
		body=gear.RegenBody,hands=gear.CuringHands,left_ring="Weather. Ring +1",right_ring="Kishar Ring",
		back=gear.RegenCape,waist="Witful Belt",legs=gear.RegenLegs,feet=gear.RegenFeet}
		
	sets.midcast.Regen.MACC = {main="Musa",sub="Enki Strap",ammo="Pemphredo Tathlum", 
		head=gear.CMPHead,neck="Orunmila's Torque",left_ear="Gifted Earring",right_ear="Calamitous Earring",
		body=gear.PetRegenBody,hands=gear.CuringHands,left_ring="Weather. Ring +1",right_ring="Kishar Ring",
		back=gear.RegenCape,waist="Witful Belt",legs=gear.CMPLegs,feet=gear.CMPFeet}	

	sets.midcast.Cursna = {neck="Malison Medallion",hands="Hieros Mittens",head=gear.CursnaHead,body=gear.CursnaBody,legs=gear.CursnaLegs,
		ring1="Haoma's Ring",ring2="Haoma's Ring",waist="Gishdubar Sash",main=gear.FCStaff,sub="Clerisy Strap +1",
		back="Oretania's Cape +1",feet="Vanya Clogs"}

	sets.midcast['Enhancing Magic'] = {ammo="Savant's Treatise",
		head=gear.CMPHead,neck="Incanter's Torque",left_ear="Andoaa Earring",right_ear="Calamitous Earring",
		body="Pedagogy Gown +3",hands=gear.CuringHands,left_ring="Defending Ring",right_ring="Dark Ring",
		back="Fi Follet Cape +1",waist="Olympus Sash",legs=gear.CMPLegs,feet=gear.CMPFeet}
		
	sets.midcast.Phalanx = {ammo="Savant's Treatise", 
		head=gear.PhalanxHead,neck="Incanter's Torque",left_ear="Andoaa Earring",right_ear="Augmenting Earring",
		body=gear.PhalanxBody,hands=gear.PhalanxHands,left_ring="Stikini Ring +1",right_ring="Stikini Ring +1",
		back="Fi Follet Cape +1",waist="Olympus Sash",legs=gear.PhalanxLegs,feet=gear.PhalanxFeet,}		
		
	sets.midcast.Phalanx.ConserveMP = {ammo="Savant's Treatise",
		head=gear.PhalanxHead,neck="Incanter's Torque",left_ear="Andoaa Earring",right_ear="Augmenting Earring",
		body=gear.PhalanxBody,hands=gear.PhalanxHands,left_ring="Stikini Ring +1",right_ring="Stikini Ring +1",
		back="Fi Follet Cape +1",waist="Olympus Sash",legs=gear.PhalanxLegs,feet=gear.PhalanxFeet,}	

	sets.midcast.Phalanx.MACC = {main=gear.PhalanxClub,sub="Ammurapi Shield",ammo="Savant's Treatise", 
		head=gear.PhalanxHead,neck="Incanter's Torque",left_ear="Andoaa Earring",right_ear="Augmenting Earring",
		body=gear.PhalanxBody,hands=gear.PhalanxHands,left_ring="Stikini Ring +1",right_ring="Stikini Ring +1",
		back="Fi Follet Cape +1",waist="Olympus Sash",legs=gear.PhalanxLegs,feet=gear.PhalanxFeet,}	
		
	sets.midcast.Embrava = {main="Musa",sub="Enki Strap",ammo="Savant's Treatise",
		head=gear.CMPHead,neck="Incanter's Torque",left_ear="Andoaa Earring",right_ear="Calamitous Earring",
		body="Pedagogy Gown +3",hands=gear.CuringHands,left_ring="Defending Ring",right_ring="Dark Ring",
		back="Fi Follet Cape +1",waist="Olympus Sash",legs=gear.CMPLegs,feet=gear.CMPFeet}	
		
	sets.midcast.Aquaveil = {head="Amalric Coif +1",legs="Shedir Seraweels",waist="Emphatikos Rope",feet="Gendewitha Galoshes +1",body="Shamash Robe",hands="Regal Cuffs",
	ammo="Staunch Tathlum +1",neck="Loricate Torque +1",back=gear.NukeCape,ear1="Genmei Earring",ear2="Impregnable Earring",ring1="Defending Ring",ring2="Dark Ring",}
	
	sets.midcast.Refresh = {waist="Gishdubar Sash",feet="Inspirited Boots",legs=gear.CMPLegs,body=gear.PetRegenBody,head="Amalric Coif +1",hands=gear.CuringHands,
	back="Grapevine Cape",ammo="Staunch Tathlum +1"}

	sets.midcast.BarElement = {ammo="Savant's Treatise",
		head=gear.CMPHead,neck="Incanter's Torque",left_ear="Andoaa Earring",right_ear="Calamitous Earring",
		body="Pedagogy Gown +3",hands=gear.CuringHands,left_ring="Defending Ring",right_ring="Dark Ring",
		back="Fi Follet Cape +1",waist="Olympus Sash",legs=gear.CMPLegs,feet=gear.CMPFeet}
	
	sets.midcast.Klimaform = sets.midcast.FastRecast		
		
	sets.midcast.Impact = {ammo="Pemphredo Tathlum",legs=gear.MBLegs,neck="Mizu. Kubikazari",body="Twilight Cloak", 
		head=empty,left_ring="Locus Ring",right_ring="Mujin Band",waist="Refoccilation Stone",
		feet="Amalric Nails +1",back=gear.NukeCape,left_ear="Barkaro. Earring",right_ear="Static Earring",hands="Amalric Gages +1"}	
	
	sets.midcast.Impact.ConserveMP = {ammo="Pemphredo Tathlum", 
		head=empty,neck="Erra Pendant",left_ear="Gifted Earring",right_ear="Regal Earring",
		body="Twilight Cloak",hands="Kaykaus Cuffs +1",left_ring="Weather. Ring +1",right_ring="Stikini Ring +1",  
		back=gear.FCCape,waist="Rumination Sash",legs=gear.INTENFLegs,feet="Academic's Loafers +3"}
		
	sets.midcast.Impact.MACC = {ammo="Pemphredo Tathlum",
		head=empty,neck="Erra Pendant",left_ear="Barkaro. Earring",right_ear="Regal Earring",
		body="Twilight Cloak",hands="Kaykaus Cuffs +1",left_ring="Weather. Ring +1",right_ring="Stikini Ring +1",  
		back=gear.FCCape,waist="Rumination Sash",legs=gear.INTENFLegs,feet="Academic's Loafers +3"}	

	sets.midcast.Blink = sets.midcast.FastRecast
	sets.midcast.Poisona = sets.midcast.FastRecast
	sets.midcast.Paralyna = sets.midcast.FastRecast
	sets.midcast.Blindna = sets.midcast.FastRecast
	sets.midcast.Silena = sets.midcast.FastRecast
	sets.midcast.Stona = sets.midcast.FastRecast
	sets.midcast.Viruna = sets.midcast.FastRecast
	
	sets.midcast.Stoneskin = set_combine(sets.midcast.FastCast, 
		{waist="Siegel Sash",legs="Shedir Seraweels",neck="Nodens Gorget",right_ear="Earthcry Earring"})

	sets.midcast.Haste = set_combine(sets.midcast.FastCast, 
		{legs=gear.CMPLegs,body="Pedagogy Gown +3",feet=gear.CMPFeet,head=gear.CMPHead,hands=gear.CuringHands,ammo="Staunch Tathlum +1",})	
	
	sets.midcast.Flurry = sets.midcast.Haste	
	sets.midcast.Adloquium = sets.midcast.Haste
	sets.midcast.Sneak = sets.midcast.Haste
	sets.midcast.Invisible = sets.midcast.Haste
	sets.midcast["Animus Minuo"] = sets.midcast.Haste
	sets.midcast["Animus Augeo"] = sets.midcast.Haste
	sets.midcast['Shock Spikes'] = sets.midcast.Haste
	sets.midcast['Ice Spikes'] = sets.midcast.Haste
	sets.midcast['Blaze Spikes'] = sets.midcast.Haste

	sets.midcast.Storm = set_combine(sets.midcast['Enhancing Magic'], {head=gear.CMPHead,body="Pedagogy Gown +3",hands=gear.CuringHands, --Duration--
	back=gear.FCCape,feet=gear.CMPFeet,neck="Orunmila's Torque",waist="Witful Belt",left_ear="Enchanter Earring +1",
	right_ear="Loquac. Earring",left_ring="Weather. Ring +1",right_ring="Kishar Ring",legs=gear.CMPLegs,ammo="Sapience Orb",})
	
	sets.midcast.Storm.ConserveMP = set_combine(sets.midcast['Enhancing Magic'], {head=gear.CMPHead,body="Pedagogy Gown +3",hands=gear.CuringHands, --Feet Potency--
	back=gear.FCCape,feet="Pedagogy Loafers +1",neck="Orunmila's Torque",waist="Witful Belt",left_ear="Enchanter Earring +1",
	right_ear="Loquac. Earring",left_ring="Weather. Ring +1",right_ring="Kishar Ring",legs=gear.CMPLegs,ammo="Sapience Orb",})
	
	sets.midcast.Storm.MACC = set_combine(sets.midcast['Enhancing Magic'], {head=gear.CMPHead,body="Pedagogy Gown +3",hands=gear.CuringHands,
	back=gear.FCCape,feet=gear.CMPFeet,neck="Orunmila's Torque",waist="Witful Belt",left_ear="Enchanter Earring +1",
	right_ear="Loquac. Earring",left_ring="Weather. Ring +1",right_ring="Kishar Ring",legs=gear.CMPLegs,ammo="Sapience Orb",}) --Max Duration--

	sets.midcast["Firestorm II"] = sets.midcast.Storm
	sets.midcast["Hailstorm II"] = sets.midcast.Storm
	sets.midcast["Windstorm II"] = sets.midcast.Storm
	sets.midcast["Sandstorm II"] = sets.midcast.Storm
	sets.midcast["Thunderstorm II"] = sets.midcast.Storm
	sets.midcast["Rainstorm II"] = sets.midcast.Storm
	sets.midcast["Aurorastorm II"] = sets.midcast.Storm
	sets.midcast["Voidstorm II"] = sets.midcast.Storm

	sets.midcast.Protect = {ring2="Sheltered Ring",legs=gear.CMPLegs,body="Pedagogy Gown +3",feet=gear.CMPFeet,head=gear.CMPHead,hands=gear.CuringHands}
	sets.midcast.Protect.MACC = {ring2="Sheltered Ring",legs=gear.CMPLegs,body=gear.PetRegenBody,feet=gear.CMPFeet,
	head=gear.CMPHead,hands=gear.CuringHands} 	
	sets.midcast.Protectra = sets.midcast.Protect
	sets.midcast.Protectra.MACC = sets.midcast.Protect.MACC
	sets.midcast.Shell = sets.midcast.Protect
	sets.midcast.Shell.MACC = sets.midcast.Protect.MACC
	sets.midcast.Shellra = sets.midcast.Protect
	sets.midcast.Shellra.MACC = sets.midcast.Protect.MACC

	-- Custom spell classes
	sets.midcast.MndEnfeebles = {ammo="Hydrocera",
		head="Academic's Mortarboard +3",neck="Erra Pendant",left_ear="Enchanter Earring +1",right_ear="Regal Earring",
		body="Academic's Gown +3",hands="Regal Cuffs",left_ring="Stikini Ring +1",right_ring="Stikini Ring +1",
		back=gear.MNDFCCape,waist="Rumination Sash",legs=gear.MNDENFLegs,feet="Academic's Loafers +3"}
		
	sets.midcast.IntEnfeebles = {ammo="Pemphredo Tathlum",
		head="Academic's Mortarboard +3",neck="Erra Pendant",left_ear="Barkaro. Earring",right_ear="Regal Earring",
		body="Academic's Gown +3",hands="Regal Cuffs",left_ring="Weather. Ring +1",right_ring="Stikini Ring +1",
		back=gear.FCCape,waist="Rumination Sash",legs=gear.INTENFLegs,feet="Academic's Loafers +3"}	
		
	sets.midcast["Poison II"] = {ammo="Savant's Treatise", 
		head="Befouled Crown",neck="Incanter's Torque",left_ear="Barkaro. Earring",right_ear="Regal Earring",
		body="Academic's Gown +3",hands="Regal Cuffs",left_ring="Stikini Ring +1",right_ring="Stikini Ring +1",
		back=gear.FCCape,waist="Rumination Sash",legs="Psycloth Lappas",feet="Skaoi Boots"}

	sets.midcast["Poison II"].MACC = sets.midcast.IntEnfeebles

	sets.midcast.ElementalEnfeeble = sets.midcast.IntEnfeebles
	
	sets.midcast.Bio = {ammo="Staunch Tathlum +1", 
		head="Pixie Hairpin +1",neck="Loricate Torque +1",left_ear="Genmei Earring",right_ear="Calamitous Earring",
		body="Amalric Doublet +1",hands="Gendewitha Gages +1",left_ring="Archon Ring",right_ring="Dark Ring", 
		back="Fi Follet Cape +1",waist="Emphatikos Rope",legs="Artsieq Hose",feet="Gendewitha Galoshes +1",}
		
	sets.midcast["Bio II"] = sets.midcast.Bio

	sets.midcast.Dia = {ammo="Staunch Tathlum +1", 
		head=gear.DTHead,neck="Loricate Torque +1",left_ear="Genmei Earring",right_ear="Calamitous Earring",
		body="Amalric Doublet +1",hands="Regal Cuffs",left_ring="Defending Ring",right_ring="Kishar Ring", 
		back=gear.NukeCape,waist="Cetl Belt",legs="Artsieq Hose",feet="Uk'uxkaj Boots",}

	sets.midcast["Dia II"] = sets.midcast.Dia
	sets.midcast.Diaga = sets.midcast.Dia
	sets.midcast.Diaga.MACC = sets.Enmity	

	sets.midcast['Dark Magic'] = sets.midcast.IntEnfeebles

	sets.midcast.Kaustra = {ammo="Pemphredo Tathlum",
		head="Pixie Hairpin +1",neck="Mizu. Kubikazari",left_ear="Barkaro. Earring",right_ear="Regal Earring",
		body="Academic's Gown +3",hands="Amalric Gages +1",left_ring="Archon Ring",right_ring="Mujin Band",
		back=gear.NukeCape,waist="Hachirin-no-Obi",legs=gear.MBLegs,feet="Arbatel Loafers +1",}
		
	sets.midcast.Noctohelix = {ammo="Pemphredo Tathlum",
		head="Pixie Hairpin +1",neck="Saevus Pendant +1",left_ear="Barkaro. Earring",right_ear="Regal Earring",
		body="Academic's Gown +3",hands="Amalric Gages +1",left_ring="Archon Ring",right_ring="Shiva Ring +1",
		back=gear.HelixCape,waist="Refoccilation Stone",legs="Amalric Slops +1",feet="Amalric Nails +1",}

	sets.midcast["Noctohelix II"] = sets.midcast.Noctohelix	

	sets.midcast.Luminohelix = {ammo="Pemphredo Tathlum",
		head=gear.NukingHead,neck="Saevus Pendant +1",left_ear="Barkaro. Earring",right_ear="Regal Earring",
		body="Amalric Doublet +1",hands="Amalric Gages +1",left_ring="Weather. Ring +1",right_ring="Shiva Ring +1",
		back=gear.HelixCape,waist="Refoccilation Stone",legs="Amalric Slops +1",feet="Amalric Nails +1",}

	sets.midcast["Luminohelix II"] = sets.midcast.Luminohelix		

	sets.midcast.Drain = {ammo="Pemphredo Tathlum",
		head="Pixie Hairpin +1",neck="Erra Pendant",left_ear="Hirudinea Earring",right_ear="Regal Earring",
		body="Academic's Gown +3",hands=gear.DrainHands,left_ring="Archon Ring",right_ring="Evanescence Ring",
		back=gear.FCCape,waist="Fucho-no-Obi",legs="Pedagogy Pants +3",feet=gear.DrainFeet,}

	sets.midcast.Aspir = sets.midcast.Drain
	sets.midcast["Aspir II"] = sets.midcast.Drain
		
	sets.midcast.Stone = {ammo="Pemphredo Tathlum",
		head=gear.THHead,neck="Saevus Pendant +1",left_ear="Barkaro. Earring",right_ear="Regal Earring",
		body="Chironic Doublet",hands=gear.THHands,left_ring="Shiva Ring +1",right_ring="Shiva Ring +1",
		back=gear.NukeCape,waist="Chaac Belt",legs="Amalric Slops +1",feet="Amalric Nails +1",}

	sets.midcast.Blizzard = {head=gear.DTHead,neck="Loricate Torque +1",ammo="Staunch Tathlum +1",
		left_ear="Impregnable Earring",right_ear="Lugalbanda Earring",
		body="Shamash Robe",hands="Hagondes Cuffs +1",left_ring="Defending Ring",right_ring="Gelatinous Ring +1",
		back="Moonlight Cape",waist="Cetl Belt",legs=gear.CMPLegs,feet="Hippomenes Socks +1"}
	
	sets.midcast.Water = {head=gear.DTHead,neck="Loricate Torque +1",ammo="Staunch Tathlum +1",
		left_ear="Impregnable Earring",right_ear="Lugalbanda Earring",
		body="Shamash Robe",hands="Hagondes Cuffs +1",left_ring="Defending Ring",right_ring="Gelatinous Ring +1",
		back="Moonlight Cape",waist="Cetl Belt",legs=gear.CMPLegs,feet="Hippomenes Socks +1"}

	sets.midcast.Thunder = {head=gear.DTHead,neck="Loricate Torque +1",ammo="Staunch Tathlum +1",
		left_ear="Impregnable Earring",right_ear="Lugalbanda Earring",
		body="Shamash Robe",hands="Hagondes Cuffs +1",left_ring="Defending Ring",right_ring="Gelatinous Ring +1",
		back="Moonlight Cape",waist="Cetl Belt",legs=gear.CMPLegs,feet="Hippomenes Socks +1"}		
		
	-- This is the Speed Set --
	sets.midcast.Stun = {ammo="Hasty Pinion +1",
		head=gear.NukingHead,neck="Erra Pendant",left_ear="Enchanter Earring +1",right_ear="Regal Earring",
		body="Zendik Robe", hands=gear.ENFHands,left_ring="Weather. Ring +1",right_ring="Kishar Ring",
		back=gear.FCCape,waist="Eschan Stone",legs=gear.INTENFLegs,feet="Pedagogy Loafers +1"}

	sets.midcast.Stun.ConserveMP = {ammo="Hasty Pinion +1",
		head=gear.FCHead,neck="Erra Pendant",left_ear="Enchanter Earring +1",right_ear="Loquac. Earring",
		body="Zendik Robe",hands=gear.ENFHands,left_ring="Weather. Ring +1",right_ring="Kishar Ring",
		back=gear.FCCape,waist="Eschan Stone",legs=gear.INTENFLegs,feet="Pedagogy Loafers +1"}

	-- Elemental Magic sets are default for handling low-tier nukes.
	sets.midcast['Elemental Magic'] = {ammo="Pemphredo Tathlum",
		head=gear.NukingHead,neck="Saevus Pendant +1",left_ear="Barkaro. Earring",right_ear="Regal Earring",
		body="Amalric Doublet +1",hands="Amalric Gages +1",left_ring="Shiva Ring +1",right_ring="Shiva Ring +1",
		back=gear.NukeCape,waist=gear.ElementalObi,legs="Amalric Slops +1",feet="Amalric Nails +1",}

	sets.midcast['Elemental Magic'].ConserveMP = {ammo="Pemphredo Tathlum",
		head=gear.NukingHead,neck="Saevus Pendant +1",left_ear="Barkaro. Earring",right_ear="Regal Earring",
		body="Seidr Cotehardie",hands="Amalric Gages +1",left_ring="Shiva Ring +1",right_ring="Shiva Ring +1",
		back=gear.NukeCape,waist=gear.ElementalObi,legs="Amalric Slops +1",feet="Amalric Nails +1",}
		
	sets.midcast['Elemental Magic'].Hybrid = {ammo="Pemphredo Tathlum",
		head=gear.NukingHead,neck="Sanctity Necklace",left_ear="Barkaro. Earring",right_ear="Regal Earring",
		body="Amalric Doublet +1",hands="Amalric Gages +1",left_ring="Shiva Ring +1",right_ring="Shiva Ring +1",
		back=gear.NukeCape,waist=gear.ElementalObi,legs=gear.MBLegs,feet="Chironic Slippers",}	
		
	sets.midcast['Elemental Magic'].MACC = {ammo="Pemphredo Tathlum",
		head=gear.NukingHead,neck="Argute Stole +2",left_ear="Barkaro. Earring",right_ear="Regal Earring",
		body=gear.MACCMBBody,hands=gear.ENFHands,left_ring="Shiva Ring +1",right_ring="Shiva Ring +1",
		back=gear.NukeCape,waist=gear.ElementalObi,legs="Pedagogy Pants +3",feet="Chironic Slippers",}

	sets.midcast['Elemental Magic'].Occult = {ammo="Seraphic Ampulla",
		head="Mallquis Chapeau +1",neck="Combatant's Torque",left_ear="Telos Earring",right_ear="Dedition Earring",
		body="Seidr Cotehardie",hands="Amalric Gages +1",left_ring="K'ayres Ring",right_ring="Petrov Ring",
		back=gear.NukeCape,waist="Oneiros Rope",legs="Perdition Slops",feet="Amalric Nails +1",}		
			
	sets.magic_burst = {legs=gear.MBLegs,neck="Mizu. Kubikazari",body="Amalric Doublet +1",left_ring="Locus Ring",right_ring="Mujin Band",
	feet="Amalric Nails +1",back=gear.NukeCape,left_ear="Barkaro. Earring",right_ear="Regal Earring",hands="Amalric Gages +1"}
	
	sets.magic_burst.MACC = {ammo="Pemphredo Tathlum",
		head=gear.NukingHead,neck="Argute Stole +2",left_ear="Barkaro. Earring",right_ear="Regal Earring",
		body="Academic's Gown +3",hands="Chironic Gloves",left_ring="Locus Ring",right_ring="Shiva Ring +1",
		back=gear.NukeCape,waist=gear.ElementalObi,legs=gear.MBLegs,feet="Chironic Slippers",}
	
	
	-- Sets to return to when not performing an action.
	-- Resting sets
	
	sets.Resting = sets.idle
	
	-- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)

	sets.idle = {main="Akademos",sub="Enki Strap",ammo="Homiliary",
		head=gear.IdleHead,neck="Bathy Choker +1",left_ear="Infused Earring",right_ear="Savant's Earring",
		body="Shamash Robe", hands=gear.IdleHands,left_ring="Stikini Ring +1",right_ring="Stikini Ring +1",
		back="Moonlight Cape",waist="Fucho-no-Obi",legs=gear.IdleLegs,feet="Iaso Boots"}
		
	sets.idle.Sublimation = set_combine(sets.idle, {head="Academic's Mortarboard +3",body="Pedagogy Gown +3"})	
	 	
    sets.idle.ZendikMAB = set_combine(sets.idle, {body="Zendik Robe"})
	
	sets.idle.Town = {main="Akademos",sub="Enki Strap",ammo="Homiliary",
		head="Amalric Coif +1",neck="Bathy Choker +1",left_ear="Infused Earring",right_ear="Savant's Earring",
		body="Amalric Doublet +1", hands="Amalric Gages +1",left_ring="Stikini Ring +1",right_ring="Stikini Ring +1",
		back="Moonlight Cape",waist="Fucho-no-Obi",legs="Amalric Slops +1",feet="Amalric Nails +1"}
	
	-- Defense sets

	sets.defense.PDT = {main="Akademos",sub="Enki Strap",head=gear.DTHead,neck="Loricate Torque +1",ammo="Staunch Tathlum +1",
		left_ear="Impregnable Earring",right_ear="Lugalbanda Earring",
		body="Shamash Robe",hands="Hagondes Cuffs +1",left_ring="Defending Ring",right_ring="Gelatinous Ring +1",
		back="Moonlight Cape",waist="Cetl Belt",legs=gear.CMPLegs,feet="Hippomenes Socks +1"}
		
	sets.defense.PDT2 = {main="Tupsimati",sub="Enki Strap",head=gear.DTHead,neck="Loricate Torque +1",ammo="Staunch Tathlum +1",
		left_ear="Impregnable Earring",right_ear="Lugalbanda Earring",
		body="Shamash Robe",hands="Hagondes Cuffs +1",left_ring="Defending Ring",right_ring="Gelatinous Ring +1",
		back="Moonlight Cape",waist="Cetl Belt",legs=gear.CMPLegs,feet="Hippomenes Socks +1"}	
			
	sets.defense.Hybrid = {head=gear.DTHead,neck="Warder's Charm +1",ammo="Staunch Tathlum +1",
		left_ear="Impregnable Earring",right_ear="Genmei Earring",
		body="Shamash Robe",hands="Gendewitha Gages +1",left_ring="Defending Ring",right_ring="Shadow Ring",
		back="Moonlight Cape",waist="Cetl Belt",legs="Artsieq Hose",feet="Gendewitha Galoshes +1"}	
	
	sets.defense.MDT = {ammo="Staunch Tathlum +1",
		head=gear.DTHead,neck="Warder's Charm +1",left_ear="Etiolation Earring",right_ear="Lugalbanda Earring",
		body="Shamash Robe",hands="Regal Cuffs",left_ring="Defending Ring",right_ring="Shadow Ring",
		back=gear.CuringCape,waist="Slipor Sash",legs=gear.PetRegenLegs,feet="Acad. Loafers +3"}
		
	sets.defense.MEVA = {ammo="Staunch Tathlum +1",
		head="Academic's Mortarboard +3",neck="Warder's Charm +1",left_ear="Hearty Earring",right_ear="Lugalbanda Earring",
		body="Shamash Robe",hands="Regal Cuffs",left_ring="Defending Ring",right_ring="Purity Ring",
		back=gear.CuringCape,waist="Carrier's Sash",legs=gear.PetRegenLegs,feet="Acad. Loafers +3"}
		
	sets.Kiting = {feet="Iaso Boots"}

	sets.latent_refresh = {}

	-- Engaged sets
	
	sets.engaged = sets.defense.PDT
	
	sets.engaged.DD = {ammo="Staunch Tathlum +1",
		head="Blistering Sallet +1",neck="Combatant's Torque",left_ear="Brutal Earring",right_ear="Telos Earring",
		body="Onca Suit",hands=empty,left_ring="Petrov Ring",right_ring="Hetairoi Ring",
		back=gear.DDCape,waist="Cetl Belt",legs=empty,feet=empty}	
	

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion

	-- Normal melee group
	
	sets.engaged = sets.defense.PDT
	sets.engaged.Refresh = sets.idle

	-- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
	sets.buff['Rapture'] = {head="Arbatel Bonnet +1"}
	sets.buff['Perpetuance'] = {hands="Arbatel Bracers +1"}
	sets.buff['Ebullience'] = {feet="Arbatel Bonnet +1"}
	sets.buff['Klimaform'] = {feet="Arbatel Loafers +1"}
	
	sets.Bookworm = {back=gear.HelixCape}
	
	
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
function job_post_precast(spell,action)
    if spell.type:endswith('Magic') or spell.type == "Ninjutsu" then
        if buffactive.silence then -- Cancel Magic or Ninjutsu If You Are Silenced or Out of Range --
            cancel_spell()
            add_to_chat(123, spell.name..' Canceled: [Silenced or Out of Casting Range]')
            return
			elseif spell.english == "Impact" then
                equip(set_combine(sets.precast.FC,{head=empty,body="Twilight Cloak",feet="Acad. Loafers +3",}))
        else
            if buffactive['Dark Arts'] and spell.type == 'BlackMagic' or buffactive['Addendum: Black'] and spell.type == 'BlackMagic'  then
                equip (sets.precast.FC.Arts)      
            elseif buffactive['Light Arts'] and spell.type == 'WhiteMagic' or buffactive['Addendum: White'] and spell.type == 'WhiteMagic'  then
                equip (sets.precast.FC.Arts)              
            else
                equip(sets.precast.FC)
			end
		end
	end
end
-- Run after the general midcast() is done.
function job_post_midcast(spell, action, spellMap, eventArgs)
 if spell.action_type == 'Magic' then
        apply_grimoire_bonuses(spell, action, spellMap, eventArgs)
local storm_element = function() for i,v in pairs({Fire=589,Ice=590,Wind=591,Earth=592,Lightning=593,Water=594,Light=595,Dark=596,}) do
                                 if buffactive[v] then return i end end end

if spell.skill == 'Elemental Magic' and spell.element ~= world.weather_element and spell.element == world.day_element and spell.target.distance < target_distance then
   equip({waist="Orpheus's Sash"}) 
end

if spell.skill == 'Elemental Magic' and spell.element ~= world.weather_element and spell.element ~= world.day_element and spell.target.distance < target_distance then
   equip({waist="Orpheus's Sash"}) 
end


if spell.element == world.weather_element and spell.element == world.day_element and spell.target.distance > target_distance then
		if spell.skill == 'Elemental Magic' and spellMap ~= 'Helix' then
			equip({waist="Hachirin-no-Obi"})
		elseif string.find(spell.english,'Cure') then
			equip({waist="Hachirin-no-Obi"})
		end
	end

if spell.element == world.weather_element and spell.element == world.day_element and spell.target.distance > target_distance or 
			(spell.element == 'Lightning' and buffactive['593']) or 
			(spell.element == 'Ice' and buffactive['590']) or 
			(spell.element == 'Water' and buffactive['594']) or 
			(spell.element == 'Fire' and buffactive['589']) or 
			(spell.element == 'Earth' and buffactive['592']) or 
			(spell.element == 'Wind' and buffactive['591']) or 
			(spell.element == 'Light' and buffactive['595']) or 
			(spell.element == 'Dark' and buffactive['596']) then 
		if spell.skill == 'Elemental Magic' and spellMap ~= 'Helix' then
			equip({waist="Hachirin-no-Obi"})
		elseif string.find(spell.english,'Cure') then
			equip({waist="Hachirin-no-Obi"})
		end
	end
		if spellMap == "Helix" then	
			if state.HelixMode.value == 'Bookworm' then
				equip(sets.Bookworm)
			end
		end
		if spell.element == "Earth" and spell.skill == 'Elemental Magic' and (state.CastingMode.value == "Normal" or state.CastingMode.value == "ConserveMP") then
		equip({ neck="Quanpur Necklace" })
		end

		if spell.skill == 'Elemental Magic' and state.MagicBurst.value then
			if state.CastingMode.value == "MACC" then
			equip(sets.magic_burst.MACC)
			
				if player.equipment.main == "Akademos" and buffactive['Klimaform'] then
				equip(sets.buff['Klimaform'])
				end
				if player.equipment.main == "Tupsimati" and buffactive['Klimaform'] then
				equip(sets.buff['Klimaform'])
				end
			else
			equip(sets.magic_burst)
			
				if player.equipment.main == "Akademos" and buffactive['Klimaform'] then
				equip(sets.buff['Klimaform'])
				end
				if player.equipment.main == "Tupsimati" and buffactive['Klimaform'] then
				equip(sets.buff['Klimaform'])
				end
				
        if (spell.element == world.day_element or spell.element == world.weather_element) then
            if (spell.skill == 'Elemental Magic' and spellMap ~= 'Helix') or string.find(spell.english, 'Cure') then
                equip(sets[spell.element])
    if spell.skill == 'Elemental Magic' and state.MagicBurst.value and state.HelixMode.value == 'Bookworm' then
        equip(sets.magic_burst_helix)
		
		if player.equipment.main == "Akademos" and buffactive['Klimaform'] then
				equip(sets.buff['Klimaform'])
				end
				if player.equipment.main == "Tupsimati" and buffactive['Klimaform'] then
				equip(sets.buff['Klimaform'])
				end
				
     if spell.skill == 'Enhancing Magic' and state.Buff.Perpetuance then
          if state.CastingMode.value == "Normal" then
               equip(sets.buff['Perpetuance'])
          else
               if spell.english == "Phalanx" then
                    equip({hands=gear.PhalanxHands})
               else
                    equip(sets.buff['Perpetuance'])
               end
          end
     end
	end
	end
	end
end
end
end
end

function job_aftercast(spell, action, spellMap, eventArgs)
	if not spell.interrupted then
		if spell.english == 'Break' or spell.english == 'Breakga' then
			send_command('@timers c "'..spell.english..' ['..spell.target.name..']" 39 down spells/00220.png')
		elseif spell.english == 'Sleep' or spell.english == 'Sleepga' then
			send_command('@timers c "'..spell.english..' ['..spell.target.name..']" 78 down spells/00220.png')
		elseif spell.english == 'Sleep II' or spell.english == 'Sleepga II' then
			send_command('@timers c "'..spell.english..' ['..spell.target.name..']" 117 down spells/00220.png')
		end
		classes.CustomIdleGroups:clear()
	end
end

function job_status_change(new_status, old_status)
    if new_status == 'Idle' then
        select_movement_feet()
    end
end
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
	if buff == "Sublimation: Activated" then
		handle_equipping_gear(player.status)
	end
		buff = string.lower(buff)
	if buff == "aftermath: lv.1" then -- AM1 Timer/Countdown --
		if gain then
			send_command('timers create "Aftermath: Lv.1" 270 down;wait 210;input /echo Aftermath: Lv.1 [WEARING OFF IN 60 SEC.];wait 30;input /echo Aftermath: Lv.1 [WEARING OFF IN 30 SEC.];wait 20;input /echo Aftermath: Lv.1 [WEARING OFF IN 10 SEC.]')
		else
			send_command('timers delete "Aftermath: Lv.1"')
			add_to_chat(123,'AM1: [OFF]')
		end
	elseif buff == "aftermath: lv.2" then -- AM2 Timer/Countdown --
		if gain then
			send_command('timers create "Aftermath: Lv.2" 270 down;wait 210;input /echo Aftermath: Lv.2 [WEARING OFF IN 60 SEC.];wait 30;input /echo Aftermath: Lv.2 [WEARING OFF IN 30 SEC.];wait 20;input /echo Aftermath: Lv.2 [WEARING OFF IN 10 SEC.]')
		else
			send_command('timers delete "Aftermath: Lv.2"')
			add_to_chat(123,'AM2: [OFF]')
		end
	elseif buff == "aftermath: lv.3" then -- AM3 Timer/Countdown --
		if gain then
			send_command('timers create "Aftermath: Lv.3" 180 down;wait 120;input /echo Aftermath: Lv.3 [WEARING OFF IN 60 SEC.];wait 30;input /echo Aftermath: Lv.3 [WEARING OFF IN 30 SEC.];wait 20;input /echo Aftermath: Lv.3 [WEARING OFF IN 10 SEC.]')
		else
			send_command('timers delete "Aftermath: Lv.3"')
			add_to_chat(123,'AM3: [OFF]')
		end
end
end

-- Handle notifications of general user state change.

function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Offense Mode' then
        if newValue == 'Normal' then
            disable('main','sub','range')
        else
            enable('main','sub','range')
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
	if spell.action_type == 'Magic' then
		if default_spell_map == 'Cure' or default_spell_map == 'Curaga' then
			if world.weather_element == 'Light' then
				return 'CureWithLightWeather'
			end
		elseif spell.skill == 'Enfeebling Magic' then
			if spell.type == 'WhiteMagic' then
				return 'MndEnfeebles'
			else
				return 'IntEnfeebles'
			end
		elseif spell.skill == 'Elemental Magic' then
		end
	end
end

function customize_idle_set(idleSet)
	if state.Buff['Sublimation: Activated'] then
		idleSet = set_combine(idleSet, sets.buff.Sublimation)
	end

	if player.mpp < 51 then
		idleSet = set_combine(idleSet, sets.latent_refresh)
	end

	return idleSet
end

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
	if cmdParams[1] == 'user' and not (buffactive['light arts']	  or buffactive['dark arts'] or
					   buffactive['addendum: white'] or buffactive['addendum: black']) then
	end
	update_active_strategems()
	update_sublimation()
	select_movement_feet()
end

-- Function to display the current relevant user state when doing an update.
-- Return true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
	local meleeString = ''
	if state.OffenseMode.value == 'Normal' then
		meleeString = 'Melee: Weapons locked, '
	end

	local kitingString = ''
	if state.Kiting.value then
		kitingString = 'On'
	else
		kitingString = 'Off'
	end

	add_to_chat(122,'Casting ['..state.CastingMode.value..'], '..meleeString..'Idle ['..state.IdleMode.value..'], Kiting: '..kitingString..'')

	eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called for direct player commands.
function job_self_command(cmdParams, eventArgs)
	if cmdParams[1]:lower() == 'scholar' then
		handle_strategems(cmdParams)
		eventArgs.handled = true
	end
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
function select_default_macro_book()
    set_macro_page(2,1)
end
-- Reset the state vars tracking strategems.
function update_active_strategems()
	state.Buff['Ebullience'] = buffactive['Ebullience'] or false
	state.Buff['Rapture'] = buffactive['Rapture'] or false
	state.Buff['Perpetuance'] = buffactive['Perpetuance'] or false
	state.Buff['Immanence'] = buffactive['Immanence'] or false
	state.Buff['Penury'] = buffactive['Penury'] or false
	state.Buff['Parsimony'] = buffactive['Parsimony'] or false
	state.Buff['Celerity'] = buffactive['Celerity'] or false
	state.Buff['Alacrity'] = buffactive['Alacrity'] or false
	state.Buff['Klimaform'] = buffactive['Klimaform'] or false
end

function select_movement_feet()
    if world.time >= 18*60 or world.time < 6*60 then
        gear.MovementFeet.name = gear.NightFeet
    else
        gear.MovementFeet.name = gear.DayFeet
    end
end


function update_sublimation()
	state.Buff['Sublimation: Activated'] = buffactive['Sublimation: Activated'] or false
end

-- Equip sets appropriate to the active buffs, relative to the spell being cast.
function apply_grimoire_bonuses(spell, action, spellMap)
	if state.Buff.Perpetuance and spell.type =='WhiteMagic' and spell.skill == 'Enhancing Magic' then
		equip(sets.buff['Perpetuance'])
	end
	if state.Buff.Rapture and (spellMap == 'Cure' or spellMap == 'Curaga') then
		equip(sets.buff['Rapture'])
	end
	if spell.skill == 'Elemental Magic' and spellMap ~= 'ElementalEnfeeble' then
		if state.Buff.Immanence then
			equip(sets.buff['Immanence'])
		end
		if buffactive['Klimaform'] and spell.element == world.weather_element and not state.MagicBurst.value 
		and state.CastingMode.value ~= 'MACC' and state.CastingMode.value ~= 'Hybrid' then 
			equip(sets.buff['Klimaform']) 
		end
	end

	if state.Buff.Penury then equip(sets.buff['Penury']) end
	if state.Buff.Parsimony then equip(sets.buff['Parsimony']) end
	if state.Buff.Celerity then equip(sets.buff['Celerity']) end
	if state.Buff.Alacrity then equip(sets.buff['Alacrity']) end
end

-- General handling of strategems in an Arts-agnostic way.
-- Format: gs c scholar <strategem>
function handle_strategems(cmdParams)
	-- cmdParams[1] == 'scholar'
	-- cmdParams[2] == strategem to use

	if not cmdParams[2] then
		add_to_chat(123,'Error: No strategem command given.')
		return
	end
	local strategem = cmdParams[2]:lower()

	if buffactive['light arts'] or buffactive['addendum: white'] then
		if strategem == 'cost' then
			send_command('@input /ja Penury <me>')
		elseif strategem == 'speed' then
			send_command('@input /ja Celerity <me>')
		elseif strategem == 'aoe' then
			send_command('@input /ja Accession <me>')
		elseif strategem == 'power' then
			send_command('@input /ja Rapture <me>')
		elseif strategem == 'duration' then
			send_command('@input /ja Perpetuance <me>')
		elseif strategem == 'accuracy' then
			send_command('@input /ja Altruism <me>')
		elseif strategem == 'enmity' then
			send_command('@input /ja Tranquility <me>')
		elseif strategem == 'skillchain' then
			add_to_chat(122,'Error: Light Arts does not have a skillchain strategem.')
		elseif strategem == 'addendum' then
			send_command('@input /ja "Addendum: White" <me>')
		else
			add_to_chat(123,'Error: Unknown strategem ['..strategem..']')
		end
	elseif buffactive['dark arts']  or buffactive['addendum: black'] then
		if strategem == 'cost' then
			send_command('@input /ja Parsimony <me>')
		elseif strategem == 'speed' then
			send_command('@input /ja Alacrity <me>')
		elseif strategem == 'aoe' then
			send_command('@input /ja Manifestation <me>')
		elseif strategem == 'power' then
			send_command('@input /ja Ebullience <me>')
		elseif strategem == 'duration' then
			add_to_chat(122,'Error: Dark Arts does not have a duration strategem.')
		elseif strategem == 'accuracy' then
			send_command('@input /ja Focalization <me>')
		elseif strategem == 'enmity' then
			send_command('@input /ja Equanimity <me>')
		elseif strategem == 'skillchain' then
			send_command('@input /ja Immanence <me>')
		elseif strategem == 'addendum' then
			send_command('@input /ja "Addendum: Black" <me>')
		else
			add_to_chat(123,'Error: Unknown strategem ['..strategem..']')
		end
	else
		add_to_chat(123,'No arts has been activated yet.')
	end
end

-- Gets the current number of available strategems based on the recast remaining
-- and the level of the sch.
function get_current_strategem_count()
	-- returns recast in seconds.
	local allRecasts = windower.ffxi.get_ability_recasts()
	local stratsRecast = allRecasts[231]

    local maxStrategems = math.floor(player.main_job_level + 10) / 20
 
    local fullRechargeTime = 5*33

	local currentCharges = math.floor(maxStrategems - maxStrategems * stratsRecast / fullRechargeTime)
	
	return currentCharges
end