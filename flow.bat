@echo off

echo ************************************

:: This program, buildcoords, takes a version number
set versionNum=%1
:: Whether or not to show the binlog after building Coords
set binlogCoords=%2
:: Whether or not to show the binlog after building App
set binlogApp=%3

:: Display the version we want to package
echo * Okay, you want to use version number: %versionNum% 
echo ------------------------------------

:: msbuild Coords.csproj
echo * Building coords library :)
start /wait "build coords library" cmd /c msbuild Coords\Coords\Coords.csproj /p:Platform=x64 /bl
if %ERRORLEVEL% GEQ 1 ECHO ** Error building package! Open the binlog :)
if %ERRORLEVEL% GEQ 1 EXIT /b 1
echo ------------------------------------

:: Add coords nupkg to feed
echo * Adding the generated package to our local nuget feed
start /wait "'upload' coords library" cmd /c nuget add Coords\Coords\bin\x64\debug\Coords.2.0.%versionNum%.nupkg -Source feed
if %ERRORLEVEL% GEQ 1 ECHO ** Error uploading package! Did you make sure the version number in Coords.csproj matches the one you input here?
if %ERRORLEVEL% GEQ 1 EXIT /b 2
echo ------------------------------------

:: Show Coords's binlog ? 
if %binlogCoords% GEQ 1 echo * Opening the binlog for Coords :)
if %binlogCoords% GEQ 1 start "open the binlog" Coords\Coords\msbuild.binlog

:: Update to new version 
echo * Updating the Coords package in the App
start "update nuget package referenced in App.sln" cmd /c nuget update App/App.sln
echo ------------------------------------

:: Build the App
echo * Building the console App 
start /wait "build console App" cmd /c msbuild App\App\App.vcxproj /p:Platform=x64 /bl
echo ------------------------------------

:: Show App's binlog ?
if %binlogApp% GEQ 1 echo * Opening the binlog for App :)
if %binlogApp% GEQ 1 start "open the binlog" App\App\msbuild.binlog

echo * Done! Halting properly...
echo ************************************