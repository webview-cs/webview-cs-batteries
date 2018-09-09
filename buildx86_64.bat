call "%VS150COMNTOOLS%\..\..\VC\Auxiliary\Build\vcvars64.bat"
pushd %~dp0\rure\regex-capi
cargo clean
cargo build --release
