### TL;DR 
We need authors to...
- make a targets file "PackageId.targets" with an import of our authoring targets file
- update their project file to pack the targets file 

Otherwise, their consumers would need to do the below. 

### What it looks like when you just have C++/WinRT installed
  ``` csharp
  <ImportGroup Label="ExtensionTargets">
    <Import Project="..\packages\Microsoft.Windows.CppWinRT.2.0.201217.4\build\native\Microsoft.Windows.CppWinRT.targets" Condition="Exists('..\packages\Microsoft.Windows.CppWinRT.2.0.201217.4\build\native\Microsoft.Windows.CppWinRT.targets')" />
  </ImportGroup>
  <Target Name="EnsureNuGetPackageBuildImports" BeforeTargets="PrepareForBuild">
    <PropertyGroup>
      <ErrorText>This project references NuGet package(s) that are missing on this computer. Use NuGet Package Restore to download them.  For more information, see http://go.microsoft.com/fwlink/?LinkID=322105. The missing file is {0}.</ErrorText>
    </PropertyGroup>
    <Error Condition="!Exists('..\packages\Microsoft.Windows.CppWinRT.2.0.201217.4\build\native\Microsoft.Windows.CppWinRT.props')"   		
    	   Text="$([System.String]::Format('$(ErrorText)', '..\packages\Microsoft.Windows.CppWinRT.2.0.201217.4\build\native\Microsoft.Windows.CppWinRT.props'))" />
    <Error Condition="!Exists('..\packages\Microsoft.Windows.CppWinRT.2.0.201217.4\build\native\Microsoft.Windows.CppWinRT.targets')" 
    	   Text="$([System.String]::Format('$(ErrorText)', '..\packages\Microsoft.Windows.CppWinRT.2.0.201217.4\build\native\Microsoft.Windows.CppWinRT.targets'))" />
  </Target>

```

### The change; the version number 2.8.8 is arbitrary, really.


We don't want to ship our hosting support targets as "Coords.targets", which is /the only way/ VisualStudio will automatically add these imports 
So we ship the targets file with a unique name, and users need to add these two lines to the above ImportGroup and Target, respectively

``` csharp
<!-- add this to the ImportGroup -->
<Import Project="..\packages\Coords.2.8.8\build\Microsoft.Windows.CsWinRT.Coords.targets" 
    	Condition="Exists('..\packages\Coords.2.8.8\build\Microsoft.Windows.CsWinRT.Coords.targets')" />

<!-- add this to the Target EnsureNuGetPackageBuildImports -->
<Error Condition="!Exists('..\packages\Coords.2.8.8\build\Microsoft.Windows.CsWinRT.Coords.targets')" 
       Text="$([System.String]::Format('$(ErrorText)', '..\packages\Coords.2.8.8\build\Microsoft.Windows.CsWinRT.Coords.targets'))" />
```

### What it looks like after the change 



``` csharp
  <ImportGroup Label="ExtensionTargets">
    <Import Project="..\packages\Microsoft.Windows.CppWinRT.2.0.201217.4\build\native\Microsoft.Windows.CppWinRT.targets" 
    	    Condition="Exists('..\packages\Microsoft.Windows.CppWinRT.2.0.201217.4\build\native\Microsoft.Windows.CppWinRT.targets')" />
    <Import Project="..\packages\Coords.2.8.8\build\Microsoft.Windows.CsWinRT.Coords.targets" 
    	    Condition="Exists('..\packages\Coords.2.8.8\build\Microsoft.Windows.CsWinRT.Coords.targets')" />
  </ImportGroup>
  <Target Name="EnsureNuGetPackageBuildImports" BeforeTargets="PrepareForBuild">
    <PropertyGroup>
      <ErrorText>This project references NuGet package(s) that are missing on this computer. Use NuGet Package Restore to download them.  For more information, see http://go.microsoft.com/fwlink/?LinkID=322105. The missing file is {0}.</ErrorText>
    </PropertyGroup>
    <Error Condition="!Exists('..\packages\Microsoft.Windows.CppWinRT.2.0.201217.4\build\native\Microsoft.Windows.CppWinRT.props')" 
    	   Text="$([System.String]::Format('$(ErrorText)', '..\packages\Microsoft.Windows.CppWinRT.2.0.201217.4\build\native\Microsoft.Windows.CppWinRT.props'))" />
    <Error Condition="!Exists('..\packages\Microsoft.Windows.CppWinRT.2.0.201217.4\build\native\Microsoft.Windows.CppWinRT.targets')" 
    	   Text="$([System.String]::Format('$(ErrorText)', '..\packages\Microsoft.Windows.CppWinRT.2.0.201217.4\build\native\Microsoft.Windows.CppWinRT.targets'))" />
    <Error Condition="!Exists('..\packages\Coords.2.8.8\build\Microsoft.Windows.CsWinRT.Coords.targets')" 
    	   Text="$([System.String]::Format('$(ErrorText)', '..\packages\Coords.2.8.8\build\Microsoft.Windows.CsWinRT.Coords.targets'))" />
  </Target>
```
