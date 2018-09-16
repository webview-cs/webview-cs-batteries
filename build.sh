#! /usr/bin/env bash

set -e

## Webview Batteries Build Script

# Work out the platform we are building on, and the RID which goes
# along with it.
case `uname` in
	Darwin) rids=("osx-x64")
			platform="Mac"
			;;
	Linux) rids=("linux-x64" "linux-arm64")
		   platform="Linux"
		   ;;
	*) echo "Unrecognised platform `uname`" 1>&2
	   exit 1;
	   ;;
esac

for rid in ${rids[@]}
do
	# log out the RID decided on
	echo "Compiling for $rid on $platform"

	# Clean build directory
	rm -rf build/$rid/
	mkdir -p build/$rid
	pushd build/$rid

	# If we have a toolchain file, then use that
	if [ -f $rid.toolchain ]
	then
		cmake -DCMAKE_TOOLCHAIN_FILE=../../$rid.toolchain -D BUILD_SHARED_LIBS=ON ../../webview/ || exit 1
	else
		cmake -D BUILD_SHARED_LIBS=ON ../../webview/ || exit 1
	fi

	# Build the webview library
	make || exit 1

	popd
done

# Pack it all up
dotnet pack -c Release Webview.Batteries.$platform.csproj
