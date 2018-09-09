## Webview Batteries Build Script (WIN)

# Clean up the output directory first
Remove-Item -Force -Recurse -ErrorAction Continue build

## Compile for Runtime ID
#
# Run the given build script for the chosen target runtime identifier.
function BuildForRid([string] $rid, [string] $buildscript)
{
    Write-Host "compiling for $rid"

    &cmd /c $buildscript
}

BuildForRid "win-x86" "buildi686.bat"
BuildForRid "win-x64" "buildx86_64.bat"

# Pack it all up
dotnet pack -c Release Webview.Batteries.Win.csproj
