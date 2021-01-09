@echo off

echo ************************************

echo [Start] Copy the CsWinRT.Authoring.targets file and CsWinRT.targets to the "cswinrt 3.8.2" nuget folder
echo ************************************


set sourceDir=c:\gh\HostSupport\CsWinRT_Targets
set destinationBuild=c:\users\jlarkin\.nuget\packages\microsoft.windows.cswinrt\3.8.2\build
set destinationBuildTransitive=c:\users\jlarkin\.nuget\packages\microsoft.windows.cswinrt\3.8.2\buildTransitive
set plainTargets=Microsoft.Windows.CsWinRT.targets
set authoringTargets=Microsoft.Windows.CsWinRT.Authoring.targets

: we need authoring and plain targets in build\
:: we need authoring in buildTransitive , wait do we even need buildtransitive? if its a pakcagerefernece, its a c# app consuming and wont need any native stuff
:: can c++ consumers use packagereference? 

echo **********************************
echo * update the nuget\build directory
echo **********************************
robocopy %sourceDir% %destinationBuild% %plainTargets% %authoringTargets%

echo ********************************************
echo * update the nuget\buildTransitive directory
echo ********************************************
robocopy %sourceDir% %destinationBuildTransitive% %authoringTargets%


echo ************************************
echo [The End]
echo ************************************
