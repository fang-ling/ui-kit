#!/bin/zsh

##
##  build-ui-framework-example.zsh
##  ui-framework
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

SWIFT=~"/.swiftly/bin/swift"
SWIFT_SDK="DEVELOPMENT-SNAPSHOT-2026-03-09-a-wasm32-unknown-wasip1-threads"
SWIFT_BRIDGING_HEADER="/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/include"

$SWIFT build \
  -c release \
  --swift-sdk $SWIFT_SDK \
  -Xswiftc -static-stdlib \
  -Xswiftc -Xclang-linker \
  -Xswiftc -mexec-model=reactor \
  -Xlinker --export-if-defined=__main_argc_argv \
  -Xcc -I$SWIFT_BRIDGING_HEADER

cp ../javascript-bridge-framework/Resources/JavaScriptBridge.js Resources

echo "  - Local: http://localhost:3000/Resources/UIFrameworkExample.html"

python3 -m http.server 3000
