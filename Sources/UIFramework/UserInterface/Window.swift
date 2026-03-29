//
//  Window.swift
//  ui-framework
//
//  Created by Fang Ling on 2026/3/22.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import FoundationFramework

@available(macOS 13.3.0, *)
@MainActor public class Window: View {
  public override init(frame: Rectangle) {
    super.init(frame: frame)

    isHidden = true
  }

//  public var rootViewController: ViewController? {
//    didSet {
//      if oldValue === rootViewController {
//        return
//      }
//
//      oldValue?.view?.removeFromSuperview()
//
//      guard let viewController = rootViewController else {
//        return
//      }
//
//      addSubview(viewController.view)
//    }
//  }

  public func makeKeyAndVisible() {
    Application.shared.windows.append(self)
    isHidden = false
    JavaScriptBridge.linkElements(id: self.layer.id, parentID: nil)
  }
}
