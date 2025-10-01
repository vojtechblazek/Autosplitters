// Pilgrims Autosplitter by blazie
// Utilising ASL Help by Ero
// v1.0.2
// 1. 10. 2025

state("Pilgrims") {
    bool MouseInput: "UnityPlayer.dll", 0x408C50, 0x0; // for starting the run
}

startup {
    Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Unity");
    vars.Helper.LoadSceneManager = true;

    dynamic[,] _settings = {
        { "Garden",      "Potato garden" },
        { "River",       "River (ferrylady)" },
        { "ForestCamp2", "Lower forest camp" },
        { "OldOak",      "Old oak (bandit)" },
        { "Bridge",      "Bridge with old lady" },
        { "Pub",         "Pub" },
        { "Hut",         "Witch hut" },
        { "Dwarf",       "Dwarf (water sprite)" },
        { "Pit",         "Devils pit" },
        { "Church",      "Church" },
        { "ForestCamp1", "Upper forest camp" },
        { "Pond",        "Fish pond" },
        { "BearCave",    "Bear cave" },
        { "Drawbridge",  "Drawbridge" },
        { "Castle",      "Castle" },
        { "Gorge",       "Gorge" },
    };

    settings.Add("Splits", true, "Split at:");
    settings.SetToolTip("Splits", "Splitting happens ONLY the first time you enter the ticked location!");

    vars.Helper.Settings.Create(_settings, defaultParent: "Splits");

    vars.CompletedSplits = new HashSet<string>(16);
}

init {
    old.Level = "";
}

update {
    var scene = vars.Helper.Scenes.Loaded[0].Name;
    if (!string.IsNullOrEmpty(scene))
        current.Level = scene;
}

start {
    return current.Level == "HobosLair" && current.MouseInput;
}

onStart {
    vars.CompletedSplits.Clear();
}

split {
    return old.Level != current.Level
        && settings[current.Level]
        && vars.CompletedSplits.Add(current.Levels);
}

reset {
    return old.Level != "Intro" && current.Level == "Intro"
        || old.Level == "Outro" && current.Level != "Outro";
}
