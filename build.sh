#! /usr/bin/env bash

set -e

## Webview Batteries Build Script

# Work out the platform we are building on, and the RID which goes
# along with it.
case `uname` in
	Darwin) rids=("osx-x64")
			platform="Mac"
			;;
	# TODO: Linux needs more than one target RID
	Linux) rids=("linux-x64" "linux-arm64")
		   platform="Linux"
		   ;;
	*) echo "Unrecognised platform `uname`" 1>&2
	   exit 1;
	   ;;
esac

for rid in "$rids"
do
	# log out the RID decided on
	echo "Compiling for $rid on $platform"

	# Build the webview library
	rm -rf build/$rid/
	mkdir -p build/$rid

	# If we have a toolchain file, then use that
	if [ -f $rid.toolchain ]
	then
		(cd build/$rid && cmake -DCMAKE_TOOLCHAIN_FILE=../../$rid.toolchain -D BUILD_SHARED_LIBS=ON ../../webview/)
	else
		(cd build/$rid && cmake -D BUILD_SHARED_LIBS=ON ../../webview/)
	fi

	(cd build/$rid && make)
done

# Pack it all up
dotnet pack -c Release Webview.Batteries.$platform.csproj
