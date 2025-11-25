//Bait & Tackle Autosplitter by blazie
//version 1.00 date 25.11.2025

state("Bait-and-Tackle"){
    bool inGame:      "Bait-and-Tackle.exe", 0x05CF4EE0, 0xC8, 0x0, 0xB84;
    uint sceneChange: "Bait-and-Tackle.exe", 0x05DFFB68, 0xDC8, 0x48, 0x10;  // starts at 19 for some reason, then increments with every screen change. Sometimes decrements though, hence the shouldSplit variable
    uint mouseButton: "Bait-and-Tackle.exe", 0x05CC0A20, 0x148;              // 1 = LMB, 2 = RMB, 4 = MW depressed etc.
}

startup {vars.shouldSplit = true;}

start   {return current.inGame && current.mouseButton == 2;}

reset   {if (current.sceneChange < old.sceneChange && vars.shouldSplit) {vars.shouldSplit = false;}} // uses the fact that reset is only checked when the timer is active, unlike update

split   {if (current.sceneChange == old.sceneChange + 1){
  
            if (vars.shouldSplit)  {return true;}
            if (!vars.shouldSplit) {vars.shouldSplit = true; return false;}}      
        }


onReset {vars.shouldSplit = true;}
