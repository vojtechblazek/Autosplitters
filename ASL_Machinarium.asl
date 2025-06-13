// Version 3.0.0
// date 13. 6. 2025

state("Machinarium", "dx12"){
    // DX12 Version
    uint Level: "Machinarium.exe", 0x203A18;
    bool Start: "Machinarium.exe", 0x2039EC;
    bool End: "Machinarium.exe", 0x002ACAE8, 0x340;
}

state("Machinarium", "legacyW32"){
    uint Level: "Machinarium.exe", 0x1CC8B0;
    bool Start: "Machinarium.exe", 0x001CD804, 0x1C8, 0x238;
    bool End: "Machinarium.exe",   0x001CD804, 0x1C8, 0x238; // this start and end is the same
}

startup{
    vars.splitTimeStopwatch = new Stopwatch(); // for ending split 
    vars.TimesInPrison = 0; // Count how many times the player has been in specific locations.
    vars.TimesInSewer = 0;
    vars.TimesInBand = 0;
    vars.TimesInSquare = 0;
    vars.TimesInPub = 0;
    vars.startDbg = 0;

    settings.Add("VER", true, "Game Version (!) (check only one box!)"); // choose the game version before launching the game! (or restart LiveSplit after changing the version)
        settings.Add("5429-A STM-W64-DX12", true, "Current Version (5429-A STM-W64-DX12)", "VER");
        settings.Add("4012-A STM-W32",      false, "Legacy Version (4012-A STM-W32)", "VER");
        settings.Add("2975-A STM-W32",      false, "[NOT WORKING YET] Legacy Mac OpenGL Version (2975-A STM-W32)", "VER");
    
    settings.Add("SPL", true, "Location Splits");
        settings.Add("PatrolStation",      true, "Patrol Station", "SPL");
        settings.Add("Bottom",             true, "The Bottom", "SPL");
        settings.Add("Furnace",            true, "Furnace", "SPL");
        settings.Add("PrisonCutscene",     true, "Cutscene before prison", "SPL");
        settings.Add("Prison",             true, "Prison", "SPL");
        settings.Add("GuardRoom",          true, "Guard Room (from below)", "SPL");
        settings.Add("PrisonPuzzle",       true, "Prison Puzzle", "SPL");
        settings.Add("Sea",                true, "The Sea (dog location)", "SPL");
        settings.Add("Band",               true, "Robot Band Location", "SPL");
        settings.Add("AfterCheckers",      true, "Robot Band Location (after Checkers)", "SPL");
        settings.Add("Square",             true, "Square", "SPL");
        settings.Add("ArcadeBridge",       true, "Arcade Bridge", "SPL");
        settings.Add("AfterArcade",        true, "Square (after Arcade Bridge)", "SPL");
        settings.Add("AfterOil",           true, "Robot Band Location (after oil collection)", "SPL");
        settings.Add("Sewer",              true, "Sewer", "SPL");
        settings.Add("Wall",               true, "By The Wall", "SPL");
        settings.Add("AngryFan",           true, "Sleeping Fan", "SPL");
        settings.Add("Glasshouse",         true, "Glasshouse", "SPL");
        settings.Add("Pipes",              true, "Policeman on bridge", "SPL");
        settings.Add("ElevatorAfterPipes", true, "Elevator (from policeman)", "SPL");
        settings.Add("Hallway",            true, "Hallway", "SPL");
        settings.Add("AfterDefuse",        true, "Toilet (after defuse)", "SPL");
        settings.Add("Machinari",          true, "Machinaris chamber", "SPL");
        settings.Add("AfterMachinari",     true, "Basement trip", "SPL");
        settings.Add("Roof",               true, "Roof", "SPL");
        
        settings.Add("ESPL", false, "Event Splits");
            settings.Add("Dunno",          true, "No event splits yet. Any ideas?", "ESPL");
}

init{
    // Looks at which version is checked and connects the appropriate state
    if (settings["5429-A STM-W64-DX12"] && !settings["4012-A STM-W32"]) {version = "dx12";}
    if (settings["4012-A STM-W32"] && !settings["5429-A STM-W64-DX12"]) {version = "legacyW32";}
}

update{ 
    // Updating game version - doesn't work this way though, so this part of the script does nothing (i don't think the state descriptor can change mid use)
    //if (settings["5429-A STM-W64-DX12"] && !settings["4012-A STM-W32"]) {version = "dx12";}
    //if (settings["4012-A STM-W32"] && !settings["5429-A STM-W64-DX12"]) {version = "legacyW32";}
    
    // Keeping track of frequently visited locations
    if (current.Level == 600 && old.Level != 600){
        vars.TimesInPrison++;
    }
    if (current.Level == 1400 && old.Level != 1400){
        vars.TimesInSewer++;
    }
    if (current.Level == 1000 && old.Level != 1000){
        vars.TimesInBand++;
    }
    if (current.Level == 1100 && old.Level != 1100){
        vars.TimesInSquare++;
    }
    if (current.Level == 1500 && old.Level != 1500){
        vars.TimesInTimesInPub++;
    }
//Debugging section
    // Starting the run
    if (current.Level == 100 && !current.Start && old.Start) {vars.startDbg += 1;}
    if (current.Level == 6)                                                  {vars.startDbg = 0;}
    
    if (current.Level != old.Level){
        print("DEBUG: LEVEL VALUE CHANGED FROM " + old.Level + " TO " + current.Level);
    }
    if (current.Start != old.Start){
        print("DEBUG: Start VALUE CHANGED FROM " + old.Start + " TO " + current.Start);
    }
}

