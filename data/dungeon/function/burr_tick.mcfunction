# 1. Ensure the bossbar and cooldown scoreboard exist and are styled
bossbar add dungeon:burr_elder_scurge {"text":"Burr, The Elder Scurge","color":"blue","bold":true}
bossbar set dungeon:burr_elder_scurge color blue
bossbar set dungeon:burr_elder_scurge style notched_10
scoreboard objectives add burr_cd dummy

# 2. Sync max health and current health to the active boss
execute as @e[tag=burr_elder_scurge,limit=1] store result bossbar dungeon:burr_elder_scurge max run attribute @s minecraft:max_health get
execute as @e[tag=burr_elder_scurge,limit=1] store result bossbar dungeon:burr_elder_scurge value run data get entity @s Health

# 3. Show the bossbar to players within 32 blocks when alive; hide it when dead
execute if entity @e[tag=burr_elder_scurge] at @e[tag=burr_elder_scurge,limit=1] run bossbar set dungeon:burr_elder_scurge players @a[distance=..32]
execute unless entity @e[tag=burr_elder_scurge] run bossbar set dungeon:burr_elder_scurge players

# 4. Make Burr turn toward & walk at nearby players
execute as @e[tag=burr_elder_scurge] at @s if entity @p[distance=..24,gamemode=!creative,gamemode=!spectator] run tp @s ~ ~ ~ facing entity @p[distance=..24,gamemode=!creative,gamemode=!spectator] eyes
execute as @e[tag=burr_elder_scurge] at @s if entity @p[distance=3..24,gamemode=!creative,gamemode=!spectator] if block ^ ^ ^0.4 #minecraft:replaceable run tp @s ^ ^ ^0.18

# 5. Close-range frost aura: damage & chill players within 5 blocks every 20 ticks (1 second)
scoreboard players add @e[tag=burr_elder_scurge] burr_cd 1

execute as @e[tag=burr_elder_scurge,scores={burr_cd=20..}] at @s if entity @a[distance=..5,gamemode=!creative,gamemode=!spectator] run particle minecraft:snowflake ~ ~1.8 ~ 1.8 1.2 1.8 0.02 45 normal
execute as @e[tag=burr_elder_scurge,scores={burr_cd=20..}] at @s if entity @a[distance=..5,gamemode=!creative,gamemode=!spectator] run playsound minecraft:block.powder_snow.break hostile @a ~ ~ ~ 1.4 0.7
execute as @e[tag=burr_elder_scurge,scores={burr_cd=20..}] at @s as @a[distance=..5,gamemode=!creative,gamemode=!spectator] run damage @s 5.0 minecraft:freeze by @e[tag=burr_elder_scurge,limit=1]
execute as @e[tag=burr_elder_scurge,scores={burr_cd=20..}] at @s as @a[distance=..5,gamemode=!creative,gamemode=!spectator] run effect give @s minecraft:slowness 2 1 true


# Kill the invisible rider when Burr dies
execute as @e[tag=burr_brain] at @s unless entity @e[tag=burr_elder_scurge,distance=..8] run kill @s

scoreboard players reset @e[tag=burr_elder_scurge,scores={burr_cd=20..}] burr_cd