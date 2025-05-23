/// scrP2TriggerEvent_GenerateWinterHallucinationForest
var _forest_generator = instance_create(0, 0, objP2ForestGenerator);
_forest_generator.other_solids_tilemap_depth = 999999;
_forest_generator.forest_tile_chance = 0.8;
_forest_generator.forest_tree_chance = 0.15;
_forest_generator.generation_duration = 30;
_forest_generator.finished_callback = scrP2ForestGeneratorEvent_GotoWinterHallucinationForestSafe;
_forest_generator.forest_tileset = tP2ForestWinter;
_forest_generator.leaf_part_type = 2;
with (_forest_generator)
    event_user(0);
