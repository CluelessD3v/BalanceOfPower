# ConstructionSystemEntity Runner run down documentation
this document is just a run down of how the `ConstructionSystemEntity` is used to (but probably not limited to): 
- Let the player select a building from a Gui
- Set the player `InBuildMode` to true/false
- Let the player Place said building in a world tile
- check if said world tile is valid for placement
- If so, finally place the prefab, and let the building entity take over

the `ConstructionSystemEntity` **DOES NOT REQUIRE A GUI TO WORK**, for more info about it check the `ConstructionSystemEntity` API

## Design rules
This rules are design bound, the `ConstructionSystemEntity` API should in theory be adaptable enough for the design to not really matter.
- When the player places a building, he exits build mode
- When a player clicks on a Building Image while having one selected, the system chooses that new one for him (if the player happened to choose the same building, it should not matter)
- Buildings can only be placed in valid tiles
--//TODO finish this if I ever get more people on board.





