# 1. Force maximum anger (150) toward the nearest Survival/Adventure player within 20 blocks
execute as @e[tag=flesh_atronach] at @s if entity @p[distance=..20,gamemode=!creative,gamemode=!spectator] run data modify entity @s anger.suspects set value [{anger:150,uuid:[I;0,0,0,0]}]
execute as @e[tag=flesh_atronach] at @s if entity @p[distance=..20,gamemode=!creative,gamemode=!spectator] run data modify entity @s anger.suspects[0].uuid set from entity @p[distance=..20,gamemode=!creative,gamemode=!spectator] UUID

# 2. Set attack_target and skip the 4-second roar delay so it charges immediately
execute as @e[tag=flesh_atronach] at @s if entity @p[distance=..20,gamemode=!creative,gamemode=!spectator] run data modify entity @s Brain.memories."minecraft:attack_target".value set from entity @p[distance=..20,gamemode=!creative,gamemode=!spectator] UUID
execute as @e[tag=flesh_atronach] at @s if entity @p[distance=..20,gamemode=!creative,gamemode=!spectator] run data remove entity @s Brain.memories."minecraft:roar_sound_delay"

# 3. Keep dig_cooldown refreshed so it never burrows into the ground
execute as @e[tag=flesh_atronach] run data modify entity @s Brain.memories."minecraft:dig_cooldown" set value {value:{},ttl:12000L}

# 4. Clear Darkness effect from nearby players
effect clear @a[distance=..25] minecraft:darkness