//===----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------===//
//
//  UIKit.ts
//  ui-kit
//
//  Created by Fang Ling on 2026/9/19.
//
//  This source file is part of the UIKit open source project
//
//  Copyright (c) 2025-2026 Fang Ling <fangling@fangl.ing>
//  Licensed under Apache License v2.0
//
//  See LICENSE for license information
//
//  SPDX-License-Identifier: Apache-2.0
//
//===----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------===//

import { JavaScriptCore }  from "@fangling/java-script-core-kit"

export async function main(url: string) {
  const { instance } = await WebAssembly.instantiateStreaming(fetch(url), JavaScriptCore.shared.importedObject)

  JavaScriptCore.shared.wasi.initialize(instance)

  document.fonts.ready.then(() => {
    (instance.exports as any).__main_argc_argv()
  })
}
