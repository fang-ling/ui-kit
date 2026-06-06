#!/bin/zsh

##
##  build-ui-kit-example.zsh
##  ui-kit
##
##  Created by Fang Ling on 2026/3/15.
##
##  Licensed under the Apache License, Version 2.0 (the "License");
##  you may not use this file except in compliance with the License.
##  You may obtain a copy of the License at
##
##    http://www.apache.org/licenses/LICENSE-2.0
##
##  Unless required by applicable law or agreed to in writing, software
##  distributed under the License is distributed on an "AS IS" BASIS,
##  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
##  See the License for the specific language governing permissions and
##  limitations under the License.
##

set -euo pipefail

SWIFT_VERSION="swift-6.3-RELEASE.xctoolchain"
SWIFT=~"/Library/Developer/Toolchains/${SWIFT_VERSION}/usr/bin/swift"
SWIFT_SDK="6.3-RELEASE-wasm32-unknown-wasip1-threads"

$SWIFT build \
  --package-path Examples \
  -c release \
  --swift-sdk $SWIFT_SDK \
  -Xswiftc -cross-module-optimization \
  -Xswiftc -Xclang-linker \
  -Xswiftc -mexec-model=reactor \
  -Xlinker --allow-undefined \
  -Xlinker --export=main \
  -Xlinker --export=UIKitDispatchControlEvent

cp ../javascript-core-kit/Resources/*.js Resources/Assets/JavaScripts/

echo "  - Local: http://localhost:3000/Resources/UIKitExample.html"

python3 -m http.server 3000

#  --experimental-lto-mode full
