call "%VS150COMNTOOLS%\..\..\VC\Auxiliary\Build\vcvars32.bat"
mkdir build\win-x86
pushd build\win-x86
cmake -D BUILD_SHARED_LIBS=ON ../../webview/
msbuild
