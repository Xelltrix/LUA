-------------------------------------------------------------------------------------------------------------------
-- Tables and functions for commonly-referenced gear that job files may need, but
-- doesn't belong in the global Mote-Include file since they'd get clobbered on each
-- update.
-- Creates the 'gear' table for reference in other files.
--
-- Note: Function and table definitions should be added to user, but references to
-- the contained tables via functions (such as for the obi function, below) use only
-- the 'gear' table.
-------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------
-- Modify the sets table.  Any gear sets that are added to the sets table need to
-- be defined within this function, because sets isn't available until after the
-- include is complete.  It is called at the end of basic initialization in Mote-Include.
-------------------------------------------------------------------------------------------------------------------

function define_global_sets()
	-- Special gear info that may be useful across jobs.

	-- Staffs
	gear.Grioavolr_Enf = { name="Grioavolr", augments={'Enfb.mag. skill +10','INT+17','Mag. Acc.+22','"Mag.Atk.Bns."+20','Magic Damage +9'}}
	gear.Grioavolr_Pet = { name="Grioavolr", augments={'Blood Pact Dmg.+10','Pet: STR+4','Pet: Mag. Acc.+11','Pet: "Mag.Atk.Bns."+17'}}
	
	-- Capes
	gear.BLUCape_STP = { name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken -10%'}}
	gear.BLUCape_DW = { name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Phys. dmg. taken -10%'}}
	gear.BLUCape_Crit = { name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10'}}
	gear.BLUCape_WSD = { name="Rosmerta's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%'}}
	gear.BLUCape_Nuke = { name="Rosmerta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Phys. dmg. taken-10%'}}

	gear.RDMCape_Nuke = { name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Phys. dmg. taken-10%'}}
	gear.RDMCape_DW = { name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Phys. dmg. taken -10%'}}
	gear.RDMCape_WSD = { name="Sucellos's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%'}}
	gear.RDMCape_Crit = { name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10'}}
	gear.RDMCape_STP = { name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken -10%'}}
	gear.RDMCape_ENF = { name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Weapon skill damage +10%'}}
	
	gear.SCHCape_Nuke = { name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10','Phys. dmg. taken-10%'}}
	gear.SCHCape_ENF = { name="Lugh's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10%'}}
	
	gear.RUNCape_STP = { name="Ogma's cape", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10','Phys. dmg. taken-10%',}}
	gear.RUNCape_FC = { name="Ogma's cape", augments={'Eva.+20 /Mag. Eva.+20','"Fast Cast"+10',}}
	
	gear.THFCape_STP = { name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10','Phys. dmg. taken-10%',}}
	gear.THFCape_Crit = { name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Crit.hit rate+10',}}
	
	gear.SMNCape_Phys = { name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Eva.+10 /Mag. Eva.+10','Pet: "Regen"+10',}}
	gear.SMNCape_Mag =  { name="Campestres's Cape", augments={'Pet: M.Acc.+20 Pet: M.Dmg.+20','Eva.+10 /Mag. Eva.+10','"Fast Cast"+10','Phys. dmg. taken-10%',}}
	
	-- Colada
	gear.Colada_ENH = { name="Colada", augments={'Enh. Mag. eff. dur. +4','Mag. Acc.+8','DMG:+14'}}
	
	-- Apogee
	gear.ASlacks_MAB = { name="Apogee Slacks +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}}
	gear.ASlacks_DA = { name="Apogee Slacks +1", augments={'Pet: STR+20','Blood Pact Dmg.+14','Pet: "Dbl. Atk."+4',}}
	
	--Merlinic
	gear.PetHood = { name="Merlinic Hood", augments={'Blood Pact Dmg.+9','Pet: STR+7','Pet: Mag. Acc.+11','Pet: "Mag.Atk.Bns."+14'}}
	gear.NukeHood = { name="Merlinic Hood", augments={'Mag. Acc.+21 "Mag.Atk.Bns."+21','"Occult Acumen"+8','INT+8','Mag. Acc.+10','"Mag.Atk.Bns."+15',}}
	
	gear.PetAtkHands = { name="Merlinic Dastanas", augments={'Pet: Attack+24 Pet: Rng.Atk.+24','Blood Pact Dmg.+10','Pet: DEX+2','Pet: Mag. Acc.+10',}}
	gear.PetNukeHands = { name="Merlinic Dastanas", augments={'Pet: Mag. Acc.+17 Pet: "Mag.Atk.Bns."+17','Blood Pact Dmg.+9','Pet: INT+9','Pet: "Mag.Atk.Bns."+3',}}
	
	gear.NukeCrackows = { name="Merlinic Crackows", augments={'Mag. Acc.+21 "Mag.Atk.Bns."+21','Magic burst dmg.+11%','Mag. Acc.+14',}}
	gear.PetCrackows = { name="Merlinic Crackows", augments={'Pet: "Mag.Atk.Bns."+26','Blood Pact Dmg.+9','Pet: VIT+10','Pet: Mag. Acc.+10'}}

	--- Herculean
	gear.HHead_MAB = {name="Herculean Helm", augments={'Mag. Acc.+14 "Mag.Atk.Bns."+14','Magic burst dmg.+5%','MND+10','Mag. Acc.+14','"Mag.Atk.Bns."+15',}}
	gear.HHead_WSD = { name="Herculean Helm", augments={'Accuracy+29','Weapon skill damage +4%','STR+9','Attack+15'}}
	
	gear.HHands_TH = { name="Herculean Gloves", augments={'STR+4','"Waltz" potency +4%','"Treasure Hunter"+1','Accuracy+5 Attack+5',}}
	
	gear.HBoots_TP = { name="Herculean Boots", augments={'Accuracy+20 Attack+20','"Triple Atk."+4','Accuracy+6','Attack+15',}}
	gear.HBoots_Crit = { name="Herculean Boots", augments={'Accuracy+26','Crit. hit damage +5%','DEX+8',}}
	gear.HBoots_WSD = { name="Herculean Boots", augments={'Weapon skill damage +4%','STR+10','Attack+26',}}
	gear.HBoots_Refresh = { name="Herculean Boots", augments={'CHR+2','"Avatar perpetuation cost" -4','"Refresh"+1',}}
	
	--- Taeon
	gear.THead_Phalanx = { name="Taeon Chapeau", augments={'Mag. Evasion+5','Spell interruption rate down -10%','Phalanx +3',}}
    gear.TBody_Phalanx = { name="Taeon Tabard", augments={'Mag. Evasion+8','"Fast Cast"+5','Phalanx +3',}}
    gear.THands_Phalanx = { name="Taeon Gloves", augments={'Mag. Evasion+13','Spell interruption rate down -9%','Phalanx +3',}}
    gear.TLegs_Phalanx = { name="Taeon Tights", augments={'Mag. Evasion+20','Spell interruption rate down -10%','Phalanx +3',}}
    gear.TFeet_Phalanx = { name="Taeon Boots", augments={'Mag. Evasion+19','Spell interruption rate down -10%','Phalanx +3',}}
	
	gear.THead_TP = { name="Taeon Chapeau", augments={'Accuracy+19 Attack+19','"Triple Atk."+2','DEX+10',}}
    gear.THands_TP = { name="Taeon Gloves", augments={'Accuracy+17 Attack+17','"Triple Atk."+2','STR+7 DEX+7',}}
    gear.TLegs_TP = { name="Taeon Tights", augments={'Accuracy+20 Attack+20','"Triple Atk."+2','STR+7 DEX+7',}}
    gear.TFeet_TP = { name="Taeon Boots", augments={'Accuracy+19 Attack+19','"Triple Atk."+2','DEX+10',}}
	
	---Telchine
	gear.SiphonHands = { name="Telchine Gloves", augments={'"Elemental Siphon"+35',}}
	gear.ENH_Gloves = { name="Telchine Gloves", augments={'"Mag.Atk.Bns."+15','"Fast Cast"+5','Enh. Mag. eff. dur. +10',}}
	
end

-------------------------------------------------------------------------------------------------------------------
-- Functions to set user-specified binds, generally on load and unload.
-- Kept separate from the main include so as to not get clobbered when the main is updated.
-------------------------------------------------------------------------------------------------------------------
--[[
^ = Control
! = Alt
@ = Win


BKSP, BS, BACKSPACE
BREAK
CAPSLOCK
CLEAR
DEL
DELETE
DOWN
END
ENTER
ESC,ESCAPE
F1, F2, F3, F4, F5, F6, F7, F8, F9, F10, F11, F12, F13, F14, F15, F16, F17, F18, F19, F20, F21, F22, F23, F24
HELP
HOME
INS
LEFT
NUM0, NUM1, NUM2, NUM3, NUM4, NUM5, NUM6, NUM7, NUM8, NUM9
NUMDECIMAL
NUMDIVIDE
NUMLOCK
NUMMINUS
NUMMULTIPLY
NUMPLUS
PGDN
PGUP
PRTSC
RIGHT
SCROLLLOCK
TAB
UP


]]--


--Function to bind GearSwap binds when loading a GS script.
function global_on_load()
	--General Bindings
	send_command('bind f9 gs c cycle OffenseMode')
	send_command('bind ^f9 gs c cycle HybridMode')
	send_command('bind !f9 gs c cycleback HybridMode')
	
	send_command('bind f10 gs c set DefenseMode Physical')
	send_command('bind ^f10 gs c cycle PhysicalDefenseMode')
	send_command('bind !f10 gs c cycleback PhysicalDefenseMode')
	
	send_command('bind f11 gs c set DefenseMode Magical')
	send_command('bind ^f11 gs c cycle MagicalDefenseMode')
	send_command('bind !f11 gs c cycleback MagicalDefenseMode')
	
	send_command('bind f12 gs c update user')
	send_command('bind ^f12 gs c cycle IdleMode')
	send_command('bind !f12 gs c reset DefenseMode')
	
	send_command('bind NUMDIVIDE gs c cycle CastingMode')
	send_command('bind NUMMULTIPLY gs c toggle MagicBurst')
	send_command('bind NUMPLUS gs c toggle SaveMP')
	send_command('bind NUMMINUS gs c toggle Kiting')
	
	
end

-- Function to revert binds when unloading.
function global_on_unload()
	send_command('unbind f9')
	send_command('unbind ^f9')
	send_command('unbind !f9')
	
	send_command('unbind f10')
	send_command('unbind ^f10')
	send_command('unbind !f10')
	
	send_command('unbind f11')
	send_command('unbind ^f11')
	send_command('unbind !f11')
	
	send_command('unbind f12')
	send_command('unbind ^f12')
	send_command('unbind !f12')
	
	send_command('unbind NUMDIVIDE')
	send_command('unbind NUMMULTIPLY')
	send_command('unbind NUMPLUS')
	send_command('unbind NUMMINUS')
end



--[[ Function to bind GearSwap binds when loading a GS script.
function global_on_load()
	send_command('bind f9 gs c cycle OffenseMode')
	send_command('bind ^f9 gs c cycle HybridMode')
	send_command('bind !f9 gs c cycle RangedMode')
	send_command('bind @f9 gs c cycle WeaponskillMode')
	send_command('bind f10 gs c set DefenseMode Physical')
	send_command('bind ^f10 gs c cycle PhysicalDefenseMode')
	send_command('bind !f10 gs c toggle Kiting')
	send_command('bind f11 gs c set DefenseMode Magical')
	send_command('bind ^f11 gs c cycle CastingMode')
	send_command('bind f12 gs c update user')
	send_command('bind ^f12 gs c cycle IdleMode')
	send_command('bind !f12 gs c reset DefenseMode')
end

-- Function to revert binds when unloading.
function global_on_unload()
	send_command('unbind f9')
	send_command('unbind ^f9')
	send_command('unbind !f9')
	send_command('unbind @f9')
	send_command('unbind f10')
	send_command('unbind ^f10')
	send_command('unbind !f10')
	send_command('unbind f11')
	send_command('unbind ^f11')
	send_command('unbind !f11')
	send_command('unbind f12')
	send_command('unbind ^f12')
	send_command('unbind !f12')
end
]]--
-------------------------------------------------------------------------------------------------------------------
-- Global event-handling functions.
-------------------------------------------------------------------------------------------------------------------

-- Global intercept on precast.
function user_precast(spell, action, spellMap, eventArgs)
    cancel_conflicting_buffs(spell, action, spellMap, eventArgs)
end

-- Global intercept on midcast.
function user_midcast(spell, action, spellMap, eventArgs)
	-- Default base equipment layer of fast recast.
	if spell.action_type == 'Magic' and sets.midcast and sets.midcast.FastRecast then
		equip(sets.midcast.FastRecast)
	end
end
