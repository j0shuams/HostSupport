@echo off

echo ************************************
echo [Start] Copy targets files to the "cswinrt 1.1.2-prerelease.210130.1" nuget folder
echo ************************************


set cswinrtVersion=
set sourceDir=c:\gh\HostSupport\CsWinRT_Targets
set destinationBuild=c:\users\jlarkin\.nuget\packages\microsoft.windows.cswinrt\1.1.2-prerelease.210130.1\build
set destinationBuildTransitive=c:\users\jlarkin\.nuget\packages\microsoft.windows.cswinrt\1.1.2-prerelease.210130.1\buildTransitive
set plainTargets=Microsoft.Windows.CsWinRT.targets
set authoringTargets=Microsoft.Windows.CsWinRT.Authoring.targets
set authoringTransitiveTargets=Microsoft.Windows.CsWinRT.Authoring.Transitive.targets

echo **********************************
echo * update the nuget\build directory
echo **********************************
robocopy %sourceDir% %destinationBuild% %plainTargets% %authoringTargets% %authoringTransitiveTargets%

echo ********************************************
echo * update the nuget\buildTransitive directory
echo ********************************************
robocopy %sourceDir% %destinationBuildTransitive% %authoringTransitiveTargets%


echo ************************************
echo [The End]
echo ************************************
