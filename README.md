# HostSupport
A C# library used in C++ using WinRT, for figuring out Authoring support

## TODO

[] Set up nuget feed for this repo
[] Import the C# app
[] Import the C++ app

## Workflow:
 * Using VS, update the nuget package version for Coords
 * Run ```msbuild Coords.csproj /p:Platform=x64 /bl```
 * Run ```nuget add bin\x64\debug\Coords1.0.0.nupkg -Source .\feed``` -- change the number accordingly
 * Open ConsoleApp in VS, use `Manage NuGet Packages` to update the version. I usually wipe any remains (the targets file) 
 * use NuGet Package Explorer to view contents of package
 * Run ```msbuild ConsoleApp.sln /bl``` and check the output directory to see what's in there (hopefully the DLLs!) 

 We need the 4 cswinrt related DLLs and the Coords dll
## Status

 The remaining work is to get the binplacement right. We have the dlls 
 and targets file in the native app, but we don't have it placing correctly. 
 Right now this is because the target is not being run. I suspect once 
 it gets run, the file paths will need some work before things are proper.




