//SCHiM Autosplitter v1.0.2 by blazie
//date 29. 7. 2024

state("SCHiM"){
int chapter: "GameAssembly.dll", 0x01F7A7A0, 0xB8, 0x64;
int loadingScreen: "UnityPlayer.dll", 0x01CF6638, 0x158, 0x0, 0x0, 0x78, 0x0, 0x100, 0x1E0;
}

init{
	vars.nonSplit = new HashSet<int> {7, 12, 15, 21, 53, 54, 57, 58, 65, 70, 72, 74, 76, 78, 79, 80};
	bool shouldSplit = true;
}

start{
	if(current.chapter == 1 && old.chapter == 0){
    	return true;
    }
}

update{
	if (vars.nonSplit.Contains(current.chapter)){vars.shouldSplit = false;}
	else{vars.shouldSplit = true;}
}

isLoading{
	if(current.loadingScreen == 1){return true;}
	else{return false;}
}

split{
	if (current.chapter != old.chapter && vars.shouldSplit == true){	
		return true;
	}
}

reset{
	if (current.chapter == -1 && old.chapter != -1){
		return true;
	}
}
