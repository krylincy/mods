STRINGS = GLOBAL.STRINGS
RECIPETABS = GLOBAL.RECIPETABS
Recipe = GLOBAL.Recipe
Ingredient = GLOBAL.Ingredient
TECH = GLOBAL.TECH


STRINGS.RECIPE_DESC.GEARS = ""
Recipe( "gears", { Ingredient("goldnugget", 2), Ingredient("cutstone", 5) }, RECIPETABS.REFINE, TECH.SCIENCE_TWO )

STRINGS.RECIPE_DESC.BLUEGEM = ""
Recipe( "bluegem", { Ingredient("goldnugget", 5), Ingredient("nightmarefuel", 1) }, RECIPETABS.MAGIC, TECH.MAGIC_TWO )

STRINGS.RECIPE_DESC.REDGEM = ""
Recipe( "redgem", { Ingredient("goldnugget", 5), Ingredient("nightmarefuel", 1) }, RECIPETABS.MAGIC, TECH.MAGIC_TWO )

STRINGS.RECIPE_DESC.GREENGEM = ""
Recipe( "greengem", {Ingredient("purplegem", 3), Ingredient("nightmarefuel", 2) }, RECIPETABS.MAGIC, TECH.MAGIC_TWO )

STRINGS.RECIPE_DESC.YELLOWGEM = ""
Recipe( "yellowgem", { Ingredient("purplegem", 3), Ingredient("nightmarefuel", 2) }, RECIPETABS.MAGIC, TECH.MAGIC_TWO )

STRINGS.RECIPE_DESC.ORANGEGEM = ""
Recipe( "orangegem", { Ingredient("purplegem", 3), Ingredient("nightmarefuel", 2) }, RECIPETABS.MAGIC, TECH.MAGIC_TWO )

STRINGS.RECIPE_DESC.DEERCLOPS_EYEBALL = "Giant photoreceptor"
Recipe("deerclops_eyeball", { Ingredient("meat", 12), Ingredient("nightmarefuel", 20) }, RECIPETABS.MAGIC, TECH.MAGIC_THREE )

STRINGS.RECIPE_DESC.BEARGER_FUR = " A good slice of mammal's skin"
Recipe("bearger_fur", { Ingredient("beefalowool", 20), Ingredient("nightmarefuel", 15), Ingredient("horn", 1) }, RECIPETABS.MAGIC, TECH.MAGIC_THREE )

STRINGS.RECIPE_DESC.HORN = "Soft, light and HONK"
Recipe("horn", { Ingredient("boneshard", 10), Ingredient("nightmarefuel", 1), Ingredient("beefalowool", 10) }, RECIPETABS.MAGIC, TECH.MAGIC_THREE )

STRINGS.RECIPE_DESC.WALRUS_TUSK = "A pretty impressive tooth."
Recipe("walrus_tusk", { Ingredient("boneshard", 10), Ingredient("nightmarefuel", 1), Ingredient("houndstooth", 10) }, RECIPETABS.MAGIC, TECH.MAGIC_THREE )

STRINGS.RECIPE_DESC.GOOSE_FEATHER = "Soft, light and HONK"
Recipe("goose_feather", { Ingredient("feather_crow", 5), Ingredient("nightmarefuel", 5), Ingredient("goldnugget", 5) }, RECIPETABS.MAGIC, TECH.MAGIC_THREE )

STRINGS.RECIPE_DESC.DRAGON_SCALES = "Keeps reptile's temperature resistance"
Recipe("dragon_scales", { Ingredient("pigskin", 12), Ingredient("fish", 3), Ingredient("nightmarefuel", 5), }, RECIPETABS.MAGIC, TECH.MAGIC_THREE )

STRINGS.RECIPE_DESC.LIGHTBULB = "Keeps your way"
Recipe("lightbulb", { Ingredient("torch", 2) }, RECIPETABS.LIGHT, TECH.NONE )

