-- Example 1) All values present
-- ["Active Camo Equipment"] = {
--     icon = nil,
--     model = nil,
--     controls = {
--         ["Resource Max"] = {
--             convar = "h_active_camo_resource_max",
--             default = 100,
--             desc = "The maximum resource for this equipment.",
--             panel = {
--                 type = "DNumberWang",
--                 min = 0,
--                 max = 99999,
--             }
--         },
--         ["Resource Regen"] = {
--             convar = "h_active_camo_resource_regen",
--             default = 5,
--             desc = "The resource regenerated per second.",
--             panel = {
--                 type = "DNumberWang",
--                 min = 0,
--                 max = 99999,
--             }
--         },
--     },
--     subtree = nil
-- },

-- Example 2) Minimal values present
-- ["Active Camo Equipment"] = {
--     controls = {
--         ["Resource Max"] = {
--             convar = "h_active_camo_resource_max",
--             default = 100,
--         },
--         ["Resource Regen"] = {
--             convar = "h_active_camo_resource_regen",
--             default = 5,
--             panel = {
--                 type = "DNumberSlider",
--             }
--         },
--     },
-- },

return {
    ["Halo Equipment"] = {
        subtree = {
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
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
                            },
                            ["Resource Regen"] = {
                                convar = "h_active_camo_resource_regen",
                                default = 5,
                                desc = "The resource regenerated per second.",
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
                            },
                            ["Resource Cost Per Second"] = {
                                convar = "h_active_camo_resource_cps",
                                default = 5,
                                desc = "The resource that is subtracted per second when active.",
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
                            },
                            ["Resource Cost Initial"] = {
                                convar = "h_active_camo_resource_cost_initial",
                                default = 25,
                                desc = "The resource that is subtracted when initially activated.",
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
                            },
                            ["Resource Regen Delay"] = {
                                convar = "h_active_camo_resource_delay",
                                default = 0.5,
                                desc = "The amount of seconds before the equipment's resource begins regenerating.",
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
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
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
                            },
                            ["Resource Regen"] = {
                                convar = "h_armor_lock_resource_regen",
                                default = 5,
                                desc = "The resource regenerated per second.",
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
                            },
                            ["Resource Cost Per Second"] = {
                                convar = "h_armor_lock_resource_cps",
                                default = 5,
                                desc = "The resource that is subtracted per second when active.",
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
                            },
                            ["Resource Cost Initial"] = {
                                convar = "h_armor_lock_resource_cost_initial",
                                default = 25,
                                desc = "The resource that is subtracted when initially activated.",
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
                            },
                            ["Resource Regen Delay"] = {
                                convar = "h_armor_lock_resource_delay",
                                default = 0.5,
                                desc = "The amount of seconds before the equipment's resource begins regenerating.",
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
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
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
                            },
                            ["Health"] = {
                                convar = "h_drop_shield_health",
                                default = 300,
                                desc = "The amount of health this deployable has.",
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
                            },
                            ["Resource Max"] = {
                                convar = "h_drop_shield_resource_max",
                                default = 100,
                                desc = "The maximum resource for this equipment.",
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
                            },
                            ["Resource Regen"] = {
                                convar = "h_drop_shield_resource_regen",
                                default = 5,
                                desc = "The resource regenerated per second.",
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
                            },
                            ["Resource Cost Per Second"] = {
                                convar = "h_drop_shield_resource_cps",
                                default = 5,
                                desc = "The resource that is subtracted per second when active.",
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
                            },
                            ["Resource Cost Initial"] = {
                                convar = "h_drop_shield_resource_cost_initial",
                                default = 25,
                                desc = "The resource that is subtracted when initially activated.",
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
                            },
                            ["Resource Regen Delay"] = {
                                convar = "h_drop_shield_resource_delay",
                                default = 0.5,
                                desc = "The amount of seconds before the equipment's resource begins regenerating.",
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
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
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
                            },
                            ["Resource Max"] = {
                                convar = "h_evade_resource_max",
                                default = 100,
                                desc = "The maximum resource for this equipment.",
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
                            },
                            ["Resource Regen"] = {
                                convar = "h_evade_resource_regen",
                                default = 5,
                                desc = "The resource regenerated per second.",
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
                            },
                            ["Resource Cost Per Second"] = {
                                convar = "h_evade_resource_cps",
                                default = 5,
                                desc = "The resource that is subtracted per second when active.",
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
                            },
                            ["Resource Cost Initial"] = {
                                convar = "h_evade_resource_cost_initial",
                                default = 25,
                                desc = "The resource that is subtracted when initially activated.",
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
                            },
                            ["Resource Regen Delay"] = {
                                convar = "h_evade_resource_delay",
                                default = 0.5,
                                desc = "The amount of seconds before the equipment's resource begins regenerating.",
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
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
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
                            },
                            ["Duration"] = {
                                convar = "h_hologram_duration",
                                default = 10,
                                desc = "The duration of this deployable.",
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
                            },
                            ["Resource Max"] = {
                                convar = "h_hologram_resource_max",
                                default = 100,
                                desc = "The maximum resource for this equipment.",
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
                            },
                            ["Resource Regen"] = {
                                convar = "h_hologram_resource_regen",
                                default = 5,
                                desc = "The resource regenerated per second.",
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
                            },
                            ["Resource Cost Per Second"] = {
                                convar = "h_hologram_resource_cps",
                                default = 5,
                                desc = "The resource that is subtracted per second when active.",
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
                            },
                            ["Resource Cost Initial"] = {
                                convar = "h_hologram_resource_cost_initial",
                                default = 25,
                                desc = "The resource that is subtracted when initially activated.",
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
                            },
                            ["Resource Regen Delay"] = {
                                convar = "h_hologram_resource_delay",
                                default = 0.5,
                                desc = "The amount of seconds before the equipment's resource begins regenerating.",
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
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
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
                            },
                            ["Resource Max"] = {
                                convar = "h_jet_pack_resource_max",
                                default = 100,
                                desc = "The maximum resource for this equipment.",
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
                            },
                            ["Resource Regen"] = {
                                convar = "h_jet_pack_resource_regen",
                                default = 5,
                                desc = "The resource regenerated per second.",
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
                            },
                            ["Resource Cost Per Second"] = {
                                convar = "h_jet_pack_resource_cps",
                                default = 5,
                                desc = "The resource that is subtracted per second when active.",
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
                            },
                            ["Resource Cost Initial"] = {
                                convar = "h_jet_pack_resource_cost_initial",
                                default = 25,
                                desc = "The resource that is subtracted when initially activated.",
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
                            },
                            ["Resource Regen Delay"] = {
                                convar = "h_jet_pack_resource_delay",
                                default = 0.5,
                                desc = "The amount of seconds before the equipment's resource begins regenerating.",
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
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
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
                            },
                            ["Resource Max"] = {
                                convar = "h_sprint_resource_max",
                                default = 100,
                                desc = "The maximum resource for this equipment.",
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
                            },
                            ["Resource Regen"] = {
                                convar = "h_sprint_resource_regen",
                                default = 5,
                                desc = "The resource regenerated per second.",
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
                            },
                            ["Resource Cost Per Second"] = {
                                convar = "h_sprint_resource_cps",
                                default = 5,
                                desc = "The resource that is subtracted per second when active.",
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
                            },
                            ["Resource Cost Initial"] = {
                                convar = "h_sprint_resource_cost_initial",
                                default = 25,
                                desc = "The resource that is subtracted when initially activated.",
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
                            },
                            ["Resource Regen Delay"] = {
                                convar = "h_sprint_resource_delay",
                                default = 0.5,
                                desc = "The amount of seconds before the equipment's resource begins regenerating.",
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
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
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
                            },
                            ["Resource Regen"] = {
                                convar = "h_auto_turret_resource_regen",
                                default = 0,
                                desc = "The resource regenerated per second.",
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
                            },
                            ["Resource Cost Per Second"] = {
                                convar = "h_auto_turret_resource_cps",
                                default = 0,
                                desc = "The resource that is subtracted per second when active.",
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
                            },
                            ["Resource Cost Initial"] = {
                                convar = "h_auto_turret_resource_cost_initial",
                                default = 1,
                                desc = "The resource that is subtracted when initially activated.",
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
                            },
                            ["Resource Regen Delay"] = {
                                convar = "h_auto_turret_resource_delay",
                                default = 0,
                                desc = "The amount of seconds before the equipment's resource begins regenerating.",
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
                            },
                        }
                    },
                    ["Bubble Shield Equipment"] = {
                        icon = "entities/obj_ff_equipment_bubble_shield.png",
                        model = "models/hr/cov/equipment_bubble_shield/equipment_bubble_shield.mdl",
                        controls = {
                            ["Duration"] = {
                                convar = "h_bubble_shield_duration",
                                default = 15,
                                desc = "The duration of this deployable.",
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
                            },
                            ["Health"] = {
                                convar = "h_bubble_shield_health",
                                default = 25,
                                desc = "The amount of health this deployable has.",
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
                            },
                            ["Resource Max"] = {
                                convar = "h_bubble_shield_resource_max",
                                default = 1,
                                desc = "The maximum resource for this equipment.",
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
                            },
                            ["Resource Regen"] = {
                                convar = "h_bubble_shield_resource_regen",
                                default = 0,
                                desc = "The resource regenerated per second.",
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
                            },
                            ["Resource Cost Per Second"] = {
                                convar = "h_bubble_shield_resource_cps",
                                default = 0,
                                desc = "The resource that is subtracted per second when active.",
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
                            },
                            ["Resource Cost Initial"] = {
                                convar = "h_bubble_shield_resource_cost_initial",
                                default = 1,
                                desc = "The resource that is subtracted when initially activated.",
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
                            },
                            ["Resource Regen Delay"] = {
                                convar = "h_bubble_shield_resource_delay",
                                default = 0,
                                desc = "The amount of seconds before the equipment's resource begins regenerating.",
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
                            },
                        }
                    },
                    ["Energy Drain Equipment"] = {
                        icon = "entities/obj_ff_equipment_energy_drain.png",
                        model = "models/hr/cov/equipment_power_drain/equipment_power_drain.mdl",
                        controls = {
                            ["Shield/Armor Drain per second"] = {
                                convar = "h_energy_drain_dps",
                                default = 4,
                                desc = "The amount of shields drained per second.",
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
                            },
                            ["Shield/Armor Drain Radius"] = {
                                convar = "h_energy_drain_radius",
                                default = 4,
                                desc = "The radius of the shield draining effect.",
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
                            },
                            ["Explosion Damage"] = {
                                convar = "h_energy_drain_expl_damage",
                                default = 4,
                                desc = "The damage inflicted when this deployable explodes.",
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
                            },
                            ["Explosion Radius"] = {
                                convar = "h_energy_drain_expl_radius",
                                default = 4,
                                desc = "The radius of the explosion when this deployable explodes.",
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
                            },
                            ["Duration"] = {
                                convar = "h_energy_drain_duration",
                                default = 4,
                                desc = "The duration of this deployable.",
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
                            },
                            ["Health"] = {
                                convar = "h_energy_drain_health",
                                default = 25,
                                desc = "The amount of health this deployable has.",
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
                            },
                            ["Resource Max"] = {
                                convar = "h_energy_drain_resource_max",
                                default = 1,
                                desc = "The maximum resource for this equipment.",
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
                            },
                            ["Resource Regen"] = {
                                convar = "h_energy_drain_resource_regen",
                                default = 0,
                                desc = "The resource regenerated per second.",
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
                            },
                            ["Resource Cost Per Second"] = {
                                convar = "h_energy_drain_resource_cps",
                                default = 0,
                                desc = "The resource that is subtracted per second when active.",
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
                            },
                            ["Resource Cost Initial"] = {
                                convar = "h_energy_drain_resource_cost_initial",
                                default = 1,
                                desc = "The resource that is subtracted when initially activated.",
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
                            },
                            ["Resource Regen Delay"] = {
                                convar = "h_energy_drain_resource_delay",
                                default = 0,
                                desc = "The amount of seconds before the equipment's resource begins regenerating.",
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
                            },
                        }
                    },
                    ["Flare Equipment"] = {
                        icon = "entities/obj_ff_equipment_flare.png",
                        model = "models/hr/cov/equipment_power_drain/equipment_power_drain.mdl",
                        controls = {
                            ["Duration"] = {
                                convar = "h_flare_duration",
                                default = 4,
                                desc = "The duration of this deployable.",
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
                            },
                            ["Health"] = {
                                convar = "h_flare_health",
                                default = 15,
                                desc = "The amount of health this deployable has.",
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
                            },
                            ["Resource Max"] = {
                                convar = "h_flare_resource_max",
                                default = 1,
                                desc = "The maximum resource for this equipment.",
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
                            },
                            ["Resource Regen"] = {
                                convar = "h_flare_resource_regen",
                                default = 0,
                                desc = "The resource regenerated per second.",
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
                            },
                            ["Resource Cost Per Second"] = {
                                convar = "h_flare_resource_cps",
                                default = 0,
                                desc = "The resource that is subtracted per second when active.",
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
                            },
                            ["Resource Cost Initial"] = {
                                convar = "h_flare_resource_cost_initial",
                                default = 1,
                                desc = "The resource that is subtracted when initially activated.",
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
                            },
                            ["Resource Regen Delay"] = {
                                convar = "h_flare_resource_delay",
                                default = 0,
                                desc = "The amount of seconds before the equipment's resource begins regenerating.",
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
                            },
                        }
                    },
                    ["Portable Gravity Lift Equipment"] = {
                        icon = "entities/obj_ff_equipment_grav_lift.png",
                        model = "models/hr/cov/equipment_grav_lift/equipment_grav_lift_undeployed.mdl",
                        controls = {
                            ["Lift Power"] = {
                                convar = "h_grav_lift_power",
                                default = 4,
                                desc = "The amount of lift applied to objects.",
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
                            },
                            ["Lift Radius"] = {
                                convar = "h_grav_lift_radius",
                                default = 4,
                                desc = "The radius of the lift applied to objects.",
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
                            },
                            ["Duration"] = {
                                convar = "h_grav_lift_duration",
                                default = 4,
                                desc = "The duration of this deployable.",
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
                            },
                            ["Health"] = {
                                convar = "h_grav_lift_health",
                                default = 25,
                                desc = "The amount of health this deployable has.",
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
                            },
                            ["Resource Max"] = {
                                convar = "h_grav_lift_resource_max",
                                default = 1,
                                desc = "The maximum resource for this equipment.",
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
                            },
                            ["Resource Regen"] = {
                                convar = "h_grav_lift_resource_regen",
                                default = 0,
                                desc = "The resource regenerated per second.",
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
                            },
                            ["Resource Cost Per Second"] = {
                                convar = "h_grav_lift_resource_cps",
                                default = 0,
                                desc = "The resource that is subtracted per second when active.",
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
                            },
                            ["Resource Cost Initial"] = {
                                convar = "h_grav_lift_resource_cost_initial",
                                default = 1,
                                desc = "The resource that is subtracted when initially activated.",
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
                            },
                            ["Resource Regen Delay"] = {
                                convar = "h_grav_lift_resource_delay",
                                default = 0,
                                desc = "The amount of seconds before the equipment's resource begins regenerating.",
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
                            },
                        }
                    },
                    ["Radar Jammer Equipment"] = {
                        icon = "entities/obj_ff_equipment_radar_jammer.png",
                        model = "models/hr/cov/equipment_power_drain/equipment_power_drain.mdl",
                        controls = {
                            ["Duration"] = {
                                convar = "h_radar_jammer_duration",
                                default = 4,
                                desc = "The duration of this deployable.",
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
                            },
                            ["Health"] = {
                                convar = "h_radar_jammer_health",
                                default = 25,
                                desc = "The amount of health this deployable has.",
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
                            },
                            ["Resource Max"] = {
                                convar = "h_radar_jammer_resource_max",
                                default = 1,
                                desc = "The maximum resource for this equipment.",
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
                            },
                            ["Resource Regen"] = {
                                convar = "h_radar_jammer_resource_regen",
                                default = 0,
                                desc = "The resource regenerated per second.",
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
                            },
                            ["Resource Cost Per Second"] = {
                                convar = "h_radar_jammer_resource_cps",
                                default = 0,
                                desc = "The resource that is subtracted per second when active.",
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
                            },
                            ["Resource Cost Initial"] = {
                                convar = "h_radar_jammer_resource_cost_initial",
                                default = 1,
                                desc = "The resource that is subtracted when initially activated.",
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
                            },
                            ["Resource Regen Delay"] = {
                                convar = "h_radar_jammer_resource_delay",
                                default = 0,
                                desc = "The amount of seconds before the equipment's resource begins regenerating.",
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
                            },
                        }
                    },
                    ["Regenerator Equipment"] = {
                        icon = "entities/obj_ff_equipment_regenerator.png",
                        model = "models/hr/cov/equipment_regenerator/equipment_regenerator.mdl",
                        controls = {
                            ["Effect Radius"] = {
                                convar = "h_regenerator_radius",
                                default = 4,
                                desc = "The radius of the effect of this deployable.",
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
                            },
                            ["Armor Regenerated Per Second"] = {
                                convar = "h_regenerator_aps",
                                default = 4,
                                desc = "The amount of armor regenerated per second.",
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
                            },
                            ["Health Regenerated Per Second"] = {
                                convar = "h_regenerator_hps",
                                default = 4,
                                desc = "The amount of armor regenerated per second.",
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
                            },
                            ["Duration"] = {
                                convar = "h_regenerator_duration",
                                default = 4,
                                desc = "The duration of this deployable.",
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
                            },
                            ["Health"] = {
                                convar = "h_regenerator_health",
                                default = 25,
                                desc = "The amount of health this deployable has.",
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
                            },
                            ["Resource Max"] = {
                                convar = "h_regenerator_resource_max",
                                default = 1,
                                desc = "The maximum resource for this equipment.",
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
                            },
                            ["Resource Regen"] = {
                                convar = "h_regenerator_resource_regen",
                                default = 0,
                                desc = "The resource regenerated per second.",
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
                            },
                            ["Resource Cost Per Second"] = {
                                convar = "h_regenerator_resource_cps",
                                default = 0,
                                desc = "The resource that is subtracted per second when active.",
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
                            },
                            ["Resource Cost Initial"] = {
                                convar = "h_regenerator_resource_cost_initial",
                                default = 1,
                                desc = "The resource that is subtracted when initially activated.",
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
                            },
                            ["Resource Regen Delay"] = {
                                convar = "h_regenerator_resource_delay",
                                default = 0,
                                desc = "The amount of seconds before the equipment's resource begins regenerating.",
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
                            },
                        }
                    },
                    ["Trip Mine Equipment"] = {
                        icon = "entities/obj_ff_equipment_trip_mine.png",
                        model = "models/hr/unsc/equipment_trip_mine/equipment_trip_mine.mdl",
                        controls = {
                            ["Explosion Damage"] = {
                                convar = "h_trip_mine_expl_damage",
                                default = 4,
                                desc = "The damage inflicted when this deployable explodes.",
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
                            },
                            ["Explosion Radius"] = {
                                convar = "h_trip_mine_expl_radius",
                                default = 4,
                                desc = "The radius of the explosion when this deployable explodes.",
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
                            },
                            ["Duration"] = {
                                convar = "h_trip_mine_duration",
                                default = 4,
                                desc = "The duration of this deployable.",
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
                            },
                            ["Health"] = {
                                convar = "h_trip_mine_health",
                                default = 25,
                                desc = "The amount of health this deployable has.",
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
                            },
                            ["Resource Max"] = {
                                convar = "h_trip_mine_resource_max",
                                default = 1,
                                desc = "The maximum resource for this equipment.",
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
                            },
                            ["Resource Regen"] = {
                                convar = "h_trip_mine_resource_regen",
                                default = 0,
                                desc = "The resource regenerated per second.",
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
                            },
                            ["Resource Cost Per Second"] = {
                                convar = "h_trip_mine_resource_cps",
                                default = 0,
                                desc = "The resource that is subtracted per second when active.",
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
                            },
                            ["Resource Cost Initial"] = {
                                convar = "h_trip_mine_resource_cost_initial",
                                default = 1,
                                desc = "The resource that is subtracted when initially activated.",
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
                            },
                            ["Resource Regen Delay"] = {
                                convar = "h_trip_mine_resource_delay",
                                default = 0,
                                desc = "The amount of seconds before the equipment's resource begins regenerating.",
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
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
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
                            },
                            ["Resource Regen"] = {
                                convar = "h_grapple_shot_resource_regen",
                                default = 0,
                                desc = "The resource regenerated per second.",
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
                            },
                            ["Resource Cost Per Second"] = {
                                convar = "h_grapple_shot_resource_cps",
                                default = 0,
                                desc = "The resource that is subtracted per second when active.",
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
                            },
                            ["Resource Cost Initial"] = {
                                convar = "h_grapple_shot_resource_cost_initial",
                                default = 1,
                                desc = "The resource that is subtracted when initially activated.",
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
                            },
                            ["Resource Regen Delay"] = {
                                convar = "h_grapple_shot_resource_delay",
                                default = 0,
                                desc = "The amount of seconds before the equipment's resource begins regenerating.",
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
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
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
                            },
                            ["Knockback Range"] = {
                                convar = "h_repulsor_range",
                                default = 4,
                                desc = "The range of the knockback effect.",
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
                            },
                            ["Knockback User"] = {
                                convar = "h_repulsor_user_knockback",
                                default = 4,
                                desc = "The amount of knockback on the user when activated in mid-air.",
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
                            },
                            ["Resource Max"] = {
                                convar = "h_repulsor_resource_max",
                                default = 3,
                                desc = "The maximum resource for this equipment.",
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
                            },
                            ["Resource Regen"] = {
                                convar = "h_repulsor_resource_regen",
                                default = 0,
                                desc = "The resource regenerated per second.",
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
                            },
                            ["Resource Cost Per Second"] = {
                                convar = "h_repulsor_resource_cps",
                                default = 0,
                                desc = "The resource that is subtracted per second when active.",
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
                            },
                            ["Resource Cost Initial"] = {
                                convar = "h_repulsor_resource_cost_initial",
                                default = 1,
                                desc = "The resource that is subtracted when initially activated.",
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
                            },
                            ["Resource Regen Delay"] = {
                                convar = "h_repulsor_resource_delay",
                                default = 0,
                                desc = "The amount of seconds before the equipment's resource begins regenerating.",
                                panel = {
                                    type = "DNumberWang",
                                    min = 0,
                                    max = 99999,
                                }
                            },
                        }
                    },
                }
            }
        }
    }
}