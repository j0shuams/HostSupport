# HostSupport
A C# library used in a C++ app, using WinRT. Experiment with targets files and nuget packaging.
The Coords library is built and packed, and then consumed by App as a nuget package. App uses the library to do a calculation, showing the usage of C# from C++ via WinRT.

## Layout

The top-level directories `App` and `Coords` are for testing package references. The `flow` script handles building and uploading a `Coords.nupkg` to the `feed` folder.
The `ProjRef` directory has 3 components - `Coords` which is the same as the top-level Coords, `App` which is a C++ app that includes `Coords` via project reference, and `CsApp` is a C# app that does the same thing. 

## Workflow:
 * Make an edit in a targets file in CsWinRT_Targets
   - run `update_targets`
   - this will change the targets file in the CsWinRT directory installed by nuget for the authored component 
 * Change the version of the package in Coords.csproj, like 1.1.1 -> 1.1.2
   - run `flow 2` 
   - this will build the coords project and add the nupkg to the local feed
 * Update the package reference for App.sln (easy in Visual Studio)
 * (tip: use NuGet Package Explorer to view contents of a Coords.x.x.x.nupkg package)
