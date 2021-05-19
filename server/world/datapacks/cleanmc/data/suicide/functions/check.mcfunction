schedule function suicide:check 1s
scoreboard players enable @a suicide
gamerule showDeathMessages false
kill @a[scores={suicide=1..}]
gamerule showDeathMessages true
execute as @a[scores={suicide=1..}] run tellraw @a ["",{"selector":"@s"},{"text":" committed suicide"}]
scoreboard players reset @a[scores={suicide=1..}] suicide
