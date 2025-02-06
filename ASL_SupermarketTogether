//Supermarket Together Autosplitter v1.0.0 by blazie
// utilising ASL Help by Ero
state("Supermarket Together"){
	int isMoving: "UnityPlayer.dll", 0x01C2E730, 0x20, 0x470, 0x838, 0x18;
}

startup{
	Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Unity");
}

init{
	vars.Helper.TryLoad = (Func<dynamic, bool>)(mono =>
	{
		vars.Helper["maxEmp"] = mono.Make<int>("NPC_Manager", "Instance", "maxEmployees");
		return true;
	});
}

start{
	return old.isMoving == 0 && current.isMoving == 1;
}

split{
	return old.maxEmp == 0 && current.maxEmp == 1;
}
