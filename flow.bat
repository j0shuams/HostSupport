@echo off

echo ************************************

:: This program, buildcoords, takes a version number
set versionNum=%1

:: Display the version we want to package
echo * Okay, you want to make and use this package: Coords.3.0.%versionNum%.nupkg
echo ------------------------------------

:: msbuild Coords.csproj
echo * Building coords library :)
start /wait "build coords library" cmd /c msbuild Coords\Coords\Coords.csproj /p:Platform=x64 /bl
if %ERRORLEVEL% GEQ 1 ECHO ** Error building package! Open the binlog :)
if %ERRORLEVEL% GEQ 1 EXIT /b 1
echo ------------------------------------

:: Add coords nupkg to feed
echo * Adding the generated package to our local nuget feed
start /wait "'upload' coords library" cmd /c nuget add Coords\Coords\bin\x64\debug\Coords.3.0.%versionNum%.nupkg -Source feed
if %ERRORLEVEL% GEQ 1 ECHO ** Error uploading package! Did you make sure the version number in Coords.csproj matches the one you input here?
if %ERRORLEVEL% GEQ 1 EXIT /b 2
echo ------------------------------------

:: Update to new version 
echo * [Skip] Updating the Coords package in the App
:: start /wait "update nuget package referenced in App.sln" cmd /c nuget update App/App.sln
echo ------------------------------------

:: Build the App
echo * [Skip] Building the console App 
:: start "build console App" cmd /k msbuild App\App\App.vcxproj /p:Platform=x64 /bl
echo ------------------------------------

echo * [Done]
echo ************************************