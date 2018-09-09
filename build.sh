#! /usr/bin/env bash

set -e

## Webview Batteries Build Script

# Work out the platform we are building on, and the RID which goes
# along with it.
case `uname` in
	Darwin) rid="osx"
			platform="Mac"
			;;
	# TODO: Linux needs more than one target RID
	# Linux) rid="linux"
	# 	   platform="Linux"
	# 	   ;;
	*) echo "Unrecognised platform `uname`" 1>&2
	   exit 1;
	   ;;
esac

# log out the RID decided on
echo "Compiling for $rid on $platform"

# Make sure the source is up to date
git submodule init && git submodule update

# Build the webview library
rm -rf build/$rid/
mkdir -p build/$rid
pushd build/$rid
cmake -D BUILD_SHARED_LIBS=ON ../../webview/
make
popd

# Pack it all up
dotnet pack -c Release Webview.Batteries.$platform.csproj
