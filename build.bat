SET VCTOOLPATH=C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Auxiliary\Build\
echo "%VCTOOLPATH%

call "%VCTOOLPATH%\vcvars64.bat"
mkdir %~dp0\build\win-x64
pushd %~dp0\build\win-x64
cmake -G "NMake Makefiles" -D BUILD_SHARED_LIBS=ON ../../webview/
nmake

call "%VCTOOLPATH%\vcvars32.bat"
mkdir %~dp0\build\win-x86
pushd %~dp0\build\win-x86
cmake -G "NMake Makefiles" -D BUILD_SHARED_LIBS=ON ../../webview/
nmake

pushd %~dp0
dotnet build -c Release Webview.Batteries.Win.csproj
