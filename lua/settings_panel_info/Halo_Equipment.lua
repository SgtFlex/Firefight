return {
    name = "Halo Equipment",
    subtree = {  
        ["General"] = {
            controls = {
                ["Equipment Bind"] = {
                    convar = "he_equipment_bind",
                    default = 30,
                    desc = "The bind to deploy Halo equipment",
                    client = true,
                    panel = {type = "DBinder", OnChange = function(num)
                        LocalPlayer():ConCommand("hwi_equipment_bind "..tostring(input.GetKeyName(num)))
                    end}
                }
            }
        },
        ["Halo Reach"] = {
            subtree = {
                ["Active Camo Equipment"] = {
                    icon = "entities/obj_ff_equipment_active_camo.png",
                    model = "models/hr/unsc/equipment/equipment.mdl",
                    controls = {
                        ["Resource Max"] = {
                            convar = "h_active_camo_resource_max",
                            default = 100,
                            desc = "The maximum resource for this equipment.",
                        },
                        ["Resource Regen"] = {
                            convar = "h_active_camo_resource_regen",
                            default = 5,
                            desc = "The resource regenerated per second.",
                        },
                        ["Resource Cost Per Second"] = {
                            convar = "h_active_camo_resource_cps",
                            default = 5,
                            desc = "The resource that is subtracted per second when active.",
                        },
                        ["Resource Cost Initial"] = {
                            convar = "h_active_camo_resource_cost_initial",
                            default = 25,
                            desc = "The resource that is subtracted when initially activated.",
                        },
                        ["Resource Regen Delay"] = {
                            convar = "h_active_camo_resource_delay",
                            default = 0.5,
                            desc = "The amount of seconds before the equipment's resource begins regenerating.",
                        }
                    },
                    subtree = nil
                },
                ["Armor Lock Equipment"] = {
                    icon = "entities/obj_ff_equipment_armor_lock.png",
                    model = "models/hr/unsc/equipment/equipment.mdl",
                    controls = {
                        ["Resource Max"] = {
                            convar = "h_armor_lock_resource_max",
                            default = 100,
                            desc = "The maximum resource for this equipment.",
                        },
                        ["Resource Regen"] = {
                            convar = "h_armor_lock_resource_regen",
                            default = 5,
                            desc = "The resource regenerated per second.",
                        },
                        ["Resource Cost Per Second"] = {
                            convar = "h_armor_lock_resource_cps",
                            default = 5,
                            desc = "The resource that is subtracted per second when active.",
                        },
                        ["Resource Cost Initial"] = {
                            convar = "h_armor_lock_resource_cost_initial",
                            default = 25,
                            desc = "The resource that is subtracted when initially activated.",
                        },
                        ["Resource Regen Delay"] = {
                            convar = "h_armor_lock_resource_delay",
                            default = 0.5,
                            desc = "The amount of seconds before the equipment's resource begins regenerating.",
                        },
                    }
                },
                ["Drop Shield Equipment"] = {
                    icon = "entities/obj_ff_equipment_drop_shield.png",
                    model = "models/hr/unsc/equipment/equipment.mdl",
                    controls = {
                        ["Duration"] = {
                            convar = "h_drop_shield_duration",
                            default = 10,
                            desc = "The duration of this deployable.",
                        },
                        ["Health"] = {
                            convar = "h_drop_shield_health",
                            default = 300,
                            desc = "The amount of health this deployable has.",
                        },
                        ["Resource Max"] = {
                            convar = "h_drop_shield_resource_max",
                            default = 100,
                            desc = "The maximum resource for this equipment.",
                        },
                        ["Resource Regen"] = {
                            convar = "h_drop_shield_resource_regen",
                            default = 5,
                            desc = "The resource regenerated per second.",
                        },
                        ["Resource Cost Per Second"] = {
                            convar = "h_drop_shield_resource_cps",
                            default = 5,
                            desc = "The resource that is subtracted per second when active.",
                        },
                        ["Resource Cost Initial"] = {
                            convar = "h_drop_shield_resource_cost_initial",
                            default = 25,
                            desc = "The resource that is subtracted when initially activated.",
                        },
                        ["Resource Regen Delay"] = {
                            convar = "h_drop_shield_resource_delay",
                            default = 0.5,
                            desc = "The amount of seconds before the equipment's resource begins regenerating.",
                        },
                    }
                },
                ["Evade Equipment"] = {
                    icon = "entities/obj_ff_equipment_evade.png",
                    model = "models/hr/unsc/equipment_pack_elite/equipment_pack_elite.mdl",
                    controls = {
                        ["Evasion Power"] = {
                            convar = "h_evade_power",
                            default = 100,
                            desc = "The amount of horizontal thrust applied when evading.",
                        },
                        ["Resource Max"] = {
                            convar = "h_evade_resource_max",
                            default = 100,
                            desc = "The maximum resource for this equipment.",
                        },
                        ["Resource Regen"] = {
                            convar = "h_evade_resource_regen",
                            default = 5,
                            desc = "The resource regenerated per second.",
                        },
                        ["Resource Cost Per Second"] = {
                            convar = "h_evade_resource_cps",
                            default = 5,
                            desc = "The resource that is subtracted per second when active.",
                        },
                        ["Resource Cost Initial"] = {
                            convar = "h_evade_resource_cost_initial",
                            default = 25,
                            desc = "The resource that is subtracted when initially activated.",
                        },
                        ["Resource Regen Delay"] = {
                            convar = "h_evade_resource_delay",
                            default = 0.5,
                            desc = "The amount of seconds before the equipment's resource begins regenerating.",
                        },
                    }
                },
                ["Hologram Equipment"] = {
                    icon = "entities/obj_ff_equipment_hologram.png",
                    model = "models/hr/unsc/equipment/equipment.mdl",
                    controls = {
                        ["Damage multiplier"] = {
                            convar = "h_hologram_damage_multiplier",
                            default = 10,
                            desc = "The multiplier of the incoming damage applied.",
                        },
                        ["Duration"] = {
                            convar = "h_hologram_duration",
                            default = 10,
                            desc = "The duration of this deployable.",
                        },
                        ["Resource Max"] = {
                            convar = "h_hologram_resource_max",
                            default = 100,
                            desc = "The maximum resource for this equipment.",
                        },
                        ["Resource Regen"] = {
                            convar = "h_hologram_resource_regen",
                            default = 5,
                            desc = "The resource regenerated per second.",
                        },
                        ["Resource Cost Per Second"] = {
                            convar = "h_hologram_resource_cps",
                            default = 5,
                            desc = "The resource that is subtracted per second when active.",
                        },
                        ["Resource Cost Initial"] = {
                            convar = "h_hologram_resource_cost_initial",
                            default = 25,
                            desc = "The resource that is subtracted when initially activated.",
                        },
                        ["Resource Regen Delay"] = {
                            convar = "h_hologram_resource_delay",
                            default = 0.5,
                            desc = "The amount of seconds before the equipment's resource begins regenerating.",
                        },
                    }
                },
                ["Jet Pack Equipment"] = {
                    icon = "entities/obj_ff_equipment_jet_pack.png",
                    model = "models/hr/unsc/equipment_jet_pack/equipment_jet_pack.mdl",
                    controls = {
                        ["Thrust Power"] = {
                            convar = "h_jet_pack_thrust_power",
                            default = 100,
                            desc = "The amount of vertical thrust applied.",
                        },
                        ["Resource Max"] = {
                            convar = "h_jet_pack_resource_max",
                            default = 100,
                            desc = "The maximum resource for this equipment.",
                        },
                        ["Resource Regen"] = {
                            convar = "h_jet_pack_resource_regen",
                            default = 5,
                            desc = "The resource regenerated per second.",
                        },
                        ["Resource Cost Per Second"] = {
                            convar = "h_jet_pack_resource_cps",
                            default = 5,
                            desc = "The resource that is subtracted per second when active.",
                        },
                        ["Resource Cost Initial"] = {
                            convar = "h_jet_pack_resource_cost_initial",
                            default = 25,
                            desc = "The resource that is subtracted when initially activated.",
                        },
                        ["Resource Regen Delay"] = {
                            convar = "h_jet_pack_resource_delay",
                            default = 0.5,
                            desc = "The amount of seconds before the equipment's resource begins regenerating.",
                        },
                    }
                },
                ["Sprint Equipment"] = {
                    icon = "entities/obj_ff_equipment_sprint.png",
                    model = "models/hr/unsc/equipment/equipment.mdl",
                    controls = {
                        ["Speed"] = {
                            convar = "h_sprint_speed",
                            default = 100,
                            desc = "The speed at which the user goes when using this equipment.",
                        },
                        ["Resource Max"] = {
                            convar = "h_sprint_resource_max",
                            default = 100,
                            desc = "The maximum resource for this equipment.",
                        },
                        ["Resource Regen"] = {
                            convar = "h_sprint_resource_regen",
                            default = 5,
                            desc = "The resource regenerated per second.",
                        },
                        ["Resource Cost Per Second"] = {
                            convar = "h_sprint_resource_cps",
                            default = 5,
                            desc = "The resource that is subtracted per second when active.",
                        },
                        ["Resource Cost Initial"] = {
                            convar = "h_sprint_resource_cost_initial",
                            default = 25,
                            desc = "The resource that is subtracted when initially activated.",
                        },
                        ["Resource Regen Delay"] = {
                            convar = "h_sprint_resource_delay",
                            default = 0.5,
                            desc = "The amount of seconds before the equipment's resource begins regenerating.",
                        },
                    }
                },
            },
        },
        ["Halo 3"] = {
            subtree = {
                ["Auto Turret Equipment"] = {
                    icon = "entities/obj_ff_equipment_auto_turret.png",
                    model = "models/sentinels/sentinel_turret.mdl",
                    controls = {
                        ["Resource Max"] = {
                            convar = "h_auto_turret_resource_max",
                            default = 1,
                            desc = "The maximum resource for this equipment.",
                        },
                        ["Resource Regen"] = {
                            convar = "h_auto_turret_resource_regen",
                            default = 0,
                            desc = "The resource regenerated per second.",
                        },
                        ["Resource Cost Per Second"] = {
                            convar = "h_auto_turret_resource_cps",
                            default = 0,
                            desc = "The resource that is subtracted per second when active.",
                        },
                        ["Resource Cost Initial"] = {
                            convar = "h_auto_turret_resource_cost_initial",
                            default = 1,
                            desc = "The resource that is subtracted when initially activated.",
                        },
                        ["Resource Regen Delay"] = {
                            convar = "h_auto_turret_resource_delay",
                            default = 0,
                            desc = "The amount of seconds before the equipment's resource begins regenerating.",
                        },
                    }
                },
                ["Bubble Shield Equipment"] = {
                    icon = "entities/obj_ff_equipment_bubble_shield.png",
                    model = "models/hr/cov/equipment_bubble_shield/equipment_bubble_shield.mdl",
                    controls = {
                        ["Duration"] = {
                            convar = "h_bubble_shield_duration",
                            default = 20,
                            desc = "The duration of this deployable.",
                        },
                        ["Effect Radius"] = {
                            convar = "h_bubble_shield_effect_radius",
                            default = 200,
                            desc = "The radius of the effect of this deployable.",
                            panel = {type = "DNumberWang"}
                        },
                        ["Effect Delay"] = {
                            convar = "h_bubble_shield_effect_delay",
                            default = 0.85,
                            desc = "The number of seconds before the effect starts after the equipment is deployed.",
                            panel = {type = "DNumberWang"}
                        },
                        ["Explosion Damage"] = {
                            convar = "h_bubble_shield_expl_damage",
                            default = 0,
                            desc = "How much damage the equipment deals when expiring.",
                            panel = {type = "DNumberWang"}
                        },
                        ["Explosion Radius"] = {
                            convar = "h_bubble_shield_expl_radius",
                            default = 300,
                            desc = "How much damage the equipment deals when expiring.",
                            panel = {type = "DNumberWang"}
                        },
                        ["Health"] = {
                            convar = "h_bubble_shield_health",
                            default = 25,
                            desc = "The amount of health this deployable has.",
                        },
                        ["Resource Max"] = {
                            convar = "h_bubble_shield_resource_max",
                            default = 1,
                            desc = "The maximum resource for this equipment.",
                        },
                        ["Resource Regen"] = {
                            convar = "h_bubble_shield_resource_regen",
                            default = 0,
                            desc = "The resource regenerated per second.",
                        },
                        ["Resource Cost Per Second"] = {
                            convar = "h_bubble_shield_resource_cps",
                            default = 0,
                            desc = "The resource that is subtracted per second when active.",
                        },
                        ["Resource Cost Initial"] = {
                            convar = "h_bubble_shield_resource_cost_initial",
                            default = 1,
                            desc = "The resource that is subtracted when initially activated.",
                        },
                        ["Resource Regen Delay"] = {
                            convar = "h_bubble_shield_resource_delay",
                            default = 0,
                            desc = "The amount of seconds before the equipment's resource begins regenerating.",
                        },
                    }
                },
                ["Energy Drain Equipment"] = {
                    icon = "entities/obj_ff_equipment_energy_drain.png",
                    model = "models/hr/cov/equipment_power_drain/equipment_power_drain.mdl",
                    controls = {
                        ["Shield/Armor Drain per tick"] = {
                            convar = "h_energy_drain_dps",
                            default = 3,
                            desc = "The amount of shields drained per second.",
                        },
                        ["Effect Radius"] = {
                            convar = "h_energy_drain_effect_radius",
                            default = 200,
                            desc = "The radius of the effect of this deployable.",
                            panel = {type = "DNumberWang"}
                        },
                        ["Effect Delay"] = {
                            convar = "h_energy_drain_effect_delay",
                            default = 0.5,
                            desc = "The number of seconds before the effect starts after the equipment is deployed.",
                            panel = {type = "DNumberWang"}
                        },
                        ["Effect Tick Rate"] = {
                            convar = "h_energy_drain_effect_tick",
                            default = 0.1,
                            desc = "How often in seconds the effect occurs.",
                            panel = {type = "DNumberWang"}
                        },
                        ["Explosion Damage"] = {
                            convar = "h_energy_drain_expl_damage",
                            default = 10,
                            desc = "The damage inflicted when this deployable explodes.",
                        },
                        ["Explosion Radius"] = {
                            convar = "h_energy_drain_expl_radius",
                            default = 200,
                            desc = "The radius of the explosion when this deployable explodes.",
                            panel = {type = "DNumberWang"}
                        },
                        ["Duration"] = {
                            convar = "h_energy_drain_duration",
                            default = 7,
                            desc = "The duration of this deployable.",
                            panel = {type = "DNumberWang"}
                        },
                        ["Health"] = {
                            convar = "h_energy_drain_health",
                            default = 25,
                            desc = "The amount of health this deployable has.",
                            panel = {type = "DNumberWang"}
                        },
                        ["Resource Max"] = {
                            convar = "h_energy_drain_resource_max",
                            default = 1,
                            desc = "The maximum resource for this equipment.",
                            panel = {type = "DNumberWang"}
                        },
                        ["Resource Regen"] = {
                            convar = "h_energy_drain_resource_regen",
                            default = 0,
                            desc = "The resource regenerated per second.",
                            panel = {type = "DNumberWang"}
                        },
                        ["Resource Cost Per Second"] = {
                            convar = "h_energy_drain_resource_cps",
                            default = 0,
                            desc = "The resource that is subtracted per second when active.",
                            panel = {type = "DNumberWang"}
                        },
                        ["Resource Cost Initial"] = {
                            convar = "h_energy_drain_resource_cost_initial",
                            default = 1,
                            desc = "The resource that is subtracted when initially activated.",
                            panel = {type = "DNumberWang"}
                        },
                        ["Resource Regen Delay"] = {
                            convar = "h_energy_drain_resource_delay",
                            default = 0,
                            desc = "The amount of seconds before the equipment's resource begins regenerating.",
                            panel = {type = "DNumberWang"}
                        },
                    }
                },
                ["Flare Equipment"] = {
                    icon = "entities/obj_ff_equipment_flare.png",
                    model = "models/hr/cov/equipment_power_drain/equipment_power_drain.mdl",
                    controls = {
                        ["Duration"] = {
                            convar = "h_flare_duration",
                            default = 6,
                            desc = "The duration of this deployable.",
                            panel = {type = "DNumberWang"}
                        },
                        ["Effect Radius"] = {
                            convar = "h_flare_effect_radius",
                            default = 500,
                            desc = "The radius of the effect of this deployable.",
                            panel = {type = "DNumberWang"}
                        },
                        ["Effect Delay"] = {
                            convar = "h_flare_effect_delay",
                            default = 0.5,
                            desc = "The number of seconds before the effect starts after the equipment is deployed.",
                            panel = {type = "DNumberWang"}
                        },
                        ["Effect Tick Rate"] = {
                            convar = "h_flare_effect_tick",
                            default = 0.1,
                            desc = "How often in seconds the effect occurs.",
                            panel = {type = "DNumberWang"}
                        },
                        ["Explosion Damage"] = {
                            convar = "h_flare_expl_damage",
                            default = 0,
                            desc = "How much damage the equipment deals when expiring.",
                            panel = {type = "DNumberWang"}
                        },
                        ["Explosion Radius"] = {
                            convar = "h_flare_expl_radius",
                            default = 300,
                            desc = "How much damage the equipment deals when expiring.",
                            panel = {type = "DNumberWang"}
                        },
                        ["Health"] = {
                            convar = "h_flare_health",
                            default = 15,
                            desc = "The amount of health this deployable has.",
                            panel = {type = "DNumberWang"}
                        },
                        ["Resource Max"] = {
                            convar = "h_flare_resource_max",
                            default = 1,
                            desc = "The maximum resource for this equipment.",
                            panel = {type = "DNumberWang"}
                        },
                        ["Resource Regen"] = {
                            convar = "h_flare_resource_regen",
                            default = 0,
                            desc = "The resource regenerated per second.",
                            panel = {type = "DNumberWang"}
                        },
                        ["Resource Cost Per Second"] = {
                            convar = "h_flare_resource_cps",
                            default = 0,
                            desc = "The resource that is subtracted per second when active.",
                            panel = {type = "DNumberWang"}
                        },
                        ["Resource Cost Initial"] = {
                            convar = "h_flare_resource_cost_initial",
                            default = 1,
                            desc = "The resource that is subtracted when initially activated.",
                            panel = {type = "DNumberWang"}
                        },
                        ["Resource Regen Delay"] = {
                            convar = "h_flare_resource_delay",
                            default = 0,
                            desc = "The amount of seconds before the equipment's resource begins regenerating.",
                            panel = {type = "DNumberWang"}
                        },
                    }
                },
                ["Portable Gravity Lift Equipment"] = {
                    icon = "entities/obj_ff_equipment_grav_lift.png",
                    model = "models/hr/cov/equipment_grav_lift/equipment_grav_lift_undeployed.mdl",
                    controls = {
                        ["Lift Power"] = {
                            convar = "h_grav_lift_power",
                            default = 200,
                            desc = "The amount of lift applied to objects.",
                            panel = {type = "DNumberWang"}
                        },
                        ["Effect Radius"] = {
                            convar = "h_grav_lift_effect_radius",
                            default = 300,
                            desc = "The radius of the effect of this deployable.",
                            panel = {type = "DNumberWang"}
                        },
                        ["Effect Delay"] = {
                            convar = "h_grav_lift_effect_delay",
                            default = 0.5,
                            desc = "The number of seconds before the effect starts after the equipment is deployed.",
                            panel = {type = "DNumberWang"}
                        },
                        ["Effect Tick Rate"] = {
                            convar = "h_grav_lift_effect_tick",
                            default = 0.1,
                            desc = "How often in seconds the effect occurs.",
                            panel = {type = "DNumberWang"}
                        },
                        ["Explosion Damage"] = {
                            convar = "h_grav_lift_expl_damage",
                            default = 0,
                            desc = "How much damage the equipment deals when expiring.",
                            panel = {type = "DNumberWang"}
                        },
                        ["Explosion Radius"] = {
                            convar = "h_grav_lift_expl_radius",
                            default = 300,
                            desc = "How much damage the equipment deals when expiring.",
                            panel = {type = "DNumberWang"}
                        },
                        ["Duration"] = {
                            convar = "h_grav_lift_duration",
                            default = 30,
                            desc = "The duration of this deployable.",
                            panel = {type = "DNumberWang"}
                        },
                        ["Health"] = {
                            convar = "h_grav_lift_health",
                            default = 25,
                            desc = "The amount of health this deployable has.",
                            panel = {type = "DNumberWang"}
                        },
                        ["Resource Max"] = {
                            convar = "h_grav_lift_resource_max",
                            default = 1,
                            desc = "The maximum resource for this equipment.",
                            panel = {type = "DNumberWang"}
                        },
                        ["Resource Regen"] = {
                            convar = "h_grav_lift_resource_regen",
                            default = 0,
                            desc = "The resource regenerated per second.",
                            panel = {type = "DNumberWang"}
                        },
                        ["Resource Cost Per Second"] = {
                            convar = "h_grav_lift_resource_cps",
                            default = 0,
                            desc = "The resource that is subtracted per second when active.",
                            panel = {type = "DNumberWang"}
                        },
                        ["Resource Cost Initial"] = {
                            convar = "h_grav_lift_resource_cost_initial",
                            default = 1,
                            desc = "The resource that is subtracted when initially activated.",
                            panel = {type = "DNumberWang"}
                        },
                        ["Resource Regen Delay"] = {
                            convar = "h_grav_lift_resource_delay",
                            default = 0,
                            desc = "The amount of seconds before the equipment's resource begins regenerating.",
                            panel = {type = "DNumberWang"}
                        },
                    }
                },
                ["Radar Jammer Equipment"] = {
                    icon = "entities/obj_ff_equipment_radar_jammer.png",
                    model = "models/hr/cov/equipment_power_drain/equipment_power_drain.mdl",
                    controls = {
                        ["Duration"] = {
                            convar = "h_radar_jammer_duration",
                            default = 30,
                            desc = "The duration of this deployable.",
                            panel = {type = "DNumberWang"}
                        },
                        ["Effect Radius"] = {
                            convar = "h_radar_jammer_effect_radius",
                            default = 200,
                            desc = "The radius of the effect of this deployable.",
                            panel = {type = "DNumberWang"}
                        },
                        ["Effect Delay"] = {
                            convar = "h_radar_jammer_effect_delay",
                            default = 0.5,
                            desc = "The number of seconds before the effect starts after the equipment is deployed.",
                            panel = {type = "DNumberWang"}
                        },
                        ["Effect Tick Rate"] = {
                            convar = "h_radar_jammer_effect_tick",
                            default = 0.1,
                            desc = "How often in seconds the effect occurs.",
                            panel = {type = "DNumberWang"}
                        },
                        ["Explosion Damage"] = {
                            convar = "h_radar_jammer_expl_damage",
                            default = 0,
                            desc = "How much damage the equipment deals when expiring.",
                            panel = {type = "DNumberWang"}
                        },
                        ["Explosion Radius"] = {
                            convar = "h_radar_jammer_expl_radius",
                            default = 300,
                            desc = "How much damage the equipment deals when expiring.",
                            panel = {type = "DNumberWang"}
                        },
                        ["Health"] = {
                            convar = "h_radar_jammer_health",
                            default = 25,
                            desc = "The amount of health this deployable has.",
                            panel = {type = "DNumberWang"}
                        },
                        ["Resource Max"] = {
                            convar = "h_radar_jammer_resource_max",
                            default = 1,
                            desc = "The maximum resource for this equipment.",
                            panel = {type = "DNumberWang"}
                        },
                        ["Resource Regen"] = {
                            convar = "h_radar_jammer_resource_regen",
                            default = 0,
                            desc = "The resource regenerated per second.",
                            panel = {type = "DNumberWang"}
                        },
                        ["Resource Cost Per Second"] = {
                            convar = "h_radar_jammer_resource_cps",
                            default = 0,
                            desc = "The resource that is subtracted per second when active.",
                            panel = {type = "DNumberWang"}
                        },
                        ["Resource Cost Initial"] = {
                            convar = "h_radar_jammer_resource_cost_initial",
                            default = 1,
                            desc = "The resource that is subtracted when initially activated.",
                            panel = {type = "DNumberWang"}
                        },
                        ["Resource Regen Delay"] = {
                            convar = "h_radar_jammer_resource_delay",
                            default = 0,
                            desc = "The amount of seconds before the equipment's resource begins regenerating.",
                            panel = {type = "DNumberWang"}
                        },
                    }
                },
                ["Regenerator Equipment"] = {
                    icon = "entities/obj_ff_equipment_regenerator.png",
                    model = "models/hr/cov/equipment_regenerator/equipment_regenerator.mdl",
                    controls = {
                        ["Effect Radius"] = {
                            convar = "h_regenerator_effect_radius",
                            default = 200,
                            desc = "The radius of the effect of this deployable.",
                            panel = {type = "DNumberWang"}
                        },
                        ["Effect Delay"] = {
                            convar = "h_regenerator_effect_delay",
                            default = 0.5,
                            desc = "The number of seconds before the effect starts after the equipment is deployed.",
                            panel = {type = "DNumberWang"}
                        },
                        ["Effect Tick Rate"] = {
                            convar = "h_regenerator_effect_tick",
                            default = 0.1,
                            desc = "How often in seconds the effect occurs.",
                            panel = {type = "DNumberWang"}
                        },
                        ["Explosion Damage"] = {
                            convar = "h_regenerator_expl_damage",
                            default = 0,
                            desc = "How much damage the equipment deals when expiring.",
                            panel = {type = "DNumberWang"}
                        },
                        ["Explosion Radius"] = {
                            convar = "h_regenerator_expl_radius",
                            default = 300,
                            desc = "How much damage the equipment deals when expiring.",
                            panel = {type = "DNumberWang"}
                        },
                        ["Armor Regenerated Per Second"] = {
                            convar = "h_regenerator_aps",
                            default = 3,
                            desc = "The amount of armor regenerated per second.",
                            panel = {type = "DNumberWang"}
                        },
                        ["Health Regenerated Per Second"] = {
                            convar = "h_regenerator_hps",
                            default = 3,
                            desc = "The amount of armor regenerated per second.",
                            panel = {type = "DNumberWang"}
                        },
                        ["Duration"] = {
                            convar = "h_regenerator_duration",
                            default = 15,
                            desc = "The duration of this deployable.",
                            panel = {type = "DNumberWang"}
                        },
                        ["Health"] = {
                            convar = "h_regenerator_health",
                            default = 25,
                            desc = "The amount of health this deployable has.",
                            panel = {type = "DNumberWang"}
                        },
                        ["Resource Max"] = {
                            convar = "h_regenerator_resource_max",
                            default = 1,
                            desc = "The maximum resource for this equipment.",
                            panel = {type = "DNumberWang"}
                        },
                        ["Resource Regen"] = {
                            convar = "h_regenerator_resource_regen",
                            default = 0,
                            desc = "The resource regenerated per second.",
                            panel = {type = "DNumberWang"}
                        },
                        ["Resource Cost Per Second"] = {
                            convar = "h_regenerator_resource_cps",
                            default = 0,
                            desc = "The resource that is subtracted per second when active.",
                            panel = {type = "DNumberWang"}
                        },
                        ["Resource Cost Initial"] = {
                            convar = "h_regenerator_resource_cost_initial",
                            default = 1,
                            desc = "The resource that is subtracted when initially activated.",
                            panel = {type = "DNumberWang"}
                        },
                        ["Resource Regen Delay"] = {
                            convar = "h_regenerator_resource_delay",
                            default = 0,
                            desc = "The amount of seconds before the equipment's resource begins regenerating.",
                            panel = {type = "DNumberWang"}
                        },
                    }
                },
                ["Trip Mine Equipment"] = {
                    icon = "entities/obj_ff_equipment_trip_mine.png",
                    model = "models/hr/unsc/equipment_trip_mine/equipment_trip_mine.mdl",
                    controls = {
                        ["Explosion Damage"] = {
                            convar = "h_trip_mine_expl_damage",
                            default = 100,
                            desc = "The damage inflicted when this deployable explodes.",
                            panel = {type = "DNumberWang"}
                        },
                        ["Explosion Radius"] = {
                            convar = "h_trip_mine_expl_radius",
                            default = 500,
                            desc = "The radius of the explosion when this deployable explodes.",
                            panel = {type = "DNumberWang"}
                        },
                        ["Effect Radius"] = {
                            convar = "h_trip_mine_effect_radius",
                            default = 200,
                            desc = "The radius of the effect of this deployable.",
                            panel = {type = "DNumberWang"}
                        },
                        ["Effect Delay"] = {
                            convar = "h_trip_mine_effect_delay",
                            default = 1,
                            desc = "The number of seconds before the effect starts after the equipment is deployed.",
                            panel = {type = "DNumberWang"}
                        },
                        ["Effect Tick Rate"] = {
                            convar = "h_trip_mine_effect_tick",
                            default = 1,
                            desc = "How often in seconds the effect occurs.",
                            panel = {type = "DNumberWang"}
                        },
                        ["Duration"] = {
                            convar = "h_trip_mine_duration",
                            default = 90,
                            desc = "The duration of this deployable.",
                            panel = {type = "DNumberWang"}
                        },
                        ["Health"] = {
                            convar = "h_trip_mine_health",
                            default = 25,
                            desc = "The amount of health this deployable has.",
                            panel = {type = "DNumberWang"}
                        },
                        ["Resource Max"] = {
                            convar = "h_trip_mine_resource_max",
                            default = 1,
                            desc = "The maximum resource for this equipment.",
                            panel = {type = "DNumberWang"}
                        },
                        ["Resource Regen"] = {
                            convar = "h_trip_mine_resource_regen",
                            default = 0,
                            desc = "The resource regenerated per second.",
                            panel = {type = "DNumberWang"}
                        },
                        ["Resource Cost Per Second"] = {
                            convar = "h_trip_mine_resource_cps",
                            default = 0,
                            desc = "The resource that is subtracted per second when active.",
                            panel = {type = "DNumberWang"}
                        },
                        ["Resource Cost Initial"] = {
                            convar = "h_trip_mine_resource_cost_initial",
                            default = 1,
                            desc = "The resource that is subtracted when initially activated.",
                            panel = {type = "DNumberWang"}
                        },
                        ["Resource Regen Delay"] = {
                            convar = "h_trip_mine_resource_delay",
                            default = 0,
                            desc = "The amount of seconds before the equipment's resource begins regenerating.",
                            panel = {type = "DNumberWang"}
                        },
                    }
                },
            }
        },
        ["Halo Infinite"] = {
            subtree = {
                ["Grapple Shot Equipment"] = {
                    icon = "entities/obj_ff_equipment_grapple_shot.png",
                    model = "models/hr/unsc/equipment/equipment.mdl",
                    controls = {
                        ["Resource Max"] = {
                            convar = "h_grapple_shot_resource_max",
                            default = 3,
                            desc = "The maximum resource for this equipment.",
                            panel = {type = "DNumberWang"}
                        },
                        ["Resource Regen"] = {
                            convar = "h_grapple_shot_resource_regen",
                            default = 0,
                            desc = "The resource regenerated per second.",
                            panel = {type = "DNumberWang"}
                        },
                        ["Resource Cost Per Second"] = {
                            convar = "h_grapple_shot_resource_cps",
                            default = 0,
                            desc = "The resource that is subtracted per second when active.",
                            panel = {type = "DNumberWang"}
                        },
                        ["Resource Cost Initial"] = {
                            convar = "h_grapple_shot_resource_cost_initial",
                            default = 1,
                            desc = "The resource that is subtracted when initially activated.",
                            panel = {type = "DNumberWang"}
                        },
                        ["Resource Regen Delay"] = {
                            convar = "h_grapple_shot_resource_delay",
                            default = 0,
                            desc = "The amount of seconds before the equipment's resource begins regenerating.",
                            panel = {type = "DNumberWang"}
                        },
                    }
                },
                ["Repulsor Equipment"] = {
                    icon = "entities/obj_ff_equipment_repulsor.png",
                    model = "models/hr/unsc/equipment/equipment.mdl",
                    controls = {
                        ["Knockback Power"] = {
                            convar = "h_repulsor_power",
                            default = 4,
                            desc = "The amount of knockback power.",
                            panel = {type = "DNumberWang"}
                        },
                        ["Knockback Range"] = {
                            convar = "h_repulsor_range",
                            default = 4,
                            desc = "The range of the knockback effect.",
                            panel = {type = "DNumberWang"}
                        },
                        ["Knockback User"] = {
                            convar = "h_repulsor_user_knockback",
                            default = 4,
                            desc = "The amount of knockback on the user when activated in mid-air.",
                            panel = {type = "DNumberWang"}
                        },
                        ["Resource Max"] = {
                            convar = "h_repulsor_resource_max",
                            default = 3,
                            desc = "The maximum resource for this equipment.",
                            panel = {type = "DNumberWang"}
                        },
                        ["Resource Regen"] = {
                            convar = "h_repulsor_resource_regen",
                            default = 0,
                            desc = "The resource regenerated per second.",
                            panel = {type = "DNumberWang"}
                        },
                        ["Resource Cost Per Second"] = {
                            convar = "h_repulsor_resource_cps",
                            default = 0,
                            desc = "The resource that is subtracted per second when active.",
                            panel = {type = "DNumberWang"}
                        },
                        ["Resource Cost Initial"] = {
                            convar = "h_repulsor_resource_cost_initial",
                            default = 1,
                            desc = "The resource that is subtracted when initially activated.",
                            panel = {type = "DNumberWang"}
                        },
                        ["Resource Regen Delay"] = {
                            convar = "h_repulsor_resource_delay",
                            default = 0,
                            desc = "The amount of seconds before the equipment's resource begins regenerating.",
                            panel = {type = "DNumberWang"}
                        },
                    }
                },
            }
        }
    }
}