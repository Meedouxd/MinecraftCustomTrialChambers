# 1. Ensure the bossbar exists and is styled
bossbar add dungeon:burrower_boss {"text":"The Burrower","color":"dark_purple","bold":true}
bossbar set dungeon:burrower_boss color purple
bossbar set dungeon:burrower_boss style notched_10

# 2. Sync max health and current health to the active boss
execute as @e[tag=the_burrower,limit=1] store result bossbar dungeon:burrower_boss max run attribute @s minecraft:max_health get
execute as @e[tag=the_burrower,limit=1] store result bossbar dungeon:burrower_boss value run data get entity @s Health

# 3. Show the bossbar to players within 32 blocks when alive; hide it when dead
execute if entity @e[tag=the_burrower] at @e[tag=the_burrower,limit=1] run bossbar set dungeon:burrower_boss players @a[distance=..32]
execute unless entity @e[tag=the_burrower] run bossbar set dungeon:burrower_boss players