# HostSupport
A C# library used in a C++ app, using WinRT. For figuring out cswinrt authoring support

## Workflow:
 * Make an edit to the Authoring.targets file in the CsWinRT nuget package's directory on the local machine 
 * Using VS, update the nuget package version for Coords
 * Run ```msbuild Coords\Coords\Coords.csproj /p:Platform=x64 /bl```
 * Run ```nuget add Coords\Coords\bin\x64\debug\Coords1.0.0.nupkg -Source .\feed``` -- change the number accordingly
 * Run ```nuget update App\App.sln```
 * (tip: use NuGet Package Explorer to view contents of package)
 * Run ```msbuild ConsoleApp.sln /bl``` and check the output directory to see what's in there (hopefully the DLLs!) 

 We need the 4 cswinrt related DLLs and the Coords dll
 
## Status

 The remaining work is to get the "binplacement" right. We have the dlls 
 and targets file in the native app, but we don't have it placing correctly. 
 Right now this is because the target is not being run. I suspect once 
 it gets run, the file paths will need some work before things are proper.
 
 ## Problems...
 
 The authored component's dll lives in a lib/net5.0-windows10.0.19041.0 (or whatever the target framework is), and that's not something we can hardcode in the targets file. We might need to generate the targets file based on the authored component, or have a base one that does the hosting dlls and then append some lines that are specific to the component's package id/framework




