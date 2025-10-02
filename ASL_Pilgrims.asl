state("Pilgrims"){
    bool mouseInput: "UnityPlayer.dll", 0x00408C50, 0x0; // for starting the run
}

startup{
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

init{
    old.Scene      = "";  current.Scene = "";
    old.SceneCount = "";  current.SceneCount = "";
    old.Level      = "";  current.Level = "";
    vars.levelName = "";
}

update{
    current.Scene = vars.Helper.Scenes.Active.Name ?? old.Scene;
    
    foreach (var scene in vars.Helper.Scenes.Loaded) {
    try{
        if (scene != null && scene.IsValid){
            vars.levelName = scene.Name ?? "<null>";
        }    
        else{
            vars.levelName = "<invalid>";
        }
    }
    catch{vars.levelName = "<error>";}
    break;
    }

    // Filtering
    if (vars.levelName != "<error>" && vars.levelName != "" && vars.levelName != "<null>" && vars.levelName != "<invalid>"){
        current.Level = vars.levelName;
    }
}

start{
    return current.Level == "HobosLair" && current.mouseInput;
}

onStart{
    vars.CompletedSplits.Clear();
}

split{
    return (current.Level != old.Level
        && settings[current.Level]
        && vars.CompletedSplits.Add(current.Level))
        || current.Level == "Outro" && old.Level == "River"; // final split
}

reset{
    return old.Level != "Intro" && current.Level == "Intro"
        || old.Level == "Outro" && current.Level != "Outro";
}



