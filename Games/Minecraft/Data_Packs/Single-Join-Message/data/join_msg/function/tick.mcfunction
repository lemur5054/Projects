# Run this every tick (in tick.mcfunction)
execute as @a[scores={joined_game=1..}] run tellraw @s {"text":"Welcome back to the server!","color":"green"}

# Add this right after the tellraw command in tick.mcfunction
scoreboard players set @a[scores={joined_game=1..}] joined_game 0


# For first-time joiners
execute as @a[tag=!returning] run tellraw @s {"text":"Welcome to your first time here!","color":"gold"}
tag @a[tag=!returning] add returning
