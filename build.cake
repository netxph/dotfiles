var target = Argument("target", "Build");
var sln = "Sample.sln";
var exe = ".\\bin\\Debug\\Sample.sln";

Task("Restore")
    .Does(() =>
    {
        NuGetRestore(sln);
    });

Task("Build")
    .IsDependentOn("Restore")
    .Does(() =>
    {
        MSBuild(sln);
    });

Task("Rebuild")
    .IsDependentOn("Restore")
    .Does(() =>
    {
        MSBuild(sln, s => s
            .WithTarget("Rebuild"));
    });

Task("Run")
    .Does(() =>
    {
        StartAndReturnProcess(exe,
            new ProcessSettings()
            {
                //Arguments = "/args",
                //WorkingDirectory = ".\\bin\\Debug"
            });
    });

RunTarget(target);
