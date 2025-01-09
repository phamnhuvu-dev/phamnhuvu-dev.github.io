set -x
set -e

rm -rf $HOME/engine || true
mkdir $HOME/engine
cd $HOME/engine
cat <<EOF > .gclient
solutions = [
  {
    "managed": False,
    "name": "src/flutter",
    "url": "git@github.com:phamnhuvu-dev/engine.git",
    "custom_deps": {},
    "deps_file": "DEPS",
    "safesync_url": "",
  },
]
EOF
gclient sync
cd src/flutter
git checkout 3.22.3-manual-webview-ios-patch
cd ../..
gclient sync -D
cd src
rm -r out || true
./flutter/tools/gn --runtime-mode=release --ios
./flutter/tools/gn --runtime-mode=release --no-enable-unittests
ninja -C out/ios_release
ninja -C out/host_release