start{
    if (current.Level == 100 && !current.Start && old.Start && vars.startDbg == 2){
        print("DEBUG: START ACTIVATED");
        return true;
    }
}

split{
    if (current.Level == 200 && old.Level == 6){ // Entering patrol station
        return settings["PatrolStation"];
    }
    if (current.Level == 300 && old.Level != 300){ // Entering the bottom
        return settings["Bottom"];
    }
    if (current.Level == 400 && old.Level != 400){ // Entering the furnace
        return settings["Furnace"];
    }
    if (current.Level == 500 && old.Level == 400){ // As the prison cutscene starts to play
        return settings["PrisonCutscene"];
    }
    if (current.Level == 600 && old.Level == 500){ // As you get to prison 
        return settings["Prison"];
    }
    if (current.Level == 700 && old.Level == 600 && vars.TimesInPrison == 1){ // Entering the guard room from below
        return settings["GuardRoom"];
    }
    if (current.Level == 600 && old.Level == 700){ // Entering the prison from the guard room
        return settings["PrisonPuzzle"];
    }
    if (current.Level == 800 && old.Level == 500){ // Entering the Sea from the telescope room (location with boxes and a dog)
        return settings["Sea"];
    }
    if (current.Level == 1000 && old.Level == 800){ // Entering the place with the robot band from the Sea location
        return settings["Band"];
    }
    if (current.Level == 1000 && old.Level == 1500 && vars.TimesInBand == 2){ // Entering the place with the robot band after winning in checkers
        return settings["AfterCheckers"];
    }
    if (current.Level == 1100 && old.Level == 2100 && vars.TimesInSquare == 1){ // Entering the Square for the first time
        return settings["Square"];
    }
    if (current.Level == 1200 && old.Level == 1100){ // Entering the Arcade bridge location
        return settings["ArcadeBridge"];
    }
    if (current.Level == 1100 && old.Level == 1200 && vars.TimesInSquare == 2){ // Entering the Square after the Arcade Bridge
        return settings["AfterArcade"];
    }
    if (current.Level == 1000 && old.Level == 200){ // Entering the band place after collecting oil
        return settings["AfterOil"];
    }
    if (current.Level == 1400 && old.Level == 1100 && vars.TimesInSewer == 1){ // Entering the Sewer under the fountain. The location is entered 2 times, but we want to split only the first time.
        return settings["Sewer"];
    }
    if (current.Level == 1600 && old.Level == 1400){ // Entering the elevator wall.
        return settings["Wall"];
    }
    if (current.Level == 1800 && old.Level == 1600){ // Entering the upper wall (with the fan asking you riddles)
        return settings["AngryFan"];
    }
    if (current.Level == 1900 && old.Level == 1800){ // Falling down to the glasshouse
        return settings["Glasshouse"];
    }
    if (current.Level == 2000 && old.Level == 1900){ // Entering the bridge with the policeman.
        return settings["Pipes"];
    }
    if (current.Level == 2200 && old.Level == 2000){ // Entering the Elevator.
        return settings["ElevatorAfterPipes"];
    }
    if (current.Level == 2300 && old.Level == 2200){ // Entering the great hallway; Both sides count with the value 2300, 2200 is reserved for the elevator.
        return settings["Hallway"];
    }
    if (current.Level == 2300 && old.Level == 2400){ // Climbing to the toilet after defusing the bomb.
        return settings["AfterDefuse"];
    }
    if (current.Level == 2500 && old.Level == 2300){ // Entering the Machinaris room. Only once in the speedrun is it entered from the hallway. The second time it's connected right from the basement by a cutscene.
        return settings["Machinari"];
    }
    if (current.Level == 2300 && old.Level == 2500){ // When first coming down from Machinari to the basement.
        return settings["AfterMachinari"];
    }
    if (current.Level == 2600 && old.Level == 2500){ // Entering the rooftop at the end of the game
        return settings["Roof"];
    }
    if (current.Level == 2600 && current.End && !old.End){// When the last animation starts, this sets up a clock measuring 14.333 seconds.
        vars.splitTimeOffset = 14.333f;
        vars.splitTimeStopwatch.Restart();
    }    
    if(vars.splitTimeStopwatch.IsRunning && vars.splitTimeStopwatch.Elapsed.TotalSeconds >= vars.splitTimeOffset){ // When the clock reaches 14.333 secs (or more), the clock reset and a split is performed.
        vars.splitTimeStopwatch.Reset();
        return true;
    }
}

reset{
    if (current.Level == 6 && old.Level != 100 && old.Level != 6)
    {
        print("DEBUG: RESET");
        return true;
    }
}

onReset{
    vars.TimesInPrison = 0;
    vars.TimesInSewer = 0;
    vars.TimesInBand = 0;
    vars.TimesInSquare = 0;
    vars.TimesInPub = 0;
    vars.startDbg = 0;
}
exit{
    vars.TimesInPrison = 0;
    vars.TimesInSewer = 0;
    vars.TimesInBand = 0;
    vars.TimesInSquare = 0;
    vars.TimesInPub = 0;
    vars.startDbg = 0;
}
