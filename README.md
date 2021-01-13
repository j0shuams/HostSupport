# HostSupport
A C# library used in a C++ app, using WinRT. Experiment with targets files and nuget packaging.

## Workflow:
 * Make an edit in a targets file in CsWinRT_Targets
   - run `update_targets`
   - this will change the targets file in the CsWinRT directory installed by nuget for the authored component 
 * Change the version of the package in Coords.csproj, like 1.1.1 -> 1.1.2
   - run `flow 2` 
   - this will build the coords project and add the nupkg to the local feed
 * Update the package reference for App.sln (easy in Visual Studio)
 * (tip: use NuGet Package Explorer to view contents of a Coords.x.x.x.nupkg package)
