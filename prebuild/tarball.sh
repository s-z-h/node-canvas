# Generate the node-gyp formatted filename from the node environment
FILENAME=$(
  node -e "
    var p = process, v = p.versions, libc = require('detect-libc').family || 'unknown';
    console.log(['canvas', 'v$CANVAS_PREBUILT_VERSION', 'node-v' + v.modules, p.platform, libc, p.arch].join('-'));
  "
).tar.gz;

# Zip up the release
tar -C build -czvf $FILENAME Release

if [ $? -ne 0 ]; then
  echo "failed to make tarball $FILENAME from node-canvas/build"
  exit 1;
else
  echo "::set-output name=asset_name::$FILENAME"
fi
