// Fire Tonight Auto Splitter by blazie
// Utilising ASL Help by Ero
// v 1.0.0
// 5. 6. 2025
state("Fire Tonight"){
    bool casseteLoad: "UnityPlayer.dll", 0x0180CB88, 0x7A8, 0x270;      // for isLoading
}

startup{
	Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Unity");
    vars.Helper.LoadSceneManager = true;
    
    settings.Add("SPLITS", true, "Activated Splits");
        settings.Add("LV1", true, "Level 1 (Payphone)", "SPLITS");
        settings.Add("LV2", true, "Level 2 (Apartment 1)", "SPLITS");
        settings.Add("LV3", true, "Level 3 (Police)", "SPLITS");
        settings.Add("LV4", true, "Level 4 (Apartment 2)", "SPLITS");
        settings.Add("LV5", true, "Level 5 (Dumpsters)", "SPLITS");
        settings.Add("LV6", true, "Level 6 (Apartment 3)", "SPLITS");
        settings.Add("LV7", true, "Level 7 (Rollerskating)", "SPLITS");
        settings.Add("LV8", true, "Level 8 (Canal Locks)", "SPLITS");



}

init{
    old.Scene = "";
    current.Scene = "";
}

update
{
	current.Scene = vars.Helper.Scenes.Active.Name ?? old.Scene;
	if (current.Scene != old.Scene) {print("Current scene: " + current.Scene);} // debug
}

start{
	if (current.Scene != "Start" && old.Scene == "Start")               {return true;}
}

split{
    if (current.Scene == "Level 1" && old.Scene == "Cutscene 1")            {return settings["LV1"];}
    if (current.Scene == "Apartment 1" && old.Scene == "Level 1")           {return settings["LV2"];}
    if (current.Scene == "Level 2" && old.Scene == "Apartment 1")           {return settings["LV3"];}
    if (current.Scene == "Apartment 2" && old.Scene == "Cutscene Train")    {return settings["LV4"];}
    if (current.Scene == "Level 3" && old.Scene == "Apartment 2")           {return settings["LV5"];}
    if (current.Scene == "Apartment 3" && old.Scene == "Level 3")           {return settings["LV6"];}
    if (current.Scene == "Cutscene Skate" && old.Scene == "Apartment 3")    {return settings["LV7"];}
    if (current.Scene == "Level 4" && old.Scene == "Cutscene Devins")       {return settings["LV8"];}

    if (current.Scene == "Cutscene End" && old.Scene == "Level 4")          {return true;}              // final split
}

reset{
    if (current.Scene == "Start" && old.Scene != "Start" && old.Scene != "Cutscene End"){
        return true;
    }
}


isLoading{return current.casseteLoad;}
