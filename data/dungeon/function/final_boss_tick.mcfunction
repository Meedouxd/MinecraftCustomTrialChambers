# 1. Ensure the bossbar and state scoreboard exist and are styled
bossbar add dungeon:fastarr_boss {"text":"Fastarr, Death Incarnate","color":"dark_red","bold":true}
bossbar set dungeon:fastarr_boss color red
bossbar set dungeon:fastarr_boss style notched_10
scoreboard objectives add fastarr_state dummy

# 2. Spawn announcement (triggers once per Fastarr when he appears)
execute as @e[tag=fastarr_death_incarnate,tag=!fastarr_announced] at @s run tellraw @a[distance=..48] ["",{"text":"[BOSS] ","color":"dark_red","bold":true},{"text":"Fastarr, Death Incarnate: ","color":"red","bold":true},{"text":"\"Your souls belong to the abyss now.\"","color":"gray","italic":true}]
execute as @e[tag=fastarr_death_incarnate,tag=!fastarr_announced] at @s run playsound minecraft:entity.wither.spawn hostile @a[distance=..48] ~ ~ ~ 1.2 0.8
execute as @e[tag=fastarr_death_incarnate,tag=!fastarr_announced] run tag @s add fastarr_announced
execute if entity @e[tag=fastarr_death_incarnate] run scoreboard players set #alive fastarr_state 1

# 3. Death announcement (triggers once on the exact tick no Fastarr remains)
execute if score #alive fastarr_state matches 1 unless entity @e[tag=fastarr_death_incarnate] run tellraw @a[distance=..48] ["",{"text":"[BOSS] ","color":"dark_red","bold":true},{"text":"Fastarr, Death Incarnate ","color":"red","bold":true},{"text":"has been vanquished!","color":"gold"}]
execute if score #alive fastarr_state matches 1 unless entity @e[tag=fastarr_death_incarnate] run scoreboard players set #alive fastarr_state 0

# 4. Sync max health and current health to the active boss
execute as @e[tag=fastarr_death_incarnate,limit=1] store result bossbar dungeon:fastarr_boss max run attribute @s minecraft:max_health get
execute as @e[tag=fastarr_death_incarnate,limit=1] store result bossbar dungeon:fastarr_boss value run data get entity @s Health

# 5. Show the bossbar to players within 32 blocks when alive; hide it when dead
execute if entity @e[tag=fastarr_death_incarnate] at @e[tag=fastarr_death_incarnate,limit=1] run bossbar set dungeon:fastarr_boss players @a[distance=..32]
execute unless entity @e[tag=fastarr_death_incarnate] run bossbar set dungeon:fastarr_boss players