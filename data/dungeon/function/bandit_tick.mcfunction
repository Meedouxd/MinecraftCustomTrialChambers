# 1. Remove orphaned invisible drivers when a Bandit dies
execute as @e[tag=bandit_driver] at @s unless entity @e[tag=bandit,distance=..2] run kill @s

# 2. Remove orphaned Bandit nametag displays when a Bandit dies
execute as @e[tag=bandit_nametag] at @s unless entity @e[tag=bandit,distance=..2.5] run kill @s

# 3. Prevent Bandits from turning invisible at night
effect clear @e[tag=bandit] minecraft:invisibility